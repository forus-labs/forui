import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import 'dart_doc_linker.dart';
import 'main.dart';
import 'snippet.dart';

/// Fragments (e.g., `FButton({required this.child})`) are not valid Dart on their own. This class wraps it in a
/// stub declaration, formats it, resolves the AST to extract dartdoc links, then extracts the original declaration
/// with adjusted offsets.
class Stubber extends RecursiveAstVisitor<void> {
  static int _monotonic = 0;

  static Future<FragmentSnippet> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String imports,
    String fragment,
    FragmentSnippetKind kind,
    (String name, String url)? container,
  ) async {
    final snippet = FragmentSnippet(
      formatter.format(
        imports +
            switch (kind) {
              // Transform `Type name` to `late Type name;`
              .field => 'late $fragment;',
              // Transform `Type get name` to `Type get name => throw UnimplementedError();` or `Type name(params)` to
              // `Type name(params) => throw UnimplementedError();`
              .getter || .method => '$fragment => throw UnimplementedError();',
              // Transform `Type.ctr(params)` to `class Type { Type.ctr(params); }`
              .constructor => 'class ${container!.$1} { $fragment; }',
              // Transform `Type param` to `void a(Type param) {}`
              .formalParameter => 'void a($fragment) {}',
            },
      ),
      kind,
      container,
    );

    final syntheticPath = p.join(lib, 'tooltip_stub_${_monotonic++}.dart');
    overlay.setOverlay(syntheticPath, content: snippet.text, modificationStamp: DateTime.now().millisecondsSinceEpoch);
    final result = (await session.getResolvedUnit(syntheticPath)) as ResolvedUnitResult;

    final linker = _Linker(packages, container: snippet.container?.$1);
    result.unit.visitChildren(linker);
    snippet.spans.addAll(linker.links);

    result.unit.visitChildren(Stubber(snippet));

    // Constructor code is indented by 2 spaces inside the class wrapper - strip it and adjust link offsets
    if (kind == .constructor) {
      snippet.unindent(2);
    }

    return snippet;
  }

  FragmentSnippet snippet;

  Stubber(this.snippet);

  /// Field: extracts "Type name" from "late Type name;".
  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    if (snippet.kind == .field) {
      // We assume there's only one variable declared.
      final variable = node.variables.variables.single;
      snippet.between(node.variables.type?.offset ?? variable.offset, variable.end);
    }
  }

  /// Constructor: extracts "ClassName(params)" from "class X { ClassName(); }".
  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    if (snippet.kind == .constructor) {
      snippet.between(node.returnType.offset, node.parameters.end);
    }
  }

  /// Getter/Method/FormalParameter: extracts signature from function declaration.
  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (snippet.kind == .getter) {
      // "Type get name" - from return type to getter name end
      snippet.between(node.returnType?.offset ?? node.name.offset, node.name.end);
    } else if (snippet.kind == .method) {
      // "Type name(params)" - from return type to parameters end
      snippet.between(
        node.returnType?.offset ?? node.name.offset,
        node.functionExpression.parameters?.end ?? node.name.end,
      );
    } else if (node.functionExpression.parameters case final parameters? when snippet.kind == .formalParameter) {
      // Extract parameter from "void a(Type param) {}"
      snippet.between(parameters.leftParenthesis.next!.offset, parameters.rightParenthesis.previous!.end);
    }
  }
}

/// A [DartDocLinker] subclass for processing tooltip stubs.
///
/// When tooltip stubs wrap constructors like `class FCalendar { FCalendar({required this.control}); }`,
/// the stub class has no fields. This linker looks up the **actual type* from packages to find field declarations for
/// parameters.
class _Linker extends DartDocLinker {
  /// The container class name.
  final String? container;

  _Linker(super.packages, {this.container});

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    // Find the actual type and get the constructor from it.
    if (_type(container) case final type?) {
      final name = node.name?.lexeme ?? 'new';
      final constructor = name == 'new' ? type.unnamedConstructor : type.getNamedConstructor(name);
      if (constructor != null) {
        link(Entity(node.returnType.offset, node.name?.end ?? node.returnType.end), constructor);
      }
    }
    super.visitConstructorDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (_topLevelFunction(node.name.lexeme) case final function?) {
      // Look up actual top level function and get the function from it. Needed for top level functions like
      // `showFPersistentSheet`.
      link(node.name, function);
    } else if (_type(container)?.getMethod(node.name.lexeme) case final method?) {
      // Look up actual target and get the method from it. Needed for static functions like
      // `FCalendarControl.managedDates`.
      link(node.name, method);
    }
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitDefaultFormalParameter(DefaultFormalParameter node) {
    final element = node.parameter.declaredFragment?.element;
    if (element case Element(enclosingElement: ConstructorElement(:final name?)) when node.name != null) {
      // Find the actual type from packages (not the stub).
      if (_type(container) case final type?) {
        final field = type.getField(name);
        final constructor = name == 'new' ? type.unnamedConstructor : type.getNamedConstructor(name);

        if (field != null || constructor != null) {
          link(node.name!, field ?? constructor!);
        }
      }
    }

    super.visitDefaultFormalParameter(node);
  }

  InterfaceElement? _type(String? name) {
    if (name == null) {
      return null;
    }

    for (final package in packages) {
      if (package.library.exportNamespace.get2(name) case final InterfaceElement element) {
        return element;
      }
    }

    return null;
  }

  TopLevelFunctionElement? _topLevelFunction(String name) {
    for (final package in packages) {
      if (package.library.exportNamespace.get2(name) case final TopLevelFunctionElement element) {
        return element;
      }
    }
    return null;
  }
}

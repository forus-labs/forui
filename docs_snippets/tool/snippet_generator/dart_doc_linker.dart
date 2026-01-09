import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import 'main.dart';
import 'snippet.dart';

/// A visitor that adds Dartdoc links to AST nodes.
class DartDocLinker extends RecursiveAstVisitor<void> {
  static int _monotonic = 0;

  /// Generates DartDoc links for identifiers in [code] that belong to [packages].
  static Future<List<DartDocLink>> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String code,
  ) async {
    final path = p.join(lib, 'dart_doc_linker_${_monotonic++}.dart');
    overlay.setOverlay(path, content: code, modificationStamp: DateTime.now().millisecondsSinceEpoch);

    final result = (await session.getResolvedUnit(path)) as ResolvedUnitResult;
    final linker = DartDocLinker(packages);
    result.unit.visitChildren(linker);

    return linker.links;
  }

  final List<DartDocLink> links = [];
  final List<Package> packages;

  DartDocLinker(this.packages);

  /// Links type annotations to their class/enum/mixin documentation.
  ///
  /// Handles standalone type references like `FButton`, `String`, or `List<int>`. Skips types that are part of
  /// constructor calls (e.g., `FButton` in `FButton()`) since those are handled by [visitInstanceCreationExpression].
  /// Also skips types in TypeLiterals used as targets for static method/property access.
  @override
  void visitNamedType(NamedType node) {
    // Skip types in constructor names (handled by visitInstanceCreationExpression).
    if (node.parent is ConstructorName) {
      super.visitNamedType(node);
      return;
    }

    // Skip types in TypeLiterals used as targets for static access (handled by visitMethodInvocation/visitPrefixedIdentifier).
    if (node.parent case TypeLiteral(parent: MethodInvocation() || PrefixedIdentifier())) {
      super.visitNamedType(node);
      return;
    }

    if (node.element != null) {
      link(node, node.element!);
    }
    super.visitNamedType(node);
  }

  /// Links property access and method tear-offs where both parts are compile-time identifiers.
  ///
  /// Handles expressions like `FIcons.anchor`, `context.theme`, or `int.parse` where `prefix.identifier` are both
  /// simple identifiers known at compile time. [visitPropertyAccess] handles chained access where the target is an
  /// expression.
  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    switch (node.element) {
      // Link entire "Type.property" for static accesses like `FIcons.anchor and just the property name for instance
      // accesses like `instance.property`.
      //
      // Const fields are synthetic and treated as property accesses.
      case final PropertyAccessorElement element:
        link(element.isStatic ? node : node.identifier, element);

      // Link entire "Type.method" for static method tear-offs like `int.parse and just the method name for instance
      // method tear-offs like `controller.submit`.
      case final MethodElement element:
        link(element.isStatic ? node : node.identifier, element);
    }

    super.visitPrefixedIdentifier(node);
  }

  /// Links property access and method tear-offs where the target is an expression.
  ///
  /// Handles expressions like `context.theme.paginationStyle` or `object.nested.method` where the target is an
  /// expression rather than a compile-time identifier. [visitPrefixedIdentifier] handles `prefix.identifier` where
  /// both parts are compile-time identifiers.
  ///
  /// Also handles record field access like `FThemes.zinc.light` where the field has no element - links to the parent
  /// expression's element instead.
  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (node.propertyName.element case final element?) {
      link(node.propertyName, element);
    } else if (node.target case final target? when target.staticType is RecordType) {
      // Record field access - link to the parent expression's element.
      if (recordElement(target) case final element?) {
        link(node.propertyName, element);
      }
    }
    super.visitPropertyAccess(node);
  }

  Element? recordElement(Expression expression) => switch (expression) {
    PrefixedIdentifier(:final element?) => element,
    PropertyAccess(:final propertyName) => propertyName.element,
    MethodInvocation(:final methodName) => methodName.element,
    _ => null,
  };

  /// Links targeted top level function/method invocations to their method documentation.
  ///
  /// Handles expressions like `FThemes.zinc.light()` or `instance.instanceMethod()`.
  ///
  /// See [visitDotShorthandInvocation] for dot shorthand method invocations.
  @override
  void visitMethodInvocation(MethodInvocation node) {
    switch (node.methodName.element) {
      // Link top-level function calls like `print()` or `myCustomFunction()`.
      case final TopLevelFunctionElement element:
        link(node.methodName, element);

      // Link entire "Type.method" for static calls like `FButtonStyle.ghost()` and  just the method name for instance
      // calls like `instance.method()`.
      case final MethodElement element:
        link(
          element.isStatic
              ? Entity(node.target!.offset, node.methodName.offset + node.methodName.length)
              : node.methodName,
          element,
        );
    }
    super.visitMethodInvocation(node);
  }

  /// Links targeted constructor invocations to their constructor documentation.
  ///
  /// Handles expressions like `FButton()`, `FButton.raw()`, or `const EdgeInsets.all(8)`.
  ///
  /// See [visitDotShorthandConstructorInvocation] for dot shorthand constructor invocations.
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.element case final element?) {
      link(node.constructorName, element);
    }
    super.visitInstanceCreationExpression(node);
  }

  /// Links dot shorthand **property** access to the property's field documentation.
  ///
  /// Handles dot shorthand syntax like `.zero` or `.infinity`.
  @override
  void visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node) {
    if (node.propertyName.element case final element?) {
      // Dot shorthand property access are synthetic and treated as property accesses, e.g. FItemDivider get full.
      // We need to link to the non-synthetic element instead.
      link(node.propertyName, element.nonSynthetic);
    }
    super.visitDotShorthandPropertyAccess(node);
  }

  /// Links dot shorthand **method** invocations to their method documentation.
  ///
  /// Handles dot shorthand syntax like `.method()`.
  @override
  void visitDotShorthandInvocation(DotShorthandInvocation node) {
    if (node.memberName.element case final element?) {
      link(node.memberName, element);
    }
    super.visitDotShorthandInvocation(node);
  }

  /// Links dot shorthand **constructor** invocations to their constructor documentation.
  ///
  /// Handles dot shorthand syntax like `.constructor()`.
  @override
  void visitDotShorthandConstructorInvocation(DotShorthandConstructorInvocation node) {
    if (node.constructorName.element case final element?) {
      link(node.constructorName, element);
    }
    super.visitDotShorthandConstructorInvocation(node);
  }

  /// Links named parameters in top level function/constructor/method invocations to:
  /// * their corresponding field documentation if they exist.
  /// * the enclosing constructor/method documentation otherwise.
  ///
  /// Handles named arguments like `onPress:` in `FButton(onPress: () {})`.
  @override
  void visitNamedExpression(NamedExpression node) {
    if (node.element case FormalParameterElement(:final enclosingElement?, :final name?)) {
      switch (enclosingElement) {
        case final TopLevelFunctionElement function:
          // Link to the top level function for named parameters.
          link(node.name.label, function);

        case final ConstructorElement constructor:
          final classElement = constructor.enclosingElement;
          final field = classElement.getField(name);
          // Link to the constructor for named parameters that don't correspond to fields.
          link(node.name.label, field ?? constructor);

        case final MethodElement method:
          // Link to the method for named parameters.
          link(node.name.label, method);
      }
    }
    super.visitNamedExpression(node);
  }

  /// Adds a link for [element] at [node].
  void link(SyntacticEntity node, Element element) {
    if (dartDocUrl(element) case final url?) {
      links.add(DartDocLink(node.offset, node.length, url));
    }
  }

  /// Returns the Dart docs link, or null if it shouldn't be linked.
  String? dartDocUrl(Element element) {
    final n = element.library?.uri.pathSegments.first;
    if (packages.firstWhereOrNull((p) => p.name == n) case Package(name: final package, :final version)) {
      // We check enclosingElement != null to avoid top level functions being treated as methods.
      final type = switch (element) {
        FieldElement() ||
        PropertyAccessorElement() ||
        ConstructorElement() ||
        MethodElement() when element.enclosingElement != null => element.enclosingElement?.name,
        _ => element.name,
      };

      var base = '';
      for (final Package(:library) in packages) {
        if (_barrel(library, type!)?.name case final name?) {
          base = 'https://pub.dev/documentation/$package/$version/${name.isEmpty ? package : name}';
          break;
        }
      }
      assert(base.isNotEmpty, 'Could not find barrel library for type "$type" in package "$package".');

      return switch (element) {
        TopLevelFunctionElement(:final name) => '$base/$name.html',
        EnumElement(:final name) => '$base/$name.html',
        ExtensionElement(:final name) => '$base/$name.html',
        MixinElement(:final name) => '$base/$name-mixin.html',
        ClassElement(:final name) || InterfaceElement(:final name) => '$base/$name-class.html',
        FieldElement(:final enclosingElement, :final name, :final isEnumConstant) when isEnumConstant =>
          '$base/${enclosingElement.name}.html#$name',
        FieldElement(:final enclosingElement, :final name, :final isConst) when isConst =>
          '$base/${enclosingElement.name}/$name-constant.html',
        FieldElement(:final enclosingElement, :final name) => '$base/${enclosingElement.name}/$name.html',
        PropertyAccessorElement(:final enclosingElement, :final name) => '$base/${enclosingElement.name}/$name.html',
        ConstructorElement(:final enclosingElement, :final name?) =>
          '$base/${enclosingElement.name}/${enclosingElement.name}${name == 'new' ? '' : '.$name'}.html',
        MethodElement(:final enclosingElement?, :final name) => '$base/${enclosingElement.name}/$name.html',
        _ => null,
      };
    }

    return null;
  }

  /// Returns the deepest barrel library that exports [type].
  LibraryElement? _barrel(LibraryElement library, String type) {
    if (library.exportNamespace.get2(type) == null) {
      return null;
    }

    for (final lib in library.exportedLibraries.where((l) => !l.uri.pathSegments.contains('src'))) {
      if (lib.exportNamespace.get2(type) != null) {
        return _barrel(lib, type);
      }
    }

    return library;
  }
}

class Entity implements SyntacticEntity {
  @override
  final int offset;
  @override
  final int end;

  Entity(this.offset, this.end);

  @override
  int get length => end - offset;
}

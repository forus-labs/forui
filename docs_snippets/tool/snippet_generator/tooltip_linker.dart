import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:auto_route_generator/utils.dart';
import 'package:path/path.dart' as p;

import 'stubber.dart';
import 'dart_doc_linker.dart';
import 'main.dart';
import 'snippet.dart';

/// A [DartDocLinker] that additionally creates [Tooltip]s that display the source declaration of properties, methods,
/// constructors, and parameters.
class TooltipLinker extends DartDocLinker {
  static int _monotonic = 0;

  /// Links DartDoc URLs and generates tooltips for [code].
  static Future<(List<DartDocLink>, List<Tooltip>)> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String code,
  ) async {
    final path = p.join(lib, 'tooltip_generator_${_monotonic++}.dart');
    overlay.setOverlay(path, content: code, modificationStamp: DateTime.now().millisecondsSinceEpoch);

    final result = (await session.getResolvedUnit(path)) as ResolvedUnitResult;
    final linker = TooltipLinker._(packages);
    result.unit.visitChildren(linker);

    // Transform each tooltip: format code and extract dartdoc links
    final imports = code
        .split('\n')
        .skipWhile((l) => l.trim().isEmpty || l.trimLeft().startsWith('//') || l.trimLeft().startsWith('library'))
        .takeWhile((l) => l.startsWith('import ') || l.trim().isEmpty)
        .toList()
        .join('\n');

    for (final tooltip in linker.tooltips) {
      final snippet = tooltip.snippet;
      tooltip.snippet = await Stubber.generate(
        session,
        overlay,
        packages,
        imports,
        snippet.text,
        snippet.kind,
        snippet.container,
      );
    }

    return (linker.links, linker.tooltips);
  }

  final List<Tooltip> tooltips = [];

  TooltipLinker._(super.packages);

  /// Adds tooltips for property access and method tear-offs where both parts are compile-time identifiers.
  ///
  /// Handles expressions like `FIcons.anchor` or `instance.property`. For static accesses, the tooltip spans the entire
  /// expression; for instance accesses, it spans only the identifier.
  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    switch (node.element) {
      // Static accesses like `FIcons.anchor` or `instance.property`.
      case final PropertyAccessorElement element when _forui(element):
        tooltip(
          element.isStatic ? node : node.identifier,
          element.nonSynthetic is FieldElement ? .field : .getter,
          element.nonSynthetic.toString(),
          element.enclosingElement,
        );

      // Method tear-offs like `int.parse` or `controller.submit`.
      case final MethodElement element when _forui(element):
        tooltip(element.isStatic ? node : node.identifier, .method, element.toString(), element.enclosingElement);
    }
    super.visitPrefixedIdentifier(node);
  }

  /// Adds tooltips for property access where the target is an expression.
  ///
  /// Handles expressions like `context.theme.paginationStyle`. See [visitPrefixedIdentifier] for compile-time identifiers.
  ///
  /// Also handles record field access like `FThemes.zinc.light` where the field has no element - links to the parent
  /// expression's element instead.
  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (node.propertyName.element case final element? when _forui(element)) {
      tooltip(
        node.propertyName,
        element.nonSynthetic is FieldElement ? .field : .getter,
        element.nonSynthetic.toString(),
        element.enclosingElement,
      );
    } else if (node.target?.staticType case final RecordType type) {
      // Record field access - show the field type, link to the parent expression's element.
      // This is messy because record fields have no elements. We only support named fields.
      final name = node.propertyName.name;
      if (type.namedFields.firstWhereOrNull((f) => f.name == name) case final field?) {
        if (recordElement(node.target!) case final element? when _forui(element)) {
          tooltip(node.propertyName, .field, '${field.type} $name');
        }
      }
    }
    super.visitPropertyAccess(node);
  }

  /// Adds tooltips for constructor invocations.
  ///
  /// Handles expressions like `FButton()` or `FButton.raw()`. See [visitDotShorthandConstructorInvocation] for dot
  /// shorthand constructors.
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName case ConstructorName(:final element?) when _forui(element)) {
      tooltip(
        node.constructorName,
        .constructor,
        // Replace parameterized type with non-parameterized type in constructor declaration.
        element.toString().replaceFirst(node.staticType?.getDisplayString() ?? '', element.enclosingElement.name ?? ''),
        node.staticType?.element,
      );
    }
    super.visitInstanceCreationExpression(node);
  }

  /// Adds tooltips for method invocations.
  ///
  /// Handles expressions like `instance.method()` or `FButtonStyle.ghost()`. See [visitDotShorthandInvocation] for dot
  /// shorthand methods.
  @override
  void visitMethodInvocation(MethodInvocation node) {
    switch (node.methodName.element) {
      case final TopLevelFunctionElement element when _forui(element):
        tooltip(node.methodName, .method, element.toString());

      case final MethodElement element when _forui(element):
        tooltip(node.methodName, .method, element.toString(), element.enclosingElement);
    }
    super.visitMethodInvocation(node);
  }

  /// Adds tooltips for dot shorthand property access.
  ///
  /// Handles dot shorthand syntax like `.zero` or `.infinity`.
  @override
  void visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node) {
    if (node.propertyName.element case final element? when _forui(element)) {
      tooltip(
        node.propertyName,
        element.nonSynthetic is FieldElement ? .field : .getter,
        element.nonSynthetic.toString(),
        element.enclosingElement,
      );
    }
    super.visitDotShorthandPropertyAccess(node);
  }

  /// Adds tooltips for dot shorthand constructor invocations.
  ///
  /// Handles dot shorthand syntax like `.new()` or `.named()`.
  @override
  void visitDotShorthandConstructorInvocation(DotShorthandConstructorInvocation node) {
    if (node.constructorName.element case final element? when _forui(element)) {
      tooltip(
        node.constructorName,
        .constructor,
        // Replace parameterized type with non-parameterized type in constructor declaration.
        element.toString().replaceFirst(
          node.staticType?.getDisplayString() ?? '',
          element.enclosingElement?.name ?? '',
        ),
        node.staticType?.element,
      );
    }
    super.visitDotShorthandConstructorInvocation(node);
  }

  /// Adds tooltips for dot shorthand method invocations.
  ///
  /// Handles dot shorthand syntax like `.parse()`.
  @override
  void visitDotShorthandInvocation(DotShorthandInvocation node) {
    if (node.memberName.element case final element? when _forui(element)) {
      tooltip(node.memberName, .method, element.nonSynthetic.toString(), node.staticType?.element);
    }
    super.visitDotShorthandInvocation(node);
  }

  /// Adds tooltips for named arguments showing the parameter declaration.
  ///
  /// Handles named arguments like `onPress:` in `FButton(onPress: () {})`.
  @override
  void visitNamedExpression(NamedExpression node) {
    if (node case NamedExpression(:final name, :final FormalParameterElement element) when _forui(element)) {
      tooltip(name, .formalParameter, element.toString());
    }
    super.visitNamedExpression(node);
  }

  /// Adds tooltips for lambda parameters.
  ///
  /// Handles parameters like `controller` in `(_, controller, _) => ...`.
  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    // Only handle parameters in function expressions (lambdas), not in method/function declarations.
    // Top-level functions are also considered function expressions but are part of FunctionDeclarations.
    if (node.parent?.parent is FunctionExpression && node.parent?.parent?.parent is NamedExpression) {
      if (node.declaredFragment?.element case final element?) {
        tooltip(node, .formalParameter, element.toString());
      }
    }

    super.visitSimpleFormalParameter(node);
  }

  bool _forui(Element element) => packages.any((p) => p.name == element.library?.uri.pathSegments.first);

  void tooltip(SyntacticEntity node, FragmentSnippetKind kind, String text, [Element? container]) {
    tooltips.add(
      Tooltip(
        node.offset,
        node.length,
        FragmentSnippet(text, kind, switch (container) {
          null => null,
          final e => switch (dartDocUrl(e)) {
            null => null,
            final url => (e.name ?? '', url),
          },
        }),
      ),
    );
  }
}

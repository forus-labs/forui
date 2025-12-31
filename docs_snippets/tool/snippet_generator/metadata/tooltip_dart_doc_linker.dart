import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import '../snippet.dart';
import '../transformations/tooltip_stubs.dart';
import 'dart_doc_linker.dart';
import 'link.dart';

/// Extends [DartDocLinker] to also generate tooltips showing element declarations.
///
/// The code in generated tooltips are neither formatted nor linked to dart docs. Those are done in a subsequent
/// step since the code requires transformation to become valid Dart code.
///
/// While [DartDocLinker] links identifiers to their DartDoc URLs, this class additionally creates [Tooltip]s that
/// display the source declaration of properties, methods, constructors, and parameters.
class TooltipDartDocLinker extends DartDocLinker {
  static int _monotonic = 0;

  /// Links DartDoc URLs and generates tooltips for [code].
  ///
  /// Returns both [DartDocLink]s (from the parent class) and [Tooltip]s for identifiers in [packages].
  static Future<(List<DartDocLink>, List<Tooltip>)> link(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String code,
    int importsLength,
  ) async {
    final syntheticPath = p.join(docsSnippets, 'tooltip_dart_doc_linker_${_monotonic++}.dart');
    overlay.setOverlay(syntheticPath, content: code, modificationStamp: DateTime.now().millisecondsSinceEpoch);

    final result = (await session.getResolvedUnit(syntheticPath)) as ResolvedUnitResult;
    final linker = TooltipDartDocLinker(packages, importsLength);
    result.unit.visitChildren(linker);

    // Transform each tooltip: format code and extract dartdoc links
    final imports = code.substring(0, importsLength);
    await Future.wait([
      for (final tooltip in linker.tooltips)
        TooltipStub.transform(session, overlay, packages, imports, tooltip),
    ]);

    return (linker.links, linker.tooltips);
  }

  final List<Tooltip> tooltips = [];

  TooltipDartDocLinker(super.packages, super.importsLength);

  /// Adds tooltips for property access and method tear-offs where both parts are compile-time identifiers.
  ///
  /// Handles expressions like `FIcons.anchor` or `instance.property`. For static accesses, the tooltip spans the entire
  /// expression; for instance accesses, it spans only the identifier.
  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    switch (node.element) {
      // Static accesses like `FIcons.anchor`.
      case final PropertyAccessorElement element when element.isStatic && _tooltip(element):
        tooltips.add(Tooltip(
          offset: node.offset,
          baseOffset: importsLength,
          length: node.length,
          target: element.nonSynthetic is FieldElement ? .field : .getter,
          code: element.nonSynthetic.toString(),
          container: _containerFromElement(element),
        ));

      // Instance accesses like `instance.property`.
      case final PropertyAccessorElement element when _tooltip(element):
        tooltips.add(Tooltip(
          offset: node.identifier.offset,
          baseOffset: importsLength,
          length: node.identifier.length,
          target: element.nonSynthetic is FieldElement ? .field : .getter,
          code: element.nonSynthetic.toString(),
          container: _containerFromElement(element),
        ));

      // Static method tear-offs like `int.parse`.
      case final MethodElement element when element.isStatic && _tooltip(element):
        tooltips.add(Tooltip(
          offset: node.offset,
          baseOffset: importsLength,
          length: node.length,
          target: .method,
          code: element.nonSynthetic.toString(),
          container: _containerFromElement(element),
        ));

      // Instance method tear-offs like `controller.submit`.
      case final MethodElement element when _tooltip(element):
        tooltips.add(Tooltip(
          offset: node.identifier.offset,
          baseOffset: importsLength,
          length: node.identifier.length,
          target: .method,
          code: element.nonSynthetic.toString(),
          container: _containerFromElement(element),
        ));
    }
    super.visitPrefixedIdentifier(node);
  }

  /// Adds tooltips for property access where the target is an expression.
  ///
  /// Handles expressions like `context.theme.paginationStyle`. See [visitPrefixedIdentifier] for compile-time identifiers.
  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (node.propertyName.element case final element? when _tooltip(element)) {
      tooltips.add(Tooltip(
        offset: node.propertyName.offset,
        baseOffset: importsLength,
        length: node.propertyName.length,
        target: element.nonSynthetic is FieldElement ? .field : .getter,
        code: element.nonSynthetic.toString(),
        container: _containerFromElement(element),
      ));
    }
    super.visitPropertyAccess(node);
  }

  /// Adds tooltips for constructor invocations.
  ///
  /// Handles expressions like `FButton()` or `FButton.raw()`. See [visitDotShorthandConstructorInvocation] for dot
  /// shorthand constructors.
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName case ConstructorName(
      :final offset,
      :final length,
      :final element?,
    ) when _tooltip(element)) {
      // Replace parameterized type with non-parameterized type in constructor declaration.
      final parameterizedType = node.staticType?.getDisplayString() ?? '';
      final type = element.enclosingElement.name ?? '';

      tooltips.add(
        Tooltip(
          offset: offset,
          baseOffset: importsLength,
          length: length,
          target: .constructor,
          code: element.toString().replaceFirst(parameterizedType, type),
          container: _containerFromType(node.staticType),
        ),
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
    if (node.methodName case SimpleIdentifier(
        :final offset,
        :final length,
        :final element?,
    ) when _tooltip(element)) {
      tooltips.add(
        Tooltip(
          offset: offset,
          baseOffset: importsLength,
          length: length,
          target: .method,
          code: element.toString(),
          container: _containerFromType(node.staticType),
        ),
      );
    }
    super.visitMethodInvocation(node);
  }

  /// Adds tooltips for dot shorthand property access.
  ///
  /// Handles dot shorthand syntax like `.zero` or `.infinity`.
  @override
  void visitDotShorthandPropertyAccess(DotShorthandPropertyAccess node) {
    if (node.propertyName.element case final element? when _tooltip(element)) {
      tooltips.add(Tooltip(
        offset: node.propertyName.offset,
        baseOffset: importsLength,
        length: node.propertyName.length,
        target: element.nonSynthetic is FieldElement ? .field : .getter,
        code: element.nonSynthetic.toString(),
        container: _containerFromElement(element),
      ));
    }
    super.visitDotShorthandPropertyAccess(node);
  }

  /// Adds tooltips for dot shorthand constructor invocations.
  ///
  /// Handles dot shorthand syntax like `.new()` or `.named()`.
  @override
  void visitDotShorthandConstructorInvocation(DotShorthandConstructorInvocation node) {
    if (node.constructorName.element case final element? when _tooltip(element)) {
      // Replace parameterized type with non-parameterized type in constructor declaration.
      final parameterizedType = node.staticType?.getDisplayString() ?? '';
      final type = element.enclosingElement?.name ?? '';

      tooltips.add(Tooltip(
        offset: node.constructorName.offset,
        baseOffset: importsLength,
        length: node.constructorName.length,
        target: .constructor,
        code: element.toString().replaceFirst(parameterizedType, type),
        container: _containerFromType(node.staticType),
      ));
    }
    super.visitDotShorthandConstructorInvocation(node);
  }

  /// Adds tooltips for dot shorthand method invocations.
  ///
  /// Handles dot shorthand syntax like `.parse()`.
  @override
  void visitDotShorthandInvocation(DotShorthandInvocation node) {
    if (node.memberName.element case final element? when _tooltip(element)) {
      tooltips.add(Tooltip(
        offset: node.memberName.offset,
        baseOffset: importsLength,
        length: node.memberName.length,
        target: .method,
        code: element.nonSynthetic.toString(),
        container: _containerFromType(node.staticType),
      ));
    }
    super.visitDotShorthandInvocation(node);
  }

  /// Adds tooltips for named arguments showing the parameter declaration.
  ///
  /// Handles named arguments like `onPress:` in `FButton(onPress: () {})`.
  @override
  void visitNamedExpression(NamedExpression node) {
    if (node case NamedExpression(:final name, :final FormalParameterElement element) when _tooltip(element)) {
      tooltips.add(Tooltip(
        offset: name.offset,
        baseOffset: importsLength,
        length: name.length,
        target: .formalParameter,
        code: element.toString(),
      ));
    }
    super.visitNamedExpression(node);
  }

  /// Adds tooltips for ALL function expression parameters.
  ///
  /// Handles parameters like `controller` in `(_, controller, _) => ...`.
  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    // Only handle parameters in function expressions (lambdas), not in method/function declarations.
    if (node.parent?.parent is! FunctionExpression) {
      super.visitSimpleFormalParameter(node);
      return;
    }

    if (node.declaredFragment?.element case final element?) {
      tooltips.add(Tooltip(
        offset: node.offset,
        baseOffset: importsLength,
        length: node.length,
        target: .formalParameter,
        code: element.toString(),
      ));
    }
    super.visitSimpleFormalParameter(node);
  }

  bool _tooltip(Element element) => packages.any((p) => p.name == element.library?.uri.pathSegments.first);

  (String, String)? _containerFromElement(Element element) {
    if (element.enclosingElement case final enclosing?) {
      if (dartDocUrl(packages, enclosing) case final url?) {
        return (enclosing.name ?? '', url);
      }
    }

    return null;
  }

  (String, String)? _containerFromType(DartType? type) {
    if (type?.element case final element?) {
      if (dartDocUrl(packages, element) case final url?) {
        return (element.name ?? '', url);
      }
    }

    return null;
  }
}

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import '../snippet.dart';
import 'link.dart';

/// A visitor that adds Dartdoc links to AST nodes.
class DartDocLinker extends RecursiveAstVisitor<void> {
  static int _monotonic = 0;

  /// Generates DartDoc links for identifiers in [code] that belong to [packages].
  ///
  /// Creates a synthetic file from [code], resolves it using [session], and visits the AST to find linkable identifiers.
  /// The [importsLength] is subtracted from offsets to account for any prefix removed from the original code.
  static Future<List<DartDocLink>> link(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String code,
    int importsLength,
  ) async {
    final syntheticPath = p.join(docsSnippets, 'dart_doc_linker_${_monotonic++}.dart');
    overlay.setOverlay(syntheticPath, content: code, modificationStamp: DateTime.now().millisecondsSinceEpoch);

    final result = (await session.getResolvedUnit(syntheticPath)) as ResolvedUnitResult;
    final linker = DartDocLinker(packages, importsLength);
    result.unit.visitChildren(linker);

    return linker.links;
  }

  final List<DartDocLink> links = [];
  final int importsLength;
  final List<Package> packages;

  DartDocLinker(this.packages, this.importsLength);

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
      _link(node.offset, node.length, node.element!);
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
      // Link entire "Type.property" for static accesses like `FIcons.anchor`.
      case final PropertyAccessorElement element when element.isStatic:
        // Const fields are synthetic and treated as property accesses, causing the links to be incorrectly generated.
        _link(node.offset, node.length, element.nonSynthetic);

      // Link just the property name for instance accesses like `instance.property`.
      case final PropertyAccessorElement element:
        _link(node.identifier.offset, node.identifier.length, element);

      // Link entire "Type.method" for static method tear-offs like `int.parse`.
      case final MethodElement element when element.isStatic:
        _link(node.offset, node.length, element);

      // Link just the method name for instance method tear-offs like `controller.submit`.
      case final MethodElement element:
        _link(node.identifier.offset, node.identifier.length, element);
    }

    super.visitPrefixedIdentifier(node);
  }

  /// Links property access and method tear-offs where the target is an expression.
  ///
  /// Handles expressions like `context.theme.paginationStyle` or `object.nested.method` where the target is an
  /// expression rather than a compile-time identifier. [visitPrefixedIdentifier] handles `prefix.identifier` where
  /// both parts are compile-time identifiers.
  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (node.propertyName.element case final element?) {
      _link(node.propertyName.offset, node.propertyName.length, element);
    }
    super.visitPropertyAccess(node);
  }

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
        _link(node.methodName.offset, node.methodName.length, element);

      // Link entire "Type.method" for static calls like `FButtonStyle.ghost()`.
      case final MethodElement element when element.isStatic:
        final start = node.target!.offset;
        final end = node.methodName.offset + node.methodName.length;
        _link(start, end - start, element);

      // Link just the method name for instance calls like `instance.method()`.
      case final MethodElement element:
        _link(node.methodName.offset, node.methodName.length, element);
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
      _link(node.constructorName.offset, node.constructorName.length, element);
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
      _link(node.propertyName.offset, node.propertyName.length, element.nonSynthetic);
    }
    super.visitDotShorthandPropertyAccess(node);
  }

  /// Links dot shorthand **method** invocations to their method documentation.
  ///
  /// Handles dot shorthand syntax like `.method()`.
  @override
  void visitDotShorthandInvocation(DotShorthandInvocation node) {
    if (node.memberName.element case final element?) {
      _link(node.memberName.offset, node.memberName.length, element);
    }
    super.visitDotShorthandInvocation(node);
  }

  /// Links dot shorthand **constructor** invocations to their constructor documentation.
  ///
  /// Handles dot shorthand syntax like `.constructor()`.
  @override
  void visitDotShorthandConstructorInvocation(DotShorthandConstructorInvocation node) {
    if (node.constructorName.element case final element?) {
      _link(node.constructorName.offset, node.constructorName.length, element);
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
          _link(node.name.label.offset, node.name.label.length, function);

        case final ConstructorElement constructor:
          final classElement = constructor.enclosingElement;
          final field = classElement.getField(name);
          if (field == null) {
            // Link to the constructor for named parameters that don't correspond to fields.
            _link(node.name.label.offset, node.name.label.length, constructor);
          } else {
            // Link to the field for named parameters that correspond to fields.
            _link(node.name.label.offset, node.name.label.length, field);
          }

        case final MethodElement method:
          // Link to the method for named parameters.
          _link(node.name.label.offset, node.name.label.length, method);
      }
    }
    super.visitNamedExpression(node);
  }

  /// Adds a link for [element] at the given [offset] and [length].
  void _link(int offset, int length, Element element) {
    if (dartDocUrl(packages, element) case final url?) {
      links.add(DartDocLink(offset: offset, baseOffset: importsLength, length: length, url: url));
    }
  }
}

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import '../snippet.dart';

/// Returns the URL for [element], or null if it shouldn't be linked.
String? url(List<Package> packages, Element element) {
  final n = element.library?.uri.pathSegments.first;
  if (packages.firstWhereOrNull((p) => p.name == n) case Package(name: final package, :final version)) {
    final type = switch (element) {
      FieldElement(:final enclosingElement) => enclosingElement.name,
      PropertyAccessorElement(:final enclosingElement) => enclosingElement.name,
      ConstructorElement(:final enclosingElement) => enclosingElement.name,
      MethodElement(:final enclosingElement?) => enclosingElement.name,
      _ => element.name,
    };

    var baseUrl = '';
    for (final Package(:library) in packages) {
      if (_barrel(library, type!)?.name case final name?) {
        baseUrl = 'https://pub.dev/documentation/$package/$version/${name.isEmpty ? package : name}';
        break;
      }
    }

    assert(baseUrl.isNotEmpty, 'Could not find barrel library for type "$type" in package "$package".');

    return switch (element) {
      TopLevelFunctionElement(:final name) => '$baseUrl/$name.html',
      EnumElement(:final name) => '$baseUrl/$name.html',
      MixinElement(:final name) => '$baseUrl/$name-mixin.html',
      ClassElement(:final name) || InterfaceElement(:final name) => '$baseUrl/$name-class.html',
      FieldElement(:final enclosingElement, :final name, :final isEnumConstant) when isEnumConstant =>
      '$baseUrl/${enclosingElement.name}.html#$name',
      FieldElement(:final enclosingElement, :final name, :final isConst) when isConst =>
      '$baseUrl/${enclosingElement.name}/$name-constant.html',
      FieldElement(:final enclosingElement, :final name) => '$baseUrl/${enclosingElement.name}/$name.html',
      PropertyAccessorElement(:final enclosingElement, :final name) => '$baseUrl/${enclosingElement.name}/$name.html',
      ConstructorElement(:final enclosingElement, :final name?) =>
      '$baseUrl/${enclosingElement.name}/${enclosingElement.name}${name == 'new' ? '' : '.$name'}.html',
      MethodElement(:final enclosingElement?, :final name) => '$baseUrl/${enclosingElement.name}/$name.html',
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

/// Links DartDoc URLs in [Snippet]s.
class DartDocLinker extends RecursiveAstVisitor<void> {
  static int _monotonic = 0;

  static Future<List<DartDocLink>> link(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String code,
    int baseOffset,
  ) async {
    final syntheticPath = p.join(samples, 'snippet_${_monotonic++}.dart');
    overlay.setOverlay(syntheticPath, content: code, modificationStamp: DateTime.now().millisecondsSinceEpoch);

    final result = (await session.getResolvedUnit(syntheticPath)) as ResolvedUnitResult;
    final linker = DartDocLinker._(packages, baseOffset);
    result.unit.visitChildren(linker);

    return linker.links;
  }

  final List<DartDocLink> links = [];
  final int _baseOffset;
  final List<Package> _packages;

  DartDocLinker._(this._packages, this._baseOffset);

  /// Links type annotations to their class/enum/mixin documentation.
  ///
  /// Handles standalone type references like `FButton`, `String`, or `List<int>`. Skips types that are part of
  /// constructor calls (e.g., `FButton` in `FButton()`) since those are handled by [visitInstanceCreationExpression].
  @override
  void visitNamedType(NamedType node) {
    if (node.parent is! ConstructorName && node.element != null) {
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
    if (url(_packages, element) case final url?) {
      links.add(DartDocLink(offset: offset, baseOffset: _baseOffset, length: length, url: url));
    }
  }
}

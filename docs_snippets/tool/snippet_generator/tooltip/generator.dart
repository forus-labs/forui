import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import '../main.dart';
import 'stubber.dart';
import '../dart_doc_linker.dart';

/// The kind of identifier that a tooltip describes.
enum TooltipTarget { field, getter, method, constructor, formalParameter }

/// A tooltip for an identifier.
class Tooltip {
  /// The character offset where the linked identifier starts.
  int offset;

  /// The length of the linked identifier.
  final int length;

  /// The kind of identifier that this tooltip describes.
  final TooltipTarget target;

  /// The source code.
  String code;

  /// The links within the tooltip code (for types, etc.).
  final List<DartDocLink> links = [];

  /// The identifier's containing class.
  ///
  /// For constructors, fields and methods: `containing class <class>`.
  final (String name, String url)? container;

  /// The markdown documentation.
  final String documentation;

  Tooltip({
    required this.offset,
    required this.length,
    required this.target,
    required this.code,
    this.container,
    this.documentation = '',
  });

  Map<String, dynamic> toJson() => {
    'offset': offset,
    'length': length,
    'code': code,
    'links': [for (final l in links) l.toJson()],
    if (container != null) 'container': {'name': container!.$1, 'url': container!.$2},
    'documentation': documentation,
  };
}

/// A [DartDocLinker] that additionally creates [Tooltip]s that display the source declaration of properties, methods,
/// constructors, and parameters.
class TooltipGenerator extends DartDocLinker {
  static int _monotonic = 0;

  /// Links DartDoc URLs and generates tooltips for [code].
  static Future<(List<DartDocLink>, List<Tooltip>)> generate(
    AnalysisSession session,
    OverlayResourceProvider overlay,
    List<Package> packages,
    String code,
    int importsLength,
  ) async {
    final path = p.join(docsSnippets, 'tooltip_generator_${_monotonic++}.dart');
    overlay.setOverlay(path, content: code, modificationStamp: DateTime.now().millisecondsSinceEpoch);

    final result = (await session.getResolvedUnit(path)) as ResolvedUnitResult;
    final linker = TooltipGenerator._(packages, importsLength);
    result.unit.visitChildren(linker);

    // Transform each tooltip: format code and extract dartdoc links
    final imports = code.substring(0, importsLength);
    await Future.wait([
      for (final tooltip in linker.tooltips) TooltipStubber.generate(session, overlay, packages, imports, tooltip),
    ]);

    return (linker.links, linker.tooltips);
  }

  final List<Tooltip> tooltips = [];

  TooltipGenerator._(super.packages, super.importsLength);

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
  @override
  void visitPropertyAccess(PropertyAccess node) {
    if (node.propertyName.element case final element? when _forui(element)) {
      tooltip(
        node.propertyName,
        element.nonSynthetic is FieldElement ? .field : .getter,
        element.nonSynthetic.toString(),
        element.enclosingElement,
      );
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
    if (node.methodName case SimpleIdentifier(:final element?) when _forui(element)) {
      tooltip(node.methodName, .method, element.toString(), node.staticType?.element);
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
      tooltip(node, .formalParameter, element.toString());
    }
    super.visitSimpleFormalParameter(node);
  }

  bool _forui(Element element) => packages.any((p) => p.name == element.library?.uri.pathSegments.first);

  void tooltip(SyntacticEntity node, TooltipTarget target, String code, [Element? container]) {
    tooltips.add(
      Tooltip(
        offset: node.offset - importsLength,
        length: node.length,
        target: target,
        code: code,
        container: switch (container) {
          null => null,
          final e => switch (dartDocUrl(e)) {
            null => null,
            final url => (e.name ?? '', url),
          },
        },
      ),
    );
  }
}

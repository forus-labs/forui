import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:path/path.dart' as p;

import 'main.dart';

var _counter = 0;

class DartDocLink {
  final int offset;
  final int length;
  final String url;

  DartDocLink({required this.offset, required this.length, required this.url});

  Map<String, dynamic> toJson() => {'offset': offset, 'length': length, 'url': url};
}

Future<void> transformLinks(Snippet snippet, AnalysisSession session, OverlayResourceProvider overlay) async {
  final syntheticPath = p.join(samples, 'snippet_${_counter++}.dart');
  overlay.setOverlay(syntheticPath, content: snippet.source, modificationStamp: DateTime.now().millisecondsSinceEpoch);

  final result = await session.getResolvedUnit(syntheticPath);
  if (result is! ResolvedUnitResult) {
    return;
  }

  if (await session.getLibraryByUri('package:forui/forui.dart') case LibraryElementResult(:final element)) {
    final visitor = _DartdocLinkVisitor(element);
    result.unit.visitChildren(visitor);
    snippet.links.addAll(visitor.links);
  }
}

class _DartdocLinkVisitor extends RecursiveAstVisitor<void> {
  final LibraryElement _forui;
  final List<DartDocLink> links = [];

  _DartdocLinkVisitor(this._forui);

  @override
  void visitNamedType(NamedType node) {
    // Skip if part of constructor call (handled by visitInstanceCreationExpression)
    if (node.parent is! ConstructorName && node.element != null) {
      _link(node.offset, node.length, node.element!);
    }
    super.visitNamedType(node);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.element case final element?) {
      _link(node.constructorName.offset, node.constructorName.length, element);
    }
    super.visitInstanceCreationExpression(node);
  }

  @override
  void visitDotShorthandInvocation(DotShorthandInvocation node) {
    // Links dot shorthand constructor/method calls like .managed().
    if (node.memberName.element case final element?) {
      _link(node.memberName.offset, node.memberName.length, element);
    }
    super.visitDotShorthandInvocation(node);
  }

  @override
  void visitNamedExpression(NamedExpression node) {
    // Links named parameters in constructor calls to field docs.
    // e.g., FButton(onPress: ...) -> links "onPress" to FButton.onPress field docs
    // Only links if the parameter corresponds to a field in the class.
    if (node.element case final FormalParameterElement element?) {
      if (element.enclosingElement case final ConstructorElement constructor) {
        final classElement = constructor.enclosingElement;
        if (element.name case final parameter?) {
          final field = classElement.getField(parameter);
          if (field != null) {
            _link(node.name.label.offset, node.name.label.length, field);
          }
        }
      }
    }
    super.visitNamedExpression(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    final element = node.element;
    if (element is PropertyAccessorElement && element.isStatic) {
      _link(node.offset, node.length, element.variable);
    }
    super.visitPrefixedIdentifier(node);
  }

  void _link(int offset, int length, Element element) {
    if (_url(element) case final url?) {
      links.add(DartDocLink(offset: offset, length: length, url: url));
    }
  }

  String? _url(Element element) {
    final library = element.library;
    if (library == null) {
      return null;
    }

    final uri = library.uri;
    final package = uri.pathSegments.first;
    if (package != 'forui') {
      return null;
    }

    final name = switch (element) {
      ConstructorElement(:final enclosingElement) => enclosingElement.name,
      FieldElement(:final enclosingElement) => enclosingElement.name,
      MethodElement(:final InterfaceElement enclosingElement) => enclosingElement.name,
      _ => element.name,
    };

    var barrel = _barrel(_forui, name!).uri.pathSegments.join('.');
    barrel = barrel.substring(0, barrel.length - 5); // Remove .dart

    return switch (element) {
      ConstructorElement(:final enclosingElement, :final name) =>
        'https://pub.dev/documentation/$package/latest/$barrel/${enclosingElement.name}/${enclosingElement.name}${name == null || name == 'new' ? '' : '.$name'}.html',
      ClassElement(:final name) ||
      InterfaceElement(:final name) => 'https://pub.dev/documentation/$package/latest/$barrel/$name-class.html',
      FieldElement(:final enclosingElement, :final name) =>
        'https://pub.dev/documentation/$package/latest/$barrel/${enclosingElement.name}/$name.html',
      MethodElement(:final InterfaceElement enclosingElement, :final name) =>
        'https://pub.dev/documentation/$package/latest/$barrel/${enclosingElement.name}/$name.html',
      _ => null,
    };
  }

  LibraryElement _barrel(LibraryElement library, String name) {
    for (final sublibrary in library.exportedLibraries) {
      if (sublibrary.uri.pathSegments.contains('src')) {
        continue;
      }

      if (sublibrary.exportNamespace.get2(name) != null) {
        return _barrel(sublibrary, name);
      }
    }

    return library;
  }
}

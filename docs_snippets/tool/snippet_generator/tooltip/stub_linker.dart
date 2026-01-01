import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

import '../dart_doc_linker.dart';

/// A [DartDocLinker] subclass for processing tooltip stubs.
///
/// When tooltip stubs wrap constructors like `class FCalendar { FCalendar({required this.control}); }`,
/// the stub class has no fields. This linker looks up the **actual type* from packages to find field declarations for
/// parameters.
class StubLinker extends DartDocLinker {
  /// The container class name.
  final String? container;

  StubLinker(super.packages, super.importsLength, {this.container});

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
      link(node.name, function);
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

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

import '../dart_doc_linker.dart';

/// A [DartDocLinker] subclass for processing tooltip stubs.
///
/// When tooltip stubs wrap constructors like `class FCalendar { FCalendar({required this.control}); }`,
/// the stub class has no fields. This linker looks up the **actual type* from packages to find field declarations for
/// parameters.
class StubLinker extends DartDocLinker {
  StubLinker(super.packages, super.importsLength);

  @override
  void visitDefaultFormalParameter(DefaultFormalParameter node) {
    if (node.parameter.declaredFragment?.element case Element(:final enclosingElement?)) {
      if (enclosingElement case ConstructorElement(:final name?, :final enclosingElement) when node.name != null) {
        // Find the actual type from packages (not the stub).
        if (_type(enclosingElement.name) case final type?) {
          final field = type.getField(name);
          final constructor = name == 'new' ? type.unnamedConstructor : type.getNamedConstructor(name);

          if (field != null || constructor != null) {
            link(node.name!, field ?? constructor!);
          }
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
}

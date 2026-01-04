import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_route_generator/utils.dart';

/// Holds parsed values from an `@Options` annotation.
class Options {
  final List<Element> include;
  final DartType? inline;

  factory Options.extract(ClassDeclaration declaration) {
    final visitor = _Visitor()..visitClassDeclaration(declaration);
    return visitor.options ?? Options();
  }

  Options({this.include = const [], this.inline})
    : assert(inline == null || inline is InterfaceType, 'inline must be a class type: ${inline.getDisplayString()}');
}

/// A visitor that parses the `@Options` annotation from class metadata.
class _Visitor extends RecursiveAstVisitor<void> {
  Options? options;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.metadata.firstWhereOrNull((a) => a.name.name == 'Options') case final annotation?) {
      final value = annotation.elementAnnotation!.computeConstantValue()!;
      final include = <Element>[
        for (final object in value.getField('include')?.toListValue() ?? <DartObject>[])
          // Type literal: SomeClass
          if (object.toTypeValue()?.element case final element?)
            element
          // Function tear-off: someFunction
          else if (object.toFunctionValue() case final element?)
            element
          // Const field: someConstField
          else if (object.variable case final variable?)
            variable
          else
            throw ArgumentError('Unsupported include type: $object'),
      ];
      final inline = value.getField('inline')?.toTypeValue();
      options = Options(include: include, inline: inline);
    }
  }
}

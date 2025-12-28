import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_route_generator/utils.dart';

/// Holds parsed values from an `@Options` annotation.
class Options {
  final List<DartType> include;
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
      final include = [
        for (final type in value.getField('include')?.toListValue() ?? <DartObject>[]) ?type.toTypeValue(),
      ];
      final inline = value.getField('inline')?.toTypeValue();
      options = Options(include: include, inline: inline);
    }
  }
}

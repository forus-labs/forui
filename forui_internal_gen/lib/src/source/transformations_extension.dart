import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

/// Generates an extension.
///
/// The copyWith function is generated in an extension rather than on a mixin/augmentation to make the function
/// non-virtual. This prevents conflicts between base and subclasses.
@internal
class TransformationsExtension {
  /// The type.
  @protected
  final ClassElement2 element;

  /// The fields.
  @protected
  final List<FieldElement2> fields;

  /// The copyWith documentation comments.
  @protected
  final List<String> copyWithDocsHeader;

  /// Creates a [TransformationsExtension].
  TransformationsExtension(this.element, {required this.copyWithDocsHeader}) : fields = instanceFields(element);

  /// Generates an extension that provides non virtual transforming methods.
  Extension generate() =>
      (ExtensionBuilder()
            ..docs.addAll(['/// Provides a [copyWith] method.'])
            ..name = '\$${element.name3!}Transformations'
            ..on = refer(element.name3!)
            ..methods.addAll([copyWith]))
          .build();

  /// Generates a copyWith method that allows for creating a new instance of the style with modified properties.
  @protected
  Method get copyWith {
    // Copy the documentation comments from the fields.
    final docs = ['/// ## Parameters'];

    for (final field in fields) {
      final prefix = '/// * [${element.name3}.${field.name3}]';
      final lines = field.documentationComment?.split('\n') ?? const <String>[];

      switch (lines.firstOrNull) {
        case final comment? when comment.startsWith('/// {@macro'):
          docs.add('$prefix - \n$comment');
          continue;

        case final comment? when comment.startsWith('/// {@template'):
          final summary = lines.skip(1).join('\n').replaceFirst('/// ', '').split('.').firstOrNull;
          final suffix = summary == null ? '' : ' - $summary.';
          docs.add('$prefix$suffix');
          continue;

        default:
          final summary = field.documentationComment?.replaceFirst('/// ', '').split('.').firstOrNull;
          final suffix = summary == null ? '' : ' - $summary.';
          docs.add('$prefix$suffix');
          continue;
      }
    }

    // Generate assignments for the copyWith method body
    final assignments = fields.map((f) {
      if (nestedMotion(f.type) || nestedStyle(f.type)) {
        return '${f.name3}: ${f.name3} != null ? ${f.name3}(this.${f.name3}) : this.${f.name3},';
      } else {
        return '${f.name3}: ${f.name3} ?? this.${f.name3},';
      }
    }).join();

    return Method(
      (m) => m
        ..returns = refer(element.name3!)
        ..docs.addAll([...copyWithDocsHeader, ...docs])
        ..annotations.add(refer('useResult'))
        ..name = 'copyWith'
        ..optionalParameters.addAll([
          for (final field in fields)
            if (nestedMotion(field.type))
              Parameter(
                (p) => p
                  ..name = field.name3!
                  ..type = refer('${field.type.getDisplayString()} Function(${field.type.getDisplayString()} motion)?')
                  ..named = true,
              )
            else if (nestedStyle(field.type))
              Parameter(
                (p) => p
                  ..name = field.name3!
                  ..type = refer('${field.type.getDisplayString()} Function(${field.type.getDisplayString()} style)?')
                  ..named = true,
              )
            else
              Parameter(
                (p) => p
                  ..name = field.name3!
                  ..type = refer(
                    field.type.getDisplayString().endsWith('?')
                        ? field.type.getDisplayString()
                        : '${field.type.getDisplayString()}?',
                  )
                  ..named = true,
              ),
        ])
        ..lambda = true
        ..body = Code('${element.name3!}($assignments)\n'),
    );
  }

  /// Checks if the type is a nested motion.
  @protected
  bool nestedMotion(DartType type) {
    final typeName = type.getDisplayString();
    return typeName.startsWith('F') && typeName.endsWith('Motion');
  }

  /// Checks if the type is a nested style.
  @protected
  bool nestedStyle(DartType type) {
    final typeName = type.getDisplayString();
    return (typeName.startsWith('F') && !typeName.startsWith('FInherited')) &&
        (typeName.endsWith('Style') || typeName.endsWith('Styles'));
  }
}

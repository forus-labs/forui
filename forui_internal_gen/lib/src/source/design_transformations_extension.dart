import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/transformations_extension.dart';
import 'package:forui_internal_gen/src/source/types.dart';

/// Generates a [TransformationsExtension] that provides `copyWith` and `lerp` methods.
class DesignTransformationsExtension extends TransformationsExtension {
  /// Creates a [DesignTransformationsExtension].
  DesignTransformationsExtension(super.element, {required super.copyWithDocsHeader});

  /// Generates an extension that provides non virtual transforming methods.
  @override
  Extension generate() =>
      (ExtensionBuilder()
            ..docs.addAll(['/// Provides [copyWith] and [lerp] methods.'])
            ..name = '\$${element.name!}Transformations'
            ..on = refer(element.name!)
            ..methods.addAll([copyWith, _lerp]))
          .build();

  Method get _lerp {
    String invocation(FieldElement field) {
      final type = field.type;
      final name = field.name!;

      // DO NOT REORDER, we need the subclass (Alignment) to dominate the superclass (AlignmentGeometry) pattern.
      return switch (type) {
        _
            when alignmentGeometry.isAssignableFromType(type) ||
                borderRadiusGeometry.isAssignableFromType(type) ||
                boxConstraints.isAssignableFromType(type) ||
                decoration.isAssignableFromType(type) ||
                color.isAssignableFromType(type) ||
                edgeInsetsGeometry.isAssignableFromType(type) ||
                textStyle.isAssignableFromType(type) =>
          '.lerp($name, other.$name, t) ?? $name',
        //
        _ when iconThemeData.isAssignableFromType(type) => '.lerp($name, other.$name, t)',
        //
        _ when doubleType.isAssignableFromType(type) => 'lerpDouble($name, other.$name, t) ?? $name',
        // List<BoxShadow>/List<Shadow>
        _ when list.isAssignableFromType(type) && type is ParameterizedType => switch (type.typeArguments.single) {
          final t when boxShadow.isAssignableFromType(t) => 'BoxShadow.lerpList($name, other.$name, t) ?? $name',
          final t when shadow.isAssignableFromType(t) => 'Shadow.lerpList($name, other.$name, t) ?? $name',
          _ => 't < 0.5 ? $name : other.$name',
        },
        // FWidgetStateMap<T>/FWidgetStateMap<T?>
        _ when fWidgetStateMap.isAssignableFromType(type) && type is ParameterizedType => switch (type
            .typeArguments
            .single) {
          final t when boxDecoration.isAssignableFromType(t) && t.nullabilitySuffix == .none =>
            '.lerpBoxDecoration($name, other.$name, t)',
          final t when boxDecoration.isAssignableFromType(t) => '.lerpWhere($name, other.$name, t, BoxDecoration.lerp)',
          //
          final t when color.isAssignableFromType(t) && t.nullabilitySuffix == .none =>
            '.lerpColor($name, other.$name, t)',
          final t when color.isAssignableFromType(t) => '.lerpWhere($name, other.$name, t, Color.lerp)',
          //
          final t when iconThemeData.isAssignableFromType(t) && t.nullabilitySuffix == .none =>
            '.lerpIconThemeData($name, other.$name, t)',
          final t when iconThemeData.isAssignableFromType(t) => '.lerpWhere($name, other.$name, t, IconThemeData.lerp)',
          //
          final t when textStyle.isAssignableFromType(t) && t.nullabilitySuffix == .none =>
            '.lerpTextStyle($name, other.$name, t)',
          final t when textStyle.isAssignableFromType(t) => '.lerpWhere($name, other.$name, t, TextStyle.lerp)',
          //
          _ => 't < 0.5 ? $name : other.$name',
        },
        // Nested motion/style
        _ when nestedMotion(type) || nestedStyle(type) => '$name.lerp(other.$name, t)',
        //
        _ => 't < 0.5 ? $name : other.$name',
      };
    }

    // Generate field assignments for the lerp method body.
    final assignments = [for (final field in fields) '${field.name}: ${invocation(field)},'].join();

    return Method(
      (m) => m
        ..returns = refer(element.name!)
        ..docs.addAll([
          '/// Linearly interpolate between this and another [${element.name!}] using the given factor [t].',
        ])
        ..annotations.add(refer('useResult'))
        ..name = 'lerp'
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'other'
              ..type = refer(element.name!),
          ),
          Parameter(
            (p) => p
              ..name = 't'
              ..type = refer('double'),
          ),
        ])
        ..lambda = true
        ..body = Code('.new($assignments)\n'),
    );
  }
}

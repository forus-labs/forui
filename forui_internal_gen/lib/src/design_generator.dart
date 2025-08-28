import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:forui_internal_gen/src/source/transformations_extension.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:source_gen/source_gen.dart';

final _style = RegExp(r'^F.*(Style|Styles)$');
final _motion = RegExp(r'^F.*(Motion)$');

/// Generates corresponding style/motion mixins and extensions that implement several commonly used operations.
class DesignGenerator extends Generator {
  final _emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

  @override
  Future<String?> generate(LibraryReader library, BuildStep step) async {
    final generated = <String>[];
    for (final type in library.classes) {
      if (type.name3 == null && type.isSealed || type.isAbstract) {
        continue;
      }

      if (_style.hasMatch(type.name3!)) {
        generated
          ..add(
            _emitter
                .visitExtension(
                  DesignTransformationsExtension(
                    type,
                    copyWithDocsHeader: [
                      '/// Returns a copy of this [${type.name3!}] with the given properties replaced.',
                      '///',
                      '/// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).',
                      '///',
                    ],
                  ).generate(),
                )
                .toString(),
          )
          ..add(
            _emitter
                .visitMixin(
                  FunctionsMixin(type, [
                    '/// Returns itself.',
                    '/// ',
                    "/// Allows [${type.name3}] to replace functions that accept and return a [${type.name3}], such as a style's",
                    '/// `copyWith(...)` function.',
                    '/// ',
                    '/// ## Example',
                    '/// ',
                    '/// Given:',
                    '/// ```dart',
                    '/// void copyWith(${type.name3} Function(${type.name3}) nestedStyle) {}',
                    '/// ```',
                    '/// ',
                    '/// The following:',
                    '/// ```dart',
                    '/// copyWith((style) => ${type.name3}(...));',
                    '/// ```',
                    '/// ',
                    '/// Can be replaced with:',
                    '/// ```dart',
                    '/// copyWith(${type.name3}(...));',
                    '/// ```',
                  ]).generate(),
                )
                .toString(),
          );
      } else if (_motion.hasMatch(type.name3!)) {
        generated
          ..add(
            _emitter
                .visitExtension(
              DesignTransformationsExtension(
                type,
                copyWithDocsHeader: [
                  '/// Returns a copy of this [${type.name3!}] with the given properties replaced.',
                  '///',
                ],
              ).generate(),
            )
                .toString(),
          )
          ..add(
            _emitter
                .visitMixin(
              FunctionsMixin(type, [
                '/// Returns itself.',
              ]).generate(),
            )
                .toString(),
          );

      } else if (type.name3 == 'FThemeData') {
        generated.add(_emitter.visitMixin(FunctionsMixin(type, ['/// Returns itself.']).generate()).toString());
      }
    }

    return generated.join('\n');
  }
}

/// Generates a `TransformationsExtension` that provides `copyWith` and `lerp` methods.
class DesignTransformationsExtension extends TransformationsExtension {
  /// Creates a [DesignTransformationsExtension].
  DesignTransformationsExtension(super.element, {required super.copyWithDocsHeader});

  /// Generates an extension that provides non virtual transforming methods.
  @override
  Extension generate() =>
      (ExtensionBuilder()
            ..docs.addAll(['/// Provides [copyWith] and [lerp] methods.'])
            ..name = '\$${element.name3!}Transformations'
            ..on = refer(element.name3!)
            ..methods.addAll([copyWith, _lerp]))
          .build();

  Method get _lerp {
    String invocation(FieldElement2 field) {
      final type = field.type;
      final name = field.name3!;

      // DO NOT REORDER, we need the subclass (Alignment) to dominate the superclass (AlignmentGeometry) pattern.
      return switch (type) {
        _ when doubleType.isAssignableFromType(type) => 'lerpDouble($name, other.$name, t) ?? $name',
        //
        _ when alignment.isAssignableFromType(type) => 'Alignment.lerp($name, other.$name, t) ?? $name',
        _ when alignmentGeometry.isAssignableFromType(type) => 'AlignmentGeometry.lerp($name, other.$name, t) ?? $name',
        //
        _ when borderRadius.isAssignableFromType(type) => 'BorderRadius.lerp($name, other.$name, t) ?? $name',
        _ when borderRadiusGeometry.isAssignableFromType(type) =>
          'BorderRadiusGeometry.lerp($name, other.$name, t) ?? $name',
        //
        _ when boxConstraints.isAssignableFromType(type) => 'BoxConstraints.lerp($name, other.$name, t) ?? $name',
        //
        _ when boxDecoration.isAssignableFromType(type) => 'BoxDecoration.lerp($name, other.$name, t) ?? $name',
        _ when decoration.isAssignableFromType(type) => 'Decoration.lerp($name, other.$name, t) ?? $name',
        //
        _ when color.isAssignableFromType(type) => 'Color.lerp($name, other.$name, t) ?? $name',
        //
        _ when edgeInsets.isAssignableFromType(type) => 'EdgeInsets.lerp($name, other.$name, t) ?? $name',
        _ when edgeInsetsDirectional.isAssignableFromType(type) =>
          'EdgeInsetsDirectional.lerp($name, other.$name, t) ?? $name',
        _ when edgeInsetsGeometry.isAssignableFromType(type) =>
          'EdgeInsetsGeometry.lerp($name, other.$name, t) ?? $name',
        //
        _ when iconThemeData.isAssignableFromType(type) => 'IconThemeData.lerp($name, other.$name, t)',
        _ when textStyle.isAssignableFromType(type) => 'TextStyle.lerp($name, other.$name, t) ?? $name',
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
          final t when boxDecoration.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
            'FWidgetStateMap.lerpBoxDecoration($name, other.$name, t)',
          final t when boxDecoration.isAssignableFromType(t) =>
            'FWidgetStateMap.lerpWhere($name, other.$name, t, BoxDecoration.lerp)',
          //
          final t when color.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
            'FWidgetStateMap.lerpColor($name, other.$name, t)',
          final t when color.isAssignableFromType(t) => 'FWidgetStateMap.lerpWhere($name, other.$name, t, Color.lerp)',
          //
          final t when iconThemeData.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
            'FWidgetStateMap.lerpIconThemeData($name, other.$name, t)',
          final t when iconThemeData.isAssignableFromType(t) =>
            'FWidgetStateMap.lerpWhere($name, other.$name, t, IconThemeData.lerp)',
          //
          final t when textStyle.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
            'FWidgetStateMap.lerpTextStyle($name, other.$name, t)',
          final t when textStyle.isAssignableFromType(t) =>
            'FWidgetStateMap.lerpWhere($name, other.$name, t, TextStyle.lerp)',
          //
          _ => 't < 0.5 ? $name : other.$name',
        },
        // Nested motion/style
        _ when nestedMotion(type) || nestedStyle(type) => '$name.lerp(other.$name, t)',
        _ => 't < 0.5 ? $name : other.$name',
      };
    }

    // Generate field assignments for the lerp method body.
    final assignments = [for (final field in fields) '${field.name3}: ${invocation(field)},'].join();

    return Method(
      (m) => m
        ..returns = refer(element.name3!)
        ..docs.addAll([
          '/// Linearly interpolate between this and another [${element.name3!}] using the given factor [t].',
        ])
        ..annotations.add(refer('useResult'))
        ..name = 'lerp'
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'other'
              ..type = refer(element.name3!),
          ),
          Parameter(
            (p) => p
              ..name = 't'
              ..type = refer('double'),
          ),
        ])
        ..lambda = true
        ..body = Code('${element.name3!}($assignments)\n'),
    );
  }
}

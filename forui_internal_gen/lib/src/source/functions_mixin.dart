import 'package:analyzer/dart/element/element2.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

const _foo = 'lorem';

/// Generates a mixin for a class that implements a call, debugFillProperties, equals and hashCode methods and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
class FunctionsMixin {
  /// The type.
  @protected
  final ClassElement2 element;

  /// The fields.
  @protected
  final List<FieldElement2> fields;

  /// The generated call function's docs.
  @protected
  final List<String> callDocs;

  /// Creates a new [FunctionsMixin].
  FunctionsMixin(this.element, this.callDocs) : fields = instanceFields(element);

  /// Generates a mixin.
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${element.name3}Functions'
            ..on = refer('Diagnosticable')
            ..methods.addAll([..._getters, _call, _debugFillProperties, _equals, _hashCode]))
          .build();

  /// Generates getters for the class's fields that must be overridden by the class.
  List<Method> get _getters => fields
      .map(
        (field) => Method(
          (m) => m
            ..returns = refer(field.type.getDisplayString())
            ..type = MethodType.getter
            ..name = field.name3,
        ),
      )
      .toList();

  /// Generates a special `call` method that allows styles to be used directly.
  Method get _call => Method(
    (m) => m
      ..docs.addAll(callDocs)
      ..annotations.add(refer('useResult'))
      ..returns = refer(element.name3!)
      ..name = 'call'
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..type = refer('Object?')
            ..name = '_',
        ),
      )
      ..lambda = true
      ..body = Code('this as ${element.name3}'),
  );

  /// Generates a `debugFillProperties` method.
  Method get _debugFillProperties {
    final properties = fields
        .map(
          (field) => switch (field.type) {
            _ when intType.isAssignableFromType(field.type) =>
              "IntProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when doubleType.isAssignableFromType(field.type) =>
              "DoubleProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when boolType.isAssignableFromType(field.type) =>
              "FlagProperty('${field.name3}', value: ${field.name3}, ifTrue: '${field.name3}', level: DiagnosticLevel.debug)",
            _ when string.isAssignableFromType(field.type) =>
              "StringProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when color.isAssignableFromType(field.type) =>
              "ColorProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when iconData.isAssignableFromType(field.type) =>
              "IconDataProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when enumeration.isAssignableFromType(field.type) =>
              "EnumProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when iterable.isAssignableFromType(field.type) =>
              "IterableProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when field.type.isDartCoreFunction =>
              "ObjectFlagProperty.has('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
            _ when field.type is RecordType =>
              "StringProperty('${field.name3}', ${field.name3}.toString(), level: DiagnosticLevel.debug)",
            _ => "DiagnosticsProperty('${field.name3}', ${field.name3}, level: DiagnosticLevel.debug)",
          },
        )
        .toList();

    final additions = switch (properties) {
      _ when properties.isEmpty => '',
      _ when properties.length == 1 => 'properties.add(${properties.single});',
      _ => 'properties\n      ..add(${properties.join(')..add(')});',
    };

    return Method(
      (m) => m
        ..annotations.add(refer('override'))
        ..returns = refer('void')
        ..name = 'debugFillProperties'
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'properties'
              ..type = refer('DiagnosticPropertiesBuilder'),
          ),
        )
        ..body = Code('''
        super.debugFillProperties(properties);
        $additions
        '''),
    );
  }

  /// Generates an `operator==` method.
  Method get _equals {
    // DO NOT REORDER, we need the list/set pattern to dominate the iterable pattern.
    String generate(FieldElement2 field) => switch (field.type) {
      _ when list.isAssignableFromType(field.type) => 'listEquals(${field.name3}, other.${field.name3})',
      _ when set.isAssignableFromType(field.type) => 'setEquals(${field.name3}, other.${field.name3})',
      _ when map.isAssignableFromType(field.type) => 'mapEquals(${field.name3}, other.${field.name3})',
      _ => '${field.name3} == other.${field.name3}',
    };

    final comparisons = fields.isEmpty ? '' : '&& ${fields.map(generate).join(' && ')}';
    return Method(
      (m) => m
        ..returns = refer('bool')
        ..name = 'operator=='
        ..annotations.add(refer('override'))
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..type = refer('Object')
              ..name = 'other',
          ),
        )
        ..lambda = true
        ..body = Code('identical(this, other) || (other is ${element.name3} $comparisons)'),
    );
  }

  /// Generates a `hashCode` getter.
  Method get _hashCode {
    // DO NOT REORDER, we need the list/set pattern to dominate the iterable pattern.
    String generate(FieldElement2 field) => switch (field.type) {
      _ when list.isAssignableFromType(field.type) => 'const ListEquality().hash(${field.name3})',
      _ when set.isAssignableFromType(field.type) => 'const SetEquality().hash(${field.name3})',
      _ when map.isAssignableFromType(field.type) => 'const MapEquality().hash(${field.name3})',
      _ => '${field.name3}.hashCode',
    };

    final hash = fields.isEmpty ? '0' : fields.map(generate).join(' ^ ');

    return Method(
      (m) => m
        ..returns = refer('int')
        ..type = MethodType.getter
        ..annotations.add(refer('override'))
        ..name = 'hashCode'
        ..lambda = true
        ..body = Code(hash),
    );
  }
}

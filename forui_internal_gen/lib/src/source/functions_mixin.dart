import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

/// Generates a mixin for a class that implements a debugFillProperties, equals and hashCode methods and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
abstract class FunctionsMixin {
  /// The type.
  @protected
  final ClassElement element;

  /// The transitive fields.
  @protected
  final List<FieldElement> transitiveFields;

  /// The fields defined in [element].
  @protected
  final List<FieldElement> fields;

  /// Creates a new [FunctionsMixin].
  FunctionsMixin(this.element) : transitiveFields = transitiveInstanceFields(element), fields = instanceFields(element);

  /// Generates a mixin.
  Mixin generate();

  /// Generates getters for the class's fields that must be overridden by the class.
  @protected
  List<Method> get getters => transitiveFields
      .map(
        (field) => Method(
          (m) => m
            ..returns = refer(aliasAwareType(field.type))
            ..type = MethodType.getter
            ..name = field.name,
        ),
      )
      .toList();

  /// Generates a `debugFillProperties` method.
  @protected
  Method get debugFillProperties {
    final properties = fields
        .map(
          (field) => switch (field.type) {
            _ when intType.isAssignableFromType(field.type) =>
              "IntProperty('${field.name}', ${field.name}, level: .debug)",
            _ when doubleType.isAssignableFromType(field.type) =>
              "DoubleProperty('${field.name}', ${field.name}, level: .debug)",
            _ when boolType.isAssignableFromType(field.type) =>
              "FlagProperty('${field.name}', value: ${field.name}, ifTrue: '${field.name}', level: .debug)",
            _ when string.isAssignableFromType(field.type) =>
              "StringProperty('${field.name}', ${field.name}, level: .debug)",
            _ when color.isAssignableFromType(field.type) =>
              "ColorProperty('${field.name}', ${field.name}, level: .debug)",
            _ when iconData.isAssignableFromType(field.type) =>
              "IconDataProperty('${field.name}', ${field.name}, level: .debug)",
            _ when enumeration.isAssignableFromType(field.type) =>
              "EnumProperty('${field.name}', ${field.name}, level: .debug)",
            _ when iterable.isAssignableFromType(field.type) =>
              "IterableProperty('${field.name}', ${field.name}, level: .debug)",
            _ when field.type.isDartCoreFunction =>
              "ObjectFlagProperty.has('${field.name}', ${field.name}, level: .debug)",
            _ when field.type is RecordType =>
              "StringProperty('${field.name}', ${field.name}.toString(), level: .debug)",
            _ => "DiagnosticsProperty('${field.name}', ${field.name}, level: .debug)",
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
  @protected
  Method get equals {
    // DO NOT REORDER, we need the list/set pattern to dominate the iterable pattern.
    String generate(FieldElement field) => switch (field.type) {
      _ when list.isAssignableFromType(field.type) => 'listEquals(${field.name}, other.${field.name})',
      _ when set.isAssignableFromType(field.type) => 'setEquals(${field.name}, other.${field.name})',
      _ when map.isAssignableFromType(field.type) => 'mapEquals(${field.name}, other.${field.name})',
      _ => '${field.name} == other.${field.name}',
    };

    final typeParameters = element.typeParameters.isEmpty
        ? ''
        : '<${element.typeParameters.map((e) => e.name).join(', ')}>';
    final comparisons = transitiveFields.isEmpty ? '' : '&& ${transitiveFields.map(generate).join(' && ')}';
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
        ..body = Code(
          'identical(this, other) || (other is ${element.name}$typeParameters && runtimeType == other.runtimeType $comparisons)',
        ),
    );
  }

  /// Generates a `hashCode` getter.
  @protected
  Method get hash {
    // DO NOT REORDER, we need the list/set pattern to dominate the iterable pattern.
    String generate(FieldElement field) => switch (field.type) {
      _ when list.isAssignableFromType(field.type) => 'const ListEquality().hash(${field.name})',
      _ when set.isAssignableFromType(field.type) => 'const SetEquality().hash(${field.name})',
      _ when map.isAssignableFromType(field.type) => 'const MapEquality().hash(${field.name})',
      _ => '${field.name}.hashCode',
    };

    final hash = transitiveFields.isEmpty ? '0' : transitiveFields.map(generate).join(' ^ ');

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

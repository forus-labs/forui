import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

final _style = RegExp(r'^F.*Style$');

/// Generates corresponding style mixins that implement several commonly used operations.
class StyleGenerator extends Generator {
  final _emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

  @override
  Future<String?> generate(LibraryReader library, BuildStep step) async {
    for (final type in library.classes) {
      if (_style.hasMatch(type.name)) {
        return _emitter.visitMixin(generateMixin(type)).toString();
      }
    }

    return null;
  }
}

/// Generates a mixin for the given [element].
Mixin generateMixin(ClassElement element) {
  final fields = element.fields.where((f) => !f.isStatic && (f.getter?.isSynthetic ?? true)).toList();
  final type = MixinBuilder()
    ..name = '_\$${element.name}Functions'
    ..on = refer('Diagnosticable')
    ..methods.addAll([
      ...getters(fields),
      generateTransform(element),
      generateCopyWith(element, fields),
      generateDebugFillProperties(element, fields),
      generateEquals(element, fields),
      generateHashCode(element, fields),
    ]);

  return type.build();
}

/// Generates getters for the given [fields].
@visibleForTesting
List<Method> getters(List<FieldElement> fields) => fields
    .map(
      (field) => Method(
        (m) => m
          ..returns = refer(field.type.getDisplayString())
          ..type = MethodType.getter
          ..name = field.name,
      ),
    )
    .toList();

/// Generates a `transform` method using the given [element].
@visibleForTesting
Method generateTransform(ClassElement element) => Method(
      (m) => m
        ..returns = refer(element.name)
        ..docs.addAll([
          '''
        /// Transform this [${element.name}] using the given [transform].
        ///
        /// This should be used in conjunction with [copyWith] to update deeply nested properties and styles that rely on the
        /// current [${element.name}].'''
        ])
        ..annotations.add(refer('useResult'))
        ..name = 'transform'
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'transform'
              ..type = refer('${element.name} Function(${element.name} self)'),
          ),
        ])
        ..lambda = true
        ..body = Code('transform(this as ${element.name})'),
    );

/// Generates a `copyWith` method using the given [element] and [fields].
@visibleForTesting
Method generateCopyWith(ClassElement element, List<FieldElement> fields) {
  final assignments = fields.map((f) => '${f.name}: ${f.name} ?? this.${f.name},').join();
  return Method(
    (m) => m
      ..returns = refer(element.name)
      ..docs.addAll(['/// Returns a copy of this [${element.name}] with the given properties replaced.'])
      ..annotations.add(refer('useResult'))
      ..name = 'copyWith'
      ..optionalParameters.addAll([
        for (final field in fields)
          Parameter(
            (p) => p
              ..name = field.name
              ..type = refer('${field.type.getDisplayString()}?')
              ..named = true,
          ),
      ])
      ..lambda = true
      ..body = Code('${element.name}($assignments)\n'),
  );
}

/// Generates a `debugFillProperties` method using the given [element] and [fields].
@visibleForTesting
Method generateDebugFillProperties(ClassElement element, List<FieldElement> fields) {
  const string = TypeChecker.fromUrl('dart:core#String');
  const int = TypeChecker.fromUrl('dart:core#int');
  const double = TypeChecker.fromUrl('dart:core#double');
  const color = TypeChecker.fromUrl('dart:ui#Color');
  const iconData = TypeChecker.fromUrl('package:flutter#IconData');
  const enumeration = TypeChecker.fromUrl('dart:core#Enum');
  const iterable = TypeChecker.fromUrl('dart:core#Iterable');
  const bool = TypeChecker.fromUrl('dart:core#bool');

  final properties = fields
      .map(
        (field) => switch (field.type) {
          _ when string.isAssignableFromType(field.type) => "StringProperty('${field.name}', ${field.name})",
          _ when int.isAssignableFromType(field.type) => "IntProperty('${field.name}', ${field.name})",
          _ when double.isAssignableFromType(field.type) => "DoubleProperty('${field.name}', ${field.name})",
          _ when color.isAssignableFromType(field.type) => "ColorProperty('${field.name}', ${field.name})",
          _ when iconData.isAssignableFromType(field.type) => "IconDataProperty('${field.name}', ${field.name})",
          _ when enumeration.isAssignableFromType(field.type) => "EnumProperty('${field.name}', ${field.name})",
          _ when iterable.isAssignableFromType(field.type) => "IterableProperty('${field.name}', ${field.name})",
          _ when bool.isAssignableFromType(field.type) =>
            "FlagProperty('${field.name}', value: ${field.name}, ifTrue: '${field.name}'",
          _ when field.type.isDartCoreFunction => "ObjectFlagProperty.has('${field.name}', ${field.name})",
          _ when field.type is RecordType => "StringProperty('${field.name}', ${field.name}.toString())",
          _ => "DiagnosticsProperty('${field.name}', ${field.name})"
        },
      )
      .toList();

  final additions = switch (properties) {
    _ when properties.isEmpty => '',
    _ when properties.length == 1 => 'properties.addProperty(${properties.single});',
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

/// Generates an `operator==` method using the given [element] and [fields].
@visibleForTesting
Method generateEquals(ClassElement element, List<FieldElement> fields) {
  final comparisons = fields.isEmpty ? '' : '&& ${fields.map((f) => '${f.name} == other.${f.name}').join(' && ')}';
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
      ..body = Code('identical(this, other) || (other is ${element.name} $comparisons)'),
  );
}

/// Generates a `hashCode` method using the given [element] and [fields].
@visibleForTesting
Method generateHashCode(ClassElement element, List<FieldElement> fields) {
  final hash = fields.isEmpty ? '0' : fields.map((f) => '${f.name}.hashCode').join(' ^ ');
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

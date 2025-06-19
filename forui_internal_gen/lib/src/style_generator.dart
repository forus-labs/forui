// ignore_for_file: deprecated_member_use - Wait for changes to stabilize before migrating.
// https://github.com/dart-lang/sdk/blob/main/pkg/analyzer/doc/element_model_migration_guide.md

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

final _style = RegExp(r'^F.*(Style|Styles)$');
const _list = TypeChecker.fromUrl('dart:core#List');
const _set = TypeChecker.fromUrl('dart:core#Set');
const _map = TypeChecker.fromUrl('dart:core#Map');

/// Generates corresponding style mixins and extensions that implement several commonly used operations.
class StyleGenerator extends Generator {
  final _emitter = DartEmitter(orderDirectives: true, useNullSafetySyntax: true);

  @override
  Future<String?> generate(LibraryReader library, BuildStep step) async {
    final classes = library.classes
        .where((type) => _style.hasMatch(type.name) && !type.isSealed && !type.isAbstract)
        .toList();

    final extensions = classes.map((type) => _emitter.visitExtension(generateExtension(type)).toString());
    final mixins = classes.map((type) => _emitter.visitMixin(generateMixin(type)).toString());

    return [...extensions, ...mixins].join('\n');
  }
}

List<FieldElement> _collectFields(ClassElement element) {
  final fields = <FieldElement>[];

  void addFieldsFromType(ClassElement element) {
    fields.addAll(element.fields.where((f) => !f.isStatic && (f.getter?.isSynthetic ?? true)));
    if (element.supertype?.element case final ClassElement supertype) {
      addFieldsFromType(supertype);
    }
  }

  addFieldsFromType(element);

  // Remove duplicates (in case a field is overridden)
  return fields.toSet().toList();
}

/// Generates an extension for the given [element].
///
/// The copyWith function is generated in an extension rather than on a mixin/augmentation to make the function
/// non-virtual. This prevents conflicts between base and subclasses.
Extension generateExtension(ClassElement element) {
  final fields = _collectFields(element);

  final type = ExtensionBuilder()
    ..docs.addAll(['/// Provides a `copyWith` method.'])
    ..name = '\$${element.name}CopyWith'
    ..on = refer(element.name)
    ..methods.add(generateCopyWith(element, fields));

  return type.build();
}

/// Generates a `copyWith` method using the given [element] and [fields].
@visibleForTesting
Method generateCopyWith(ClassElement element, List<FieldElement> fields) {
  // Check if a field is a complex type.
  bool complex(DartType type) {
    final typeName = type.getDisplayString();
    return typeName.startsWith('F') && (typeName.endsWith('Style') || typeName.endsWith('Styles'));
  }

  final docs = [
    for (final field in fields)
      if (field.documentationComment case final comment? when comment.isNotEmpty) ...[
        '/// # [${field.name}]',
        comment,
        '/// ',
      ],
  ];

  // Generate assignments for the copyWith method body
  final assignments = fields.map((f) {
    if (complex(f.type)) {
      return '${f.name}: ${f.name} != null ? ${f.name}(this.${f.name}) : this.${f.name},';
    } else {
      return '${f.name}: ${f.name} ?? this.${f.name},';
    }
  }).join();

  return Method(
    (m) => m
      ..returns = refer(element.name)
      ..docs.addAll([
        '/// Returns a copy of this [${element.name}] with the given properties replaced.',
        '///',
        '/// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)',
        '/// and directly modify the style.',
        '///',
        ...docs,
      ])
      ..annotations.add(refer('useResult'))
      ..name = 'copyWith'
      ..optionalParameters.addAll([
        for (final field in fields)
          if (complex(field.type))
            Parameter(
              (p) => p
                ..name = field.name
                ..type = refer('${field.type.getDisplayString()} Function(${field.type.getDisplayString()})?')
                ..named = true,
            )
          else
            Parameter(
              (p) => p
                ..name = field.name
                ..type = refer(
                  field.type.getDisplayString().endsWith('?')
                      ? field.type.getDisplayString()
                      : '${field.type.getDisplayString()}?',
                )
                ..named = true,
            ),
      ])
      ..lambda = true
      ..body = Code('${element.name}($assignments)\n'),
  );
}

/// Generates a mixin for the given [element].
Mixin generateMixin(ClassElement element) {
  final fields = _collectFields(element);

  final type = MixinBuilder()
    ..name = '_\$${element.name}Functions'
    ..on = refer('Diagnosticable')
    ..methods.addAll([
      ...getters(fields),
      generateCall(element),
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

/// Generates a special `call` method that allows styles to be used directly.
@visibleForTesting
Method generateCall(ClassElement element) => Method(
  (m) => m
    ..docs.addAll([
      '/// Returns itself.',
      '/// ',
      "/// Allows [${element.name}] to replace functions that accept and return a [${element.name}], such as a style's",
      '/// `copyWith(...)` function.',
      '/// ',
      '/// ## Example',
      '/// ',
      '/// Given:',
      '/// ```dart',
      '/// void copyWith(${element.name} Function(${element.name}) nestedStyle) {}',
      '/// ```',
      '/// ',
      '/// The following:',
      '/// ```dart',
      '/// copyWith((style) => ${element.name}(...));',
      '/// ```',
      '/// ',
      '/// Can be replaced with:',
      '/// ```dart',
      '/// copyWith(${element.name}(...));',
      '/// ```',
    ])
    ..annotations.add(refer('useResult'))
    ..returns = refer(element.name)
    ..name = 'call'
    ..requiredParameters.add(
      Parameter(
        (p) => p
          ..type = refer('Object?')
          ..name = '_',
      ),
    )
    ..lambda = true
    ..body = Code('this as ${element.name}'),
);

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
            "FlagProperty('${field.name}', value: ${field.name}, ifTrue: '${field.name}')",
          _ when field.type.isDartCoreFunction => "ObjectFlagProperty.has('${field.name}', ${field.name})",
          _ when field.type is RecordType => "StringProperty('${field.name}', ${field.name}.toString())",
          _ => "DiagnosticsProperty('${field.name}', ${field.name})",
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

/// Generates an `operator==` method using the given [element] and [fields].
@visibleForTesting
Method generateEquals(ClassElement element, List<FieldElement> fields) {
  String generate(FieldElement field) => switch (field.type) {
    _ when _list.isAssignableFromType(field.type) => 'listEquals(${field.name}, other.${field.name})',
    _ when _set.isAssignableFromType(field.type) => 'setEquals(${field.name}, other.${field.name})',
    _ when _map.isAssignableFromType(field.type) => 'mapEquals(${field.name}, other.${field.name})',
    _ => '${field.name} == other.${field.name}',
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
      ..body = Code('identical(this, other) || (other is ${element.name} $comparisons)'),
  );
}

/// Generates a `hashCode` method using the given [element] and [fields].
@visibleForTesting
Method generateHashCode(ClassElement element, List<FieldElement> fields) {
  String generate(FieldElement field) => switch (field.type) {
    _ when _list.isAssignableFromType(field.type) => 'const ListEquality().hash(${field.name})',
    _ when _set.isAssignableFromType(field.type) => 'const SetEquality().hash(${field.name})',
    _ when _map.isAssignableFromType(field.type) => 'const MapEquality().hash(${field.name})',
    _ => '${field.name}.hashCode',
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

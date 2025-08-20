import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
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
        .where((type) => type.name3 != null && _style.hasMatch(type.name3!) && !type.isSealed && !type.isAbstract)
        .toList();

    final extensions = classes.map((type) => _emitter.visitExtension(_Extension(type).generate()).toString());
    final mixins = classes.map((type) => _emitter.visitMixin(_Mixin(type).generate()).toString());

    return [...extensions, ...mixins].join('\n');
  }
}

List<FieldElement2> _collectFields(ClassElement2 element) {
  final fields = <FieldElement2>[];

  void addFieldsFromType(ClassElement2 element) {
    fields.addAll(element.fields2.where((f) => !f.isStatic && (f.getter2?.isSynthetic ?? true)));
    if (element.supertype?.element3 case final ClassElement2 supertype) {
      addFieldsFromType(supertype);
    }
  }

  addFieldsFromType(element);

  // Remove duplicates (in case a field is overridden)
  return fields.toSet().toList();
}

/// Generates an extension.
///
/// The copyWith function is generated in an extension rather than on a mixin/augmentation to make the function
/// non-virtual. This prevents conflicts between base and subclasses.
class _Extension {
  final ClassElement2 _element;
  final List<FieldElement2> _fields;

  _Extension(this._element) : _fields = _collectFields(_element);

  Extension generate() =>
      (ExtensionBuilder()
            ..docs.addAll(['/// Provides a `copyWith` method.'])
            ..name = '\$${_element.name3!}CopyWith'
            ..on = refer(_element.name3!)
            ..methods.add(_copyWith))
          .build();

  Method get _copyWith {
    // Check if a field is a complex type.
    bool complex(DartType type) {
      final typeName = type.getDisplayString();
      return typeName.startsWith('F') && (typeName.endsWith('Style') || typeName.endsWith('Styles'));
    }

    final docs = [
      for (final field in _fields)
        if (field.documentationComment case final comment? when comment.isNotEmpty) ...[
          '/// # [${field.name3}]',
          comment,
          '/// ',
        ],
    ];

    // Generate assignments for the copyWith method body
    final assignments = _fields.map((f) {
      if (complex(f.type)) {
        return '${f.name3}: ${f.name3} != null ? ${f.name3}(this.${f.name3}) : this.${f.name3},';
      } else {
        return '${f.name3}: ${f.name3} ?? this.${f.name3},';
      }
    }).join();

    return Method(
      (m) => m
        ..returns = refer(_element.name3!)
        ..docs.addAll([
          '/// Returns a copy of this [${_element.name3!}] with the given properties replaced.',
          '///',
          '/// Consider [using the CLI to generate a style](https://forui.dev/themes#customization).',
          '///',
          ...docs,
        ])
        ..annotations.add(refer('useResult'))
        ..name = 'copyWith'
        ..optionalParameters.addAll([
          for (final field in _fields)
            if (complex(field.type))
              Parameter(
                (p) => p
                  ..name = field.name3!
                  ..type = refer('${field.type.getDisplayString()} Function(${field.type.getDisplayString()})?')
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
        ..body = Code('${_element.name3!}($assignments)\n'),
    );
  }
}

class _Mixin {
  final ClassElement2 _element;
  final List<FieldElement2> _fields;

  _Mixin(this._element) : _fields = _collectFields(_element);

  /// Generates a mixin.
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${_element.name3}Functions'
            ..on = refer('Diagnosticable')
            ..methods.addAll([..._getters, _call, _debugFillProperties, _equals, _hashCode]))
          .build();

  /// Generates getters for the class's fields that must be overridden by the class.
  List<Method> get _getters => _fields
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
      ..docs.addAll([
        '/// Returns itself.',
        '/// ',
        "/// Allows [${_element.name3}] to replace functions that accept and return a [${_element.name3}], such as a style's",
        '/// `copyWith(...)` function.',
        '/// ',
        '/// ## Example',
        '/// ',
        '/// Given:',
        '/// ```dart',
        '/// void copyWith(${_element.name3} Function(${_element.name3}) nestedStyle) {}',
        '/// ```',
        '/// ',
        '/// The following:',
        '/// ```dart',
        '/// copyWith((style) => ${_element.name3}(...));',
        '/// ```',
        '/// ',
        '/// Can be replaced with:',
        '/// ```dart',
        '/// copyWith(${_element.name3}(...));',
        '/// ```',
      ])
      ..annotations.add(refer('useResult'))
      ..returns = refer(_element.name3!)
      ..name = 'call'
      ..requiredParameters.add(
        Parameter(
          (p) => p
            ..type = refer('Object?')
            ..name = '_',
        ),
      )
      ..lambda = true
      ..body = Code('this as ${_element.name3}'),
  );

  /// Generates a `debugFillProperties` method.
  Method get _debugFillProperties {
    const string = TypeChecker.fromUrl('dart:core#String');
    const int = TypeChecker.fromUrl('dart:core#int');
    const double = TypeChecker.fromUrl('dart:core#double');
    const color = TypeChecker.fromUrl('dart:ui#Color');
    const iconData = TypeChecker.fromUrl('package:flutter#IconData');
    const enumeration = TypeChecker.fromUrl('dart:core#Enum');
    const iterable = TypeChecker.fromUrl('dart:core#Iterable');
    const bool = TypeChecker.fromUrl('dart:core#bool');

    final properties = _fields
        .map(
          (field) => switch (field.type) {
            _ when string.isAssignableFromType(field.type) => "StringProperty('${field.name3}', ${field.name3})",
            _ when int.isAssignableFromType(field.type) => "IntProperty('${field.name3}', ${field.name3})",
            _ when double.isAssignableFromType(field.type) => "DoubleProperty('${field.name3}', ${field.name3})",
            _ when color.isAssignableFromType(field.type) => "ColorProperty('${field.name3}', ${field.name3})",
            _ when iconData.isAssignableFromType(field.type) => "IconDataProperty('${field.name3}', ${field.name3})",
            _ when enumeration.isAssignableFromType(field.type) => "EnumProperty('${field.name3}', ${field.name3})",
            _ when iterable.isAssignableFromType(field.type) => "IterableProperty('${field.name3}', ${field.name3})",
            _ when bool.isAssignableFromType(field.type) =>
              "FlagProperty('${field.name3}', value: ${field.name3}, ifTrue: '${field.name3}')",
            _ when field.type.isDartCoreFunction => "ObjectFlagProperty.has('${field.name3}', ${field.name3})",
            _ when field.type is RecordType => "StringProperty('${field.name3}', ${field.name3}.toString())",
            _ => "DiagnosticsProperty('${field.name3}', ${field.name3})",
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
    String generate(FieldElement2 field) => switch (field.type) {
      _ when _list.isAssignableFromType(field.type) => 'listEquals(${field.name3}, other.${field.name3})',
      _ when _set.isAssignableFromType(field.type) => 'setEquals(${field.name3}, other.${field.name3})',
      _ when _map.isAssignableFromType(field.type) => 'mapEquals(${field.name3}, other.${field.name3})',
      _ => '${field.name3} == other.${field.name3}',
    };

    final comparisons = _fields.isEmpty ? '' : '&& ${_fields.map(generate).join(' && ')}';
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
        ..body = Code('identical(this, other) || (other is ${_element.name3} $comparisons)'),
    );
  }

  /// Generates a `hashCode` getter.
  Method get _hashCode {
    String generate(FieldElement2 field) => switch (field.type) {
      _ when _list.isAssignableFromType(field.type) => 'const ListEquality().hash(${field.name3})',
      _ when _set.isAssignableFromType(field.type) => 'const SetEquality().hash(${field.name3})',
      _ when _map.isAssignableFromType(field.type) => 'const MapEquality().hash(${field.name3})',
      _ => '${field.name3}.hashCode',
    };

    final hash = _fields.isEmpty ? '0' : _fields.map(generate).join(' ^ ');

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

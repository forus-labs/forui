import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:source_gen/source_gen.dart';

final _style = RegExp(r'^F.*(Style|Styles)$');

const _bool = TypeChecker.fromUrl('dart:core#bool');
const _int = TypeChecker.fromUrl('dart:core#int');
const _double = TypeChecker.fromUrl('dart:core#double');
const _string = TypeChecker.fromUrl('dart:core#String');
const _enumeration = TypeChecker.fromUrl('dart:core#Enum');

const _iterable = TypeChecker.fromUrl('dart:core#Iterable');
const _list = TypeChecker.fromUrl('dart:core#List');
const _set = TypeChecker.fromUrl('dart:core#Set');
const _map = TypeChecker.fromUrl('dart:core#Map');

const _color = TypeChecker.fromUrl('dart:ui#Color');

const _alignment = TypeChecker.fromUrl('package:flutter#Alignment');
const _alignmentGeometry = TypeChecker.fromUrl('package:flutter#AlignmentGeometry');
const _borderRadius = TypeChecker.fromUrl('package:flutter#BorderRadius');
const _borderRadiusGeometry = TypeChecker.fromUrl('package:flutter#BorderRadiusGeometry');
const _boxConstraints = TypeChecker.fromUrl('package:flutter#BoxConstraints');
const _boxDecoration = TypeChecker.fromUrl('package:flutter#BoxDecoration');
const _decoration = TypeChecker.fromUrl('package:flutter#Decoration');
const _edgeInsets = TypeChecker.fromUrl('package:flutter#EdgeInsets');
const _edgeInsetsGeometry = TypeChecker.fromUrl('package:flutter#EdgeInsetsGeometry');
const _iconData = TypeChecker.fromUrl('package:flutter#IconData');
const _iconThemeData = TypeChecker.fromUrl('package:flutter#IconThemeData');
const _textStyle = TypeChecker.fromUrl('package:flutter#TextStyle');
const _boxShadow = TypeChecker.fromUrl('package:flutter#BoxShadow');
const _shadow = TypeChecker.fromUrl('package:flutter#Shadow');

const _fWidgetStateMap = TypeChecker.fromUrl('package:forui#FWidgetStateMap');

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
            ..docs.addAll(['/// Provides [copyWith] and [lerp] methods.'])
            ..name = '\$${_element.name3!}NonVirtual'
            ..on = refer(_element.name3!)
            ..methods.addAll([_copyWith, _lerp]))
          .build();

  Method get _lerp {
    String invocation(FieldElement2 field) {
      final type = field.type;
      final name = field.name3!;

      return switch (type) {
        _ when _double.isAssignableFromType(type) => 'lerpDouble($name, other.$name, t) ?? $name',
        //
        _ when _alignment.isAssignableFromType(type) => 'Alignment.lerp($name, other.$name, t) ?? $name',
        _ when _alignmentGeometry.isAssignableFromType(type) =>
          'AlignmentGeometry.lerp($name, other.$name, t) ?? $name',
        //
        _ when _borderRadius.isAssignableFromType(type) => 'BorderRadius.lerp($name, other.$name, t) ?? $name',
        _ when _borderRadiusGeometry.isAssignableFromType(type) =>
          'BorderRadiusGeometry.lerp($name, other.$name, t) ?? $name',
        //
        _ when _boxConstraints.isAssignableFromType(type) => 'BoxConstraints.lerp($name, other.$name, t) ?? $name',
        //
        _ when _boxDecoration.isAssignableFromType(type) => 'BoxDecoration.lerp($name, other.$name, t) ?? $name',
        _ when _decoration.isAssignableFromType(type) => 'Decoration.lerp($name, other.$name, t) ?? $name',
        //
        _ when _color.isAssignableFromType(type) => 'Color.lerp($name, other.$name, t) ?? $name',
        //
        _ when _edgeInsets.isAssignableFromType(type) => 'EdgeInsets.lerp($name, other.$name, t) ?? $name',
        _ when _edgeInsetsGeometry.isAssignableFromType(type) =>
          'EdgeInsetsGeometry.lerp($name, other.$name, t) ?? $name',
        //
        _ when _iconThemeData.isAssignableFromType(type) => 'IconThemeData.lerp($name, other.$name, t) ?? $name',
        _ when _textStyle.isAssignableFromType(type) => 'TextStyle.lerp($name, other.$name, t) ?? $name',
        // List<BoxShadow>/List<Shadow>
        _ when _list.isAssignableFromType(type) && type is ParameterizedType => switch (type.typeArguments.single) {
          final t when _boxShadow.isAssignableFromType(t) => 'BoxShadow.lerpList($name, other.$name, t) ?? $name',
          final t when _shadow.isAssignableFromType(t) => 'Shadow.lerpList($name, other.$name, t) ?? $name',
          _ => name,
        },
        // FWidgetStateMap<T>/FWidgetStateMap<T?>
        _ when _fWidgetStateMap.isAssignableFromType(type) && type is ParameterizedType =>
          switch (type.typeArguments.single) {
            final t when _boxDecoration.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
              'FWidgetStateMap.lerpBoxDecoration($name, other.$name, t)',
            final t when _boxDecoration.isAssignableFromType(t) =>
              'FWidgetStateMap.lerpWhere($name, other.$name, Color.lerp)',
            //
            final t when _color.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
              'FWidgetStateMap.lerpColor($name, other.$name, t)',
            final t when _color.isAssignableFromType(t) => 'FWidgetStateMap.lerpWhere($name, other.$name, Color.lerp)',
            //
            final t when _iconThemeData.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
              'FWidgetStateMap.lerpIconThemeData($name, other.$name, t)',
            final t when _iconThemeData.isAssignableFromType(t) =>
              'FWidgetStateMap.lerpWhere($name, other.$name, IconThemeData.lerp)',
            //
            final t when _textStyle.isAssignableFromType(t) && t.nullabilitySuffix == NullabilitySuffix.none =>
              'FWidgetStateMap.lerpTextStyle($name, other.$name, t)',
            final t when _textStyle.isAssignableFromType(t) =>
              'FWidgetStateMap.lerpWhere($name, other.$name, TextStyle.lerp)',
            //
            _ => name,
          },
        // Nested styles
        _ when _nestedStyle(type) => '$name.lerp(other.$name, t)',
        _ => name,
      };

      // TODO: we can do better. check if type has lerp static function or instance function
    }

    // Generate field assignments for the lerp method body
    final assignments = [for (final field in _fields) '${field.name3}: ${invocation(field)},'].join();

    return Method(
      (m) => m
        ..returns = refer(_element.name3!)
        ..docs.addAll([
          '/// Linearly interpolate between this and another [${_element.name3!}] using the given factor [t].',
        ])
        ..annotations.add(refer('useResult'))
        ..name = 'lerp'
        ..requiredParameters.addAll([
          Parameter(
            (p) => p
              ..name = 'other'
              ..type = refer(_element.name3!),
          ),
          Parameter(
            (p) => p
              ..name = 't'
              ..type = refer('double'),
          ),
        ])
        ..lambda = true
        ..body = Code('${_element.name3!}($assignments)\n'),
    );
  }

  Method get _copyWith {
    // Copy the documentation comments from the fields.
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
      if (_nestedStyle(f.type)) {
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
            if (_nestedStyle(field.type))
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

  bool _nestedStyle(DartType type) {
    final typeName = type.getDisplayString();
    return typeName.startsWith('F') && (typeName.endsWith('Style') || typeName.endsWith('Styles'));
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
    final properties = _fields
        .map(
          (field) => switch (field.type) {
            _ when _string.isAssignableFromType(field.type) => "StringProperty('${field.name3}', ${field.name3})",
            _ when _int.isAssignableFromType(field.type) => "IntProperty('${field.name3}', ${field.name3})",
            _ when _double.isAssignableFromType(field.type) => "DoubleProperty('${field.name3}', ${field.name3})",
            _ when _color.isAssignableFromType(field.type) => "ColorProperty('${field.name3}', ${field.name3})",
            _ when _iconData.isAssignableFromType(field.type) => "IconDataProperty('${field.name3}', ${field.name3})",
            _ when _enumeration.isAssignableFromType(field.type) => "EnumProperty('${field.name3}', ${field.name3})",
            _ when _iterable.isAssignableFromType(field.type) => "IterableProperty('${field.name3}', ${field.name3})",
            _ when _bool.isAssignableFromType(field.type) =>
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

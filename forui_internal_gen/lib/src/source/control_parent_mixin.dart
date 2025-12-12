import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

/// Generates a private mixin for the sealed parent control class.
///
/// This mixin provides:
/// - `_create` method (if not specified in sealed class)
/// - `_dispose` method (if not specified in sealed class)
/// - `_default` method (always generated)
@internal
class ControlParentMixin {
  /// The sealed parent class.
  final ClassElement supertype;

  /// The `_create` method from the sealed parent, if any.
  final MethodElement? create;

  /// The `_update` method from the sealed parent, if any.
  final MethodElement update;

  /// The `_dispose` method from the sealed parent, if any.
  final MethodElement? dispose;

  /// Creates a new [ControlParentMixin].
  ControlParentMixin({required this.supertype, required this.create, required this.update, required this.dispose});

  /// Generates the mixin.
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${supertype.name}Mixin'
            ..types.addAll([for (final t in supertype.typeParameters) refer(t.name!)])
            ..methods.addAll([if (create == null) _create, if (dispose == null) _dispose, defaultMethod]))
          .build();

  Method get createMethod => switch (create) {
    null => _create,
    final create => Method(
      (m) => m
        ..returns = refer(aliasAwareType(create.returnType))
        ..name = '_create'
        ..requiredParameters.addAll([
          for (final parameter in create.formalParameters)
            Parameter(
              (p) => p
                ..name = parameter.name!
                ..type = refer(aliasAwareType(parameter.type)),
            ),
        ]),
    ),
  };

  Method get _create => Method(
    (m) => m
      ..returns = refer(_returnType)
      ..name = '_create'
      ..requiredParameters.addAll([
        for (final parameter in update.formalParameters)
          if (parameter.name case final name? when name != 'old' && name != 'controller' && name != 'callback')
            Parameter(
              (p) => p
                ..name = name
                ..type = refer(aliasAwareType(parameter.type)),
            ),
      ]),
  );

  Method get disposeMethod => switch (dispose) {
    null => _dispose,
    final dispose => Method(
      (m) => m
        ..returns = refer(aliasAwareType(dispose.returnType))
        ..name = '_dispose'
        ..requiredParameters.addAll([
          for (final parameter in dispose.formalParameters)
            Parameter(
              (p) => p
                ..name = parameter.name!
                ..type = refer(aliasAwareType(parameter.type)),
            ),
        ]),
    ),
  };

  Method get _dispose => Method(
    (m) => m
      ..returns = refer('void')
      ..name = '_dispose'
      ..requiredParameters.addAll([
        for (final parameter in update.formalParameters)
          if (parameter.name case 'controller' || 'callback')
            Parameter(
              (p) => p
                ..name = parameter.name!
                ..type = refer(aliasAwareType(parameter.type)),
            ),
      ]),
  );

  Method get defaultMethod => Method(
    (m) => m
      ..docs.addAll(['// TODO: https://github.com/dart-lang/sdk/issues/62198', '// ignore: unused_element'])
      ..returns = refer(_returnType)
      ..name = '_default'
      ..requiredParameters.addAll([
        for (final parameter in update.formalParameters)
          Parameter(
            (p) => p
              ..name = parameter.name!
              ..type = refer(aliasAwareType(parameter.type)),
          ),
      ])
      ..lambda = true
      ..body = const Code('controller'),
  );

  String get _returnType => aliasAwareType((update.returnType as RecordType).positionalFields.first.type);
}

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
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
        ..returns = refer(create.returnType.getDisplayString())
        ..name = '_create'
        ..requiredParameters.addAll([
          for (final parameter in create.formalParameters)
            Parameter(
              (p) => p
                ..name = parameter.name!
                ..type = refer(parameter.type.getDisplayString()),
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
          if (parameter.name case final name? when name != 'old' && name != 'controller')
            Parameter(
              (p) => p
                ..name = name
                ..type = refer(parameter.type.getDisplayString()),
            ),
      ]),
  );

  Method get disposeMethod => switch (dispose) {
    null => _dispose,
    final dispose => Method(
      (m) => m
        ..returns = refer(dispose.returnType.getDisplayString())
        ..name = '_dispose'
        ..requiredParameters.addAll([
          for (final parameter in dispose.formalParameters)
            Parameter(
              (p) => p
                ..name = parameter.name!
                ..type = refer(parameter.type.getDisplayString()),
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
                ..type = refer(parameter.type.getDisplayString()),
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
              ..type = refer(parameter.type.getDisplayString()),
          ),
      ])
      ..lambda = true
      ..body = const Code('controller'),
  );

  String get _returnType => (update.returnType as RecordType).positionalFields.first.type.getDisplayString();
}

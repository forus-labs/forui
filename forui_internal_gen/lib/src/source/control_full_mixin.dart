import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:forui_internal_gen/src/source/types.dart';
import 'package:meta/meta.dart';

/// Generates a mixin for a class that implements a call, debugFillProperties, equals and hashCode , and _update
/// methods and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
abstract class ControlMixin extends FunctionsMixin {
  /// The sealed parent class.
  final ClassElement supertype;

  /// The `_update` method.
  final MethodElement update;

  /// The `create` method.
  final Method createController;

  /// The `_dispose` method.
  final Method dispose;

  /// The `_default` method.
  final Method default_;

  /// All sibling subclasses (excluding this one).
  final List<ClassElement> siblings;

  /// Creates a new [ControlMixin].
  factory ControlMixin({
    required ClassElement element,
    required ClassElement supertype,
    required MethodElement update,
    required Method createController,
    required Method dispose,
    required Method default_,
    required List<ClassElement> siblings,
  }) => element.name!.contains('Lifted')
      ? _LiftedControlMixin(
          element: element,
          supertype: supertype,
          update: update,
          createController: createController,
          dispose: dispose,
          default_: default_,
          siblings: siblings,
        )
      : _ManagedControlMixin(
          element: element,
          supertype: supertype,
          update: update,
          createController: createController,
          dispose: dispose,
          default_: default_,
          siblings: siblings,
        );

  ControlMixin._({
    required ClassElement element,
    required this.supertype,
    required this.update,
    required this.createController,
    required this.default_,
    required this.dispose,
    required this.siblings,
  }) : super(element);

  String get _typeParameters =>
      supertype.typeParameters.isEmpty ? '' : '<${supertype.typeParameters.map((t) => t.name).join(', ')}>';

  Method get _update => Method(
    (m) => m
      ..annotations.add(refer('override'))
      ..returns = refer(update.returnType.getDisplayString())
      ..name = '_update'
      ..requiredParameters.addAll([
        for (final parameter in update.formalParameters)
          Parameter(
            (p) => p
              ..name = parameter.name!
              ..type = refer(aliasAwareType(parameter.type)),
          ),
      ])
      ..body = _updateBody,
  );

  /// Generates the body of the `_update` method.
  ///
  /// We assume that the parameter names are always old, controller and callback.
  Code get _updateBody;

  String get _createParameters => [for (final p in createController.requiredParameters) p.name].join(', ');

  String get _defaultParameters => [for (final p in default_.requiredParameters) p.name].join(', ');
}

class _ManagedControlMixin extends ControlMixin {
  _ManagedControlMixin({
    required super.element,
    required super.supertype,
    required super.update,
    required super.createController,
    required super.dispose,
    required super.default_,
    required super.siblings,
  }) : assert(siblings.length == 1, '_ManagedControlMixin only supports exactly 2 variants.'),
       super._();

  @override
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${element.name}Mixin'
            ..types.addAll([for (final t in supertype.typeParameters) refer(t.name!)])
            ..on = refer('Diagnosticable, ${supertype.name}$_typeParameters')
            ..methods.addAll([...getters, _update, _dispose, debugFillProperties, equals, hash]))
          .build();

  @override
  Code get _updateBody => Code('''
      switch (old) {
        case _ when old == this:
          return (_default($_defaultParameters), false);

        // External (Controller A) -> External (Controller B)
        case ${element.name}(controller: final old?) when this.controller != null && this.controller != old:
          controller.removeListener(callback);
          return (createController($_createParameters)..addListener(callback), true);

        // Internal -> External
        case ${element.name}(controller: final old) when this.controller != null && old == null:
          controller.dispose();
          return (createController($_createParameters)..addListener(callback), true);

        // External -> Internal
        case ${element.name}(controller: _?) when this.controller == null:
          controller.removeListener(callback);
          return (createController($_createParameters)..addListener(callback), true);

        // Lifted -> Managed
        case ${siblings.first.name}():
          controller.dispose();
          return (createController($_createParameters)..addListener(callback), true);

        ${element.isAbstract ? '''
        // Internal -> Internal (different type, e.g. Normal -> Cascade)
        case final ${element.name}$_typeParameters old when old.runtimeType != runtimeType:
          controller.dispose();
          return (createController($_createParameters)..addListener(callback), true);
        ''' : ''}

        default:
          return (_default($_defaultParameters), false);
      }
    ''');

  Method get _dispose =>
      (dispose.toBuilder()
            ..annotations.add(refer('override'))
            ..body = const Code('''
              if (this.controller != null) {
                controller.removeListener(callback);
              } else {
                controller.dispose();
              }
        '''))
          .build();
}

class _LiftedControlMixin extends ControlMixin {
  _LiftedControlMixin({
    required super.element,
    required super.supertype,
    required super.update,
    required super.createController,
    required super.dispose,
    required super.default_,
    required super.siblings,
  }) : assert(siblings.length == 1, '_LiftedControlMixin only supports exactly 2 variants.'),
       super._();

  @override
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${element.name}Mixin'
            ..types.addAll([for (final t in supertype.typeParameters) refer(t.name!)])
            ..on = refer('Diagnosticable, ${supertype.name}$_typeParameters')
            ..methods.addAll([...getters, _update, _updateController, _dispose, debugFillProperties, equals, hash]))
          .build();

  @override
  Code get _updateBody {
    final updateParameters = [
      for (final p in update.formalParameters)
        if (p.name case final name when name != 'old' && name != 'callback') p.name!,
    ].join(', ');

    return Code('''
      switch (old) {
        case _ when old == this:
          return (_default($_defaultParameters), false);

        // Lifted (Value A) -> Lifted (Value B)
        case ${element.name}() when old.runtimeType == runtimeType:
          _updateController($updateParameters);
          return (controller, true);
          
       // LiftedFoo -> LiftedBar
        case ${element.name}():
          controller.dispose();
          return (createController($_createParameters)..addListener(callback), true);

        // External -> Lifted
        case ${siblings.first.name}(controller: _?):
          controller.removeListener(callback);
          return (createController($_createParameters)..addListener(callback), true);

        // Internal -> Lifted
        case ${siblings.first.name}():
          controller.dispose();
          return (createController($_createParameters)..addListener(callback), true);

        default:
          return (_default($_defaultParameters), false);
      }
    ''');
  }

  Method get _updateController => Method(
    (m) => m
      ..returns = refer('void')
      ..name = '_updateController'
      ..requiredParameters.addAll([
        for (final parameter in update.formalParameters)
          if (parameter.name case final name? when name != 'old' && name != 'callback')
            Parameter(
              (p) => p
                ..name = name
                ..type = refer(aliasAwareType(parameter.type)),
            ),
      ]),
  );

  Method get _dispose =>
      (dispose.toBuilder()
            ..annotations.add(refer('override'))
            ..body = const Code('controller.dispose();'))
          .build();
}

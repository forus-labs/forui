import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:forui_internal_gen/src/source/functions_mixin.dart';
import 'package:meta/meta.dart';

/// Generates a mixin for a class that implements a call, debugFillProperties, equals and hashCode methods and getters.
///
/// This will probably be replaced by an augment class in the future.
@internal
abstract class ControlFunctionsMixin extends FunctionsMixin {
  /// The sealed parent class.
  final ClassElement supertype;

  /// The `_update` method from the sealed parent, if any.
  final MethodElement? update;

  /// The `_dispose` method from the sealed parent, if any.
  final MethodElement? dispose;

  /// All sibling subclasses (including this one).
  final List<ClassElement> siblings;

  /// Creates a new [ControlFunctionsMixin].
  factory ControlFunctionsMixin({
    required ClassElement element,
    required ClassElement supertype,
    required MethodElement? update,
    required MethodElement? dispose,
    required List<ClassElement> siblings,
  }) =>
      element.name!.contains('Lifted') // TODO: Support controls that have more than 2 variants
      ? _LiftedControlFunctionsMixin(
          element: element,
          supertype: supertype,
          update: update,
          dispose: dispose,
          siblings: siblings,
        )
      : _ManagedControlFunctionsMixin(
          element: element,
          supertype: supertype,
          update: update,
          dispose: dispose,
          siblings: siblings,
        );

  ControlFunctionsMixin._({
    required ClassElement element,
    required this.supertype,
    required this.update,
    required this.dispose,
    required this.siblings,
  }) : super(element);

  Method get _update => Method(
    (m) => m
      ..annotations.add(refer('override'))
      ..returns = refer(update!.returnType.getDisplayString())
      ..name = '_update'
      ..requiredParameters.addAll([
        for (final parameter in update!.formalParameters)
          Parameter(
            (p) => p
              ..name = parameter.name!
              ..type = refer(parameter.type.getDisplayString()),
          ),
      ])
      ..body = _updateBody,
  );

  /// Generates the body of the `_update` method.
  ///
  /// We assume that the parameter names are always old, controller and callback.
  Code get _updateBody;

  String get _remainingParameters => [
    for (final p in update!.formalParameters)
      if (p.name case final name when name != 'old' && name != 'controller') p.name!,
  ].join(', ');
}

class _LiftedControlFunctionsMixin extends ControlFunctionsMixin {
  _LiftedControlFunctionsMixin({
    required super.element,
    required super.supertype,
    required super.update,
    required super.dispose,
    required super.siblings,
  }) : assert(siblings.length == 2, 'LiftedControlFunctionsMixin only supports exactly 2 variants.'),
       super._();

  @override
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${element.name}Functions'
            ..on = refer(supertype.name!)
            ..methods.addAll([
              ...getters,
              if (update != null) ...[_update, _updateController],
              if (dispose != null) _dispose,
              debugFillProperties,
              equals,
              hash,
            ]))
          .build();

  @override
  Code get _updateBody {
    final updateParameters = [
      for (final p in update!.formalParameters)
        if (p.name case final name when name != 'old' && name != 'callback') p.name!,
    ].join(', ');

    return Code('''
      switch (old) {
        case _ when old == this:
          return controller;

        // Lifted (Value A) -> Lifted (Value B)
        case Lifted():
          _updateController($updateParameters);
          return controller;
  
        // External -> Lifted
        case Managed(controller: _?):
          controller.removeListener(callback);
          return _create($_remainingParameters);
  
        // Internal -> Lifted
        case Managed():
          controller.dispose();
          return _create($_remainingParameters);
          
        default:
          return controller;
      }
    ''');
  }

  Method get _updateController => Method(
    (m) => m
      ..returns = refer('void')
      ..name = '_updateController'
      ..requiredParameters.addAll([
        for (final parameter in update!.formalParameters)
          if (parameter.name case final name? when name != 'old' && name != 'callback')
            Parameter(
              (p) => p
                ..name = name
                ..type = refer(parameter.type.getDisplayString()),
            ),
      ]),
  );

  Method get _dispose => Method(
    (m) => m
      ..annotations.add(refer('override'))
      ..returns = refer('void')
      ..name = '_dispose'
      ..requiredParameters.addAll([
        for (final parameter in dispose!.formalParameters)
          Parameter(
            (p) => p
              ..name = parameter.name!
              ..type = refer(parameter.type.getDisplayString()),
          ),
      ])
      ..body = const Code('controller.dispose();'),
  );
}

class _ManagedControlFunctionsMixin extends ControlFunctionsMixin {
  _ManagedControlFunctionsMixin({
    required super.element,
    required super.supertype,
    required super.update,
    required super.dispose,
    required super.siblings,
  }) : assert(siblings.length == 2, 'ManagedControlFunctionsMixin only supports exactly 2 variants.'),
       super._();

  @override
  Mixin generate() =>
      (MixinBuilder()
            ..name = '_\$${element.name}Functions'
            ..on = refer(supertype.name!)
            ..methods.addAll([
              ...getters,
              if (update != null) _update,
              if (dispose != null) _dispose,
              debugFillProperties,
              equals,
              hash,
            ]))
          .build();

  @override
  Code get _updateBody => Code('''
      switch (old) {
        case _ when old == this:
          return controller;
  
        // External (Controller A) -> External (Controller B)
        case ${element.name}(controller: final old?) when this.controller != null && this.controller != old:
          controller.removeListener(callback);
          return this.controller!..addListener(callback);
  
        // Internal -> External
        case ${element.name}(controller: final old) when this.controller != null && old == null:
          controller.dispose();
          return this.controller!..addListener(callback);
  
        // External -> Internal
        case ${element.name}(controller: _?) when this.controller == null:
          controller.removeListener(callback);
          return _create($_remainingParameters);
  
        default:
          return controller;
      }
    ''');

  Method get _dispose => Method(
    (m) => m
      ..annotations.add(refer('override'))
      ..returns = refer('void')
      ..name = '_dispose'
      ..requiredParameters.addAll([
        for (final parameter in dispose!.formalParameters)
          Parameter(
            (p) => p
              ..name = parameter.name!
              ..type = refer(parameter.type.getDisplayString()),
          ),
      ])
      ..body = const Code('''
        if (this.controller != null) {
          controller.removeListener(callback);
        } else {
          controller.dispose();
        }
        '''),
  );
}

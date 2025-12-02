import 'package:flutter/foundation.dart';

/// Defines how the password field's obscure text is controlled.
sealed class FObscureTextControl {
  /// Creates a [FObscureTextControl] for controlling the obscure text using lifted state.
  const factory FObscureTextControl.lifted({required bool value, required ValueChanged<bool> onChange}) = Lifted;

  /// Creates a [FObscureTextControl] for controlling the obscure text using a controller.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [initial] are provided.
  const factory FObscureTextControl.managed({
    ValueNotifier<bool>? controller,
    bool initial,
    ValueChanged<bool>? onChange,
  }) = Managed;
}

@internal
class Lifted with Diagnosticable implements FObscureTextControl {
  final bool value;
  final ValueChanged<bool> onChange;

  const Lifted({required this.value, required this.onChange});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('value', value: value, ifTrue: 'obscured', ifFalse: 'visible'))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lifted && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange;

  @override
  int get hashCode => Object.hash(value, onChange);
}

@internal
class Managed with Diagnosticable implements FObscureTextControl {
  final ValueNotifier<bool>? controller;
  final bool initial;
  final ValueChanged<bool>? onChange;

  const Managed({this.controller, this.initial = true, this.onChange})
    : assert(controller == null || initial, 'Cannot provide both an initial value and a controller.');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(FlagProperty('initial', value: initial, ifTrue: 'obscured', ifFalse: 'visible'))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Managed &&
          runtimeType == other.runtimeType &&
          controller == other.controller &&
          initial == other.initial &&
          onChange == other.onChange;

  @override
  int get hashCode => Object.hash(controller, initial, onChange);
}

@internal
class LiftedController extends ValueNotifier<bool> {
  ValueChanged<bool> _onChange;

  // ignore: avoid_positional_boolean_parameters
  LiftedController(super._value, this._onChange);

  // ignore: avoid_positional_boolean_parameters
  void update(bool value, ValueChanged<bool> onChange) {
    if (super.value != value) {
      super.value = value;
    }
    _onChange = onChange;
  }

  @override
  set value(bool value) {
    if (super.value != value) {
      _onChange(value);
    }
  }
}

import 'package:flutter/foundation.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'obscure_text_control.control.dart';

/// Defines how the password field's obscure text is controlled.
sealed class FObscureTextControl with Diagnosticable, _$FObscureTextControlMixin {
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

  const FObscureTextControl._();

  (ValueNotifier<bool>, bool) _update(FObscureTextControl old, ValueNotifier<bool> controller, VoidCallback callback);
}

@internal
final class Lifted extends FObscureTextControl with _$LiftedMixin {
  @override
  final bool value;
  @override
  final ValueChanged<bool> onChange;

  const Lifted({required this.value, required this.onChange}) : super._();

  @override
  ValueNotifier<bool> _create(VoidCallback callback) => _Controller(value, onChange)..addListener(callback);

  @override
  void _updateController(ValueNotifier<bool> controller) => (controller as _Controller).update(value, onChange);
}

@internal
final class Managed extends FObscureTextControl with _$ManagedMixin {
  @override
  final ValueNotifier<bool>? controller;
  @override
  final bool initial;
  @override
  final ValueChanged<bool>? onChange;

  const Managed({this.controller, this.initial = true, this.onChange})
    : assert(controller == null || initial, 'Cannot provide both an initial value and a controller.'),
      super._();

  @override
  ValueNotifier<bool> _create(VoidCallback callback) => (controller ?? ValueNotifier(initial))..addListener(callback);
}

class _Controller extends ValueNotifier<bool> {
  ValueChanged<bool> _onChange;

  _Controller(super._value, this._onChange);

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

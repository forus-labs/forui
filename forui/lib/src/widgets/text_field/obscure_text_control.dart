import 'package:flutter/foundation.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'obscure_text_control.control.dart';

/// A [FObscureTextControl] defines how a password field's obscured state is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FObscureTextControl with Diagnosticable, _$FObscureTextControlMixin {
  /// Creates a [FObscureTextControl] for controlling the obscure text using lifted state.
  const factory FObscureTextControl.lifted({required bool value, required ValueChanged<bool> onChange}) = Lifted;

  /// Creates a [FObscureTextControl].
  const factory FObscureTextControl.managed({
    ValueNotifier<bool>? controller,
    bool initial,
    ValueChanged<bool>? onChange,
  }) = FObscureTextManagedControl;

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
  ValueNotifier<bool> createController() => _Controller(value, onChange);

  @override
  void _updateController(ValueNotifier<bool> controller) => (controller as _Controller).update(value, onChange);
}

/// A [FObscureTextManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
final class FObscureTextManagedControl extends FObscureTextControl with _$FObscureTextManagedControlMixin {
  /// The controller.
  @override
  final ValueNotifier<bool>? controller;

  /// Whether the text is initially obscured. Defaults to true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] is false and [controller] is provided.
  @override
  final bool initial;

  /// Called when the obscured state changes.
  @override
  final ValueChanged<bool>? onChange;

  /// Creates a [FObscureTextControl].
  const FObscureTextManagedControl({this.controller, this.initial = true, this.onChange})
    : assert(controller == null || initial, 'Cannot provide both an initial value and a controller.'),
      super._();

  @override
  ValueNotifier<bool> createController() => controller ?? ValueNotifier(initial);
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

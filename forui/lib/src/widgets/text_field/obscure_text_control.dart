import 'package:flutter/foundation.dart';

// ignore_for_file: avoid_positional_boolean_parameters

part 'obscure_text_control.control.dart';

class _ProxyController extends ValueNotifier<bool> {
  bool _unsynced;
  ValueChanged<bool> _onChange;

  _ProxyController(super._value, this._onChange) : _unsynced = _value;

  void update(bool newValue, ValueChanged<bool> onChange) {
    _onChange = onChange;
    if (super.value != newValue) {
      _unsynced = newValue;
      super.value = newValue;
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      notifyListeners();
    }
  }

  @override
  set value(bool newValue) {
    _unsynced = newValue;
    if (super.value != newValue) {
      _onChange(newValue);
    }
  }
}

/// A [FObscureTextControl] defines how a password field's obscured state is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FObscureTextControl with Diagnosticable, _$FObscureTextControlMixin {
  /// Creates a [FObscureTextControl] for controlling the obscure text using lifted state.
  const factory FObscureTextControl.lifted({required bool value, required ValueChanged<bool> onChange}) = _Lifted;

  /// Creates a [FObscureTextControl].
  const factory FObscureTextControl.managed({
    ValueNotifier<bool>? controller,
    bool? initial,
    ValueChanged<bool>? onChange,
  }) = FObscureTextManagedControl;

  const FObscureTextControl._();

  (ValueNotifier<bool>, bool) _update(FObscureTextControl old, ValueNotifier<bool> controller, VoidCallback callback);
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
  /// Throws [AssertionError] if [initial] is not null and [controller] is provided.
  @override
  final bool? initial;

  /// Called when the obscured state changes.
  @override
  final ValueChanged<bool>? onChange;

  /// Creates a [FObscureTextControl].
  const FObscureTextManagedControl({this.controller, this.initial, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both an initial value and a controller.'),
      super._();

  @override
  ValueNotifier<bool> createController() => controller ?? .new(initial ?? true);
}

final class _Lifted extends FObscureTextControl with _$_LiftedMixin {
  @override
  final bool value;
  @override
  final ValueChanged<bool> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  ValueNotifier<bool> createController() => _ProxyController(value, onChange);

  @override
  void _updateController(ValueNotifier<bool> controller) => (controller as _ProxyController).update(value, onChange);
}

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// Defines how the text field's text is controlled.
sealed class FTextFieldControl {
  /// Creates a [FTextFieldControl] that is controlled externally.
  const factory FTextFieldControl.lifted({
    required TextEditingValue value,
    required ValueChanged<TextEditingValue> onChange,
  }) = Lifted;

  /// Creates a [FTextFieldControl] that is managed internally.
  const factory FTextFieldControl.managed({
    required TextEditingController? controller,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = Managed;

  TextEditingController _create(VoidCallback onChange);

  TextEditingController _update(FTextFieldControl control, TextEditingController old, VoidCallback handleOnChange);

  void _dispose(TextEditingController controller, VoidCallback handleOnChange);
}

@internal
extension InternalFTextFieldControl on FTextFieldControl {
  TextEditingController create(VoidCallback handleOnChange) => _create(handleOnChange);

  TextEditingController update(FTextFieldControl control, TextEditingController old, VoidCallback handleOnChange) =>
      _update(control, old, handleOnChange);

  void dispose(TextEditingController controller, VoidCallback handleOnChange) => _dispose(controller, handleOnChange);
}

@internal
class Lifted implements FTextFieldControl {
  final TextEditingValue value;
  final ValueChanged<TextEditingValue> onChange;

  const Lifted({required this.value, required this.onChange});

  @override
  TextEditingController _create(VoidCallback _) => _Controller(value, onChange);

  @override
  TextEditingController _update(FTextFieldControl control, TextEditingController old, VoidCallback handleOnChange) {
    switch (control) {
      case Lifted _:
        return (old as _Controller)..update(value, onChange); // _Controller is guaranteed here

      case Managed(controller: _?): // External controller
        old.removeListener(handleOnChange);
        return create(handleOnChange);

      case Managed _: // Internal controller
        old.dispose();
        return create(handleOnChange);
    }
  }

  @override
  void _dispose(TextEditingController controller, VoidCallback _) => controller.dispose();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lifted && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange;

  @override
  int get hashCode => Object.hash(value, onChange);
}

@internal
class Managed implements FTextFieldControl {
  final TextEditingController? controller;
  final TextEditingValue? initial;
  final ValueChanged<TextEditingValue>? onChange;

  const Managed({this.controller, this.initial, this.onChange});

  @override
  TextEditingController _create(VoidCallback handleOnChange) => controller ?? TextEditingController.fromValue(initial)
    ..addListener(handleOnChange);

  @override
  TextEditingController _update(FTextFieldControl control, TextEditingController old, VoidCallback handleOnChange) {
    switch (control) {
      case Lifted _:
        old.dispose();
        return create(handleOnChange);

      case Managed(controller: _?): // External controller
        old.removeListener(handleOnChange);
        return create(handleOnChange);

      case Managed _: // Internal controller
        old.dispose();
        return create(handleOnChange);
    }
  }

  @override
  void _dispose(TextEditingController controller, VoidCallback handleOnChange) {
    if (this.controller == null) {
      controller.dispose();
    } else {
      controller.removeListener(handleOnChange);
    }
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

class _Controller extends TextEditingController {
  ValueChanged<TextEditingValue> _onChange;

  _Controller(super.value, this._onChange) : super.fromValue();

  void update(TextEditingValue value, ValueChanged<TextEditingValue> onChange) {
    if (super.value != value) {
      super.value = value;
    }
    _onChange = onChange;
  }

  @override
  set value(TextEditingValue value) {
    if (super.value != value) {
      _onChange(value);
    }
  }
}

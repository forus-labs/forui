import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@internal
class TextFieldControl extends StatefulWidget {
  final FTextFieldControl control;
  final ValueWidgetBuilder<TextEditingController> builder;

  const TextFieldControl({required this.control, required this.builder, super.key});

  @override
  State<TextFieldControl> createState() => _TextFieldControlState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

class _TextFieldControlState extends State<TextFieldControl> {
  // TODO: Add support for restorable text editing controller.
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = switch (widget.control) {
      _Lifted(:final value, :final onChange) => _Controller(value, onChange),
      _Managed(:final controller, :final initial) =>
        (controller ?? .new(text: initial?.text))..addListener(_handleOnChange),
    };
  }

  @override
  void didUpdateWidget(covariant TextFieldControl old) {
    super.didUpdateWidget(old);
    switch ((old.control, widget.control)) {
      case _ when old.control == widget.control:
        break;

      // Lifted (Value A) -> Lifted (Value B)
      case (_Lifted(), _Lifted(:final value, :final onChange)):
        (_controller as _Controller).update(value, onChange); // _Controller is guaranteed here

      // External -> Lifted
      case (_Managed(controller: _?), _Lifted(:final value, :final onChange)):
        _controller.removeListener(_handleOnChange);
        _controller = _Controller(value, onChange);

      // Internal -> Lifted
      case (_Managed(), _Lifted(:final value, :final onChange)):
        _controller.dispose();
        _controller = _Controller(value, onChange);

      // External (Controller A) -> External (Controller B)
      case (_Managed(controller: final old?), _Managed(:final controller?)) when old != controller:
        _controller.removeListener(_handleOnChange);
        _controller = controller..addListener(_handleOnChange);

      // Internal -> External
      case (_Managed(controller: final old), _Managed(:final controller?)) when old == null:
        _controller.dispose();
        _controller = controller..addListener(_handleOnChange);

      // External -> Internal
      case (_Managed(controller: final _?), _Managed(:final controller, :final initial)) when controller == null:
        _controller.removeListener(_handleOnChange);
        _controller = .fromValue(initial)..addListener(_handleOnChange);

      default:
        break;
    }
  }

  @override
  void dispose() {
    if (widget.control case _Managed(controller: _?)) {
      _controller.removeListener(_handleOnChange);
    } else {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case _Managed(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller, null);
}

/// Defines how the text field's text is controlled.
sealed class FTextFieldControl {
  /// Creates a [FTextFieldControl] for controlling a text field using lifted state.
  const factory FTextFieldControl.lifted({
    required TextEditingValue value,
    required ValueChanged<TextEditingValue> onChange,
  }) = _Lifted;

  /// Creates a [FTextFieldControl] for controlling a text field using a controller.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [initial] are provided.
  const factory FTextFieldControl.managed({
    TextEditingController? controller,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = _Managed;
}

class _Lifted with Diagnosticable implements FTextFieldControl {
  final TextEditingValue value;
  final ValueChanged<TextEditingValue> onChange;

  const _Lifted({required this.value, required this.onChange});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Lifted && runtimeType == other.runtimeType && value == other.value && onChange == other.onChange;

  @override
  int get hashCode => Object.hash(value, onChange);
}

class _Managed with Diagnosticable implements FTextFieldControl {
  final TextEditingController? controller;
  final TextEditingValue? initial;
  final ValueChanged<TextEditingValue>? onChange;

  const _Managed({this.controller, this.initial, this.onChange})
    : assert(initial == null || controller == null, 'Cannot provide both an initial value and a controller.');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('initial', initial))
      ..add(ObjectFlagProperty.has('onChange', onChange));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Managed &&
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

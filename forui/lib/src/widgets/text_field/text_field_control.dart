import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

part 'text_field_control.control.dart';

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
    _controller = widget.control.create(_handleOnChange);
  }

  @override
  void didUpdateWidget(covariant TextFieldControl old) {
    super.didUpdateWidget(old);
    _controller = widget.control.update(old.control, _controller, _handleOnChange);
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
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

/// Defines how the text field's text is controlled.
sealed class FTextFieldControl with Diagnosticable {
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

  const FTextFieldControl._();

  TextEditingController _create(VoidCallback callback);

  TextEditingController _update(FTextFieldControl old, TextEditingController controller, VoidCallback callback);

  void _dispose(TextEditingController controller, VoidCallback callback);
}

class _Lifted extends FTextFieldControl with _$_LiftedFunctions {
  @override
  final TextEditingValue value;
  @override
  final ValueChanged<TextEditingValue> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  TextEditingController _create(VoidCallback callback) => _Controller(value, onChange);

  @override
  void _updateController(TextEditingController controller) => (controller as _Controller).update(value, onChange);
}

class _Managed extends FTextFieldControl with _$_ManagedFunctions {
  @override
  final TextEditingController? controller;
  @override
  final TextEditingValue? initial;
  @override
  final ValueChanged<TextEditingValue>? onChange;

  const _Managed({this.controller, this.initial, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both an initial value and a controller.'),
      super._();

  @override
  TextEditingController _create(VoidCallback callback) => (controller ?? .fromValue(initial))..addListener(callback);
}

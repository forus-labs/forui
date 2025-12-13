import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart' show FTextField;
import 'package:forui/src/widgets/text_field/text_field.dart' show FTextField;
import 'package:forui/widgets/text_field.dart' show FTextField;

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
    _controller = widget.control.update(old.control, _controller, _handleOnChange).$1;
  }

  @override
  void dispose() {
    widget.control.dispose(_controller, _handleOnChange);
    super.dispose();
  }

  void _handleOnChange() {
    if (widget.control case FTextFieldManagedControl(:final onChange?)) {
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

/// A [FTextFieldControl] defines how a [FTextField] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FTextFieldControl with Diagnosticable, _$FTextFieldControlMixin {
  /// Creates a [FTextFieldControl] for controlling a text field using lifted state.
  const factory FTextFieldControl.lifted({
    required TextEditingValue value,
    required ValueChanged<TextEditingValue> onChange,
  }) = _Lifted;

  /// Creates a [FTextFieldControl].
  const factory FTextFieldControl.managed({
    TextEditingController? controller,
    TextEditingValue? initial,
    ValueChanged<TextEditingValue>? onChange,
  }) = FTextFieldManagedControl;

  const FTextFieldControl._();

  (TextEditingController, bool) _update(FTextFieldControl old, TextEditingController controller, VoidCallback callback);
}

class _Lifted extends FTextFieldControl with _$_LiftedMixin {
  @override
  final TextEditingValue value;
  @override
  final ValueChanged<TextEditingValue> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  TextEditingController createController() => _Controller(value, onChange);

  @override
  void _updateController(TextEditingController controller) => (controller as _Controller).update(value, onChange);
}

/// A [FTextFieldManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FTextFieldManagedControl extends FTextFieldControl with _$FTextFieldManagedControlMixin {
  /// The controller.
  @override
  final TextEditingController? controller;

  /// The initial value. Defaults to [TextEditingValue.empty].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final TextEditingValue? initial;

  /// Called when the value changes.
  @override
  final ValueChanged<TextEditingValue>? onChange;

  /// Creates a [FTextFieldControl].
  const FTextFieldManagedControl({this.controller, this.initial, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both an initial value and a controller.'),
      super._();

  @override
  TextEditingController createController() => controller ?? .fromValue(initial);
}

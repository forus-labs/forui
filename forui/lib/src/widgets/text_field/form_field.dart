import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

// We call this InputFormField to avoid confusion with Flutter's TextFormField.
@internal
class InputFormField extends FormField<String> {
  final TextEditingController controller;

  InputFormField({
    required this.controller,
    required super.initialValue,
    required super.onSaved,
    required super.onReset,
    required super.validator,
    required super.enabled,
    required super.autovalidateMode,
    required super.forceErrorText,
    required super.restorationId,
    required Widget Function(TextFormFieldState state) builder,
    super.key,
  }) : super(
         builder: (state) =>
             UnmanagedRestorationScope(bucket: state.bucket, child: builder(state as TextFormFieldState)),
       );

  @override
  FormFieldState<String> createState() => TextFormFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

// This class is based on Material's _TextFormFieldState implementation.
// TODO: Reimplement restorable text editing controller after declarative API has merged.
@internal
class TextFormFieldState extends FormFieldState<String> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextEditingChange);
  }

  @override
  void didUpdateWidget(covariant InputFormField old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      old.controller.removeListener(_handleTextEditingChange);
      widget.controller.addListener(_handleTextEditingChange);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextEditingChange);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (widget.controller.text != value) {
      widget.controller.text = value ?? '';
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.controller.text = widget.initialValue ?? '';
    super.reset();
  }

  // Suppress changes that originated from within this class.
  //
  // In the case where a controller has been passed in to this widget, we register this change listener. In these
  // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
  // reset() method. In such cases, the FormField value will already have been set.
  void _handleTextEditingChange() {
    if (widget.controller.text != value) {
      didChange(widget.controller.text);
    }
  }

  @override
  InputFormField get widget => super.widget as InputFormField;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@internal
class Field extends FormField<String> {
  final TextEditingController? controller;

  Field({
    required this.controller,
    required super.initialValue,
    required super.onSaved,
    required super.onReset,
    required super.validator,
    required super.enabled,
    required super.autovalidateMode,
    required super.forceErrorText,
    required super.restorationId,
    required Widget Function(FieldState state) builder,
    super.key,
  }) : super(
         builder: (state) => UnmanagedRestorationScope(bucket: state.bucket, child: builder(state as FieldState)),
       );

  @override
  FormFieldState<String> createState() => FieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

// This class is based on Material's _TextFormFieldState implementation.
@internal
class FieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller case final controller?) {
      controller.addListener(_handleTextEditingChange);
    } else {
      _registerController(RestorableTextEditingController(text: widget.initialValue));
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller case final controller?) {
      registerForRestoration(controller, 'controller');
    }

    // Make sure to update the internal [FormFieldState] value to sync up with text editing controller value.
    setValue(effectiveController.text);
  }

  void _registerController(RestorableTextEditingController controller) {
    assert(_controller == null, '_controller is already initialized.');
    _controller = controller;
    if (!restorePending) {
      registerForRestoration(controller, 'controller');
    }
  }

  @override
  void didUpdateWidget(covariant Field old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    widget.controller?.addListener(_handleTextEditingChange);
    old.controller?.removeListener(_handleTextEditingChange);

    switch ((widget.controller, old.controller)) {
      case (final current?, _):
        setValue(current.text);
        if (_controller != null) {
          unregisterFromRestoration(_controller!);
          _controller?.dispose();
          _controller = null;
        }

      case (null, final old?):
        _registerController(RestorableTextEditingController.fromValue(old.value));
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTextEditingChange);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (effectiveController.text != value) {
      effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  // Suppress changes that originated from within this class.
  //
  // In the case where a controller has been passed in to this widget, we register this change listener. In these
  // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
  // reset() method. In such cases, the FormField value will already have been set.
  void _handleTextEditingChange() {
    if (effectiveController.text != value) {
      didChange(effectiveController.text);
    }
  }

  @override
  Field get widget => super.widget as Field;

  /// The effective controller for this field.
  TextEditingController get effectiveController => widget.controller ?? _controller!.value;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('effectiveController', effectiveController));
  }
}

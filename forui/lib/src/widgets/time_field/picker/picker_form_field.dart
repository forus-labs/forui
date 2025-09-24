import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

@internal
class PickerFormField extends FormField<FTime> {
  final FTimeFieldController controller;

  PickerFormField({
    required this.controller,
    required super.enabled,
    required super.autovalidateMode,
    required super.forceErrorText,
    required super.onSaved,
    required super.onReset,
    required super.validator,
    required FTime? initialTime,
    required super.builder,
    super.key,
  }) : super(initialValue: initialTime ?? controller.value);

  @override
  FormFieldState<FTime> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('properties', properties))
      ..add(DiagnosticsProperty('initialValue', initialValue));
  }
}

class _State extends FormFieldState<FTime> {
  @override
  PickerFormField get widget => super.widget as PickerFormField;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant PickerFormField old) {
    super.didUpdateWidget(old);
    old.controller.removeListener(_handleChange);
    widget.controller.addListener(_handleChange);
  }

  // Suppress changes that originated from within this class.
  //
  // In the case where a controller has been passed in to this widget, we register this change listener. In these
  // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
  // reset() method. In such cases, the FormField value will already have been set.
  void _handleChange() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.controller.value != value) {
        didChange(widget.controller.value);
      }
    });
  }

  @override
  void didChange(FTime? value) {
    super.didChange(value);
    if (widget.controller.value != value) {
      widget.controller.value = value;
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.controller.value = widget.initialValue;
    super.reset();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleChange);
    super.dispose();
  }
}

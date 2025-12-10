import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// An internal form field for [Set] values that syncs with a [FMultiValueNotifier].
///
/// This form field does NOT manage the controller lifecycle - it expects the controller
/// to be managed by the parent widget.
@internal
class MultiValueFormField<T> extends FormField<Set<T>> {
  /// The controller that holds the current set value.
  final FMultiValueNotifier<T> controller;

  /// Creates a [MultiValueFormField].
  MultiValueFormField({
    required this.controller,
    required super.builder,
    super.onSaved,
    super.validator,
    super.enabled,
    super.autovalidateMode,
    super.forceErrorText,
    super.restorationId,
    super.key,
  }) : super(initialValue: controller.value);

  @override
  FormFieldState<Set<T>> createState() => MultiValueFormFieldState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FMultiValueNotifier<T>>('controller', controller));
  }
}

/// The state for a [MultiValueFormField].
@internal
class MultiValueFormFieldState<T> extends FormFieldState<Set<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(covariant MultiValueFormField<T> old) {
    super.didUpdateWidget(old);
    if (widget.controller != old.controller) {
      old.controller.removeListener(_handleControllerChange);
      widget.controller.addListener(_handleControllerChange);
    }
  }

  // Suppress changes that originated from within this class.
  //
  // In the case where a controller has been passed in to this widget, we register this change listener. In these
  // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
  // reset() method. In such cases, the FormField value will already have been set.
  void _handleControllerChange() {
    if (!setEquals(widget.controller.value, value)) {
      didChange(widget.controller.value);
    }
  }

  @override
  void didChange(Set<T>? value) {
    super.didChange(value);
    if (!setEquals(widget.controller.value, value)) {
      widget.controller.value = value ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChange suppress the change.
    widget.controller.value = widget.initialValue ?? {};
    super.reset();
  }

  // This is a workaround the default FormField.build() function wrapping the child (a SliverList) in a Semantics
  // which results in:
  // "A RenderSemanticsAnnotations expected a child of type RenderBox but received a child of type RenderSliverList."
  //
  // This behavior was introduced without any prior notice in Flutter 3.32.
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.builder(this);
  }

  @override
  MultiValueFormField<T> get widget => super.widget as MultiValueFormField<T>;

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }
}

import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

part 'line_calendar_controller.control.dart';

/// A [FLineCalendarControl] defines how a [FLineCalendar] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FLineCalendarControl with Diagnosticable, _$FLineCalendarControlMixin {
  /// Creates lifted state control.
  ///
  /// The [value] parameter contains the current selected date.
  /// The [onChange] callback is invoked when the user selects a date.
  /// The [toggleable] parameter determines whether the calendar can be unselected.
  const factory FLineCalendarControl.lifted({
    required DateTime? value,
    required ValueChanged<DateTime?> onChange,
    bool toggleable,
  }) = Lifted;

  /// Creates a [FLineCalendarControl].
  const factory FLineCalendarControl.managed({
    FCalendarController<DateTime?>? controller,
    DateTime? initial,
    bool toggleable,
    ValueChanged<DateTime?>? onChange,
  }) = FLineCalendarManagedControl;

  const FLineCalendarControl._();

  (FCalendarController<DateTime?>, bool) _update(
    FLineCalendarControl old,
    FCalendarController<DateTime?> controller,
    VoidCallback callback,
  );
}

@internal
class Lifted extends FLineCalendarControl with _$LiftedMixin {
  @override
  final DateTime? value;
  @override
  final ValueChanged<DateTime?> onChange;
  @override
  final bool toggleable;

  const Lifted({required this.value, required this.onChange, this.toggleable = false}) : super._();

  @override
  FCalendarController<DateTime?> createController() => _Controller(value: value, onChange: onChange, toggleable: toggleable);

  @override
  void _updateController(FCalendarController<DateTime?> controller) =>
      (controller as _Controller).update(value, onChange, toggleable);
}

/// A [FLineCalendarManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FLineCalendarManagedControl extends FLineCalendarControl with Diagnosticable, _$FLineCalendarManagedControlMixin {
  /// The controller.
  @override
  final FCalendarController<DateTime?>? controller;

  /// The initial date. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final DateTime? initial;

  /// Whether the selection is toggleable. Defaults to false.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [toggleable] is true and [controller] is provided.
  @override
  final bool toggleable;

  /// Called when the selected date changes.
  @override
  final ValueChanged<DateTime?>? onChange;

  /// Creates a [FLineCalendarControl].
  const FLineCalendarManagedControl({this.controller, this.initial, this.toggleable = false, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
      assert(controller == null || !toggleable, 'Cannot provide both controller and toggleable.'),
      super._();

  @override
  FCalendarController<DateTime?> createController() =>
      controller ?? FCalendarController.date(initialSelection: initial, toggleable: toggleable);
}

class _Controller implements FCalendarController<DateTime?> {
  FCalendarController<DateTime?> _controller;
  ValueChanged<DateTime?> _onChange;
  bool _toggleable;

  _Controller({required DateTime? value, required ValueChanged<DateTime?> onChange, required bool toggleable})
    : _controller = FCalendarController.date(initialSelection: value, toggleable: toggleable),
      _onChange = onChange,
      _toggleable = toggleable;

  // ignore: avoid_positional_boolean_parameters
  void update(DateTime? value, ValueChanged<DateTime?> onChange, bool toggleable) {
    _onChange = onChange;

    if (_toggleable != toggleable) {
      _controller.dispose();
      _controller = FCalendarController.date(initialSelection: value, toggleable: toggleable);
      _toggleable = toggleable;
    } else if (_controller.value != value) {
      _controller.value = value;
    }
  }

  @override
  void select(DateTime date) {
    final newValue = (_toggleable && _controller.value == date) ? null : date;
    if (_controller.value != newValue) {
      _controller.value = newValue;
      _onChange(newValue);
    }
  }

  @override
  bool selectable(DateTime date) => _controller.selectable(date);

  @override
  bool selected(DateTime date) => _controller.selected(date);

  @override
  void addListener(VoidCallback listener) => _controller.addListener(listener);

  @override
  void addValueListener(ValueChanged<DateTime?>? listener) => _controller.addValueListener(listener);

  @override
  void dispose() => _controller.dispose();

  @override
  bool get disposed => _controller.disposed;

  @override
  bool get hasListeners => _controller.hasListeners;

  @override
  void notifyListeners() => _controller.notifyListeners();

  @override
  void removeListener(VoidCallback listener) => _controller.removeListener(listener);

  @override
  void removeValueListener(ValueChanged<DateTime?>? listener) => _controller.removeValueListener(listener);

  @override
  DateTime? get value => _controller.value;

  @override
  set value(DateTime? value) {
    if (_controller.value != value) {
      _controller.value = value;
      _onChange(value);
    }
  }
}

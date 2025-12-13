import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';
import 'package:sugar/core.dart';

part 'line_calendar_controller.control.dart';

class _ProxyController implements FCalendarController<DateTime?> {
  FCalendarController<DateTime?> _controller;
  ValueChanged<DateTime?> _onChange;
  Predicate<DateTime> _selectable;
  DateTime? _unsynced;

  _ProxyController(this._unsynced, this._onChange, this._selectable)
    : _controller = .date(initial: _unsynced, selectable: _selectable, toggleable: false);

  void update(DateTime? newValue, ValueChanged<DateTime?> onChange, Predicate<DateTime> selectable) {
    _onChange = onChange;

    if (_selectable != selectable) {
      _selectable = selectable;
      _unsynced = newValue;
      _controller.dispose();
      _controller = .date(initial: newValue, selectable: selectable, toggleable: false);
    } else if (_controller.value != newValue) {
      _unsynced = newValue;
      _controller.value = newValue;
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      notifyListeners();
    }
  }

  @override
  void select(DateTime date) {
    if (_controller.value != date) {
      _unsynced = date;
      _onChange(date);
    }
  }

  @override
  DateTime? get value => _controller.value;

  @override
  set value(DateTime? value) {
    if (_controller.value != value) {
      _unsynced = value;
      _onChange(value);
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
}

/// A [FLineCalendarControl] defines how a [FLineCalendar] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FLineCalendarControl with Diagnosticable, _$FLineCalendarControlMixin {
  /// Creates a [FLineCalendarControl].
  const factory FLineCalendarControl.managed({
    FCalendarController<DateTime?>? controller,
    DateTime? initial,
    bool? toggleable,
    ValueChanged<DateTime?>? onChange,
  }) = FLineCalendarManagedControl;

  /// Creates lifted state control.
  ///
  /// The [value] parameter contains the current selected date.
  /// The [onChange] callback is invoked when the user selects a date.
  /// The [selectable] predicate determines whether a date can be selected. Defaults to always returning true.
  const factory FLineCalendarControl.lifted({
    required DateTime? value,
    required ValueChanged<DateTime?> onChange,
    Predicate<DateTime> selectable,
  }) = _Lifted;

  const FLineCalendarControl._();

  (FCalendarController<DateTime?>, bool) _update(
    FLineCalendarControl old,
    FCalendarController<DateTime?> controller,
    VoidCallback callback,
  );
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
  final bool? toggleable;

  /// Called when the selected date changes.
  @override
  final ValueChanged<DateTime?>? onChange;

  /// Creates a [FLineCalendarControl].
  const FLineCalendarManagedControl({this.controller, this.initial, this.toggleable, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
      assert(controller == null || toggleable == null, 'Cannot provide both controller and toggleable.'),
      super._();

  @override
  FCalendarController<DateTime?> createController() =>
      controller ?? .date(initial: initial, toggleable: toggleable ?? false);
}

class _Lifted extends FLineCalendarControl with _$_LiftedMixin {
  static bool _defaultSelectable(DateTime _) => true;

  @override
  final DateTime? value;
  @override
  final ValueChanged<DateTime?> onChange;
  @override
  final Predicate<DateTime> selectable;

  const _Lifted({required this.value, required this.onChange, this.selectable = _defaultSelectable}) : super._();

  @override
  FCalendarController<DateTime?> createController() => _ProxyController(value, onChange, selectable);

  @override
  void _updateController(FCalendarController<DateTime?> controller) =>
      (controller as _ProxyController).update(value, onChange, selectable);
}

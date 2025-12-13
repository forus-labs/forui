import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'date_field_controller.control.dart';

/// The date field's controller.
class FDateFieldController implements FValueNotifier<DateTime?> {
  static String? _defaultValidator(DateTime? _) => null;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a date in a calendar is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<DateTime> validator;

  final FCalendarController<DateTime?> _calendar;

  /// Creates a [FDateFieldController].
  FDateFieldController({DateTime? initial, String? Function(DateTime?) validator = _defaultValidator})
    : this._(
        validator: validator,
        calendar: .date(initial: initial, selectable: (date) => validator(date) == null),
      );

  FDateFieldController._({required this.validator, required FCalendarController<DateTime?> calendar})
    : _calendar = calendar;

  @override
  void addListener(VoidCallback listener) => _calendar.addListener(listener);

  @override
  void addValueListener(ValueChanged<DateTime?>? listener) => _calendar.addValueListener(listener);

  @override
  void notifyListeners() => _calendar.notifyListeners();

  @override
  void removeListener(VoidCallback listener) => _calendar.removeListener(listener);

  @override
  void removeValueListener(ValueChanged<DateTime?>? listener) => _calendar.removeValueListener(listener);

  @override
  bool get hasListeners => _calendar.hasListeners;

  @override
  DateTime? get value => _calendar.value;

  @override
  set value(DateTime? value) => _calendar.value = value;

  @override
  bool get disposed => _calendar.disposed;

  @override
  void dispose() => _calendar.dispose();
}

@internal
extension InternalFDateFieldController on FDateFieldController {
  FCalendarController<DateTime?> get calendar => _calendar;
}

class _ProxyCalendarController implements FCalendarController<DateTime?> {
  FCalendarController<DateTime?> _controller;
  ValueChanged<DateTime?> _onChange;
  String? Function(DateTime?) _validator;
  DateTime? _unsynced;

  _ProxyCalendarController(this._unsynced, this._onChange, this._validator)
    : _controller = .date(initial: _unsynced, selectable: (date) => _validator(date) == null);

  void update(DateTime? newValue, ValueChanged<DateTime?> onChange, String? Function(DateTime?) validator) {
    _onChange = onChange;
    if (_validator != validator) {
      _validator = validator;
      _controller.dispose();
      _controller = .date(initial: newValue, selectable: (date) => validator(date) == null);
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
  set value(DateTime? date) {
    if (_controller.value != date) {
      _unsynced = date;
      _onChange(date);
    }
  }
}

/// A [FDateFieldControl] defines how a [FDateField] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FDateFieldControl with Diagnosticable, _$FDateFieldControlMixin {
  /// Creates a [FDateFieldControl].
  const factory FDateFieldControl.managed({
    FDateFieldController? controller,
    DateTime? initial,
    FormFieldValidator<DateTime>? validator,
    ValueChanged<DateTime?>? onChange,
  }) = FDateFieldManagedControl;

  /// Creates a [FDateFieldControl] for controlling a date field using lifted state.
  ///
  /// The [value] represents the currently selected date.
  /// The [onChange] callback is invoked when the user selects a date. The given date is always in UTC.
  ///
  /// [validator] returns an error string to display if the input is invalid, or null otherwise. It is also used to
  /// determine whether a date in a calendar is selectable. Defaults to always returning null.
  ///
  /// ## Note
  /// Partial dates typed into input fields are treated as `null`, and not validated incrementally.
  const factory FDateFieldControl.lifted({
    required DateTime? value,
    required ValueChanged<DateTime?> onChange,
    FormFieldValidator<DateTime> validator,
  }) = _Lifted;

  const FDateFieldControl._();

  (FDateFieldController, bool) _update(
    FDateFieldControl old,
    FDateFieldController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

/// A [FDateFieldManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FDateFieldManagedControl extends FDateFieldControl with Diagnosticable, _$FDateFieldManagedControlMixin {
  /// The controller.
  @override
  final FDateFieldController? controller;

  /// The initial date. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final DateTime? initial;

  /// The validator. Defaults to no validation.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [validator] and [controller] are both provided.
  @override
  final FormFieldValidator<DateTime>? validator;

  /// Called when the selected date changes.
  @override
  final ValueChanged<DateTime?>? onChange;

  /// Creates a [FDateFieldControl].
  const FDateFieldManagedControl({
    this.controller,
    this.initial,
    this.validator,
    this.onChange,
  }) : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
       assert(controller == null || validator == null, 'Cannot provide both controller and validator.'),
       super._();

  @override
  FDateFieldController createController(TickerProvider vsync) =>
      controller ?? .new(initial: initial, validator: validator ?? FDateFieldController._defaultValidator);
}

class _Lifted extends FDateFieldControl with _$_LiftedMixin {
  @override
  final DateTime? value;
  @override
  final ValueChanged<DateTime?> onChange;
  @override
  final FormFieldValidator<DateTime> validator;

  const _Lifted({required this.value, required this.onChange, this.validator = FDateFieldController._defaultValidator})
    : super._();

  @override
  FDateFieldController createController(TickerProvider vsync) =>
      FDateFieldController._(calendar: _ProxyCalendarController(value, onChange, validator), validator: validator);

  @override
  void _updateController(FDateFieldController controller, TickerProvider vsync) {
    (controller._calendar as _ProxyCalendarController).update(value, onChange, validator);
  }
}

// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/popover/popover_controller.dart';

part 'date_field_controller.control.dart';

/// The date field's controller.
class FDateFieldController implements FValueNotifier<DateTime?> {
  static String? _defaultValidator(DateTime? _) => null;

  /// The controller for the calendar popover. Does nothing if the date field is input only.
  ///
  /// ## Contract
  /// Manually disposing this controller is undefined behavior. Dispose this [FDateFieldController] instead.
  final FPopoverController popover;

  /// Returns an error string to display if the input is invalid, or null otherwise. It is also used to determine
  /// whether a date in a calendar is selectable.
  ///
  /// Defaults to always returning null.
  final FormFieldValidator<DateTime> validator;

  /// True if the controller should truncate and convert all given [DateTime]s to dates in UTC timezone. Defaults to
  /// true.
  ///
  /// ```dart
  /// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
  /// ```
  ///
  /// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
  /// the help of a 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
  /// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
  final bool truncateAndStripTimezone;

  final FCalendarController<DateTime?> _calendar;

  /// Creates a [FDateFieldController].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initialDate] is not in UTC timezone and [truncateAndStripTimezone] is false.
  FDateFieldController({
    required TickerProvider vsync,
    DateTime? initialDate,
    String? Function(DateTime?) validator = _defaultValidator,
    bool truncateAndStripTimezone = true,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : this._(
         popover: FPopoverController(vsync: vsync, motion: popoverMotion),
         validator: validator,
         truncateAndStripTimezone: truncateAndStripTimezone,
         calendar: .date(
           initialSelection: initialDate,
           selectable: (date) => validator(date) == null,
           truncateAndStripTimezone: truncateAndStripTimezone,
         ),
       );

  FDateFieldController._({
    required this.popover,
    required this.validator,
    required this.truncateAndStripTimezone,
    required FCalendarController<DateTime?> calendar,
  }) : _calendar = calendar;

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
  void dispose() {
    _calendar.dispose();
    popover.dispose();
  }
}

@internal
extension InternalFDateFieldController on FDateFieldController {
  FCalendarController<DateTime?> get calendar => _calendar;
}

class _Controller extends FDateFieldController {
  late FPopoverController _popover;

  _Controller({
    required TickerProvider vsync,
    required DateTime? value,
    required ValueChanged<DateTime?> onChange,
    required super.validator,
    required super.truncateAndStripTimezone,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion popoverMotion = const FPopoverMotion(),
  }) : super._(
         popover: popoverShown != null && onPopoverChange != null
             ? LiftedPopoverController(popoverShown, onPopoverChange, vsync: vsync, motion: popoverMotion)
             : FPopoverController(vsync: vsync, motion: popoverMotion),
         calendar: _CalendarController(
           .date(
             initialSelection: value,
             selectable: (date) => validator(date) == null,
             truncateAndStripTimezone: truncateAndStripTimezone,
           ),
           onChange,
           validator,
           truncateAndStripTimezone,
         ),
       ) {
    _popover = super.popover; // This prevents the creation of two popover controllers, with one being shadowed.
  }

  void update(
    TickerProvider vsync,
    DateTime? value,
    ValueChanged<DateTime?> onChange,
    String? Function(DateTime?) validator,
    bool truncateAndStripTimezone,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
  ) {
    _popover = InternalFPopoverController.updateNested(_popover, vsync, popoverShown, onPopoverChange);
    (_calendar as _CalendarController).update(value, onChange, validator, truncateAndStripTimezone);
  }

  @override
  FPopoverController get popover => _popover;
}

class _CalendarController implements FCalendarController<DateTime?> {
  FCalendarController<DateTime?> _controller;
  ValueChanged<DateTime?> _onChange;
  String? Function(DateTime?) _validator;
  bool _truncateAndStripTimezone;

  _CalendarController(this._controller, this._onChange, this._validator, this._truncateAndStripTimezone);

  void update(
    DateTime? value,
    ValueChanged<DateTime?> onChange,
    String? Function(DateTime?) validator,
    bool truncateAndStripTimezone,
  ) {
    _onChange = onChange;
    if (_validator != validator || _truncateAndStripTimezone != truncateAndStripTimezone) {
      _controller.dispose();
      _controller = .date(
        initialSelection: value,
        selectable: (date) => validator(date) == null,
        truncateAndStripTimezone: truncateAndStripTimezone,
      );
      _validator = validator;
      _truncateAndStripTimezone = truncateAndStripTimezone;
    } else if (_controller.value != value) {
      _controller.value = value;
    }
  }

  @override
  void select(DateTime date) {
    if (_controller.value != date) {
      _controller.value = date;
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
  set value(DateTime? value) {
    if (_controller.value != value) {
      _controller.value = value;
      _onChange(value);
    }
  }
}

/// A [FDateFieldControl] defines how a [FDateField] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FDateFieldControl with Diagnosticable, _$FDateFieldControlMixin {
  /// Creates lifted state control.
  ///
  /// Date value is always lifted.
  /// Popover visibility is optionally lifted - if [popoverShown] is provided, [onPopoverChange] must also be provided.
  ///
  /// The [value] parameter contains the current selected date.
  /// The [onChange] callback is invoked when the user selects a date.
  ///
  /// ## Contract
  /// Throws [AssertionError] if only one of [popoverShown]/[onPopoverChange] is provided.
  const factory FDateFieldControl.lifted({
    required DateTime? value,
    required ValueChanged<DateTime?> onChange,
    bool? popoverShown,
    ValueChanged<bool>? onPopoverChange,
    FPopoverMotion motion,
  }) = Lifted;

  /// Creates a [FDateFieldControl].
  const factory FDateFieldControl.managed({
    FDateFieldController? controller,
    DateTime? initial,
    FormFieldValidator<DateTime>? validator,
    FPopoverMotion? popoverMotion,
    bool truncateAndStripTimezone,
    ValueChanged<DateTime?>? onChange,
  }) = FDateFieldManagedControl;

  const FDateFieldControl._();

  (FDateFieldController, bool) _update(
    FDateFieldControl old,
    FDateFieldController controller,
    VoidCallback callback,
    TickerProvider vsync,
  );
}

@internal
class Lifted extends FDateFieldControl with _$LiftedMixin {
  @override
  final DateTime? value;
  @override
  final ValueChanged<DateTime?> onChange;
  @override
  final FormFieldValidator<DateTime> validator;
  @override
  final bool truncateAndStripTimezone;
  @override
  final bool? popoverShown;
  @override
  final ValueChanged<bool>? onPopoverChange;
  @override
  final FPopoverMotion motion;

  const Lifted({
    required this.value,
    required this.onChange,
    this.validator = FDateFieldController._defaultValidator,
    this.truncateAndStripTimezone = true,
    this.popoverShown,
    this.onPopoverChange,
    this.motion = const FPopoverMotion(),
  }) : assert(
         (popoverShown == null) == (onPopoverChange == null),
         'popoverShown and onPopoverChange must both be provided or both be null.',
       ),
       super._();

  @override
  FDateFieldController createController(TickerProvider vsync) => _Controller(
    vsync: vsync,
    value: value,
    onChange: onChange,
    validator: validator,
    truncateAndStripTimezone: truncateAndStripTimezone,
    popoverShown: popoverShown,
    onPopoverChange: onPopoverChange,
    popoverMotion: motion,
  );

  @override
  void _updateController(FDateFieldController controller, TickerProvider vsync) {
    (controller as _Controller).update(
      vsync,
      value,
      onChange,
      validator,
      truncateAndStripTimezone,
      popoverShown,
      onPopoverChange,
    );
  }
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

  /// The popover motion. Defaults to [FPopoverMotion].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [popoverMotion] and [controller] are both provided.
  @override
  final FPopoverMotion? popoverMotion;

  /// Whether to truncate and convert all [DateTime]s to dates in UTC timezone. Defaults to true.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [truncateAndStripTimezone] is false and [controller] is provided.
  @override
  final bool truncateAndStripTimezone;

  /// Called when the selected date changes.
  @override
  final ValueChanged<DateTime?>? onChange;

  /// Creates a [FDateFieldControl].
  const FDateFieldManagedControl({
    this.controller,
    this.initial,
    this.validator,
    this.popoverMotion,
    this.truncateAndStripTimezone = true,
    this.onChange,
  }) : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
       assert(controller == null || popoverMotion == null, 'Cannot provide both controller and popoverMotion.'),
       assert(controller == null || validator == null, 'Cannot provide both controller and validator.'),
       assert(
         controller == null || truncateAndStripTimezone,
         'Cannot provide both controller and truncateAndStripTimezone.',
       ),
       super._();

  @override
  FDateFieldController createController(TickerProvider vsync) =>
      controller ??
      FDateFieldController(
        vsync: vsync,
        initialDate: initial,
        validator: validator ?? FDateFieldController._defaultValidator,
        popoverMotion: popoverMotion ?? const FPopoverMotion(),
        truncateAndStripTimezone: truncateAndStripTimezone,
      );
}

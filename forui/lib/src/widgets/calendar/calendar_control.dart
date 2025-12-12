part of 'calendar_controller.dart';

class _Controller extends FCalendarController<Object?> {
  Predicate<DateTime> _selectable;
  bool Function(DateTime) _selected;
  void Function(DateTime) _select;

  _Controller({
    required Predicate<DateTime> selectable,
    required bool Function(DateTime) selected,
    required void Function(DateTime) select,
  }) : _selectable = selectable,
       _selected = selected,
       _select = select,
       super(0);

  void update({
    required Predicate<DateTime> selectable,
    required bool Function(DateTime) selected,
    required void Function(DateTime) select,
  }) {
    _selectable = selectable;
    _selected = selected;
    _select = select;
    notifyListeners();
  }

  @override
  bool selectable(DateTime date) => _selectable(date);

  @override
  bool selected(DateTime date) => _selected(date);

  @override
  void select(DateTime date) => _select(date);
}

/// Defines how a [FCalendar]'s value is controlled.
sealed class FCalendarControl<T> with Diagnosticable, _$FCalendarControlMixin<T> {
  static bool _defaultSelectable(DateTime _) => true;

  /// Creates lifted state control.
  ///
  /// The [selectable] predicate determines if a date can be selected. Defaults to always true if not given.
  /// The [selected] function determines if a date is currently selected.
  /// The [select] callback is invoked when a date is selected.
  static FCalendarControl<Object?> lifted({
    required bool Function(DateTime) selected,
    required void Function(DateTime) select,
    Predicate<DateTime> selectable = _defaultSelectable,
  }) => Lifted(selected: selected, select: select, selectable: selectable);

  /// Managed control for single date selection.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// [toggleable] determines whether the controller should unselect a date if it is already selected. Defaults to true.
  ///
  /// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
  /// dates in UTC timezone. Defaults to true.
  ///
  /// [onChange] is called when the selected date changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * both [controller] and [initial] are provided.
  /// * both [controller] and [selectable] are provided.
  /// * both [controller] and [toggleable] are provided.
  /// * both [controller] and [truncateAndStripTimezone] are provided.
  static FCalendarControl<DateTime?> managedDate({
    FCalendarController<DateTime?>? controller,
    DateTime? initial,
    Predicate<DateTime>? selectable,
    bool toggleable = true,
    bool truncateAndStripTimezone = true,
    ValueChanged<DateTime?>? onChange,
  }) => _Date(
    controller: controller,
    initial: initial,
    selectable: selectable,
    toggleable: toggleable,
    truncateAndStripTimezone: truncateAndStripTimezone,
    onChange: onChange,
  );

  /// Managed control for multiple dates selection.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
  /// dates in UTC timezone. Defaults to true.
  ///
  /// [onChange] is called when the selected dates change.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * both [controller] and [initial] are provided.
  /// * both [controller] and [selectable] are provided.
  /// * both [controller] and [truncateAndStripTimezone] are provided.
  static FCalendarControl<Set<DateTime>> managedDates({
    FCalendarController<Set<DateTime>>? controller,
    Set<DateTime>? initial,
    Predicate<DateTime>? selectable,
    bool truncateAndStripTimezone = true,
    ValueChanged<Set<DateTime>>? onChange,
  }) => _Dates(
    controller: controller,
    initial: initial,
    selectable: selectable,
    truncateAndStripTimezone: truncateAndStripTimezone,
    onChange: onChange,
  );

  /// Managed control for range selection.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
  /// dates in UTC timezone. Defaults to true.
  ///
  /// Both the start and end dates of the range are inclusive. Unselectable dates within the selected range are selected
  /// regardless.
  ///
  /// [onChange] is called when the selected range changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * both [controller] and [initial] are provided.
  /// * both [controller] and [selectable] are provided.
  /// * both [controller] and [truncateAndStripTimezone] are provided.
  static FCalendarControl<(DateTime, DateTime)?> managedRange({
    FCalendarController<(DateTime, DateTime)?>? controller,
    (DateTime, DateTime)? initial,
    Predicate<DateTime>? selectable,
    bool truncateAndStripTimezone = true,
    ValueChanged<(DateTime, DateTime)?>? onChange,
  }) => _Range(
    controller: controller,
    initial: initial,
    selectable: selectable,
    truncateAndStripTimezone: truncateAndStripTimezone,
    onChange: onChange,
  );

  const FCalendarControl._();

  (FCalendarController<T>, bool) _update(
    FCalendarControl<T> old,
    FCalendarController<T> controller,
    VoidCallback callback,
  );
}

@internal
class Lifted extends FCalendarControl<Object?> with _$LiftedMixin<Object?> {
  @override
  final Predicate<DateTime> selectable;
  @override
  final bool Function(DateTime) selected;
  @override
  final void Function(DateTime) select;

  const Lifted({required this.selectable, required this.selected, required this.select}) : super._();

  @override
  FCalendarController<Object?> _create() =>
      _Controller(selectable: selectable, selected: selected, select: select);

  @override
  void _updateController(FCalendarController<Object?> controller) =>
      (controller as _Controller).update(selectable: selectable, selected: selected, select: select);
}

@internal
abstract class Managed<T> extends FCalendarControl<T> with _$ManagedMixin<T> {
  @override
  final FCalendarController<T>? controller;
  @override
  final T? initial;
  @override
  final Predicate<DateTime>? selectable;
  @override
  final bool truncateAndStripTimezone;
  @override
  final ValueChanged<T>? onChange;

  const Managed({this.controller, this.initial, this.selectable, this.truncateAndStripTimezone = true, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both controller and initial.'),
      assert(controller == null || selectable == null, 'Cannot provide both controller and selectable.'),
      assert(
        controller == null || truncateAndStripTimezone,
        'Cannot provide both controller and truncateAndStripTimezone.',
      ),
      super._();

  /// Calls [onChange] with the controller's value.
  void handleOnChange(FCalendarController<Object?> controller) => onChange?.call(controller.value as T);
}

class _Date extends Managed<DateTime?> with _$_DateMixin {
  @override
  final bool toggleable;

  const _Date({
    this.toggleable = true,
    super.controller,
    super.initial,
    super.selectable,
    super.truncateAndStripTimezone,
    super.onChange,
  }) : assert(controller == null || toggleable, 'Cannot provide both controller and toggleable.');

  @override
  FCalendarController<DateTime?> _create() =>
      controller ??
      .date(
        initialSelection: initial,
        selectable: selectable,
        toggleable: toggleable,
        truncateAndStripTimezone: truncateAndStripTimezone,
      );
}

class _Dates extends Managed<Set<DateTime>> with _$_DatesMixin {
  const _Dates({super.controller, super.initial, super.selectable, super.truncateAndStripTimezone, super.onChange});

  @override
  FCalendarController<Set<DateTime>> _create() =>
      controller ??
      .dates(
        initialSelections: initial ?? {},
        selectable: selectable,
        truncateAndStripTimezone: truncateAndStripTimezone,
      );
}

class _Range extends Managed<(DateTime, DateTime)?> with _$_RangeMixin {
  const _Range({super.controller, super.initial, super.selectable, super.truncateAndStripTimezone, super.onChange});

  @override
  FCalendarController<(DateTime, DateTime)?> _create() =>
      controller ??
      .range(
        initialSelection: initial,
        selectable: selectable,
        truncateAndStripTimezone: truncateAndStripTimezone,
      );
}

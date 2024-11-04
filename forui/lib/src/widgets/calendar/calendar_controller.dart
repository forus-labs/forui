import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

bool _true(DateTime _) => true;

/// A controller that controls date selection in a calendar.
///
/// The [DateTime]s are always in UTC timezone and truncated to the nearest day.
///
/// This class should be extended to customize date selection. By default, the following controllers are provided:
/// * [FCalendarController.date] for selecting a single date.
/// * [FCalendarController.dates] for selecting multiple date.
/// * [FCalendarController.range] for selecting a single range.
abstract class FCalendarController<T> extends FValueNotifier<T> {
  /// Creates a [FCalendarController] that allows only a single date to be selected, with the given initially selected
  /// date.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initialSelection] is not in UTC timezone.
  static FCalendarController<DateTime?> date({
    DateTime? initialSelection,
    Predicate<DateTime>? selectable,
  }) =>
      _DateController(initialSelection: initialSelection, selectable: selectable);

  /// Creates a [FCalendarController] that allows multiple dates to be selected, with the given initial selected dates.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the dates in [initialSelections] are not in UTC timezone.
  static FCalendarController<Set<DateTime>> dates({
    Set<DateTime> initialSelections = const {},
    Predicate<DateTime>? selectable,
  }) =>
      _DatesController(initialSelections: initialSelections, selectable: selectable);

  /// Creates a [FCalendarController] that allows a single range to be selected, with the given initial range.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// Both the start and end dates of the range is inclusive. The selected dates are always in UTC timezone and
  /// truncated to the nearest day. Unselectable dates within the selected range are selected regardless.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * the given dates in [value] is not in UTC timezone.
  /// * the end date is less than start date.
  static FCalendarController<(DateTime, DateTime)?> range({
    (DateTime, DateTime)? initialSelection,
    Predicate<DateTime>? selectable,
  }) =>
      _RangeController(initialSelection: initialSelection, selectable: selectable);

  /// Creates a [FCalendarController] with the given initial [value].
  FCalendarController(super._value);

  /// Returns true if the given [date] can be selected/unselected.
  ///
  /// [date] should always in UTC timezone and truncated to the nearest day.
  ///
  /// ## Note
  /// It is unsafe for this function to have side effects since it may be called more than once for a single date. As it
  /// is called frequently, it should not be computationally expensive.
  bool selectable(DateTime date);

  /// Returns true if the given [date] is selected.
  ///
  /// [date] should always in UTC timezone and truncated to the nearest day.
  bool selected(DateTime date);

  /// Selects the given [date].
  ///
  /// [date] should always in UTC timezone and truncated to the nearest day.
  void select(DateTime date);
}

class _DateController extends FCalendarController<DateTime?> {
  final Predicate<DateTime> _selectable;

  _DateController({
    DateTime? initialSelection,
    Predicate<DateTime>? selectable,
  })  : assert(initialSelection?.isUtc ?? true, 'value must be in UTC timezone'),
        _selectable = selectable ?? _true,
        super(initialSelection);

  @override
  bool selectable(DateTime date) => _selectable(date);

  @override
  bool selected(DateTime date) => value?.toLocalDate() == date.toLocalDate();

  @override
  void select(DateTime date) {
    value = value?.toLocalDate() == date.toLocalDate() ? null : date;
  }
}

final class _DatesController extends FCalendarController<Set<DateTime>> {
  final Predicate<DateTime> _selectable;

  _DatesController({
    Set<DateTime> initialSelections = const {},
    Predicate<DateTime>? selectable,
  })  : assert(initialSelections.every((d) => d.isUtc), 'dates must be in UTC timezone'),
        _selectable = selectable ?? _true,
        super(initialSelections);

  @override
  bool selectable(DateTime date) => _selectable(date);

  @override
  bool selected(DateTime date) => value.contains(date);

  @override
  void select(DateTime date) {
    final copy = {...value};
    value = copy..toggle(date);
  }
}

final class _RangeController extends FCalendarController<(DateTime, DateTime)?> {
  final Predicate<DateTime> _selectable;

  _RangeController({
    (DateTime, DateTime)? initialSelection,
    Predicate<DateTime>? selectable,
  })  : assert(
          initialSelection == null || (initialSelection.$1.isUtc && initialSelection.$2.isUtc),
          'value must be in UTC timezone',
        ),
        assert(
          initialSelection == null ||
              (initialSelection.$1.isBefore(initialSelection.$2) ||
                  initialSelection.$1.isAtSameMomentAs(initialSelection.$2)),
          'end date must be greater than or equal to start date',
        ),
        _selectable = selectable ?? _true,
        super(initialSelection);

  @override
  bool selectable(DateTime date) => _selectable(date);

  @override
  bool selected(DateTime date) {
    if (value case (final first, final last)) {
      final current = date.toLocalDate();
      return first.toLocalDate() <= current && current <= last.toLocalDate();
    }

    return false;
  }

  @override
  void select(DateTime date) {
    if (value == null) {
      value = (date, date);
      return;
    }

    final (first, last) = value!;
    final pressed = date.toLocalDate();

    switch ((first.toLocalDate(), last.toLocalDate())) {
      case (final first, final last) when pressed == first || pressed == last:
        value = null;

      case (final first, final last) when pressed < first:
        value = (pressed.toNative(), last.toNative());

      case (final first, _):
        value = (first.toNative(), pressed.toNative());
    }
  }
}

import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

bool _true(DateTime _) => true;

DateTime _truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);

/// A controller that controls date selection in a calendar.
///
/// All returned [DateTime]s are in UTC timezone with no time component. It is possible to set the controller's value
/// to a unselectable date. Doing so will result in undefined behavior.
///
/// This class should be extended to customize date selection. By default, the following controllers are provided:
/// * [FCalendarController.date] for selecting a single date.
/// * [FCalendarController.dates] for selecting multiple dates.
/// * [FCalendarController.range] for selecting a single range.
abstract class FCalendarController<T> extends FValueNotifier<T> {
  /// Creates a [FCalendarController] that allows only a single date to be selected, with the given initially selected
  /// date.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
  /// dates in UTC timezone. Defaults to true.
  ///
  /// ```dart
  /// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
  /// ```
  ///
  /// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
  /// the help of a 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
  /// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initialSelection] is not in UTC timezone and [truncateAndStripTimezone] is false.
  static FCalendarController<DateTime?> date({
    DateTime? initialSelection,
    Predicate<DateTime>? selectable,
    bool truncateAndStripTimezone = true,
  }) =>
      truncateAndStripTimezone
          ? _AutoDateController(initialSelection: initialSelection, selectable: selectable)
          : _DateController(initialSelection: initialSelection, selectable: selectable);

  /// Creates a [FCalendarController] that allows multiple dates to be selected, with the given initial selected dates.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
  /// dates in UTC timezone. Defaults to true.
  ///
  /// ```dart
  /// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
  /// ```
  ///
  /// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
  /// the help of a 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
  /// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the dates in [initialSelections] are not in UTC timezone and [truncateAndStripTimezone]
  /// is false.
  static FCalendarController<Set<DateTime>> dates({
    Set<DateTime> initialSelections = const {},
    Predicate<DateTime>? selectable,
    bool truncateAndStripTimezone = true,
  }) =>
      truncateAndStripTimezone
          ? _AutoDatesController(initialSelections: initialSelections, selectable: selectable)
          : _DatesController(initialSelections: initialSelections, selectable: selectable);

  /// Creates a [FCalendarController] that allows a single range to be selected, with the given initial range.
  ///
  /// [selectable] will always return true if not given.
  ///
  /// [truncateAndStripTimezone] determines whether the controller should truncate and convert all given [DateTime]s to
  /// dates in UTC timezone. Defaults to true.
  ///
  /// ```dart
  /// DateTime truncateAndStripTimezone(DateTime date) => DateTime.utc(date.year, date.month, date.day);
  /// ```
  ///
  /// [truncateAndStripTimezone] should be set to false if you can guarantee that all dates are in UTC timezone (with
  /// the help of a 3rd party library), which will improve performance. **Warning:** Giving a [DateTime] in local
  /// timezone or with a time component when [truncateAndStripTimezone] is false is undefined behavior.
  ///
  /// Both the start and end dates of the range are inclusive. Unselectable dates within the selected range are selected
  /// regardless.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * the given dates in [initialSelection] are not in UTC timezone and [truncateAndStripTimezone] is false.
  /// * the end date is less than start date.
  static FCalendarController<(DateTime, DateTime)?> range({
    (DateTime, DateTime)? initialSelection,
    Predicate<DateTime>? selectable,
    bool truncateAndStripTimezone = true,
  }) =>
      truncateAndStripTimezone
          ? _AutoRangeController(initialSelection: initialSelection, selectable: selectable)
          : _RangeController(initialSelection: initialSelection, selectable: selectable);

  /// Creates a [FCalendarController] with the given initial [value].
  FCalendarController(super._value);

  /// Returns true if the given [date] can be selected/unselected.
  ///
  /// ## Note
  /// It is unsafe for this function to have side effects since it may be called more than once for a single date. As it
  /// is called frequently, it should also not be computationally expensive.
  bool selectable(DateTime date);

  /// Returns true if the given [date] is selected.
  bool selected(DateTime date);

  /// Selects the given [date].
  void select(DateTime date);
}

// The single date controllers.
class _AutoDateController extends FCalendarController<DateTime?> {
  final Predicate<DateTime> _selectable;

  _AutoDateController({DateTime? initialSelection, Predicate<DateTime>? selectable})
    : _selectable = selectable ?? _true,
      super(initialSelection = initialSelection == null ? null : _truncateAndStripTimezone(initialSelection));

  @override
  bool selectable(DateTime date) => _selectable(_truncateAndStripTimezone(date));

  @override
  bool selected(DateTime date) => value == _truncateAndStripTimezone(date);

  @override
  void select(DateTime date) {
    date = _truncateAndStripTimezone(date);
    super.value = value == date ? null : date;
  }

  @override
  set value(DateTime? value) => super.value = value == null ? null : _truncateAndStripTimezone(value);
}

class _DateController extends FCalendarController<DateTime?> {
  final Predicate<DateTime> _selectable;

  _DateController({DateTime? initialSelection, Predicate<DateTime>? selectable})
    : assert(initialSelection?.isUtc ?? true, 'value must be in UTC timezone'),
      _selectable = selectable ?? _true,
      super(initialSelection);

  @override
  bool selectable(DateTime date) => _selectable(date);

  @override
  bool selected(DateTime date) => value == date;

  @override
  void select(DateTime date) => value = value == date ? null : date;
}

// The multiple dates controllers.
final class _AutoDatesController extends FCalendarController<Set<DateTime>> {
  final Predicate<DateTime> _selectable;

  _AutoDatesController({Set<DateTime> initialSelections = const {}, Predicate<DateTime>? selectable})
    : _selectable = selectable ?? _true,
      super(initialSelections.map(_truncateAndStripTimezone).toSet());

  @override
  bool selectable(DateTime date) => _selectable(_truncateAndStripTimezone(date));

  @override
  bool selected(DateTime date) => value.contains(_truncateAndStripTimezone(date));

  @override
  void select(DateTime date) {
    final copy = {...value};
    super.value = copy..toggle(_truncateAndStripTimezone(date));
  }

  @override
  set value(Set<DateTime> value) => super.value = value.map(_truncateAndStripTimezone).toSet();
}

final class _DatesController extends FCalendarController<Set<DateTime>> {
  final Predicate<DateTime> _selectable;

  _DatesController({Set<DateTime> initialSelections = const {}, Predicate<DateTime>? selectable})
    : assert(initialSelections.every((d) => d.isUtc), 'dates must be in UTC timezone'),
      _selectable = selectable ?? _true,
      super(initialSelections);

  @override
  bool selectable(DateTime date) => _selectable(date);

  @override
  bool selected(DateTime date) => value.contains(date);

  @override
  void select(DateTime date) => value = value..toggle(date);
}

// The range controllers.
final class _AutoRangeController extends FCalendarController<(DateTime, DateTime)?> {
  final Predicate<DateTime> _selectable;

  _AutoRangeController({(DateTime, DateTime)? initialSelection, Predicate<DateTime>? selectable})
    : _selectable = selectable ?? _true,
      super(
        initialSelection =
            initialSelection == null
                ? null
                : (_truncateAndStripTimezone(initialSelection.$1), _truncateAndStripTimezone(initialSelection.$2)),
      ) {
    final range = value;
    assert(
      range == null || (range.$1.isBefore(range.$2) || range.$1.isAtSameMomentAs(range.$2)),
      'end date must be greater than or equal to start date',
    );
  }

  @override
  bool selectable(DateTime date) => _selectable(_truncateAndStripTimezone(date));

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
    date = _truncateAndStripTimezone(date);
    switch (value) {
      case null:
        super.value = (date, date);

      case (final first, final last) when date == first || date == last:
        super.value = null;

      case (final first, final last) when date.isBefore(first):
        super.value = (date, last);

      case (final first, _):
        super.value = (first, date);
    }
  }

  @override
  set value((DateTime, DateTime)? value) =>
      super.value = value == null ? null : (_truncateAndStripTimezone(value.$1), _truncateAndStripTimezone(value.$2));
}

final class _RangeController extends FCalendarController<(DateTime, DateTime)?> {
  final Predicate<DateTime> _selectable;

  _RangeController({(DateTime, DateTime)? initialSelection, Predicate<DateTime>? selectable})
    : assert(
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
    switch (value) {
      case null:
        super.value = (date, date);

      case (final first, final last) when date == first || date == last:
        super.value = null;

      case (final first, final last) when date.isBefore(first):
        super.value = (date, last);

      case (final first, _):
        super.value = (first, date);
    }
  }
}

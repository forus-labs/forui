import 'package:flutter/widgets.dart';
import 'package:sugar/sugar.dart';

final _default = (DateTime(1900).toUtc(), null);

bool _true(DateTime _) => true;

/// A controller for the FLineCalendar widget.
class FLineCalendarController extends ValueNotifier<DateTime> {
  /// The [_calendarRange] parameter defines the range of dates that can be displayed in the calendar.
  /// Both the start and end dates of the range is inclusive. The selected dates are always in UTC timezone and
  /// truncated to the nearest day.
  final (DateTime, DateTime?) _calendarRange;
  final DateTime _today;
  final Predicate<DateTime> _selectable;

  /// The scroll controller.
  final ScrollController scrollController;

  /// Creates a [FLineCalendarController].
  ///
  /// [selectable] will always return true if not given.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * if [initialSelection] is not in UTC timezone.
  /// * the dates in [calendarRange] are not in UTC timezone.
  /// * the end date is less than start date.
  FLineCalendarController({
    (DateTime start, DateTime? end)? calendarRange,
    DateTime? today,
    Predicate<DateTime>? selectable,
    DateTime? initialSelection,
    ScrollController? scrollController,
  })  : assert(initialSelection?.isUtc ?? true, 'value must be in UTC timezone'),
        assert(
          calendarRange == null || (calendarRange.$1.isUtc && (calendarRange.$2?.isUtc ?? true)),
          'value must be in UTC timezone',
        ),
        assert(
          calendarRange == null ||
              calendarRange.$2 == null ||
              calendarRange.$1.isBefore(calendarRange.$2!) ||
              calendarRange.$1.isAtSameMomentAs(calendarRange.$2!),
          'end date must be greater than or equal to start date',
        ),
        _calendarRange = calendarRange ?? _default,
        _today = today ?? DateTime.now(),
        _selectable = selectable ?? _true,
        scrollController = scrollController ?? ScrollController(),
        super(initialSelection ?? DateTime.now().toUtc());

  /// Returns a new instance of [FLineCalendarController] with the same properties,
  /// but with its [ScrollController] initialized to a specific scroll offset.
  ///
  /// The [size], [itemPadding], and [position] parameters are used to calculate
  /// the initial scroll offset for the [ScrollController].
  ///
  /// * [size]: The size of each calendar item.
  /// * [itemPadding]: The padding between calendar items.
  /// * [position]: The position of the selected date within the visible items.
  ///
  /// This method is useful for creating a controller that starts with a specific
  /// scroll position, typically to ensure the selected date is visible.
  FLineCalendarController withInitialScrollOffset(
    double size,
    double itemPadding, {
    int position = 3,
  }) =>
      FLineCalendarController(
        calendarRange: (start, end),
        today: _today,
        selectable: _selectable,
        initialSelection: value,
        scrollController: ScrollController(
          initialScrollOffset: _selectedDateOffset(size, itemPadding, position),
          debugLabel: scrollController.debugLabel,
          keepScrollOffset: scrollController.keepScrollOffset,
          onAttach: scrollController.onAttach,
          onDetach: scrollController.onDetach,
        ),
      );

  /// Returns true if the given [date] can be selected/unselected.
  ///
  /// [date] should always in UTC timezone and truncated to the nearest day.
  ///
  /// ## Note
  /// It is unsafe for this function to have side effects since it may be called more than once for a single date. As it
  /// is called frequently, it should not be computationally expensive.
  bool selectable(DateTime date) => _selectable(date);

  /// Returns true if the given [date] is selected.
  ///
  /// [date] should always in UTC timezone and truncated to the nearest day.
  bool selected(DateTime date) => value.toLocalDate() == date.toLocalDate();

  /// Selects the given [date].
  ///
  /// [date] should always in UTC timezone and truncated to the nearest day.
  void select(DateTime date) {
    if (value.toLocalDate() == date.toLocalDate()) {
      return;
    }
    value = date;
  }

  double _selectedDateOffset(double size, double itemPadding, int position) =>
      (value.toLocalDate().difference(start.toLocalDate()).inDays - (position - 1)) * size + itemPadding;

  /// Returns `true` if the given date is today.
  bool isToday(DateTime date) => date.toLocalDate() == _today.toLocalDate();

  /// The first date in this calendar carousel. Defaults to 1st January 1900.
  DateTime get start => _calendarRange.$1;

  /// The final date in this calendar carousel.
  DateTime? get end => _calendarRange.$2;

  /// Returns the current date. It is truncated to the nearest date. Defaults to the [DateTime.now]
  DateTime get today => _today;
}

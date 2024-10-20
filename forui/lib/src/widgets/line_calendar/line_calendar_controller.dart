import 'package:flutter/cupertino.dart';
import 'package:sugar/sugar.dart';

final _default = (DateTime(1900), null);

bool _true(DateTime _) => true;

class FLineCalendarController extends ValueNotifier<DateTime> {
  final (DateTime, DateTime?) _calendarRange;

  final DateTime _today;
  final Predicate<DateTime> _selectable;

  FLineCalendarController({
    (DateTime start, DateTime? end)? calendarRange,
    DateTime? today,
    Predicate<DateTime>? selectable,
    DateTime? initialSelection,
  })  : assert(
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
        super(initialSelection ?? DateTime.now());

  bool selectable(DateTime date) => _selectable(date);

  bool selected(DateTime date) => value.toLocalDate() == date.toLocalDate();

  void select(DateTime date) {
    if (value.toLocalDate() == date.toLocalDate()) {
      return;
    }
    value = date;
  }

  /// Returns `true` if the given date is today.
  bool isToday(DateTime date) => date.toLocalDate() == _today.toLocalDate();

  /// The first date in this calendar carousel. Defaults to 1st January 1900.
  DateTime get start => _calendarRange.$1;

  DateTime? get end => _calendarRange.$2;

  /// Returns today's date. Defaults to the [LocalDate.now].
  DateTime get today => _today;
}

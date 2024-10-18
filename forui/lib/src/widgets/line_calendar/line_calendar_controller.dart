import 'package:flutter/cupertino.dart';
import 'package:sugar/sugar.dart';

final _default = (DateTime(1900), null);

class FLineCalendarController extends ValueNotifier<DateTime?> {
  final (DateTime, DateTime?) _calendarRange;
  final DateTime _today;

  FLineCalendarController({
    (DateTime start, DateTime? end)? calendarRange,
    DateTime? today,
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
        super(initialSelection ?? DateTime.now());

  bool selected(DateTime date) => value?.toLocalDate() == date.toLocalDate();

  void select(DateTime date) => value = value?.toLocalDate() == date.toLocalDate() ? null : date;

  DateTime get start => _calendarRange.$1;
  DateTime? get end => _calendarRange.$2;
  DateTime get today => _today;
}

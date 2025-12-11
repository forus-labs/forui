import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:sugar/sugar.dart';

import 'package:forui_samples/sample.dart';

DateTime get selected {
  final today = DateTime.now().toLocalDate();
  final before = today.minus(days: 2);
  if (before == today) {
    return before.toNative();
  } else {
    return today.plus(days: 2).toNative();
  }
}

@RoutePage()
class CalendarPage extends Sample {
  CalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FCalendar(control: .managedDate(), start: DateTime(2000), end: DateTime(2030));
}

@RoutePage()
class DatesCalendarPage extends Sample {
  DatesCalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FCalendar(
    control: .managedDates(initial: {DateTime(2024, 7, 17), DateTime(2024, 7, 20)}),
    start: DateTime(2000),
    today: DateTime(2024, 7, 15),
    end: DateTime(2030),
  );
}

@RoutePage()
class UnselectableCalendarPage extends Sample {
  UnselectableCalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FCalendar(
    control: .managedDates(
      initial: {DateTime(2024, 7, 17), DateTime(2024, 7, 20)},
      selectable: (date) => !{DateTime.utc(2024, 7, 18), DateTime.utc(2024, 7, 19)}.contains(date),
    ),
    start: DateTime(2000),
    today: DateTime(2024, 7, 15),
    end: DateTime(2030),
  );
}

@RoutePage()
class RangeCalendarPage extends Sample {
  RangeCalendarPage({@queryParam super.theme});

  @override
  Widget sample(BuildContext context) => FCalendar(
    control: .managedRange(initial: (DateTime(2024, 7, 17), DateTime(2024, 7, 20))),
    start: DateTime(2000),
    today: DateTime(2024, 7, 15),
    end: DateTime(2030),
  );
}

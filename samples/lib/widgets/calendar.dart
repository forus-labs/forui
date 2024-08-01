import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';
import 'package:sugar/sugar.dart';

import 'package:forui_samples/sample_scaffold.dart';

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
class CalendarPage extends SampleScaffold {
  CalendarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FCalendar(
        controller: FCalendarController.date(initialSelection: selected),
        start: DateTime.utc(2000),
        end: DateTime.utc(2030),
      );
}

@RoutePage()
class DatesCalendarPage extends SampleScaffold {
  DatesCalendarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FCalendar(
        controller: FCalendarController.dates(
          initialSelections: {DateTime.utc(2024, 7, 17), DateTime.utc(2024, 7, 20)},
        ),
        start: DateTime.utc(2000),
        today: DateTime.utc(2024, 7, 15),
        end: DateTime.utc(2030),
      );
}

@RoutePage()
class UnselectableCalendarPage extends SampleScaffold {
  UnselectableCalendarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FCalendar(
        controller: FCalendarController.dates(
          initialSelections: {DateTime.utc(2024, 7, 17), DateTime.utc(2024, 7, 20)},
          selectable: (date) => !{DateTime.utc(2024, 7, 18), DateTime.utc(2024, 7, 19)}.contains(date),
        ),
        start: DateTime.utc(2000),
        today: DateTime.utc(2024, 7, 15),
        end: DateTime.utc(2030),
      );
}

@RoutePage()
class RangeCalendarPage extends SampleScaffold {
  RangeCalendarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FCalendar(
        controller: FCalendarController.range(
          initialSelection: (DateTime.utc(2024, 7, 17), DateTime.utc(2024, 7, 20)),
        ),
        start: DateTime.utc(2000),
        today: DateTime.utc(2024, 7, 15),
        end: DateTime.utc(2030),
      );
}

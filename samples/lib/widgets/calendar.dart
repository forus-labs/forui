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
        controller: FCalendarSingleValueController(selected),
        start: DateTime.utc(2000),
        end: DateTime.utc(2030),
      );
}

@RoutePage()
class MultiValueCalendarPage extends SampleScaffold {
  MultiValueCalendarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FCalendar(
        controller: FCalendarMultiValueController({selected}),
        start: DateTime.utc(2000),
        end: DateTime.utc(2030),
      );
}

@RoutePage()
class SingleRangeCalendarPage extends SampleScaffold {
  SingleRangeCalendarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FCalendar(
        controller: FCalendarSingleRangeController((selected, selected)),
        start: DateTime.utc(2000),
        end: DateTime.utc(2030),
      );
}

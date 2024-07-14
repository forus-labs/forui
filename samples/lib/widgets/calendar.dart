import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:forui/forui.dart';

import 'package:forui_samples/sample_scaffold.dart';

@RoutePage()
class CalendarPage extends SampleScaffold {
  CalendarPage({
    @queryParam super.theme,
  });

  @override
  Widget child(BuildContext context) => FCalendar(
        controller: FCalendarSingleValueController(),
        start: DateTime.utc(2024),
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
        controller: FCalendarMultiValueController(),
        start: DateTime.utc(2024),
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
        controller: FCalendarSingleRangeController(),
        start: DateTime.utc(2024),
        end: DateTime.utc(2030),
      );
}

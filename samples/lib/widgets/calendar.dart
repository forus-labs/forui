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
class CalendarPage extends StatefulSample {
  CalendarPage({@queryParam super.theme});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends StatefulSampleState<CalendarPage> {
  final _controller = FCalendarController.date(initialSelection: selected);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) => FCalendar(controller: _controller, start: DateTime(2000), end: DateTime(2030));
}

@RoutePage()
class DatesCalendarPage extends StatefulSample {
  DatesCalendarPage({@queryParam super.theme});

  @override
  State<DatesCalendarPage> createState() => _DatesCalendarPageState();
}

class _DatesCalendarPageState extends StatefulSampleState<DatesCalendarPage> {
  final _controller = FCalendarController.dates(initialSelections: {DateTime(2024, 7, 17), DateTime(2024, 7, 20)});

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) =>
      FCalendar(controller: _controller, start: DateTime(2000), today: DateTime(2024, 7, 15), end: DateTime(2030));
}

@RoutePage()
class UnselectableCalendarPage extends StatefulSample {
  UnselectableCalendarPage({@queryParam super.theme});

  @override
  State<UnselectableCalendarPage> createState() => _UnselectableCalendarPageState();
}

class _UnselectableCalendarPageState extends StatefulSampleState<UnselectableCalendarPage> {
  final _controller = FCalendarController.dates(
    initialSelections: {DateTime(2024, 7, 17), DateTime(2024, 7, 20)},
    selectable: (date) => !{DateTime(2024, 7, 18), DateTime(2024, 7, 19)}.contains(date),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) =>
      FCalendar(controller: _controller, start: DateTime(2000), today: DateTime(2024, 7, 15), end: DateTime(2030));
}

@RoutePage()
class RangeCalendarPage extends StatefulSample {
  RangeCalendarPage({@queryParam super.theme});

  @override
  State<RangeCalendarPage> createState() => _RangeCalendarPageState();
}

class _RangeCalendarPageState extends StatefulSampleState<RangeCalendarPage> {
  final _controller = FCalendarController.range(initialSelection: (DateTime(2024, 7, 17), DateTime(2024, 7, 20)));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget sample(BuildContext context) =>
      FCalendar(controller: _controller, start: DateTime(2000), today: DateTime(2024, 7, 15), end: DateTime(2030));
}

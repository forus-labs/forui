import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui_hooks/forui_hooks.dart';

void main() {
  testWidgets('useFDateCalendarController', (tester) async {
    late FCalendarController<DateTime?> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFDateCalendarController();
          return FCalendar(controller: controller, start: DateTime.utc(1900), end: DateTime.utc(2100));
        }),
      ),
    );

    controller.value = DateTime.utc(2000);

    await tester.pumpAndSettle();
  });

  testWidgets('useFDatesCalendarController', (tester) async {
    late FCalendarController<Set<DateTime>> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFDatesCalendarController();
          return FCalendar(controller: controller, start: DateTime.utc(1900), end: DateTime.utc(2100));
        }),
      ),
    );

    controller.value = { DateTime.utc(2000) };

    await tester.pumpAndSettle();
  });

  testWidgets('useFRangeCalendarController', (tester) async {
    late FCalendarController<(DateTime, DateTime)?> controller;

    await tester.pumpWidget(
      MaterialApp(
        home: HookBuilder(builder: (context) {
          controller = useFRangeCalendarController();
          return FCalendar(controller: controller, start: DateTime.utc(1900), end: DateTime.utc(2100));
        }),
      ),
    );

    controller.value = (DateTime.utc(2000), DateTime.utc(2000, 1, 2));

    await tester.pumpAndSettle();
  });
}

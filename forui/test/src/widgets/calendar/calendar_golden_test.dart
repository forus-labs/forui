@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  final selected = {
    DateTime.utc(2024, 7, 4),
    DateTime.utc(2024, 7, 5),
    DateTime.utc(2024, 7, 16),
    DateTime.utc(2024, 7, 17),
    DateTime.utc(2024, 7, 18),
  };

  group('FCalendar', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      group('day picker', () {
        testWidgets('default - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarMultiValueController(selected),
                  enabled: (date) => date != DateTime.utc(2024, 7, 2),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 7, 10),
                  today: DateTime(2024, 7, 14),
                ),
              ),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('8')));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/day-picker/$name-default.png'),
          );
        });

        testWidgets('max rows - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarMultiValueController(selected),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 7, 10),
                  today: DateTime(2024, 6, 14),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/day-picker/$name-max-rows.png'),
          );
        });
      });

      group('month picker', () {
        testWidgets('default - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarMultiValueController(selected),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 7, 10),
                  today: DateTime(2024, 7, 14),
                  initialType: FCalendarPickerType.yearMonth,
                ),
              ),
            ),
          );

          await tester.tap(find.text('2020'));
          await tester.pumpAndSettle();

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('Feb')));
          await tester.pumpAndSettle();


          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/month-picker/$name-default.png'),
          );
        });
      });

      group('year picker', () {
        testWidgets('default - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarMultiValueController(selected),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 7, 10),
                  today: DateTime(2024, 7, 14),
                  initialType: FCalendarPickerType.yearMonth,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/year-picker/$name-default.png'),
          );
        });

        testWidgets('initial date different from today - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarMultiValueController(selected),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 7, 10),
                  today: DateTime(2024, 7, 14),
                  initialDate: DateTime(1984, 4, 2),
                  initialType: FCalendarPickerType.yearMonth,
                ),
              ),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('1991')));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/year-picker/$name-initial-date.png'),
          );
        });
      });
    }
  });
}

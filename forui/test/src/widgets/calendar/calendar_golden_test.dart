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
    group('blue screen', () {
      testWidgets('day picker', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FCalendar(
                style: TestScaffold.blueScreen.calendarStyle,
                controller: FCalendarController.dates(
                  initialSelections: selected,
                  selectable: (date) => date != DateTime.utc(2024, 7, 2),
                ),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('year picker', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FCalendar(
                style: TestScaffold.blueScreen.calendarStyle,
                initialType: FCalendarPickerType.yearMonth,
                controller: FCalendarController.dates(
                  initialSelections: selected,
                  selectable: (date) => date != DateTime.utc(2024, 7, 2),
                ),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      group('day picker', () {
        testWidgets('default - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarController.dates(
                    initialSelections: selected,
                    selectable: (date) => date != DateTime.utc(2024, 7, 2),
                  ),
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
            matchesGoldenFile('calendar/$name/day-picker/default.png'),
          );
        });

        testWidgets('max rows - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarController.dates(initialSelections: selected),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 7, 10),
                  today: DateTime(2024, 6, 14),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/$name/day-picker/max-rows.png'),
          );
        });

        testWidgets('hovered and selected dates next to each other - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarController.dates(),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 8, 10),
                  today: DateTime(2024, 7, 14),
                ),
              ),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('12')));
          await tester.pumpAndSettle();

          await tester.tap(find.text('13'));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/$name/day-picker/hovered-selected.png'),
          );
        });

        testWidgets('disabled previous icon - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarController.dates(
                    initialSelections: {DateTime.utc(2024, 7, 13)},
                  ),
                  start: DateTime(2024, 7),
                  end: DateTime(2024, 8, 10),
                  today: DateTime(2024, 7, 14),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/$name/day-picker/disabled-previous.png'),
          );
        });
      });

      group('month picker', () {
        testWidgets('default - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarController.dates(initialSelections: selected),
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
            matchesGoldenFile('calendar/$name/month-picker/default.png'),
          );
        });
      });

      group('year picker', () {
        testWidgets('default - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarController.dates(initialSelections: selected),
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
            matchesGoldenFile('calendar/$name/year-picker/default.png'),
          );
        });

        testWidgets('initial date different from today - $name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FCalendar(
                  controller: FCalendarController.dates(initialSelections: selected),
                  start: DateTime(1900, 1, 8),
                  end: DateTime(2024, 7, 10),
                  today: DateTime(2024, 7, 14),
                  initialMonth: DateTime(1984, 4, 2),
                  initialType: FCalendarPickerType.yearMonth,
                ),
              ),
            ),
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('1989')));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/$name/year-picker/initial-date.png'),
          );
        });
      });
    }
  });
}

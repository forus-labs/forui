@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

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
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('year picker', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
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
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final theme in TestScaffold.themes) {
      group('day picker', () {
        testWidgets('default - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
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
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('8')));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/${theme.name}/day-picker/default.png'),
          );
        });

        testWidgets('max rows - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                controller: FCalendarController.dates(initialSelections: selected),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 6, 14),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/${theme.name}/day-picker/max-rows.png'),
          );
        });

        testWidgets('hovered and selected dates next to each other - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                controller: FCalendarController.dates(),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 8, 10),
                today: DateTime(2024, 7, 14),
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
            matchesGoldenFile('calendar/${theme.name}/day-picker/hovered-selected.png'),
          );
        });

        testWidgets('disabled previous icon - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                controller: FCalendarController.dates(
                  initialSelections: {DateTime.utc(2024, 7, 13)},
                ),
                start: DateTime(2024, 7),
                end: DateTime(2024, 8, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/${theme.name}/day-picker/disabled-previous.png'),
          );
        });
      });

      group('month picker', () {
        testWidgets('default - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                controller: FCalendarController.dates(initialSelections: selected),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
                initialType: FCalendarPickerType.yearMonth,
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
            matchesGoldenFile('calendar/${theme.name}/month-picker/default.png'),
          );
        });
      });

      group('year picker', () {
        testWidgets('default - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                controller: FCalendarController.dates(initialSelections: selected),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
                initialType: FCalendarPickerType.yearMonth,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/${theme.name}/year-picker/default.png'),
          );
        });

        testWidgets('initial date different from today - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                controller: FCalendarController.dates(initialSelections: selected),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
                initialMonth: DateTime(1984, 4, 2),
                initialType: FCalendarPickerType.yearMonth,
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
            matchesGoldenFile('calendar/${theme.name}/year-picker/initial-date.png'),
          );
        });

        testWidgets('RTL - ${theme.name}', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              textDirection: TextDirection.rtl,
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
          );

          final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
          await gesture.addPointer(location: Offset.zero);
          addTearDown(gesture.removePointer);
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('8')));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/${theme.name}/day-picker/rtl.png'),
          );
        });
      });
    }
  });
}

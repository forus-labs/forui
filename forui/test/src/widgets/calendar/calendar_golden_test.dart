import 'package:flutter/rendering.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

// TODO: Enable leak testing once FCalendar is reimplemented.
void main() {
  final selected = {
    DateTime.utc(2024, 7, 4),
    DateTime.utc(2024, 7, 5),
    DateTime.utc(2024, 7, 16),
    DateTime.utc(2024, 7, 17),
    DateTime.utc(2024, 7, 18),
  };

  group('blue screen', () {
    testWidgets('day picker', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FCalendar(
            control: .managedDates(initial: selected, selectable: (date) => date != .utc(2024, 7, 2)),
            style: TestScaffold.blueScreen.calendarStyle,
            start: DateTime(1900, 1, 8),
            end: DateTime(2024, 7, 10),
            today: DateTime(2024, 7, 14),
          ),
        ),
      );

      await expectBlueScreen();
    }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());

    testWidgets('year picker', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FCalendar(
            control: .managedDates(initial: selected, selectable: (date) => date != .utc(2024, 7, 2)),
            style: TestScaffold.blueScreen.calendarStyle,
            initialType: FCalendarPickerType.yearMonth,
            start: DateTime(1900, 1, 8),
            end: DateTime(2024, 7, 10),
            today: DateTime(2024, 7, 14),
          ),
        ),
      );

      await expectBlueScreen();
    }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());
  });

  for (final theme in TestScaffold.themes) {
    group('day picker', () {
      testWidgets('default - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FCalendar(
              control: .managedDates(initial: selected, selectable: (date) => date != .utc(2024, 7, 2)),
              start: DateTime(1900, 1, 8),
              end: DateTime(2024, 7, 10),
              today: DateTime(2024, 7, 14),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('8')));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('calendar/${theme.name}/day-picker/default.png'),
        );
      }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());

      testWidgets('max rows - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FCalendar(
              control: .managedDates(initial: selected),
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
      }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());

      testWidgets(
        'hovered and selected dates next to each other - ${theme.name}',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                control: .managedDates(),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 8, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          );

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('12')));
          await tester.pumpAndSettle();

          await tester.tap(find.text('13'));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/${theme.name}/day-picker/hovered-selected.png'),
          );
        },
        experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
      );

      testWidgets('disabled previous icon - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FCalendar(
              control: .managedDates(initial: {.utc(2024, 7, 13)}),
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
      }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());
    });

    group('month picker', () {
      testWidgets('default - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FCalendar(
              control: .managedDates(initial: selected),
              start: DateTime(1900, 1, 8),
              end: DateTime(2024, 7, 10),
              today: DateTime(2024, 7, 14),
              initialType: FCalendarPickerType.yearMonth,
            ),
          ),
        );

        await tester.tap(find.text('2020'));
        await tester.pumpAndSettle();

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('Feb')));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('calendar/${theme.name}/month-picker/default.png'),
        );
      }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());
    });

    group('year picker', () {
      testWidgets('default - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FCalendar(
              control: .managedDates(initial: selected),
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
      }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());

      testWidgets(
        'initial date different from today - ${theme.name}',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FCalendar(
                control: .managedDates(initial: selected),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
                initialMonth: DateTime(1984, 4, 2),
                initialType: FCalendarPickerType.yearMonth,
              ),
            ),
          );

          final gesture = await tester.createPointerGesture();
          await tester.pump();

          await gesture.moveTo(tester.getCenter(find.text('1989')));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('calendar/${theme.name}/year-picker/initial-date.png'),
          );
        },
        experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
      );

      testWidgets('RTL - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            textDirection: TextDirection.rtl,
            child: FCalendar(
              control: .managedDates(initial: selected, selectable: (date) => date != .utc(2024, 7, 2)),
              start: DateTime(1900, 1, 8),
              end: DateTime(2024, 7, 10),
              today: DateTime(2024, 7, 14),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('8')));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('calendar/${theme.name}/day-picker/rtl.png'));
      }, experimentalLeakTesting: LeakTesting.settings.withIgnoredAll());
    });
  }
}

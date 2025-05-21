import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

// TODO : enable leak testing when calendar is reimplemented.
void main() {
  group('FCalendar', () {
    testWidgets(
      'initial type changes',
      (tester) async {
        final controller = autoDispose(
          FCalendarController.date(initialSelection: DateTime(2024, 7, 14)),
        );
        final type = autoDispose(ValueNotifier(FCalendarPickerType.yearMonth));

        await tester.pumpWidget(
          TestScaffold.app(
            child: ValueListenableBuilder(
              valueListenable: type,
              builder:
                  (context, value, _) => FCalendar(
                    controller: controller,
                    start: DateTime(1900, 1, 8),
                    end: DateTime(2025, 7, 10),
                    initialType: value,
                    initialMonth: DateTime(2024, 7, 14),
                  ),
            ),
          ),
        );

        expect(find.text('2023'), findsOneWidget);

        type.value = FCalendarPickerType.day;
        await tester.pumpAndSettle();

        expect(find.text('2023'), findsOneWidget);
      },
      experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
    );

    testWidgets(
      'initial month changes',
      (tester) async {
        final controller = autoDispose(
          FCalendarController.date(initialSelection: DateTime(2024, 7, 14)),
        );

        await tester.pumpWidget(
          TestScaffold.app(
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder:
                  (context, value, _) => FCalendar(
                    controller: controller,
                    start: DateTime(1900, 1, 8),
                    end: DateTime(2025, 7, 10),
                    initialMonth: value,
                  ),
            ),
          ),
        );

        expect(find.text('July 2024'), findsOneWidget);

        controller.value = DateTime(2024, 12, 14);
        await tester.pumpAndSettle();

        expect(find.text('July 2024'), findsOneWidget);

        await tester.tap(find.byType(FButton).first);
        await tester.pumpAndSettle();

        expect(find.text('June 2024'), findsOneWidget);
      },
      experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
    );

    group('previous button', () {
      testWidgets(
        'navigates to previous page',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FCalendar(
                controller: autoDispose(
                  FCalendarController.dates(
                    selectable: (date) => date != DateTime.utc(2024, 7, 2),
                  ),
                ),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          );

          expect(find.text('July 2024'), findsOneWidget);

          await tester.tap(find.byType(FButton).first);
          await tester.pumpAndSettle();

          expect(find.text('June 2024'), findsOneWidget);
        },
        experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
      );

      testWidgets(
        'did not navigate to previous page',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FCalendar(
                controller: autoDispose(
                  FCalendarController.dates(
                    selectable: (date) => date != DateTime.utc(2024, 7, 2),
                  ),
                ),
                start: DateTime(2024, 7),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          );

          expect(find.text('July 2024'), findsOneWidget);

          await tester.tap(find.byType(FButton).first);
          await tester.pumpAndSettle(const Duration(seconds: 1));

          expect(find.text('June 2024'), findsNothing);
        },
        experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
      );
    });

    group('next button', () {
      testWidgets(
        'navigates to next page',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FCalendar(
                controller: autoDispose(
                  FCalendarController.dates(
                    selectable: (date) => date != DateTime.utc(2024, 7, 2),
                  ),
                ),
                start: DateTime(1900, 1, 8),
                end: DateTime(2024, 8, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          );

          expect(find.text('July 2024'), findsOneWidget);

          await tester.tap(find.byType(FButton).last);
          await tester.pumpAndSettle();

          expect(find.text('August 2024'), findsOneWidget);
        },
        experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
      );

      testWidgets(
        'did not navigate to next page',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FCalendar(
                controller: autoDispose(
                  FCalendarController.dates(
                    selectable: (date) => date != DateTime.utc(2024, 7, 2),
                  ),
                ),
                start: DateTime(2024),
                end: DateTime(2024, 7, 10),
                today: DateTime(2024, 7, 14),
              ),
            ),
          );

          expect(find.text('July 2024'), findsOneWidget);

          await tester.tap(find.byType(FButton).first);
          await tester.pumpAndSettle();

          expect(find.text('August 2024'), findsNothing);
        },
        experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
      );
    });

    group('year month picker', () {
      late FCalendarController<Set<DateTime>> controller;
      late Widget calendar;

      setUp(() {
        controller = FCalendarController.dates();
        calendar = TestScaffold.app(
          child: FCalendar(
            initialType: FCalendarPickerType.yearMonth,
            controller: controller,
            start: DateTime(2023, 2, 8),
            end: DateTime(2025, 8, 10),
            today: DateTime(2024, 7, 14),
          ),
        );
      });

      tearDown(() {
        controller.dispose();
      });

      for (final (year, mmm, mmmm) in [
        (2023, 'Feb', 'February'),
        (2025, 'Aug', 'August'),
      ]) {
        testWidgets(
          'select $year $mmmm',
          (tester) async {
            await tester.pumpWidget(calendar);

            expect(find.text('July 2024'), findsOneWidget);

            expect(find.text('$year'), findsOneWidget);
            await tester.tap(find.text('$year'));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.text('July $year'), findsOneWidget);

            expect(find.text(mmm), findsOneWidget);
            await tester.tap(find.text(mmm));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.text('$mmmm $year'), findsOneWidget);
          },
          experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
        );
      }

      testWidgets(
        'select year out of range',
        (tester) async {
          await tester.pumpWidget(calendar);

          expect(find.text('July 2024'), findsOneWidget);

          expect(find.text('2026'), findsOneWidget);
          await tester.tap(find.text('2026'));
          await tester.pumpAndSettle(const Duration(seconds: 1));

          expect(find.text('July 2026'), findsNothing);
        },
        experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
      );

      for (final (year, mmm, mmmm) in [
        (2023, 'Jan', 'January'),
        (2025, 'Sep', 'September'),
      ]) {
        testWidgets(
          'select $year $mmmm out of range',
          (tester) async {
            await tester.pumpWidget(calendar);

            expect(find.text('July 2024'), findsOneWidget);

            expect(find.text('$year'), findsOneWidget);
            await tester.tap(find.text('$year'));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.text('July $year'), findsOneWidget);

            expect(find.text(mmm), findsOneWidget);
            await tester.tap(find.text(mmm));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.text('$mmmm $year'), findsNothing);
          },
          experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
        );
      }

      for (final (year, month) in [(2023, 'September'), (2025, 'May')]) {
        testWidgets(
          'select year where current month out of range',
          (tester) async {
            await tester.pumpWidget(
              TestScaffold.app(
                child: FCalendar(
                  initialType: FCalendarPickerType.yearMonth,
                  controller: autoDispose(FCalendarController.dates()),
                  start: DateTime(2023, 9, 8),
                  end: DateTime(2025, 5, 10),
                  today: DateTime(2024, 7, 14),
                ),
              ),
            );

            expect(find.text('July 2024'), findsOneWidget);

            expect(find.text('$year'), findsOneWidget);
            await tester.tap(find.text('$year'));
            await tester.pumpAndSettle(const Duration(seconds: 1));

            expect(find.text('$month $year'), findsOneWidget);
          },
          experimentalLeakTesting: LeakTesting.settings.withIgnoredAll(),
        );
      }
    });
  });
}

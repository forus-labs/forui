import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FCalendar', () {
    group('previous button', () {
      testWidgets('navigates to previous page', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FCalendar(
              controller: FCalendarController.dates(selectable: (date) => date != DateTime.utc(2024, 7, 2)),
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
      });

      testWidgets('did not navigate to previous page', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FCalendar(
              controller: FCalendarController.dates(selectable: (date) => date != DateTime.utc(2024, 7, 2)),
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
      });
    });

    group('next button', () {
      testWidgets('navigates to next page', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FCalendar(
              controller: FCalendarController.dates(selectable: (date) => date != DateTime.utc(2024, 7, 2)),
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
      });

      testWidgets('did not navigate to next page', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: FCalendar(
              controller: FCalendarController.dates(selectable: (date) => date != DateTime.utc(2024, 7, 2)),
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
      });
    });

    group('year month picker', () {
      late Widget calendar;

      setUp(() {
        calendar = TestScaffold(
          theme: FThemes.zinc.light,
          child: FCalendar(
            initialType: FCalendarPickerType.yearMonth,
            controller: FCalendarController.dates(),
            start: DateTime(2023, 2, 8),
            end: DateTime(2025, 8, 10),
            today: DateTime(2024, 7, 14),
          ),
        );
      });

      for (final (year, mmm, mmmm) in [
        (2023, 'Feb', 'February'),
        (2025, 'Aug', 'August'),
      ]) {
        testWidgets('select $year $mmmm', (tester) async {
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
        });
      }

      testWidgets('select year out of range', (tester) async {
        await tester.pumpWidget(calendar);

        expect(find.text('July 2024'), findsOneWidget);

        expect(find.text('2026'), findsOneWidget);
        await tester.tap(find.text('2026'));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(find.text('July 2026'), findsNothing);
      });

      for (final (year, mmm, mmmm) in [
        (2023, 'Jan', 'January'),
        (2025, 'Sep', 'September'),
      ]) {
        testWidgets('select $year $mmmm out of range', (tester) async {
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
        });
      }

      for (final (year, month) in [
        (2023, 'September'),
        (2025, 'May'),
      ]) {
        testWidgets('select year where current month out of range', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: FThemes.zinc.light,
              child: FCalendar(
                initialType: FCalendarPickerType.yearMonth,
                controller: FCalendarController.dates(),
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
        });
      }
    });
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FCalendar', () {
    group('previous button', () {
      testWidgets('navigates to previous page', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: FThemes.zinc.light,
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
            data: FThemes.zinc.light,
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
            data: FThemes.zinc.light,
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
            data: FThemes.zinc.light,
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
  });
}

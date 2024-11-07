@Tags(['golden'])
library;
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar.dart';
import '../test_scaffold.dart';

void main() {
  group('FLineCalendar', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FLineCalendar(
            style: TestScaffold.blueScreen.lineCalendarStyle,
            controller: FCalendarController.date(),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('$theme.name - default', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              controller: FCalendarController.date(initialSelection: DateTime.utc(2024, 10, 20)),
              today: DateTime.utc(2024, 10, 20),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line_calendar/${theme.name}/today.png'));
      });

      testWidgets('$theme.name - unselected', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              controller: FCalendarController.date(initialSelection: DateTime.utc(2024, 10, 20)),
              today: DateTime.utc(2024, 10, 20),
            ),
          ),
        );

        await tester.tap(find.text('20'));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line_calendar/${theme.name}/unselected.png'));
      });

      testWidgets('$theme.name - new date selected', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              controller: FCalendarController.date(initialSelection: DateTime.utc(2024, 10, 20)),
              today: DateTime.utc(2024, 10, 20),
            ),
          ),
        );

        await tester.tap(find.text('24'));
        await tester.pumpAndSettle(const Duration(milliseconds: 300));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('line_calendar/${theme.name}/new-date.png'));
      });

      testWidgets('$theme.name - single digit date', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FLineCalendar(
              controller: FCalendarController.date(initialSelection: DateTime.utc(2024, 10, 7)),
              today: DateTime.utc(2024, 10, 8),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('line_calendar/${theme.name}/single-digit-date.png'),
        );
      });
    }
  });
}

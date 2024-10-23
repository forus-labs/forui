@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui/src/widgets/line_calendar/line_calendar.dart';
import 'package:forui/src/widgets/line_calendar/line_calendar_controller.dart';
import '../test_scaffold.dart';

void main() {
  group('FLineCalendar', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FLineCalendar(
                style: TestScaffold.blueScreen.lineCalendarStyle,
                controller: FCalendarController.date(),
              ),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final (name, theme, _) in TestScaffold.themes) {
      for (final (lineCalendar, controller) in [
        ('default', FLineCalendarController(today: DateTime(2024, 10, 20))),
      ]) {
        testWidgets('$name - $lineCalendar', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FLineCalendar(controller: FCalendarController.date()),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('line_calendar/$name-$lineCalendar.png'),
          );
        });
      }
    }
  });
}

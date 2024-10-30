@Tags(['golden'])
library;

import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import 'package:forui/src/widgets/line_calendar/line_calendar.dart';
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

    for (final theme in TestScaffold.themes) {
      for (final (lineCalendar, controller) in [
        ('default', FCalendarController.date(initialSelection: DateTime.utc(2024, 10, 20))),
      ]) {
        testWidgets('$theme.name - $lineCalendar', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FLineCalendar(controller: controller),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('line_calendar/$theme.name-$lineCalendar/default.png'),
          );
        });

        testWidgets('new date selected - $theme.name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FLineCalendar(controller: controller),
                ),
              ),
            ),
          );

          await tester.tap(find.text('24'));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('line_calendar/$theme.name-$lineCalendar/new-date.png'),
          );
        });

        testWidgets('unselected - $theme.name', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FLineCalendar(controller: controller),
                ),
              ),
            ),
          );
          await tester.tap(find.text('20'));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('line_calendar/$theme.name-$lineCalendar/unselected.png'),
          );
        });
      }
    }
  });
}

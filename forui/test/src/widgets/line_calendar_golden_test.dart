@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/line_calendar.dart';
import 'package:sugar/sugar.dart';
import '../test_scaffold.dart';

void main() {
  group('FLineCalendar', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final (lineCalendar, value) in [('default', ValueNotifier(LocalDate.now()))]) {
        testWidgets('$name - $lineCalendar', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FLineCalendar(selected: value),
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

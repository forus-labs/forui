@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FProgress', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FProgress(
            style: TestScaffold.blueScreen.progressStyle,
            value: 0.5,
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), isBlueScreen);
    });

    for (final (name, theme, _) in TestScaffold.themes) {
      for (final (progress, value) in [('positive', 17.0), ('negative', -4.0), ('expected', 0.3)]) {
        testWidgets('$name - $progress', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FProgress(value: value),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('progress/$name-$progress.png'),
          );
        });
      }
    }
  });
}

@Tags(['golden'])
library;

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

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      for (final (progress, value) in [('positive', 17.0), ('negative', -4.0), ('clamped', 0.3)]) {
        testWidgets('$themeName - $progress', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FProgress(value: value),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('progress/$themeName-$progress.png'));
        });
      }
    }
  });
}

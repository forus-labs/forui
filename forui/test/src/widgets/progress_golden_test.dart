@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FProgress', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final (progress, value) in [('positive', 17.0), ('negative', -4.0), ('expected', 0.3)]) {
        testWidgets('$name - $progress', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: FProgress(value: value),
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

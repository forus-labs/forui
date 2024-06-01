import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../test_scaffold.dart';

void main() {
  group('FSeparator', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final (checked, value) in [('checked', true)]) {
        testWidgets('$name - $checked - unfocused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: FSwitch(value: value),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/$name-$checked-unfocused.png'),
          );
        });
      }
    }
  });
}
import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FSeparator', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final (checked, value) in [('checked', true), ('unchecked', false)]) {
        testWidgets('$name - $checked - unfocused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: FSwitch(
                  value: value,
                  onChanged: (_) {},
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/$name-$checked-unfocused.png'),
          );
        });

        testWidgets('$name - $checked - focused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: FSwitch(
                  value: value,
                  autofocus: true,
                  onChanged: (_) {},
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/$name-$checked-focused.png'),
          );
        });

        testWidgets('$name - $checked - disabled', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: FSwitch(
                  value: value,
                  autofocus: true,
                  onChanged: null,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/$name-$checked-disabled.png'),
          );
        });
      }
    }
  });
}

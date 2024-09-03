@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FSwitch', () {
    for (final (name, theme, _) in TestScaffold.themes) {
      for (final (checked, value) in [('checked', true), ('unchecked', false)]) {
        testWidgets('$name - $checked - unfocused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: FSwitch(
                    label: const Text('Airplane Mode'),
                    description: const Text('Disable all wireless connections.'),
                    semanticLabel: 'Airplane Mode',
                    initialValue: value,
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/$name-$checked-unfocused-switch.png'),
          );
        });

        testWidgets('$name - $checked - focused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: FSwitch(
                    label: const Text('Airplane Mode'),
                    description: const Text('Disable all wireless connections.'),
                    semanticLabel: 'Airplane Mode',
                    initialValue: value,
                    autofocus: true,
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/$name-$checked-focused-switch.png'),
          );
        });

        testWidgets('$name - $checked - disabled', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: FSwitch(
                    label: const Text('Airplane Mode'),
                    description: const Text('Disable all wireless connections.'),
                    semanticLabel: 'Airplane Mode',
                    enabled: false,
                    initialValue: value,
                    autofocus: true,
                  ),
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/$name-$checked-disabled-switch.png'),
          );
        });
      }
    }
  });
}

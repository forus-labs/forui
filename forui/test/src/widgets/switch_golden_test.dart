@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FSwitch', () {
    for (final (themeName, theme) in TestScaffold.themes) {
      for (final (checked, value) in [('checked', true), ('unchecked', false)]) {
        testWidgets('$themeName - $checked - unfocused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  semanticLabel: 'Airplane Mode',
                  value: value,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$themeName/$checked-unfocused.png'));
        });

        testWidgets('$themeName - $checked - focused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  semanticLabel: 'Airplane Mode',
                  value: value,
                  autofocus: true,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$themeName/$checked-focused.png'));
        });

        testWidgets('$themeName - $checked - disabled', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  semanticLabel: 'Airplane Mode',
                  enabled: false,
                  value: value,
                  autofocus: true,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$themeName/$checked-disabled.png'));
        });

        testWidgets('$themeName - $checked - error', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  error: const Text('Please enable to continue.'),
                  semanticLabel: 'Airplane Mode',
                  value: value,
                  enabled: false,
                  autofocus: true,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$themeName/$checked-error.png'));
        });
      }
    }
  });
}

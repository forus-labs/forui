@Tags(['golden'])
library;

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FSwitch', () {
    for (final (name, theme) in TestScaffold.themes) {
      for (final (checked, value) in [('checked', true), ('unchecked', false)]) {
        testWidgets('$name - $checked - unfocused', (tester) async {
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

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$name/$checked-unfocused.png'));
        });

        testWidgets('$name - $checked - focused', (tester) async {
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

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$name/$checked-focused.png'));
        });

        testWidgets('$name - $checked - disabled', (tester) async {
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

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$name/$checked-disabled.png'));
        });

        testWidgets('$name - $checked - error', (tester) async {
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

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/$name/$checked-error.png'));
        });
      }
    }
  });
}

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FSwitch', () {
    for (final theme in TestScaffold.themes) {
      for (final (checked, value) in [('checked', true), ('unchecked', false)]) {
        testWidgets('${theme.name} - $checked - unfocused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  semanticsLabel: 'Airplane Mode',
                  value: value,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('switch/${theme.name}/$checked-unfocused.png'),
          );
        });

        testWidgets('${theme.name} - $checked - focused', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  semanticsLabel: 'Airplane Mode',
                  value: value,
                  autofocus: true,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/${theme.name}/$checked-focused.png'));
        });

        testWidgets('${theme.name} - $checked - disabled', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  semanticsLabel: 'Airplane Mode',
                  enabled: false,
                  value: value,
                  autofocus: true,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/${theme.name}/$checked-disabled.png'));
        });

        testWidgets('${theme.name} - $checked - error', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: SizedBox(
                width: 300,
                child: FSwitch(
                  label: const Text('Airplane Mode'),
                  description: const Text('Disable all wireless connections.'),
                  error: const Text('Please enable to continue.'),
                  semanticsLabel: 'Airplane Mode',
                  value: value,
                  autofocus: true,
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('switch/${theme.name}/$checked-error.png'));
        });
      }
    }
  });
}

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FRadio(
          style: TestScaffold.blueScreen.radioStyle,
          value: true,
          label: const Text('Direct messages and mentions'),
          description: const Text('Only send me direct messages and mentions.'),
          error: const Text('An option must be selected.'),
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} focused', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FRadio(autofocus: true)));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('radio/${theme.name}/focused.png'));
    });

    for (final (enabled, value, error) in [
      (true, true, false),
      (true, true, true),
      (true, false, false),
      (true, false, true),
      (false, true, false),
      (false, true, true),
      (false, false, false),
      (false, false, true),
    ]) {
      testWidgets(
        '${theme.name} with ${enabled ? 'enabled' : 'disabled'}, ${'$value value'} & ${error ? 'with error' : 'without error'}',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FRadio(enabled: enabled, value: value, error: error ? const SizedBox() : null),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'radio/${theme.name}/${enabled ? 'enabled' : 'disabled'}${value ? '-checked' : ''}${error ? '-error' : ''}.png',
            ),
          );
        },
      );

      testWidgets(
        '${theme.name} with label, ${enabled ? 'enabled' : 'disabled'}, ${'$value value'} & ${error ? 'with error' : 'without error'}',
        (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: SizedBox(
                width: 300,
                child: FRadio(
                  label: const Text('Direct messages and mentions'),
                  description: const Text('Only send me direct messages and mentions.'),
                  error: error ? const Text('An option must be selected.') : null,
                  value: value,
                  enabled: enabled,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'radio/${theme.name}/label-${enabled ? 'enabled' : 'disabled'}${value ? '-checked' : ''}${error ? '-error' : ''}.png',
            ),
          );
        },
      );
    }
  }
}

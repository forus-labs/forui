import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FCheckbox(
          style: TestScaffold.blueScreen.checkboxStyle,
          label: const Text('Terms and Conditions'),
          description: const Text('I agree to the terms and conditions.'),
          error: const Text('Please check the agree to continue.'),
          value: true,
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} focused', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FCheckbox(autofocus: true)));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('check-box/${theme.name}/focused.png'));
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
              child: FCheckbox(enabled: enabled, value: value, error: error ? const Text('') : null),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'check-box/${theme.name}/${enabled ? 'enabled' : 'disabled'}${value ? '-checked' : ''}${error ? '-error' : ''}.png',
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
              child: FCheckbox(
                label: const Text('Terms and Conditions'),
                description: const Text('I agree to the terms and conditions.'),
                error: error ? const Text('Please check the agree to continue.') : null,
                value: value,
                enabled: enabled,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'check-box/${theme.name}/label-${enabled ? 'enabled' : 'disabled'}${value ? '-checked' : ''}${error ? '-error' : ''}.png',
            ),
          );
        },
      );
    }
  }
}

@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FCheckBox', () {
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

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (name, theme) in TestScaffold.themes) {
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
            '$name with ${enabled ? 'enabled' : 'disabled'}, ${'$value value'} & ${error ? 'with error' : 'without error'}',
            (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FCheckbox(
                enabled: enabled,
                value: value,
                error: error ? const Text('') : null,
              )
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'check-box/$name/${enabled ? 'enabled' : 'disabled'}${value ? '-checked' : ''}${error ? '-error' : ''}.png',
            ),
          );
        });

        testWidgets(
            '$name with label, ${enabled ? 'enabled' : 'disabled'}, ${'$value value'} & ${error ? 'with error' : 'without error'}',
                (tester) async {
              await tester.pumpWidget(
                TestScaffold(
                  theme: theme,
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
                  'check-box/$name/label-${enabled ? 'enabled' : 'disabled'}${value ? '-checked' : ''}${error ? '-error' : ''}.png',
                ),
              );
            });
      }
    }
  });
}

@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FCheckBox', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      for (final (enabled, initialValue, error) in [
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
            '$name with ${enabled ? 'enabled' : 'disabled'}, ${initialValue.toString() + ' value'} & ${error ? 'with error' : 'without error'}',
            (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: error
                  ? FCheckbox(
                      enabled: enabled,
                      initialValue: initialValue,
                      forceErrorText: '',
                    )
                  : FCheckbox(
                      enabled: enabled,
                      initialValue: initialValue,
                    ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'check-box/$name-${enabled ? 'enabled' : 'disabled'}-${initialValue}${error ? '-error' : ''}.png',
            ),
          );
        });
      }
    }

    for (final (name, theme, background) in TestScaffold.themes) {
      for (final (enabled, initialValue, error) in [
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
            '$name with label, ${enabled ? 'enabled' : 'disabled'}, ${initialValue.toString() + ' value'} & ${error ? 'with error' : 'without error'}',
            (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: SizedBox(
                width: 300,
                child: FCheckbox(
                  label: const Text('Terms and Conditions'),
                  description: const Text('I agree to the terms and conditions.'),
                  enabled: enabled,
                  initialValue: initialValue,
                  forceErrorText: error ? 'Please check the agree to continue.' : null,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'check-box/$name-label-${enabled ? 'enabled' : 'disabled'}-${initialValue}${error ? '-error' : ''}.png',
            ),
          );
        });
      }
    }
  });
}

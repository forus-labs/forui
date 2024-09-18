@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FRadio', () {
    for (final (name, theme, background) in TestScaffold.themes) {
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
              data: theme,
              background: background,
              child: error
                  ? FRadio(
                      enabled: enabled,
                      value: value,
                      error: const SizedBox(),
                    )
                  : FRadio(
                      enabled: enabled,
                      value: value,
                    ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'radio/$name-${enabled ? 'enabled' : 'disabled'}-$value${error ? '-error' : ''}.png',
            ),
          );
        });
      }
    }

    for (final (name, theme, background) in TestScaffold.themes) {
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
            '$name with label, ${enabled ? 'enabled' : 'disabled'}, ${'$value value'} & ${error ? 'with error' : 'without error'}',
            (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
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
              'radio/$name-label-${enabled ? 'enabled' : 'disabled'}-$value${error ? '-error' : ''}.png',
            ),
          );
        });
      }
    }
  });
}

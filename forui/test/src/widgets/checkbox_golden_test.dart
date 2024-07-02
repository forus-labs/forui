@Tags(['golden'])
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FCheckBox', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      for (final (enabled, initialValue) in [
        (true, true),
        (true, false),
        (false, true),
        (true, true),
      ]) {
        testWidgets('$name with ${enabled ? 'enabled' : 'disabled'} & ${initialValue ? 'value' : 'no-value'}',
            (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              data: theme,
              background: background,
              child: FCheckBox(
                enabled: enabled,
                initialValue: initialValue,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'check-box/$name-${enabled ? 'enabled' : 'disabled'}-${initialValue ? 'value' : 'no-value'}.png',
            ),
          );
        });
      }
    }
  });
}

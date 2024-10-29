@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/button/button.dart';
import '../../test_scaffold.dart';

void main() {
  group('FButtonSpinner', () {
    group('blue screen', () {
      testWidgets('FButtonContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FButton(
              label: const Text('Button'),
              style: TestScaffold.blueScreen.buttonStyles.primary,
              prefix: const FButtonSpinner(),
              suffix: FIcon(FAssets.icons.circleStop),
              onPress: () {},
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$themeName with enabled button spinner', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton(
                prefix: const FButtonSpinner(),
                label: const Text('Loading'),
                onPress: () {},
                style: variant,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$themeName/$variant/button-spinner-enabled-button.png'),
          );
        });

        testWidgets('$themeName with disabled button spinner', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FButton(
                prefix: const FButtonSpinner(),
                label: const Text('Loading'),
                onPress: null,
                style: variant,
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$themeName/$variant/button-spinner-disabled-button.png'),
          );
        });
      }
    }
  });
}

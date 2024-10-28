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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FButton(
                label: const Text('Button'),
                style: TestScaffold.blueScreen.buttonStyles.primary,
                prefix: const FButtonSpinner(),
                suffix: FIcon(FAssets.icons.circleStop),
                onPress: () {},
              ),
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$name with enabled button spinner', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  prefix: const FButtonSpinner(),
                  label: const Text('Loading'),
                  onPress: () {},
                  style: variant,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('button/$name/$variant/button-spinner-enabled-button.png'),
          );
        });

        testWidgets('$name with disabled button spinner', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(
                  prefix: const FButtonSpinner(),
                  label: const Text('Loading'),
                  onPress: null,
                  style: variant,
                ),
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile(
              'button/$name/$variant/button-spinner-disabled-button.png',
            ),
          );
        });
      }
    }
  });
}

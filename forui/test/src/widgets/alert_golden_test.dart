@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/alert.dart';
import '../test_scaffold.dart';

void main() {
  group('FAlert', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FAlert(
            title: const Text('Alert Title'),
            subtitle: const Text('Alert description with extra text'),
            style: TestScaffold.blueScreen.alertStyles.primary,
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$themeName with default icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FAlert(
                title: const Text('Alert Title'),
                subtitle: const Text('Alert description with extra text'),
                style: variant,
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('alert/$themeName/$variant-default-icon.png'));
        });

        testWidgets('$themeName with user icon', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FAlert(
                icon: FIcon(FAssets.icons.badgeAlert),
                title: const Text('Alert Title'),
                subtitle: const Text('Alert description with extra text'),
                style: variant,
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('alert/$themeName/$variant-user-icon.png'));
        });
      }
    }
  });
}

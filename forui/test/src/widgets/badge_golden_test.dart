@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/badge/badge.dart';
import '../test_scaffold.dart';

void main() {
  group('FBadge', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FBadge(
            label: const Text('Badge'),
            style: TestScaffold.blueScreen.badgeStyles.primary,
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('$themeName with FBadgeContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FBadge(
                label: const Text('Badge'),
                style: variant,
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('badge/$themeName/$variant-content.png'));
        });

        testWidgets('$themeName with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FBadge.raw(
                style: variant,
                builder: (_, style) => Padding(
                  padding: const EdgeInsets.all(50),
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.blueAccent,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: style.backgroundColor,
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('badge/$themeName/$variant-raw.png'));
        });
      }
    }
  });
}

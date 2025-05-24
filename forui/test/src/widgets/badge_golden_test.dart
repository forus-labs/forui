import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/badge/badge.dart';
import '../test_scaffold.dart';

void main() {
  group('FBadge', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FBadge(style: TestScaffold.blueScreen.badgeStyles.primary, child: const Text('Badge')),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      for (final variant in Variant.values) {
        testWidgets('${theme.name} with FBadgeContent', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FBadge(style: variant, child: const Text('Badge')),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('badge/${theme.name}/$variant-content.png'));
        });

        testWidgets('${theme.name} with raw content', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
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
                        color: style.decoration.color,
                        border: Border.all(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('badge/${theme.name}/$variant-raw.png'));
        });
      }
    }
  });
}

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/badge/badge.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FBadge(style: TestScaffold.blueScreen.badgeStyles.primary, child: const Text('Badge')),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    for (final (name, variant) in [
      ('primary', FBadgeStyle.primary()),
      ('secondary', FBadgeStyle.secondary()),
      ('destructive', FBadgeStyle.destructive()),
      ('outline', FBadgeStyle.outline()),
    ]) {
      testWidgets('${theme.name} with FBadgeContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FBadge(style: variant, child: const Text('Badge')),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('badge/${theme.name}/$name-content.png'));
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
                      color: (style.decoration as dynamic).color,
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('badge/${theme.name}/$name-raw.png'));
      });
    }
  }
}

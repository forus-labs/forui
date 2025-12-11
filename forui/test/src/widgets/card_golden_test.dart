import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FCard(
          style: TestScaffold.blueScreen.cardStyle,
          title: const Text('Notifications'),
          subtitle: const Text('You have 3 unread messages.'),
        ),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with FCardContent', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FCard(title: const Text('Notifications'), subtitle: const Text('You have 3 unread messages.')),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/${theme.name}/content.png'));
    });

    testWidgets('${theme.name} with image', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FCard(
            image: Container(color: Colors.blue, height: 100, width: 200),
            title: const Text('Notifications'),
            subtitle: const Text('You have 3 unread messages.'),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/${theme.name}/content-image.png'));
    });

    testWidgets('${theme.name} with raw content', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FCard.raw(child: SizedBox(width: 50, height: 50)),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/${theme.name}/raw.png'));
    });
  }
}

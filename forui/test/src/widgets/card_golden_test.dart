@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FCard', () {
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

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets('$themeName with FCardContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FCard(
                  title: const Text('Notifications'),
                  subtitle: const Text('You have 3 unread messages.'),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/$themeName/content.png'));
      });

      testWidgets('$themeName with image', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FCard(
                  image: Container(
                    color: Colors.blue,
                    height: 100,
                    width: 200,
                  ),
                  title: const Text('Notifications'),
                  subtitle: const Text('You have 3 unread messages.'),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/$themeName/content-image.png'));
      });

      testWidgets('$themeName with raw content', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FCard.raw(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/$themeName/raw.png'));
      });
    }
  });
}

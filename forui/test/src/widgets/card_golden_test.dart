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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FCard(
                style: TestScaffold.blueScreen.cardStyle,
                title: const Text('Notifications'),
                subtitle: const Text('You have 3 unread messages.'),
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('$name with FCardContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/$name/content.png'));
      });

      testWidgets('$name with image', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/$name/content-image.png'));
      });

      testWidgets('$name with raw content', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('card/$name/raw.png'));
      });
    }
  });
}

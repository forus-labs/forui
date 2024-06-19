@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FCard', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('$name with text FCardContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FCard(
                  title: 'Notifications',
                  subtitle: 'You have 3 unread messages.',
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('card/$name-text-card-content.png'),
        );
      });

      testWidgets('$name with raw FCardContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            background: background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FCard(
                  rawTitle: const Text('Notifications'),
                  rawSubtitle: const Text('You have 3 unread messages.'),
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('card/$name-raw-card-content.png'),
        );
      });

      testWidgets('$name with raw content', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
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

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('card/$name-raw-content.png'),
        );
      });
    }
  });
}

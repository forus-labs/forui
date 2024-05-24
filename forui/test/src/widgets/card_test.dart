@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../box.dart';

void main() {
  group('FCard', () {
    for (final (name, theme, background) in Box.themes) {
      testWidgets('$name with FCardContent', (tester) async {
        await tester.pumpWidget(Box(
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
        ));

        await expectLater(
          find.byType(Box),
          matchesGoldenFile('card/$name-card-content.png'),
        );
      });

      testWidgets('$name with raw content', (tester) async {
        await tester.pumpWidget(Box(
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
        ));

        await expectLater(
          find.byType(Box),
          matchesGoldenFile('card/$name-raw-content.png'),
        );
      });
    }
  });
}

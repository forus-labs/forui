@Tags(['golden'])
library;

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FCard', () {
    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('$name with FCardContent', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
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

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('card/$name-content-card.png'),
        );
      });

      testWidgets('$name with image', (tester) async {
        final testWidget = TestScaffold(
          data: theme,
          background: background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FCard(
                image: Image.file(
                  File('./test/resources/pante.jpg'),
                  height: 100,
                  width: 100,
                ),
                title: const Text('Notifications'),
                subtitle: const Text('You have 3 unread messages.'),
              ),
            ],
          ),
        );

        /// current workaround for flaky image asset testing.
        /// https://github.com/flutter/flutter/issues/38997
        await tester.runAsync(() async {
          await tester.pumpWidget(testWidget);
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pumpAndSettle();
          }
        });
        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('card/$name-content-image.png'),
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
          matchesGoldenFile('card/$name-raw-card.png'),
        );
      });
    }
  });
}

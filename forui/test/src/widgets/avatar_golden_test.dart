@Tags(['golden'])
library;

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group(
    'FAvatar',
    () {
      for (final (name, theme, _) in TestScaffold.themes) {
        testWidgets('$name with image', (tester) async {
          final testWidget = MaterialApp(
            home: TestScaffold(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FAvatar(
                  image: FileImage(File('./test/resources/pante.jpg')),
                  placeholderBuilder: (_) => const Text('MN'),
                ),
              ),
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
            matchesGoldenFile('avatar/$name-with-image.png'),
          );
        });

        /// We will not be testing for the fallback behavior due to this issue on flutter
        /// https://github.com/flutter/flutter/issues/107416
      }
    },
  );
}

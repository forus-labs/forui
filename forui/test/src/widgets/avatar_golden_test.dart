import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with image', (tester) async {
      final testWidget = TestScaffold.app(
        theme: theme.data,
        child: FAvatar(image: FileImage(File('$relativePath/test/resources/pante.jpg')), fallback: const Text('MN')),
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('avatar/${theme.name}/image.png'));
    });

    /// We will not be testing for the fallback behavior due to this issue on flutter
    /// https://github.com/flutter/flutter/issues/107416
    testWidgets('${theme.name} with raw content', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FAvatar.raw(
            child: Padding(
              padding: const .all(10),
              child: Icon(FIcons.baby, color: theme.data.colors.mutedForeground, size: 20),
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('avatar/${theme.name}/raw.png'));
    });
  }
}

@Tags(['golden'])
library;

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FIcon', () {
    testWidgets('with parent IconStyle', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FIconStyleData(
            style: const FIconStyle(color: Colors.red, size: 48),
            child: FIcon(FAssets.icons.laugh),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/icon-style.png'));
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets('$themeName with SvgAsset', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FIcon(FAssets.icons.laugh),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/$themeName/svg-asset.png'));
      });

      testWidgets('$themeName with IconData', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            // This will always be a square since we don't include material's icon in the pubspec.yaml.
            child: const FIcon.data(Icons.add),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/$themeName/data.png'));
      });

      testWidgets('$themeName with ImageProvider', (tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FIcon.image(FileImage(File('./test/resources/forus-labs.png'))),
            ),
          );
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pumpAndSettle();
          }
        });

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/$themeName/recolored-image.png'));
      });

      testWidgets('$themeName with ImageProvider and no recoloring', (tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FIcon.image(FileImage(File('./test/resources/forus-labs.png')), color: Colors.transparent),
            ),
          );
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pumpAndSettle();
          }
        });

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/$themeName/original-image.png'));
      });

      testWidgets('$themeName with raw builder', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FIcon.raw(
              builder: (context, style, _) => Container(
                color: style.color,
                height: style.size,
                width: style.size,
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/$themeName/raw.png'));
      });
    }
  });
}

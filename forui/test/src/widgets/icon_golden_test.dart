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
          data: FThemes.zinc.light,
          child: FIconStyleData(
            style: const FIconStyle(color: Colors.red, size: 48),
            child: FIcon(FAssets.icons.laugh),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/icon-style.png'));
    });

    for (final (name, theme, _) in TestScaffold.themes) {
      testWidgets('$name with SvgAsset', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            child: FIcon(FAssets.icons.laugh),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/svg-asset-$name.png'));
      });

      testWidgets('$name with IconData', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            // This will always be a square since we don't include material's icon in the pubspec.yaml.
            child: const FIcon.data(Icons.add),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/icon-data-$name.png'));
      });

      testWidgets('$name with ImageProvider', (tester) async {
        final image = TestScaffold(
          data: theme,
          child: FIcon.image(FileImage(File('./test/resources/forus-labs.png'))),
        );

        await tester.runAsync(() async {
          await tester.pumpWidget(image);
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pumpAndSettle();
          }
        });

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/image-recolored-$name.png'));
      });

      testWidgets('$name with ImageProvider and no recoloring', (tester) async {
        final image = TestScaffold(
          data: theme,
          child: FIcon.image(FileImage(File('./test/resources/forus-labs.png')), color: Colors.transparent),
        );

        await tester.runAsync(() async {
          await tester.pumpWidget(image);
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pumpAndSettle();
          }
        });

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/image-original-$name.png'));
      });

      testWidgets('$name with raw builder', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            child: FIcon.raw(
              builder: (context, style, _) => Container(
                color: style.color,
                height: style.size,
                width: style.size,
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/raw-$name.png'));
      });
    }
  });
}

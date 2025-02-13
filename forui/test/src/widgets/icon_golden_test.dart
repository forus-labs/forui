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

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with SvgAsset', (tester) async {
        await tester.pumpWidget(TestScaffold(theme: theme.data, child: FIcon(FAssets.icons.laugh)));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/${theme.name}/svg-asset.png'));
      });

      testWidgets('${theme.name} with IconData', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            // This will always be a square since we don't include material's icon in the pubspec.yaml.
            child: const FIcon.data(Icons.add),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/${theme.name}/data.png'));
      });

      testWidgets('${theme.name} with ImageProvider', (tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FIcon.image(FileImage(File('$relativePath/test/resources/forus-labs.png'))),
            ),
          );
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pumpAndSettle();
          }
        });

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/${theme.name}/recolored-image.png'));
      });

      testWidgets('${theme.name} with ImageProvider and no recoloring', (tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FIcon.image(
                FileImage(File('$relativePath/test/resources/forus-labs.png')),
                color: Colors.transparent,
              ),
            ),
          );
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pumpAndSettle();
          }
        });

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/${theme.name}/original-image.png'));
      });

      testWidgets('${theme.name} with raw builder', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FIcon.raw(
              builder: (context, style, _) => Container(color: style.color, height: style.size, width: style.size),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/${theme.name}/raw.png'));
      });

      testWidgets('empty icon', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: DecoratedBox(
              decoration: BoxDecoration(border: Border.all(color: theme.data.colorScheme.primary)),
              child: FIcon.empty(),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('icon/${theme.name}/empty.png'));
      });
    }
  });
}

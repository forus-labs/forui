import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FBreadcrumb', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FBreadcrumb(
            style: TestScaffold.blueScreen.breadcrumbStyle,
            children: [
              FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
              FBreadcrumbItem(onPress: () {}, child: const Text('Core')),
              const FBreadcrumbItem(current: true, child: Text('Components')),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with hovered breadcrumb', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FBreadcrumb(
              children: [
                FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
                FBreadcrumbItem.collapsed(
                  menu: [
                    FTileGroup(
                      children: [
                        FTile(title: const Text('Documentation'), onPress: () {}),
                        FTile(title: const Text('Themes'), onPress: () {}),
                      ],
                    ),
                  ],
                ),
                FBreadcrumbItem(onPress: () {}, child: const Text('Core')),
                const FBreadcrumbItem(current: true, child: Text('Components')),
              ],
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.text('Core')));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('breadcrumb/${theme.name}/hovered-breadcrumb.png'),
        );
      });

      testWidgets('${theme.name} with hovered breadcrumb', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FBreadcrumb(
              children: [
                FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
                FBreadcrumbItem.collapsed(
                  menu: [
                    FTileGroup(
                      children: [
                        FTile(title: const Text('Documentation'), onPress: () {}),
                        FTile(title: const Text('Themes'), onPress: () {}),
                      ],
                    ),
                  ],
                ),
                FBreadcrumbItem(onPress: () {}, child: const Text('Core')),
                const FBreadcrumbItem(current: true, child: Text('Components')),
              ],
            ),
          ),
        );

        Focus.of(tester.element(find.text('Forui'))).requestFocus();
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('breadcrumb/${theme.name}/focused-breadcrumb.png'),
        );
      });

      testWidgets('${theme.name} with collapsed breadcrumb', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FBreadcrumb(
              children: [
                FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
                FBreadcrumbItem.collapsed(
                  menu: [
                    FTileGroup(
                      children: [
                        FTile(title: const Text('Documentation'), onPress: () {}),
                        FTile(title: const Text('Themes'), onPress: () {}),
                      ],
                    ),
                  ],
                ),
                FBreadcrumbItem(onPress: () {}, child: const Text('Core')),
                const FBreadcrumbItem(current: true, child: Text('Components')),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('breadcrumb/${theme.name}/collapsed-breadcrumb.png'),
        );
      });

      testWidgets('${theme.name} with uncollapsed breadcrumb', (tester) async {
        final menu = [
          FTileGroup(
            key: const Key('menu'),
            children: [
              FTile(title: const Text('Documentation'), onPress: () {}),
              FTile(title: const Text('Themes'), onPress: () {}),
            ],
          ),
        ];

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FBreadcrumb(
              children: [
                FBreadcrumbItem(onPress: () {}, child: const Text('Forui')),
                FBreadcrumbItem.collapsed(menu: menu),
                FBreadcrumbItem(onPress: () {}, child: const Text('Core')),
                const FBreadcrumbItem(current: true, child: Text('Components')),
              ],
            ),
          ),
        );

        await tester.tap(find.descendant(of: find.byType(FBreadcrumb), matching: find.byType(FPopoverMenu)));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('breadcrumb/${theme.name}/shown-collapsed-breadcrumb.png'),
        );
      });
    }
  });
}

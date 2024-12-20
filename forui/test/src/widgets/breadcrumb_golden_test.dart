@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../test_scaffold.dart';

void main() {
  group('FBreadcrumb', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FBreadcrumb(
            style: TestScaffold.blueScreen.breadcrumbStyle,
            children: [
              FBreadcrumbItem.of(onPress: () {}, child: const Text('Forui')),
              FBreadcrumbItem.of(onPress: () {}, child: const Text('Core')),
              FBreadcrumbItem.of(onPress: () {}, child: const Text('Components')),
            ],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('${theme.name} with collapsed breadcrumb', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FBreadcrumb(
              children: [
                FBreadcrumbItem.of(onPress: () {}, child: const Text('Forui')),
                FBreadcrumbItem.collapsed(
                  menu: [
                    FTileGroup(
                      children: [
                        FTile(
                          title: const Text('Documentation'),
                          onPress: () {},
                        ),
                        FTile(
                          title: const Text('Themes'),
                          onPress: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                FBreadcrumbItem.of(onPress: () {}, child: const Text('Core')),
                FBreadcrumbItem.of(onPress: () {}, child: const Text('Components')),
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
              FTile(
                title: const Text('Documentation'),
                onPress: () {},
              ),
              FTile(
                title: const Text('Themes'),
                onPress: () {},
              ),
            ],
          ),
        ];

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FBreadcrumb(
              children: [
                FBreadcrumbItem.of(onPress: () {}, child: const Text('Forui')),
                FBreadcrumbItem.collapsed(menu: menu),
                FBreadcrumbItem.of(onPress: () {}, child: const Text('Core')),
                FBreadcrumbItem.of(onPress: () {}, child: const Text('Components')),
              ],
            ),
          ),
        );

        await tester.tap(find.descendant(of: find.byType(FBreadcrumb), matching: find.byType(FPopoverMenu)));
        await tester.pumpAndSettle();

        // await tester.tapAt(Offset.zero);

        //
        // expect(find.text('Group 1'), findsOneWidget);

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('breadcrumb/${theme.name}/shown-collapsed-breadcrumb.png'),
        );
      });
    }
  });
}

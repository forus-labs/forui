import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FPopoverController controller;

  setUp(() => controller = FPopoverController(vsync: const TestVSync()));

  for (final theme in TestScaffold.themes) {
    group('FPopoverMenu', () {
      testWidgets('${theme.name} hidden ', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FPopoverMenu(
              popoverController: controller,
              menu: [
                FTileGroup(
                  children: [
                    FTile(title: const Text('Item 1'), onPress: () {}),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(title: const Text('Item 1'), onPress: () {}),
                  ],
                ),
              ],
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(dimension: 50),
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('popover-menu/hidden-${theme.name}.png'),
        );
      });

      testWidgets('${theme.name} shown', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FPopoverMenu(
              popoverController: controller,
              menu: [
                FTileGroup(
                  children: [
                    FTile(title: const Text('Group 1'), onPress: () {}),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(title: const Text('Group 2'), onPress: () {}),
                  ],
                ),
              ],
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(dimension: 50),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('popover-menu/shown-${theme.name}.png'),
        );
      });

      testWidgets('${theme.name} scrollable', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FPopoverMenu(
              popoverController: controller,
              maxHeight: 200,
              menu: [
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Group 1 - Tile 1'),
                      onPress: () {},
                    ),
                    FTile(
                      title: const Text('Group 1 - Tile 2'),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(title: const Text('Group 2- Tile 1'), onPress: () {}),
                    FTile(
                      title: const Text('Group 2 - Tile 2'),
                      onPress: () {},
                    ),
                    FTile(
                      title: const Text('Group 2 - Tile 3'),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(dimension: 50),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('popover-menu/scrollable-${theme.name}.png'),
        );
      });
    });
  }

  tearDown(() => controller.dispose());
}

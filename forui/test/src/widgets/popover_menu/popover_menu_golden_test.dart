import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FPopoverController controller;

  setUp(() => controller = FPopoverController(vsync: const TestVSync()));

  tearDown(() => controller.dispose());

  group('blue screen', () {
    testWidgets('items ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FPopoverMenu(
            style: TestScaffold.blueScreen.popoverMenuStyle,
            menu: [
              FItemGroup(
                children: [FItem(title: const Text('Item 1'), onPress: () {})],
              ),
              FItemGroup(
                children: [FItem(title: const Text('Item 1'), onPress: () {})],
              ),
            ],
            child: ColoredBox(
              color: TestScaffold.blueScreen.colors.border,
              child: const SizedBox.square(dimension: 50),
            ),
          ),
        ),
      );

      await expectBlueScreen();
    });

    testWidgets('tiles ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FPopoverMenu.tiles(
            style: TestScaffold.blueScreen.popoverMenuStyle,
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Item 1'), onPress: () {})],
              ),
              FTileGroup(
                children: [FTile(title: const Text('Item 1'), onPress: () {})],
              ),
            ],
            child: ColoredBox(
              color: TestScaffold.blueScreen.colors.border,
              child: const SizedBox.square(dimension: 50),
            ),
          ),
        ),
      );

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} hidden ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopoverMenu.tiles(
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Item 1'), onPress: () {})],
              ),
              FTileGroup(
                children: [FTile(title: const Text('Item 1'), onPress: () {})],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/hidden-${theme.name}.png'));
    });

    testWidgets('${theme.name} items shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopoverMenu(
            control: .managed(controller: controller), menu: [
              FItemGroup(
                children: [
                  FItem(title: const Text('Group 1 - Tile 1'), onPress: () {}),
                  FItem(title: const Text('Group 1 - Tile 2'), onPress: () {}),
                ],
              ),
              FItemGroup(
                children: [
                  FItem(title: const Text('Group 2 - Tile 1'), onPress: () {}),
                  FItem(title: const Text('Group 2 - Tile 2'), onPress: () {}),
                ],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/items-shown-${theme.name}.png'));
    });

    testWidgets('${theme.name} tiles shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopoverMenu.tiles(
            control: .managed(controller: controller), menu: [
              FTileGroup(
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
              FTileGroup(
                children: [FTile(title: const Text('Group 2'), onPress: () {})],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/tiles-shown-${theme.name}.png'));
    });

    testWidgets('${theme.name} scrollable', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopoverMenu.tiles(
            control: .managed(controller: controller), maxHeight: 200,
            menu: [
              FTileGroup(
                children: [
                  FTile(title: const Text('Group 1 - Tile 1'), onPress: () {}),
                  FTile(title: const Text('Group 1 - Tile 2'), onPress: () {}),
                ],
              ),
              FTileGroup(
                children: [
                  FTile(title: const Text('Group 2- Tile 1'), onPress: () {}),
                  FTile(title: const Text('Group 2 - Tile 2'), onPress: () {}),
                  FTile(title: const Text('Group 2 - Tile 3'), onPress: () {}),
                ],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/scrollable-${theme.name}.png'));
    });
  }
}

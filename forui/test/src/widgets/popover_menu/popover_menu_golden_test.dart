import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('blue screen', () {
    testWidgets('items ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FPopoverMenu(
            control: const .managed(initial: true),
            style: TestScaffold.blueScreen.popoverMenuStyle,
            menu: [
              .group(
                children: [.item(title: const Text('Item 1'), onPress: () {})],
              ),
              .group(
                children: [.item(title: const Text('Item 1'), onPress: () {})],
              ),
            ],
            child: ColoredBox(
              color: TestScaffold.blueScreen.colors.border,
              child: const SizedBox.square(dimension: 50),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('tiles ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FPopoverMenu.tiles(
            control: const .managed(initial: true),
            style: TestScaffold.blueScreen.popoverMenuStyle,
            menu: [
              .group(
                children: [.tile(title: const Text('Item 1'), onPress: () {})],
              ),
              .group(
                children: [.tile(title: const Text('Item 1'), onPress: () {})],
              ),
            ],
            child: ColoredBox(
              color: TestScaffold.blueScreen.colors.border,
              child: const SizedBox.square(dimension: 50),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

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
              .group(
                children: [.tile(title: const Text('Item 1'), onPress: () {})],
              ),
              .group(
                children: [.tile(title: const Text('Item 1'), onPress: () {})],
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
            control: const .managed(initial: true),
            menu: [
              .group(
                children: [
                  .item(title: const Text('Group 1 - Tile 1'), onPress: () {}),
                  .item(title: const Text('Group 1 - Tile 2'), onPress: () {}),
                ],
              ),
              .group(
                children: [
                  .item(title: const Text('Group 2 - Tile 1'), onPress: () {}),
                  .item(title: const Text('Group 2 - Tile 2'), onPress: () {}),
                ],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/items-shown-${theme.name}.png'));
    });

    testWidgets('${theme.name} tiles shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopoverMenu.tiles(
            control: const .managed(initial: true),
            menu: [
              .group(
                children: [.tile(title: const Text('Group 1'), onPress: () {})],
              ),
              .group(
                children: [.tile(title: const Text('Group 2'), onPress: () {})],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/tiles-shown-${theme.name}.png'));
    });

    testWidgets('${theme.name} scrollable', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopoverMenu.tiles(
            control: const .managed(initial: true),
            maxHeight: 200,
            menu: [
              .group(
                children: [
                  .tile(title: const Text('Group 1 - Tile 1'), onPress: () {}),
                  .tile(title: const Text('Group 1 - Tile 2'), onPress: () {}),
                ],
              ),
              .group(
                children: [
                  .tile(title: const Text('Group 2- Tile 1'), onPress: () {}),
                  .tile(title: const Text('Group 2 - Tile 2'), onPress: () {}),
                  .tile(title: const Text('Group 2 - Tile 3'), onPress: () {}),
                ],
              ),
            ],
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 50)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/scrollable-${theme.name}.png'));
    });
  }
}

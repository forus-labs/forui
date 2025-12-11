import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const key = Key('key');

class PopoverItem extends StatelessWidget with FItemMixin {
  const PopoverItem({super.key});

  @override
  Widget build(BuildContext context) => FPopoverMenu(
    menu: [
      FItemGroup(
        children: [
          FItem(title: const Text('Group 1'), onPress: () {}),
          FItem(title: const Text('Group 2'), onPress: () {}),
        ],
      ),
    ],
    builder: (_, controller, _) => FItem(title: const Text('Tap me'), onPress: controller.toggle),
  );
}

class PopoverTile extends StatelessWidget with FTileMixin {
  const PopoverTile({super.key});

  @override
  Widget build(BuildContext context) => FPopoverMenu.tiles(
    menu: [
      FTileGroup(
        children: [
          FTile(title: const Text('Group 1'), onPress: () {}),
          FTile(title: const Text('Group 2'), onPress: () {}),
        ],
      ),
    ],
    builder: (_, controller, _) => FTile(title: const Text('Tap me'), onPress: controller.toggle),
  );
}

void main() {
  testWidgets('leaky inherited FItemData does not affect popover with items', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FItemGroup(children: const [PopoverItem(key: key)]),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
  });

  testWidgets('leaky inherited FItemData does not affect popover with tiles', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FTileGroup(children: const [PopoverTile(key: key)]),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(tester.takeException(), null);
  });

  testWidgets('tap outside hides popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopoverMenu.tiles(
          menu: [
            FTileGroup(
              children: [FTile(title: const Text('Group 1'), onPress: () {})],
            ),
            FTileGroup(
              children: [FTile(title: const Text('Group 2'), onPress: () {})],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);

    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsNothing);
  });

  testWidgets('tap outside does not hide popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopoverMenu.tiles(
          hideRegion: FPopoverHideRegion.none,
          menu: [
            FTileGroup(
              children: [FTile(title: const Text('Group 1'), onPress: () {})],
            ),
            FTileGroup(
              children: [FTile(title: const Text('Group 2'), onPress: () {})],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);

    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);
  });

  testWidgets('tap button when popover is open closes it', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopoverMenu.tiles(
          menu: [
            FTileGroup(
              children: [FTile(title: const Text('Group 1'), onPress: () {})],
            ),
            FTileGroup(
              children: [FTile(title: const Text('Group 2'), onPress: () {})],
            ),
          ],
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsOneWidget);

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('Group 1'), findsNothing);
  });
}

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  late FPopoverController controller;

  setUp(() => controller = FPopoverController(vsync: const TestVSync()));

  group('FPopover', () {
    testWidgets('tap outside hides popover', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopoverMenu(
            popoverController: controller,
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 1'),
                    onPress: () {},
                  ),
                ],
              ),
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 2'),
                    onPress: () {},
                  ),
                ],
              ),
            ],
            child: FButton(
              onPress: controller.toggle,
              label: const Text('target'),
            ),
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
          child: FPopoverMenu(
            popoverController: controller,
            hideOnTapOutside: false,
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 1'),
                    onPress: () {},
                  ),
                ],
              ),
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 2'),
                    onPress: () {},
                  ),
                ],
              ),
            ],
            child: FButton(
              onPress: controller.toggle,
              label: const Text('target'),
            ),
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
          child: FPopoverMenu(
            popoverController: controller,
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 1'),
                    onPress: () {},
                  ),
                ],
              ),
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 2'),
                    onPress: () {},
                  ),
                ],
              ),
            ],
            child: FButton(
              onPress: controller.toggle,
              label: const Text('target'),
            ),
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
  });

  group('FPopover.tappable', () {
    testWidgets('shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopoverMenu.automatic(
            menu: [
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 1'),
                    onPress: () {},
                  ),
                ],
              ),
              FTileGroup(
                children: [
                  FTile(
                    title: const Text('Group 2'),
                    onPress: () {},
                  ),
                ],
              ),
            ],
            child: Container(
              color: Colors.black,
              height: 10,
              width: 10,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Container).last);
      await tester.pumpAndSettle();

      expect(find.text('Group 1'), findsOneWidget);
    });
  });
}

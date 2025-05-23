// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FPopoverController controller;

  setUp(() => controller = FPopoverController(vsync: const TestVSync()));

  tearDown(() => controller.dispose());

  group('FPopover', () {
    testWidgets('tap outside hides popover', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopoverMenu(
            popoverController: controller,
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
              FTileGroup(
                children: [FTile(title: const Text('Group 2'), onPress: () {})],
              ),
            ],
            child: FButton(onPress: controller.toggle, child: const Text('target')),
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
            hideOnTapOutside: FHidePopoverRegion.none,
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
              FTileGroup(
                children: [FTile(title: const Text('Group 2'), onPress: () {})],
              ),
            ],
            child: FButton(onPress: controller.toggle, child: const Text('target')),
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
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
              FTileGroup(
                children: [FTile(title: const Text('Group 2'), onPress: () {})],
              ),
            ],
            child: FButton(onPress: controller.toggle, child: const Text('target')),
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

  group('FPopover.automatic', () {
    testWidgets('shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopoverMenu.automatic(
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
              FTileGroup(
                children: [FTile(title: const Text('Group 2'), onPress: () {})],
              ),
            ],
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      await tester.tap(find.byType(Container).last);
      await tester.pumpAndSettle();

      expect(find.text('Group 1'), findsOneWidget);
    });
  });

  group('state', () {
    testWidgets('update controller', (tester) async {
      final first = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FPopoverMenu(
            popoverController: first,
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
            ],
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      expect(first.hasListeners, false);
      expect(first.disposed, false);

      final second = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FPopoverMenu(
            popoverController: second,
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
            ],
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      expect(first.hasListeners, false);
      expect(first.disposed, false);
      expect(second.hasListeners, false);
      expect(second.disposed, false);
    });

    testWidgets('dispose controller', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FPopoverMenu(
            popoverController: controller,
            menu: [
              FTileGroup(
                children: [FTile(title: const Text('Group 1'), onPress: () {})],
              ),
            ],
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);

      await tester.pumpWidget(TestScaffold(child: const SizedBox()));

      expect(controller.hasListeners, false);
      expect(controller.disposed, false);
    });
  });
}

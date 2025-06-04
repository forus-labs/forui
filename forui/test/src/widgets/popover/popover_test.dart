// ignore_for_file: invalid_use_of_protected_member

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  testWidgets('barrier blocks taps', (tester) async {
    var outside = 0;

    await tester.pumpWidget(
      TestScaffold.app(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FPopover(
              style: FThemes.zinc.light.popoverStyle.copyWith(
                barrierFilter: (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
              ),
              popoverBuilder: (context, _) => const Text('popover'),
              builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
            ),
            const SizedBox(height: 10),
            FButton(onPress: () => outside++, child: const Text('outside')),
          ],
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tap(find.text('outside'));
    await tester.pumpAndSettle();

    expect(outside, 0);
  });

  testWidgets('tap outside hides popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsNothing);
  });

  testWidgets('tap outside does not hide popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          hideOnTapOutside: FHidePopoverRegion.none,
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => FButton(onPress: controller.toggle, child: const Text('target')),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);
  });

  testWidgets('tap button when popover is open and FHidePopoverRegion.excludeTarget remains open', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          hideOnTapOutside: FHidePopoverRegion.excludeTarget,
          popoverBuilder: (context, _) => const Text('popover'),
          builder: (_, controller, _) => Row(
            children: [
              const Text('other'),
              FButton(onPress: controller.toggle, child: const Text('target')),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tap(find.text('other'));
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsOneWidget);

    await tester.tapAt(Offset.zero);
    await tester.pumpAndSettle();

    expect(find.text('popover'), findsNothing);
  });

  testWidgets('tap button when popover is open and FHidePopoverRegion.anywhere closes it', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FPopover(
          popoverBuilder: (context, _) => const Text('follower'),
          builder: (_, controller, _) => Row(
            children: [
              const Text('other'),
              FButton(onPress: controller.toggle, child: const Text('target')),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('target'));
    await tester.pumpAndSettle();

    expect(find.text('follower'), findsOneWidget);

    await tester.tap(find.text('other'));
    await tester.pumpAndSettle();

    expect(find.text('follower'), findsNothing);
  });

  group('focus', () {
    testWidgets("focuses on popover's children", (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Column(
            children: [
              FPopover(
                popoverBuilder: (context, _) => Row(
                  children: [
                    FButton(onPress: () {}, child: const Text('1')),
                    FButton(onPress: () {}, child: const Text('2')),
                    FButton(onPress: () {}, child: const Text('3')),
                  ],
                ),
                builder: (_, controller, child) => GestureDetector(onTap: controller.toggle, child: child),
                child: Container(color: Colors.black, height: 10, width: 10),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FButton(onPress: () {}, child: const Text('Underneath')),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byType(Container).last);
      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      expect(Focus.of(tester.element(find.text('3'))).hasFocus, true);
    });
  });

  group('state', () {
    testWidgets('update controller', (tester) async {
      final first = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FPopover(
            controller: first,
            popoverBuilder: (_, _) => const SizedBox(),
            child: Container(color: Colors.black, height: 10, width: 10),
          ),
        ),
      );

      expect(first.hasListeners, false);
      expect(first.disposed, false);

      final second = autoDispose(FPopoverController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold(
          child: FPopover(
            controller: second,
            popoverBuilder: (_, _) => const SizedBox(),
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
          child: FPopover(
            controller: controller,
            popoverBuilder: (_, _) => const SizedBox(),
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

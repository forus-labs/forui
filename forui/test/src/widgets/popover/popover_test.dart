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
          child: FPopover(
            controller: controller,
            popoverBuilder: (context, style, _) => const Text('popover'),
            child: FButton(
              onPress: controller.toggle,
              label: const Text('target'),
            ),
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
            controller: controller,
            hideOnTapOutside: false,
            popoverBuilder: (context, style, _) => const Text('popover'),
            child: FButton(
              onPress: controller.toggle,
              label: const Text('target'),
            ),
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

    testWidgets('tap button when popover is open closes it', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            controller: controller,
            hideOnTapOutside: false,
            popoverBuilder: (context, style, _) => const Text('popover'),
            child: FButton(
              onPress: controller.toggle,
              label: const Text('target'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('target'));
      await tester.pumpAndSettle();

      expect(find.text('popover'), findsOneWidget);

      await tester.tap(find.text('target'));
      await tester.pumpAndSettle();

      expect(find.text('popover'), findsNothing);
    });
  });

  group('FPopover.tappable', () {
    testWidgets('shown', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover.automatic(
            controller: controller,
            popoverBuilder: (context, style, _) => const Text('popover'),
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

      expect(find.text('popover'), findsOneWidget);

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('popover'), findsNothing);
    });
  });

  tearDown(() => controller.dispose());
}

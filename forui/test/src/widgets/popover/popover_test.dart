import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPopover', () {
    testWidgets('tap outside hides popover', (tester) async {
      final controller = FPopoverController(vsync: const TestVSync());

      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: FPopover(
              controller: controller,
              follower: (context, style, _) => const Text('follower'),
              target: FButton(
                onPress: controller.toggle,
                label: const Text('target'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('target'));
      await tester.pumpAndSettle();

      expect(find.text('follower'), findsOneWidget);

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('follower'), findsNothing);
    });

    testWidgets('tap outside does not hide popover', (tester) async {
      final controller = FPopoverController(vsync: const TestVSync());

      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: FPopover(
              controller: controller,
              hideOnTapOutside: false,
              follower: (context, style, _) => const Text('follower'),
              target: FButton(
                onPress: controller.toggle,
                label: const Text('target'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('target'));
      await tester.pumpAndSettle();

      expect(find.text('follower'), findsOneWidget);

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('follower'), findsOneWidget);
    });

    testWidgets('tap button when popover is open closes it', (tester) async {
      final controller = FPopoverController(vsync: const TestVSync());

      await tester.pumpWidget(
        MaterialApp(
          home: TestScaffold(
            data: FThemes.zinc.light,
            child: FPopover(
              controller: controller,
              hideOnTapOutside: false,
              follower: (context, style, _) => const Text('follower'),
              target: FButton(
                onPress: controller.toggle,
                label: const Text('target'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('target'));
      await tester.pumpAndSettle();

      expect(find.text('follower'), findsOneWidget);

      await tester.tap(find.text('target'));
      await tester.pumpAndSettle();

      expect(find.text('follower'), findsNothing);
    });

    testWidgets('', (tester) async {

    });
  });
}

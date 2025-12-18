import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  tearDown(() {
    FTouch.primary = null;
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} hidden ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopover(
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/hidden-${theme.name}.png'));
    });

    testWidgets('${theme.name} shown on touch device', (tester) async {
      FTouch.primary = true;

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopover(
            control: const .managed(initial: true),
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/shown-touch-device-${theme.name}.png'));
    });

    testWidgets('${theme.name} shown on non-touch device', (tester) async {
      FTouch.primary = false;

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopover(
            control: const .managed(initial: true),
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('popover/shown-non-touch-device-${theme.name}.png'),
      );
    });

    testWidgets('${theme.name} with barrier', (tester) async {
      FTouch.primary = false;

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopover(
            control: const .managed(initial: true),
            style: theme.data.popoverStyle.copyWith(
              barrierFilter: (animation) => .blur(sigmaX: animation * 5, sigmaY: animation * 5),
            ),
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/barrier-${theme.name}.png'));
    });

    testWidgets('${theme.name} glassmorphic', (tester) async {
      final controller = autoDispose(FPopoverController(shown: true, vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              FButton(onPress: controller.toggle, child: const Text('Toggle Popover')),
              FPopover(
                control: .managed(controller: controller),
                style: theme.data.popoverStyle.copyWith(
                  backgroundFilter: (v) => .blur(sigmaX: v * 5, sigmaY: v * 5),
                  decoration: BoxDecoration(
                    color: theme.data.colors.background.withValues(alpha: 0.5),
                    borderRadius: theme.data.style.borderRadius,
                    border: .all(width: theme.data.style.borderWidth, color: theme.data.colors.border),
                  ),
                ),
                popoverBuilder: (_, _) => const SizedBox.square(dimension: 100),
                child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/glassmorphic-${theme.name}.png'));
    });
  }
}

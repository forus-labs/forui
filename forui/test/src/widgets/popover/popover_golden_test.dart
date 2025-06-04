import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FPopoverController controller;

  setUp(() => controller = FPopoverController(vsync: const TestVSync()));

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} hidden ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopover(
            controller: controller,
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
            controller: controller,
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/shown-touch-device-${theme.name}.png'));
    });

    testWidgets('${theme.name} shown on non-touch device', (tester) async {
      FTouch.primary = false;

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FPopover(
            controller: controller,
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      unawaited(controller.show());
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
            controller: controller,
            style: theme.data.popoverStyle.copyWith(
              barrierFilter: (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
            ),
            popoverBuilder: (context, _) => const SizedBox.square(dimension: 100),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/barrier-${theme.name}.png'));
    });
  }

  tearDown(() {
    FTouch.primary = null;
    controller.dispose();
  });
}

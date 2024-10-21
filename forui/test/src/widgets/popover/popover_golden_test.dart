@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/touch.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (name, theme, background) in TestScaffold.themes) {
    group('FPopover', () {
      testWidgets('$name hidden ', (tester) async {
        final controller = FPopoverController(vsync: const TestVSync());

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            background: background,
            child: FPopover(
              controller: controller,
              followerBuilder: (context, style, _) => const SizedBox.square(dimension: 100),
              target: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 100,
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/hidden-$name.png'));
      });

      testWidgets('$name shown on touch device', (tester) async {
        Touch.primary = true;
        final controller = FPopoverController(vsync: const TestVSync());

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            background: background,
            child: FPopover(
              controller: controller,
              followerBuilder: (context, style, _) => const SizedBox.square(dimension: 100),
              target: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 100,
                ),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/shown-touch-device-$name.png'));
      });

      testWidgets('$name shown on non-touch device', (tester) async {
        Touch.primary = false;
        final controller = FPopoverController(vsync: const TestVSync());

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
            background: background,
            child: FPopover(
              controller: controller,
              followerBuilder: (context, style, _) => const SizedBox.square(dimension: 100),
              target: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 100,
                ),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/shown-non-touch-device-$name.png'));
      });

      tearDown(() => Touch.primary = null);
    });
  }
}

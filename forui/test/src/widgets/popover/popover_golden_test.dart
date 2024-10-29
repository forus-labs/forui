@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import '../../test_scaffold.dart';

void main() {
  late FPopoverController controller;

  setUp(() => controller = FPopoverController(vsync: const TestVSync()));

  for (final (themeName, theme) in TestScaffold.themes) {
    group('FPopover', () {
      testWidgets('$themeName hidden ', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/hidden-$themeName.png'));
      });

      testWidgets('$themeName shown on touch device', (tester) async {
        Touch.primary = true;

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/shown-touch-device-$themeName.png'));
      });

      testWidgets('$themeName shown on non-touch device', (tester) async {
        Touch.primary = false;

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/shown-non-touch-device-$themeName.png'));
      });
    });
  }

  tearDown(() {
    Touch.primary = null;
    controller.dispose();
  });
}

@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (name, theme, _) in TestScaffold.themes) {
    group('FPopover', () {
      testWidgets('$name hidden ', (tester) async {
        final controller = FPopoverController(vsync: const TestVSync());

        await tester.pumpWidget(
          MaterialApp(
            home: TestScaffold(
              data: theme,
              child: FPopover(
                controller: controller,
                follower: (context, style, _) => const SizedBox.square(dimension: 100),
                target: const ColoredBox(
                  color: Colors.yellow,
                  child: SizedBox.square(
                    dimension: 100,
                  ),
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover/$name-hidden.png'));
      });

      testWidgets('$name shown', (tester) async {
        final controller = FPopoverController(vsync: const TestVSync());

        await tester.pumpWidget(
          MaterialApp(
            home: TestScaffold(
              data: theme,
              child: FPopover(
                controller: controller,
                follower: (context, style, _) => const SizedBox.square(dimension: 100),
                target: const ColoredBox(
                  color: Colors.yellow,
                  child: SizedBox.square(
                    dimension: 100,
                  ),
                ),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(find.byType(MaterialApp), matchesGoldenFile('popover/$name-shown.png'));
      });
    });
  }
}

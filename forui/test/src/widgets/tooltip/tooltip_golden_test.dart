@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final (name, theme, _) in TestScaffold.themes) {
    group('FTooltip', () {
      testWidgets('$name hidden ', (tester) async {
        final controller = FTooltipController(vsync: const TestVSync());

        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            child: FTooltip(
              controller: controller,
              tipBuilder: (context, style, _) => const Text('Lorem'),
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 100,
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/$name-hidden.png'));
      });

      testWidgets('$name shown', (tester) async {
        final controller = FTooltipController(vsync: const TestVSync());

        await tester.pumpWidget(
          TestScaffold(
            data: theme,
            child: FTooltip(
              controller: controller,
              tipBuilder: (context, style, _) => const Text('Lorem'),
              child: const ColoredBox(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/$name-shown.png'));
      });
    });
  }
}

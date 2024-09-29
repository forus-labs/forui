@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
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
          TestScaffold.app(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/hidden-$name.png'));
      });

      testWidgets('$name shown on touch devices', (tester) async {
        final controller = FTooltipController(vsync: const TestVSync());

        await tester.pumpWidget(
          TestScaffold.app(
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

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(ColoredBox).first));
        await tester.pumpAndSettle(const Duration(seconds: 5));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/shown-$name.png'));
      });
    });
  }
}

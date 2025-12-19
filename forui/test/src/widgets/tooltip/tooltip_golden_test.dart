import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} hidden ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTooltip(
            tipBuilder: (context, _) => const Text('Lorem'),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/${theme.name}-hidden.png'));
    });

    testWidgets('${theme.name} shown on touch devices', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTooltip(
            tipBuilder: (context, _) => const Text('Lorem'),
            child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(ColoredBox).first));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/${theme.name}-shown.png'));
    });

    testWidgets('${theme.name} glassmorphic ', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: Column(
            mainAxisSize: .min,
            spacing: 5,
            children: [
              const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              FTooltip(
                style: theme.data.tooltipStyle.copyWith(
                  backgroundFilter: .blur(sigmaX: 5, sigmaY: 5),
                  decoration: BoxDecoration(
                    color: theme.data.colors.background.withValues(alpha: 0.5),
                    borderRadius: theme.data.style.borderRadius,
                    border: .all(width: theme.data.style.borderWidth, color: theme.data.colors.border),
                  ),
                ),
                tipBuilder: (context, _) => const Text('Lorem'),
                child: const ColoredBox(color: Colors.yellow, child: SizedBox.square(dimension: 100)),
              ),
            ],
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(ColoredBox).first));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tooltip/${theme.name}-glassmorphic.png'));
    });
  }
}

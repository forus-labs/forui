import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTooltipController', () {
    testWidgets('toggle hides when forward', (tester) async {
      final controller = FTooltipController(vsync: tester);
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            control: .managed(controller: controller),
            tipBuilder: (_, _) => const Text('Tooltip'),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      unawaited(controller.show());
      await tester.pump();
      expect(controller.status, AnimationStatus.forward);

      unawaited(controller.toggle());
      await tester.pumpAndSettle();
      expect(controller.status, AnimationStatus.dismissed);
    });

    testWidgets('toggle shows when reverse', (tester) async {
      final controller = FTooltipController(vsync: tester, initial: 1.0);
      addTearDown(controller.dispose);

      await tester.pumpWidget(
        TestScaffold.app(
          child: FTooltip(
            control: .managed(controller: controller),
            tipBuilder: (_, _) => const Text('Tooltip'),
            child: const SizedBox.square(dimension: 100),
          ),
        ),
      );

      unawaited(controller.hide());
      await tester.pump();
      expect(controller.status, AnimationStatus.reverse);

      unawaited(controller.toggle());
      await tester.pumpAndSettle();
      expect(controller.status, AnimationStatus.completed);
    });
  });
}

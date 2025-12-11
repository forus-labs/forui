import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FPopoverController', () {
    testWidgets('toggle hides when forward', (tester) async {
      final controller = autoDispose(FPopoverController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const Text('Popover'),
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
      final controller = autoDispose(FPopoverController(vsync: tester, initial: 1.0));

      await tester.pumpWidget(
        TestScaffold.app(
          child: FPopover(
            control: .managed(controller: controller),
            popoverBuilder: (_, _) => const Text('Popover'),
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

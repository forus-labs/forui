import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  final key1 = UniqueKey();
  final key2 = UniqueKey();

  group('FSliderTooltipsController', () {
    late FSliderTooltipsController controller;
    late FTooltipController tooltip1;
    late FTooltipController tooltip2;

    group('enabled', () {
      setUp(() {
        controller = FSliderTooltipsController(enabled: true);
        tooltip1 = FTooltipController(vsync: const TestVSync());
        tooltip2 = FTooltipController(vsync: const TestVSync());

        controller
          ..add(key1, tooltip1)
          ..add(key2, tooltip2);
      });

      testWidgets('toggle', (tester) async {
        unawaited(controller.toggle());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, true);
        expect(tooltip2.status.isForwardOrCompleted, true);
      });

      testWidgets('toggle single', (tester) async {
        unawaited(controller.toggle(key1));
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, true);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('show', (tester) async {
        unawaited(controller.show());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, true);
        expect(tooltip2.status.isForwardOrCompleted, true);
      });

      testWidgets('show single', (tester) async {
        unawaited(controller.show(key1));
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, true);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('hide', (tester) async {
        unawaited(controller.show());
        await tester.pumpAndSettle();

        unawaited(controller.hide());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });
      testWidgets('hide single', (tester) async {
        unawaited(controller.show());
        await tester.pumpAndSettle();

        unawaited(controller.hide(key1));
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, true);
      });

      testWidgets('remove', (tester) async {
        controller.remove(key2);

        unawaited(controller.toggle());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, true);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });
    });

    group('disabled', () {
      setUp(() {
        controller = FSliderTooltipsController(enabled: false);
        tooltip1 = FTooltipController(vsync: const TestVSync());
        tooltip2 = FTooltipController(vsync: const TestVSync());

        controller
          ..add(key1, tooltip1)
          ..add(key2, tooltip2);
      });

      testWidgets('toggle', (tester) async {
        unawaited(controller.toggle());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('toggle single', (tester) async {
        unawaited(controller.toggle(key1));
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('show', (tester) async {
        unawaited(controller.show());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('show single', (tester) async {
        unawaited(controller.show(key1));
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('hide', (tester) async {
        unawaited(controller.hide());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('hide single', (tester) async {
        unawaited(controller.hide(key1));
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });

      testWidgets('remove', (tester) async {
        controller.remove(key2);

        unawaited(controller.toggle());
        await tester.pumpAndSettle();

        expect(tooltip1.status.isForwardOrCompleted, false);
        expect(tooltip2.status.isForwardOrCompleted, false);
      });
    });
  });
}

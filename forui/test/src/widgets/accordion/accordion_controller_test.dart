import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/accordion/accordion_controller.dart';
import '../../test_scaffold.dart';

void main() {
  late FAccordionController controller;
  late AnimationController first;
  late AnimationController second;
  int count = 0;

  setUp(() {
    count = 0;
    controller = FAccordionController(max: 2)..addListener(() => count++);
    first = AnimationController(vsync: const TestVSync());
    second = AnimationController(vsync: const TestVSync());
  });

  tearDown(() {
    controller.dispose();
    first.dispose();
    second.dispose();
  });

  group('add(...)', () {
    test('expanded', () {
      first.value = 1;

      expect(controller.add(2, first), true);
      expect(controller.controllers.length, 1);
      expect(controller.expanded.length, 1);
    });

    test('not expanded', () {
      expect(controller.add(2, first), true);
      expect(controller.controllers.length, 1);
      expect(controller.expanded.length, 0);
    });

    test('over max - expanded', () {
      final controller = FAccordionController(max: 0);
      first.value = 1;

      expect(controller.add(2, first), false);
      expect(controller.controllers.length, 0);
      expect(controller.expanded.length, 0);
    });

    test('over max - not expanded', () {
      final controller = FAccordionController(max: 0);

      expect(controller.add(2, first), true);
      expect(controller.controllers.length, 1);
      expect(controller.expanded.length, 0);
    });
  });

  group('remove(...)', () {
    test('unknown index', () {
      first.value = 1;
      final controller = FAccordionController()..add(2, first);

      expect(controller.remove(3), false);
      expect(controller.controllers.length, 1);
      expect(controller.expanded.length, 1);
    });

    test('expanded', () {
      first.value = 1;
      final controller = FAccordionController()..add(2, first);

      expect(controller.remove(2), true);
      expect(controller.controllers.length, 0);
      expect(controller.expanded.length, 0);
    });

    test('not expanded', () {
      final controller = FAccordionController()..add(2, first);

      expect(controller.remove(2), true);
      expect(controller.controllers.length, 0);
      expect(controller.expanded.length, 0);
    });

    test('under min - expanded', () {
      first.value = 1;
      final controller = FAccordionController(min: 1)..add(2, first);

      expect(controller.remove(2), false);
      expect(controller.controllers.length, 1);
      expect(controller.expanded.length, 1);
    });

    test('under min - not expanded', () {
      final controller = FAccordionController(min: 1)..add(2, first);

      expect(controller.remove(2), true);
      expect(controller.controllers.length, 0);
      expect(controller.expanded.length, 0);
    });
  });

  group('expand(...)', () {
    test('unknown index', () async {
      controller.add(2, first);

      expect(await controller.expand(3), false);
      expect(first.value, 0);
      expect(count, 0);
    });

    test('already expanded', () async {
      first.value = 1;
      controller.add(2, first);

      expect(await controller.expand(2), true);
      expect(first.value, 1);
      expect(count, 0);
    });

    test('max reached, cannot collapse', () async {
      final controller = FAccordionController(max: 0)..add(2, first);

      expect(await controller.expand(2), false);
      expect(first.value, 0);
      expect(count, 0);
    });

    testWidgets('max reached, collapse existing', (tester) async {
      first.duration = const Duration(milliseconds: 1);
      second
        ..duration = const Duration(milliseconds: 1)
        ..value = 1;

      final controller = autoDispose(FAccordionController(min: 1, max: 1))
        ..addListener(() => count++)
        ..add(0, first)
        ..add(1, second);

      final future = controller.expand(0);
      await tester.pumpAndSettle();

      expect(await future, true);
      expect(first.value, 1);
      expect(second.value, 0);
      expect(count, 1);
    });

    testWidgets('collapsed', (tester) async {
      first.duration = const Duration(milliseconds: 1);
      controller.add(2, first);

      final future = controller.expand(2);
      await tester.pumpAndSettle();

      expect(await future, true);
      expect(first.value, 1);
      expect(count, 1);
    });
  });

  group('collapse(...)', () {
    test('unknown index', () async {
      first.value = 1;
      controller.add(2, first);

      expect(await controller.collapse(0), false);
      expect(first.value, 1);
      expect(count, 0);
    });

    test('already collapsed', () async {
      first.value = 0;
      controller.add(2, first);

      expect(await controller.collapse(2), true);
      expect(first.value, 0);
      expect(count, 0);
    });

    test('under min', () async {
      first.value = 1;
      final controller = FAccordionController(min: 1)
        ..addListener(() => count++)
        ..add(2, first);

      expect(await controller.collapse(2), false);
      expect(first.value, 1);
      expect(count, 0);
    });

    testWidgets('expanded', (tester) async {
      first
        ..value = 1
        ..duration = const Duration(milliseconds: 1);

      controller.add(2, first);

      final future = controller.collapse(2);
      await tester.pumpAndSettle();

      expect(await future, true);
      expect(first.value, 0);
      expect(count, 1);
    });
  });
}

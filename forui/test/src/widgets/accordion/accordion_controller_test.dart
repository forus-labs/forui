import 'package:flutter/animation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:forui/forui.dart';
import 'accordion_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AnimationController>()])
@GenerateNiceMocks([MockSpec<Animation>()])
void main() {
  group('FAccordionController', () {
    late FAccordionController controller;
    late AnimationController animationController;
    late Animation<int> animation;
    int count = 0;

    setUp(() {
      count = 0;
      animationController = MockAnimationController();
      animation = Tween(begin: 0, end: 100).animate(animationController);
      when(animationController.forward()).thenAnswer((_) {
        when(animationController.value).thenReturn(1.0);
        return TickerFuture.complete();
      });
      when(animationController.reverse()).thenAnswer((_) {
        when(animationController.value).thenReturn(0.0);
        return TickerFuture.complete();
      });

      controller = FAccordionController(min: 1, max: 3)
        ..addListener(() {
          count++;
        });
    });

    tearDown(() {
      animationController.dispose();
      controller.dispose();
    });

    test('addItem(...)', () {
      controller.addItem(0, animationController, animation, initiallyExpanded: false);
      expect(controller.expanded.length, 0);
      controller.addItem(0, animationController, animation, initiallyExpanded: true);
      expect(controller.expanded.length, 1);

      controller.addItem(0, animationController, animation, initiallyExpanded: true);
      expect(controller.expanded.length, 1);

      controller
        ..addItem(1, animationController, animation, initiallyExpanded: true)
        ..addItem(2, animationController, animation, initiallyExpanded: true)
        ..addItem(3, animationController, animation, initiallyExpanded: true);
      expect(controller.expanded.length, 3);
      expect(controller.expanded.last, 2);

      controller.addItem(3, animationController, animation, initiallyExpanded: false);
      expect(controller.expanded.length, 3);
      expect(controller.controllers.length, 4);
    });

    test('removeItem(...)', () {
      controller
        ..addItem(0, animationController, animation, initiallyExpanded: true)
        ..addItem(1, animationController, animation, initiallyExpanded: false)
        ..addItem(2, animationController, animation, initiallyExpanded: true)
        ..addItem(3, animationController, animation, initiallyExpanded: true);
      expect(controller.removeItem(0), true);
      expect(controller.removeItem(4), false);
      expect(controller.removeItem(1), true);
      expect(controller.expanded.contains(1), false);
      expect(controller.removeItem(2), true);
    });

    test('toggle(...)', () async {
      await animationController.forward();
      controller.addItem(0, animationController, animation, initiallyExpanded: true);
      await controller.toggle(0);
      expect(controller.controllers[0]?.animation.value, 100);
      controller.addItem(1, animationController, animation, initiallyExpanded: true);
      await controller.toggle(0);
      expect(controller.controllers[0]?.animation.value, 0);
    });

    test('expand(...)', () async {
      controller
        ..addItem(0, animationController, animation, initiallyExpanded: false)
        ..addItem(1, animationController, animation, initiallyExpanded: false)
        ..addItem(2, animationController, animation, initiallyExpanded: false)
        ..addItem(3, animationController, animation, initiallyExpanded: true);
      await controller.expand(0);
      expect(controller.expanded, {3, 0});
      await controller.expand(0);
      expect(count, 1);
      await controller.expand(1);
      await controller.expand(2);
      expect(controller.expanded, {0, 1, 2});
    });

    test('collapse(...)', () async {
      controller
        ..addItem(0, animationController, animation, initiallyExpanded: false)
        ..addItem(1, animationController, animation, initiallyExpanded: false)
        ..addItem(2, animationController, animation, initiallyExpanded: false)
        ..addItem(3, animationController, animation, initiallyExpanded: true);
      await controller.collapse(3);
      expect(controller.expanded.contains(3), true);
      expect(count, 0);
      await controller.expand(0);
      await controller.collapse(3);
      await controller.collapse(2);
      expect(count, 2);
      await controller.collapse(0);
      expect(controller.expanded, {0});
    });

    // TODO: needs rework
    test('validate(...)', () {
      expect(controller.validate(controller.expanded.length), false);

      controller.addItem(0, animationController, animation, initiallyExpanded: true);
      expect(controller.validate(controller.expanded.length), true);

      controller
        ..addItem(1, animationController, animation, initiallyExpanded: true)
        ..addItem(2, animationController, animation, initiallyExpanded: true);
      expect(controller.validate(controller.expanded.length), true);

      controller.addItem(3, animationController, animation, initiallyExpanded: true);
      expect(controller.validate(controller.expanded.length), true);
    });
  });

  group('FAccordionController.radio', () {
    late FAccordionController controller;
    final List<AnimationController> animationControllers = [];
    final List<Animation<int>> animations = [];
    int count = 0;

    setUp(() {
      count = 0;
      animations.clear();
      animationControllers.clear();

      for (int i = 0; i < 4; i++) {
        animationControllers.add(MockAnimationController());
        animations.add(Tween(begin: 0, end: 100).animate(animationControllers[i]));
        when(animationControllers[i].forward()).thenAnswer((_) {
          when(animationControllers[i].value).thenReturn(1.0);
          return TickerFuture.complete();
        });
        when(animationControllers[i].reverse()).thenAnswer((_) {
          when(animationControllers[i].value).thenReturn(0.0);
          return TickerFuture.complete();
        });
      }

      controller = FAccordionController.radio()
        ..addListener(() {
          count++;
        });
    });

    tearDown(() {
      for (int i = 0; i < 4; i++) {
        animationControllers[i].dispose();
      }
      controller.dispose();
    });

    test('addItem(...)', () {
      controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
      expect(controller.expanded.length, 0);
      expect(controller.controllers.length, 1);
      controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
      expect(controller.expanded.length, 1);
      expect(controller.controllers.length, 1);

      controller
        ..addItem(1, animationControllers[1], animations[1], initiallyExpanded: true)
        ..addItem(2, animationControllers[2], animations[2], initiallyExpanded: true)
        ..addItem(3, animationControllers[3], animations[3], initiallyExpanded: true);
      expect(controller.expanded.length, 1);

      // addItem() doesn't know if the total length of initialExpanded items is within the allowed range
      expect(controller.expanded, {3});
    });

    test('removeItem(...)', () {
      controller
        ..addItem(0, animationControllers[0], animations[0], initiallyExpanded: true)
        ..addItem(1, animationControllers[1], animations[1], initiallyExpanded: false)
        ..addItem(2, animationControllers[2], animations[2], initiallyExpanded: true)
        ..addItem(3, animationControllers[3], animations[3], initiallyExpanded: true);
      expect(controller.removeItem(0), true);
      expect(controller.removeItem(4), false);
      expect(controller.removeItem(1), true);
      expect(controller.expanded.contains(1), false);
      expect(controller.removeItem(2), true);

      // removeItem() doesn't know if the total length of initialExpanded items is within the allowed range
    });

    test('toggle(...)', () async {
      controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
      await controller.toggle(0);
      expect(controller.controllers[0]?.animation.value, 100);
      await controller.toggle(1);
      expect(count, 1);

      controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: false);

      await controller.toggle(1);
      expect(controller.controllers[0]?.animation.value, 0);
    });

    test('expand(...)', () async {
      controller
        ..addItem(0, animationControllers[0], animations[0], initiallyExpanded: false)
        ..addItem(1, animationControllers[1], animations[1], initiallyExpanded: false)
        ..addItem(2, animationControllers[2], animations[2], initiallyExpanded: false)
        ..addItem(3, animationControllers[3], animations[3], initiallyExpanded: true);
      await controller.expand(0);
      expect(controller.expanded, {0});
      await controller.expand(0);
      expect(count, 1);
      await controller.expand(1);
      await controller.expand(2);
      expect(controller.expanded, {2});
    });

    test('collapse(...)', () async {
      controller
        ..addItem(0, animationControllers[0], animations[0], initiallyExpanded: false)
        ..addItem(1, animationControllers[1], animations[1], initiallyExpanded: false)
        ..addItem(2, animationControllers[2], animations[2], initiallyExpanded: false)
        ..addItem(3, animationControllers[3], animations[3], initiallyExpanded: true);
      await controller.collapse(3);
      expect(controller.expanded.isEmpty, true);
      await controller.expand(0);
      await controller.collapse(3);
      await controller.collapse(2);
      expect(count, 2);
      expect(controller.expanded, {0});
    });

    // TODO: needs rework
    test('validate(...)', () {});
  });
}

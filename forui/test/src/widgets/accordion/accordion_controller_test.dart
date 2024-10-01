import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:forui/forui.dart';
import 'accordion_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AnimationController>()])
@GenerateNiceMocks([MockSpec<Animation>()])
void _setup(List<AnimationController> animationControllers, List<Animation<int>> animations, int length) {
  animations.clear();
  animationControllers.clear();

  for (int i = 0; i < length; i++) {
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
}

void _tearDown(List<AnimationController> animationControllers, length) {
  for (int i = 0; i < length; i++) {
    animationControllers[i].dispose();
  }
}

void main() {
  group('FAccordionController', () {
    late FAccordionController controller;
    final List<AnimationController> animationControllers = [];
    final List<Animation<int>> animations = [];
    int count = 0;
    int length = 3;

    setUp(() {
      count = 0;
      length = 3;
      _setup(animationControllers, animations, length);
      controller = FAccordionController(min: 1, max: 2)
        ..addListener(() {
          count++;
        });
    });

    tearDown(() {
      _tearDown(animationControllers, length);
      controller.dispose();
    });

    group('addItem(...)', () {
      test('sets animation controller value based on initiallyExpanded', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        verify(animationControllers[0].value = 0);
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        verify(animationControllers[0].value = 1);
      });

      test('adds to expanded list', () {
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        expect(controller.expanded.length, 0);
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        expect(controller.expanded.length, 1);
        expect(controller.controllers.length, 1);
      });

      test('aware of max limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: true);
        await controller.addItem(2, animationControllers[2], animations[2], initiallyExpanded: true);
        expect(controller.expanded, {1, 2});
      });
    });

    group('removeItem(...)', () {
      setUp(() {
        length = 1;
        _setup(animationControllers, animations, length);
        controller = FAccordionController(min: 1, max: 2)
          ..addListener(() {
            count++;
          });
      });

      tearDown(() {
        _tearDown(animationControllers, length);
      });
      test('removes from the expanded list', () {
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        expect(controller.removeItem(0), true);
        expect(controller.removeItem(0), false);
      });
      test('aware of min limit', () {
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        expect(controller.removeItem(0), false);
      });
    });

    group('toggle(...)', () {
      test('expands an item', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        expect(controller.controllers[0]?.animation.value, 0);
        await controller.toggle(0);
        expect(controller.controllers[0]?.animation.value, 100);
      });

      test('collapses an item', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: true);
        await animationControllers[0].forward();
        expect(controller.controllers[0]?.animation.value, 100);
        await controller.toggle(0);
        expect(controller.controllers[0]?.animation.value, 0);
      });

      test('invalid index', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        await controller.toggle(1);
        expect(count, 0);
        await controller.toggle(0);
        expect(count, 1);
      });

      test('aware of max limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: true);
        await controller.addItem(2, animationControllers[2], animations[2], initiallyExpanded: false);
        await animationControllers[0].forward();
        await animationControllers[1].forward();
        expect(controller.controllers[0]?.animation.value, 100);
        expect(controller.controllers[1]?.animation.value, 100);

        await controller.toggle(2);
        expect(controller.controllers[0]?.animation.value, 0);
      });

      test('aware of min limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: false);
        await controller.addItem(2, animationControllers[2], animations[2], initiallyExpanded: true);
        await animationControllers[2].forward();
        expect(controller.controllers[2]?.animation.value, 100);

        await controller.toggle(2);
        expect(controller.controllers[2]?.animation.value, 100);
      });
    });

    group('expand(...)', () {
      test('does not call notifyListener on invalid index', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        await controller.expand(0);
        expect(controller.expanded, {0});
        await controller.expand(0);
        expect(count, 1);
        await controller.expand(1);
        expect(count, 1);
      });

      test('aware of max limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: true);
        await controller.addItem(2, animationControllers[2], animations[2], initiallyExpanded: false);
        await controller.expand(2);
        expect(controller.expanded, {1, 2});
      });
    });

    group('collapse(...)', () {
      setUp(() {
        length = 2;
        _setup(animationControllers, animations, length);
        controller = FAccordionController(min: 1, max: 2)
          ..addListener(() {
            count++;
          });
      });

      tearDown(() {
        _tearDown(animationControllers, length);
      });

      test('does not call notifyListener on invalid index', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: true);
        await controller.collapse(0);
        expect(controller.expanded, {1});
        await controller.collapse(0);
        expect(count, 1);
        await controller.collapse(2);
        expect(count, 1);
      });

      test('aware of min limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.collapse(0);
        expect(controller.expanded, {0});
      });
    });

    test('validate(...)', () {
      expect(controller.validate(0), false);
      expect(controller.validate(1), true);
      expect(controller.validate(2), true);
      expect(controller.validate(3), false);
    });
  });

  group('FAccordionController.radio', () {
    late FAccordionController controller;
    final List<AnimationController> animationControllers = [];
    final List<Animation<int>> animations = [];
    int count = 0;
    int length = 2;

    setUp(() {
      count = 0;
      length = 2;
      _setup(animationControllers, animations, length);
      controller = FAccordionController.radio()
        ..addListener(() {
          count++;
        });
    });

    tearDown(() {
      _tearDown(animationControllers, length);
      controller.dispose();
    });

    group('addItem(...)', () {
      test('adds to expanded list', () {
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        expect(controller.expanded.length, 0);
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        expect(controller.expanded.length, 1);
        expect(controller.controllers.length, 1);
      });
      test('aware of max limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: true);
        expect(controller.expanded, {1});
      });
    });

    group('removeItem(...)', () {
      setUp(() {
        length = 1;
        _setup(animationControllers, animations, length);
        controller = FAccordionController.radio()
          ..addListener(() {
            count++;
          });
      });

      tearDown(() {
        _tearDown(animationControllers, length);
      });

      test('removes from the expanded list', () {
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        expect(controller.removeItem(0), true);
        expect(controller.removeItem(0), false);
      });
      test('aware of min limit', () {
        controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        expect(controller.removeItem(0), true);
      });
    });

    group('toggle(...)', () {
      test('expands an item', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        expect(controller.controllers[0]?.animation.value, 0);
        await controller.toggle(0);
        expect(controller.controllers[0]?.animation.value, 100);
      });

      test('collapses an item', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await animationControllers[0].forward();
        expect(controller.controllers[0]?.animation.value, 100);
        await controller.toggle(0);
        expect(controller.controllers[0]?.animation.value, 0);
      });

      test('invalid index', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        await controller.toggle(1);
        expect(count, 0);
        await controller.toggle(0);
        expect(count, 1);
      });

      test('aware of max limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: false);
        await animationControllers[0].forward();
        expect(controller.controllers[0]?.animation.value, 100);

        await controller.toggle(1);
        expect(controller.controllers[0]?.animation.value, 0);
      });

      test('aware of min limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await animationControllers[0].forward();
        expect(controller.controllers[0]?.animation.value, 100);

        await controller.toggle(0);
        expect(controller.controllers[0]?.animation.value, 0);
      });
    });

    group('expand(...)', () {
      test('does not call notifyListener on invalid index', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.expand(0);
        expect(count, 0);

        await controller.expand(1);
        expect(count, 0);
      });

      test('aware of max limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.addItem(1, animationControllers[1], animations[1], initiallyExpanded: false);
        await controller.expand(1);
        expect(controller.expanded, {1});
      });
    });

    group('collapse(...)', () {
      test('does not call notifyListener on invalid index', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: false);
        await controller.collapse(0);
        expect(count, 0);
      });

      test('aware of min limit', () async {
        await controller.addItem(0, animationControllers[0], animations[0], initiallyExpanded: true);
        await controller.collapse(0);
        expect(controller.expanded.isEmpty, true);
      });
    });

    test('validate(...)', () {
      expect(controller.validate(0), true);
      expect(controller.validate(1), true);
      expect(controller.validate(2), false);
    });
  });
}

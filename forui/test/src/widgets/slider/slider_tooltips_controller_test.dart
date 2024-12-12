import 'package:flutter/cupertino.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'slider_tooltips_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FTooltipController>()])
void main() {
  final key1 = UniqueKey();
  final key2 = UniqueKey();

  group('FSliderTooltipsController', () {
    late FSliderTooltipsController controller;
    late MockFTooltipController tooltip1;
    late MockFTooltipController tooltip2;

    group('enabled', () {
      setUp(() {
        controller = FSliderTooltipsController(enabled: true);
        tooltip1 = MockFTooltipController();
        tooltip2 = MockFTooltipController();

        controller
          ..add(key1, tooltip1)
          ..add(key2, tooltip2);
      });

      test('toggle', () {
        controller.toggle();

        verify(tooltip1.toggle()).called(1);
        verify(tooltip2.toggle()).called(1);
      });

      test('toggle single', () {
        controller.toggle(key1);

        verify(tooltip1.toggle()).called(1);
        verifyNever(tooltip2.toggle());
      });

      test('show', () {
        controller.show();

        verify(tooltip1.show()).called(1);
        verify(tooltip2.show()).called(1);
      });

      test('show single', () {
        controller.show(key1);

        verify(tooltip1.show()).called(1);
        verifyNever(tooltip2.show());
      });

      test('hide', () {
        controller.hide();

        verify(tooltip1.hide()).called(1);
        verify(tooltip2.hide()).called(1);
      });

      test('hide single', () {
        controller.hide(key1);

        verify(tooltip1.hide()).called(1);
        verifyNever(tooltip2.hide());
      });

      test('remove', () {
        controller
          ..remove(key2)
          ..toggle();

        verify(tooltip1.toggle()).called(1);
        verifyNever(tooltip2.toggle());
      });
    });

    group('disabled', () {
      setUp(() {
        controller = FSliderTooltipsController(enabled: false);
        tooltip1 = MockFTooltipController();
        tooltip2 = MockFTooltipController();

        controller
          ..add(key1, tooltip1)
          ..add(key2, tooltip2);
      });

      test('toggle', () {
        controller.toggle();

        verifyNever(tooltip1.toggle());
        verifyNever(tooltip2.toggle());
      });

      test('toggle single', () {
        controller.toggle(key1);

        verifyNever(tooltip1.toggle());
        verifyNever(tooltip2.toggle());
      });

      test('show', () {
        controller.show();

        verifyNever(tooltip1.show());
        verifyNever(tooltip2.show());
      });

      test('show single', () {
        controller.show(key1);

        verifyNever(tooltip1.show());
        verifyNever(tooltip2.show());
      });

      test('hide', () {
        controller.hide();

        verifyNever(tooltip1.hide());
        verifyNever(tooltip2.hide());
      });

      test('hide single', () {
        controller.hide(key1);

        verifyNever(tooltip1.hide());
        verifyNever(tooltip2.hide());
      });

      test('remove', () {
        controller
          ..remove(key2)
          ..toggle();

        verifyNever(tooltip1.toggle());
        verifyNever(tooltip2.toggle());
      });
    });
  });
}

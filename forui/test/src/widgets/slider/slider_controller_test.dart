import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  const marks = [
    FSliderMark(value: 0),
    FSliderMark(value: 0.25),
    FSliderMark(value: 0.5),
    FSliderMark(value: 0.6),
    FSliderMark(value: 0.75),
    FSliderMark(value: 1),
  ];

  for (final constructor in [
    (selection, [FSliderInteraction interaction = FSliderInteraction.tapAndSlideThumb, bool min = false]) =>
        FContinuousSliderController(selection: selection, interaction: interaction, minExtendable: min),
    (selection, [FSliderInteraction interaction = FSliderInteraction.tapAndSlideThumb, bool min = false]) =>
        FDiscreteSliderController(selection: selection, interaction: interaction, minExtendable: min),
  ]) {
    group('FSlider', () {
      final value = FSliderSelection(max: 0.75);
      final range = FSliderSelection(min: 0.25, max: 0.75);

      late FSliderController controller;

      setUp(() {
        controller = constructor(value);
      });

      group('attach', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..attach(1000, marks);

          expect(calls, 0);
          expect(controller.selection.constraints, (min: 0, max: 1));
          expect(controller.selection.pixelConstraints, (min: 0, max: 1000, total: 1000));
          expect((controller.selection.min, controller.selection.max), (0, 0.75));
          expect(controller.selection.pixels, (min: 0, max: 750));
        });

        test('existing selection', () {
          controller
            ..attach(1000, marks)
            ..step(min: false, extend: true);

          final selection = controller.selection;
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..attach(100, marks);

          expect(calls, 1);
          expect(controller.selection.constraints, (min: 0, max: 1));
          expect(controller.selection.pixelConstraints, (min: 0, max: 100, total: 100));
          expect((controller.selection.min, controller.selection.max), (selection.min, selection.max));
          expect(controller.selection.pixels, (min: 0, max: selection.max * 100));
        });
      });

      group('step', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..step(min: false, extend: true);

          expect(calls, 0);
          expect(controller.selection, value);
        });
      });

      group('slide', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..slide(50, min: false);

          expect(calls, 0);
          expect(controller.selection, value);
        });

        test('move', () {
          var calls = 0;
          controller
            ..attach(100, marks)
            ..addListener(() => calls++)
            ..slide(50, min: false);

          expect(calls, 1);
          expect((controller.selection.min, controller.selection.max), (0, 0.5));
          expect(controller.selection.pixels, (min: 0, max: 50));
        });

        test('tap only', () {
          var calls = 0;
          controller = constructor(range, FSliderInteraction.tap)
            ..attach(100, marks)
            ..addListener(() => calls++)
            ..slide(50, min: false);

          expect(calls, 0);
          expect((controller.selection.min, controller.selection.max), (range.min, range.max));
        });
      });

      group('tap', () {
        for (final interaction in [FSliderInteraction.slide, FSliderInteraction.slideThumb]) {
          test('slide only - $interaction', () {
            var calls = 0;
            controller = constructor(value, interaction)
              ..attach(100, marks)
              ..addListener(() => calls++);

            expect(controller.tap(50), null);
            expect(calls, 0);
            expect((controller.selection.min, controller.selection.max), (value.min, value.max));
          });
        }

        for (final (offset, expected, min, thumb) in [
          (0.0, (min: 0.0, max: 0.75), true, true),
          (50.0, (min: 0.5, max: 0.75), true, true),
          (100.0, (min: 0.25, max: 1.0), false, false),
          (50.0, (min: 0.25, max: 0.5), false, false),
        ]) {
          test('tap value', () {
            var calls = 0;
            controller = constructor(range, FSliderInteraction.tap, min)
              ..attach(100, marks)
              ..addListener(() => calls++);

            expect(controller.tap(offset), thumb);
            expect(calls, 1);
            expect((controller.selection.min, controller.selection.max), (expected.min, expected.max));
            expect(controller.selection.pixels, (min: expected.min * 100, max: expected.max * 100));
          });
        }

        test('initial selection', () {
          var calls = 0;
          controller = constructor(range, FSliderInteraction.tap)..addListener(() => calls++);

          expect(controller.tap(50), null);
          expect(calls, 0);
          expect(controller.selection, range);
        });
      });

      group('reset', () {
        test('initial selection', () {
          var calls = 0;
          controller
            ..addListener(() => calls++)
            ..reset();

          expect(calls, 0);
          expect(controller.selection.constraints, (min: 0, max: 1));
          expect((controller.selection.min, controller.selection.max), (0, 0.75));
        });

        test('existing selection', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..step(min: false, extend: true)
            ..addListener(() => calls++)
            ..reset();

          expect(calls, 1);
          expect(controller.selection.constraints, (min: 0, max: 1));
          expect(controller.selection.pixelConstraints, (min: 0, max: 1000, total: 1000));
          expect((controller.selection.min, controller.selection.max), (0, 0.75));
          expect(controller.selection.pixels, (min: 0, max: 750));
        });
      });

      group('set selection', () {
        test('null', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..addListener(() => calls++)
            ..selection = null;

          expect(calls, 0);
          expect((controller.selection.min, controller.selection.max), (value.min, value.max));
        });

        test('same', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..addListener(() => calls++)
            ..selection = controller.selection;

          expect(calls, 0);
        });

        test('other', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..addListener(() => calls++)
            ..selection = FSliderSelection(max: 0.6);

          expect(calls, 1);
          expect((controller.selection.min, controller.selection.max), (0, 0.6));
        });
      });
    });
  }

  group('FContinuousSlider', () {
    final selection = FSliderSelection(max: 0.75);
    late FContinuousSliderController controller;

    setUp(() {
      controller = FContinuousSliderController(selection: selection);
    });

    for (final constructor in [
      () => FContinuousSliderController(selection: selection, stepPercentage: -0.1),
      () => FContinuousSliderController(selection: selection, stepPercentage: 1.1),
      () => FContinuousSliderController.range(selection: selection, stepPercentage: -0.1),
      () => FContinuousSliderController.range(selection: selection, stepPercentage: 1.1),
    ]) {
      test('constructor', () => expect(constructor, throwsAssertionError));
    }

    for (final (min, extend, expected) in [
      (true, true, (min: 0.2, max: 0.75)),
      (true, false, (min: 0.3, max: 0.75)),
      (false, true, (min: 0.25, max: 0.8)),
      (false, false, (min: 0.25, max: 0.7)),
    ]) {
      test('step ${min ? 'min' : 'max'} edge - ${extend ? 'extend' : 'shrink'}', () {
        var calls = 0;
        controller = FContinuousSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75))
          ..attach(100, [])
          ..addListener(() => calls++)
          ..step(min: min, extend: extend);

        expect(calls, 1);
        expect((controller.selection.min, controller.selection.max), (expected.min, expected.max));
        expect(controller.selection.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }

    for (final (offset, expected, times, thumb) in [
      (0.0, (min: 0.0, max: 0.75), 1, true),
      (100.0, (min: 0.25, max: 1.0), 1, false),
      (50.0, (min: 0.25, max: 0.75), 0, null),
    ]) {
      test('tap range', () {
        var calls = 0;
        controller = FContinuousSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75))
          ..attach(100, [])
          ..addListener(() => calls++);

        expect(controller.tap(offset), thumb);
        expect(calls, times);
        expect((controller.selection.min, controller.selection.max), (expected.min, expected.max));
        expect(controller.selection.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }
  });

  group('FDiscreteSlider', () {
    final selection = FSliderSelection(max: 0.75);
    late FDiscreteSliderController controller;

    setUp(() {
      controller = FDiscreteSliderController(selection: selection);
    });

    test('attach', () => expect(() => controller.attach(1000, []), throwsAssertionError));

    for (final (min, extend, expected) in [
      (true, true, (min: 0.0, max: 0.75)),
      (true, false, (min: 0.5, max: 0.75)),
      (false, true, (min: 0.25, max: 1.0)),
      (false, false, (min: 0.25, max: 0.6)),
    ]) {
      test('step ${min ? 'min' : 'max'} edge - ${extend ? 'extend' : 'shrink'}', () {
        var calls = 0;
        controller = FDiscreteSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75))
          ..attach(100, marks)
          ..addListener(() => calls++)
          ..step(min: min, extend: extend);

        expect(calls, 1);
        expect((controller.selection.min, controller.selection.max), (expected.min, expected.max));
        expect(controller.selection.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }

    for (final (offset, expected, times, thumb) in [
      (0.0, (min: 0.0, max: 0.75), 1, true),
      (100.0, (min: 0.25, max: 1.0), 1, false),
      (50.0, (min: 0.25, max: 0.75), 0, null),
    ]) {
      test('tap range', () {
        var calls = 0;
        controller = FDiscreteSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75))
          ..attach(100, marks)
          ..addListener(() => calls++);

        expect(controller.tap(offset), thumb);
        expect(calls, times);
        expect((controller.selection.min, controller.selection.max), (expected.min, expected.max));
        expect(controller.selection.pixels, (min: expected.min * 100, max: expected.max * 100));
      });
    }
  });
}

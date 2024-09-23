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
    (selection, [FSliderInteraction? interaction, bool min = false]) =>
        FContinuousSliderController(selection: selection, allowedInteraction: interaction, minExtendable: min),
    (selection, [FSliderInteraction? interaction, bool min = false]) =>
        FDiscreteSliderController(selection: selection, allowedInteraction: interaction, minExtendable: min),
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
          expect(controller.selection.extent, (min: 0, max: 1));
          expect(controller.selection.rawExtent, (min: 0, max: 1000, total: 1000));
          expect(controller.selection.offset, (min: 0, max: 0.75));
          expect(controller.selection.rawOffset, (min: 0, max: 750));
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
          expect(controller.selection.extent, (min: 0, max: 1));
          expect(controller.selection.rawExtent, (min: 0, max: 100, total: 100));
          expect(controller.selection.offset, selection.offset);
          expect(controller.selection.rawOffset, (min: 0, max: selection.offset.max * 100));
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
          expect(controller.selection.offset, (min: 0, max: 0.5));
          expect(controller.selection.rawOffset, (min: 0, max: 50));
        });

        test('tap only', () {
          var calls = 0;
          controller = constructor(range, FSliderInteraction.tap)
            ..attach(100, marks)
            ..addListener(() => calls++)
            ..slide(50, min: false);

          expect(calls, 0);
          expect(controller.selection.offset, range.offset);
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
            expect(controller.selection.offset, value.offset);
          });
        }

        for (final (offset, expected, min, thumb) in [
          (0.0, (min: 0, max: 0.75), true, true),
          (50.0, (min: 0.5, max: 0.75), true, true),
          (100.0, (min: 0.25, max: 1), false, false),
          (50.0, (min: 0.25, max: 0.5), false, false),
        ]) {
          test('tap value', () {
            var calls = 0;
            controller = constructor(range, FSliderInteraction.tap, min)
              ..attach(100, marks)
              ..addListener(() => calls++);

            expect(controller.tap(offset), thumb);
            expect(calls, 1);
            expect(controller.selection.offset, expected);
            expect(controller.selection.rawOffset, (min: expected.min * 100, max: expected.max * 100));
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
          expect(controller.selection.extent, (min: 0, max: 1));
          expect(controller.selection.offset, (min: 0, max: 0.75));
        });

        test('existing selection', () {
          var calls = 0;
          controller
            ..attach(1000, marks)
            ..step(min: false, extend: true)
            ..addListener(() => calls++)
            ..reset();

          expect(calls, 1);
          expect(controller.selection.extent, (min: 0, max: 1));
          expect(controller.selection.rawExtent, (min: 0, max: 1000, total: 1000));
          expect(controller.selection.offset, (min: 0, max: 0.75));
          expect(controller.selection.rawOffset, (min: 0, max: 750));
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
          expect(controller.selection.offset, value.offset);
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
          expect(controller.selection.offset, (min: 0, max: 0.6));
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

    for (final (min, extend, offset) in [
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
        expect(controller.selection.offset, offset);
        expect(controller.selection.rawOffset, (min: offset.min * 100, max: offset.max * 100));
      });
    }

    for (final (offset, expected, times, thumb) in [
      (0.0, (min: 0, max: 0.75), 1, true),
      (100.0, (min: 0.25, max: 1), 1, false),
      (50.0, (min: 0.25, max: 0.75), 0, null),
    ]) {
      test('tap range', () {
        var calls = 0;
        controller = FContinuousSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75))
          ..attach(100, [])
          ..addListener(() => calls++);

        expect(controller.tap(offset), thumb);
        expect(calls, times);
        expect(controller.selection.offset, expected);
        expect(controller.selection.rawOffset, (min: expected.min * 100, max: expected.max * 100));
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

    for (final (min, extend, offset) in [
      (true, true, (min: 0, max: 0.75)),
      (true, false, (min: 0.5, max: 0.75)),
      (false, true, (min: 0.25, max: 1)),
      (false, false, (min: 0.25, max: 0.6)),
    ]) {
      test('step ${min ? 'min' : 'max'} edge - ${extend ? 'extend' : 'shrink'}', () {
        var calls = 0;
        controller = FDiscreteSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75))
          ..attach(100, marks)
          ..addListener(() => calls++)
          ..step(min: min, extend: extend);

        expect(calls, 1);
        expect(controller.selection.offset, offset);
        expect(controller.selection.rawOffset, (min: offset.min * 100, max: offset.max * 100));
      });
    }

    for (final (offset, expected, times, thumb) in [
      (0.0, (min: 0, max: 0.75), 1, true),
      (100.0, (min: 0.25, max: 1), 1, false),
      (50.0, (min: 0.25, max: 0.75), 0, null),
    ]) {
      test('tap range', () {
        var calls = 0;
        controller = FDiscreteSliderController.range(selection: FSliderSelection(min: 0.25, max: 0.75))
          ..attach(100, marks)
          ..addListener(() => calls++);

        expect(controller.tap(offset), thumb);
        expect(calls, times);
        expect(controller.selection.offset, expected);
        expect(controller.selection.rawOffset, (min: expected.min * 100, max: expected.max * 100));
      });
    }
  });
}

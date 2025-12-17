import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/slider/slider_selection.dart';

void main() {
  group('_Selection', () {
    test('fields', () {
      final selection = FSliderSelection(min: 0.4, max: 0.5);

      expect((selection.min, selection.max), (0.4, 0.5));
      expect(selection.constraints, (min: 0.0, max: 1.0));
      expect(selection.pixelConstraints, (min: 0.0, max: 0.0, total: 0));
      expect(selection.pixels, (min: 0.0, max: 0.0));
    });
  });

  group('ContinuousSelection', () {
    ContinuousSelection value(
      double min,
      double max, {
      double step = 0.05,
      ({double min, double max}) extent = (min: 0.1, max: 0.3),
    }) => ContinuousSelection(step: step, mainAxisExtent: 100.0, constraints: extent, min: min, max: max);

    for (final (description, selection) in [
      ('step negative', () => value(0.2, 0.4, step: -0.05)),
      ('step larger than extent', () => value(0.2, 0.4, step: 1.1)),
    ]) {
      test(description, () => expect(selection, throwsAssertionError));
    }

    group('step', () {
      test('min step negative', () {
        expect(value(0.1, 0.2, step: 0.5).step(min: true, extend: true), value(0.0, 0.2, step: 0.5));
      });

      test('max step > extent', () {
        expect(value(0.7, 0.8, step: 0.5).step(min: false, extend: true), value(0.7, 1.0, step: 0.5));
      });

      test('min step > max raw offset', () {
        expect(value(0.2, 0.4, step: 0.5).step(min: true, extend: false), value(0.3, 0.4, step: 0.5));
      });

      test('max step < max min offset', () {
        expect(value(0.2, 0.4, step: 0.5).step(min: false, extend: false), value(0.2, 0.3, step: 0.5));
      });

      test('min extend', () => expect(value(0.2, 0.4).step(min: true, extend: true), value(0.15, 0.4)));

      test('min shrink', () => expect(value(0.2, 0.4).step(min: true, extend: false), value(0.25, 0.4)));

      test('max extend', () => expect(value(0.2, 0.4).step(min: false, extend: true), value(0.2, 0.45)));

      test('max shrink', () => expect(value(0.2, 0.4).step(min: false, extend: false), value(0.2, 0.35)));
    });

    group('move', () {
      test('min negative offset', () => expect(value(0.2, 0.4).move(min: true, to: -1), value(0.1, 0.4)));

      test('max negative offset', () => expect(value(0.2, 0.4).move(min: false, to: -1), value(0.2, 0.3)));

      test('min offset > extent', () => expect(value(0.2, 0.4).move(min: true, to: 101), value(0.3, 0.4)));

      test('max offset > extent', () => expect(value(0.2, 0.4).move(min: false, to: 101), value(0.2, 0.5)));

      test('min offset < min raw extent', () => expect(value(0.2, 0.4).move(min: true, to: 35), value(0.3, 0.4)));

      test('min offset > max raw extent', () => expect(value(0.2, 0.4).move(min: true, to: 0), value(0.1, 0.4)));

      test('min offset', () => expect(value(0.2, 0.4).move(min: true, to: 25), value(0.25, 0.4)));

      test('max offset < min raw extent', () => expect(value(0.2, 0.4).move(min: false, to: 29), value(0.2, 0.3)));

      test('max offset > max raw extent', () => expect(value(0.2, 0.4).move(min: false, to: 51), value(0.2, 0.5)));

      test('max offset < min raw extent', () => expect(value(0.2, 0.4).move(min: false, to: 45), value(0.2, 0.45)));

      test('max offset shrink to min offset', () {
        expect(
          value(0.2, 0.4, extent: (min: 0, max: 1)).move(min: false, to: 0),
          value(0.2, 0.2, extent: (min: 0, max: 1)),
        );
      });

      test('min offset shrink to max offset', () {
        expect(
          value(0.2, 0.4, extent: (min: 0, max: 1)).move(min: true, to: 50),
          value(0.4, 0.4, extent: (min: 0, max: 1)),
        );
      });
    });
  });

  group('DiscreteSelection', () {
    DiscreteSelection value(
      double min,
      double max, {
      List<double> ticks = const [0, 0.125, 0.25, 0.5, 0.75, 0.875, 1],
      ({double min, double max}) extent = (min: 0.01, max: 0.6),
    }) => DiscreteSelection(
      ticks: SplayTreeMap.fromIterable(ticks, value: (_) {}),
      mainAxisExtent: 100.0,
      constraints: extent,
      min: min,
      max: max,
    );

    for (final constructor in [
      () => DiscreteSelection(
        ticks: SplayTreeMap(),
        mainAxisExtent: 100.0,
        constraints: (min: 0, max: 1),
        min: 0.1,
        max: 0.2,
      ),
      () => DiscreteSelection(
        ticks: SplayTreeMap.fromIterable([-1.0], value: (_) {}),
        mainAxisExtent: 100.0,
        constraints: (min: 0, max: 1),
        min: 0.1,
        max: 0.2,
      ),
      () => DiscreteSelection(
        ticks: SplayTreeMap.fromIterable([1.1], value: (_) {}),
        mainAxisExtent: 100.0,
        constraints: (min: 0, max: 1),
        min: 0.1,
        max: 0.2,
      ),
    ]) {
      test('constructor', () => expect(constructor, throwsAssertionError));
    }

    group('step', () {
      for (final (value, min, extend, expected) in [
        (value(0, 0.25), true, true, value(0.0, 0.25)),
        (value(0.75, 1), false, true, value(0.75, 1)),
        (value(0.25, 0.5), true, true, value(0.125, 0.5)),
        (value(0.25, 0.5), false, true, value(0.25, 0.75)),
        (value(0.125, 0.5), true, false, value(0.25, 0.5)),
        (value(0.25, 0.75), false, false, value(0.25, 0.5)),
      ]) {
        test('${min ? 'min' : 'max'} ${extend ? 'extend' : 'shrink'}', () {
          expect(value.step(min: min, extend: extend), expected);
        });
      }

      for (final (min, extend) in [(true, true), (false, true), (true, false), (false, false)]) {
        test('single point - ${min ? 'min' : 'max'} ${extend ? 'extend' : 'shrink'}', () {
          expect(
            value(0.5, 0.5, extent: (min: 0, max: 1), ticks: [0.5]).step(min: min, extend: extend),
            value(0.5, 0.5, extent: (min: 0, max: 1), ticks: [0.5]),
          );
        });
      }
    });

    group('move', () {
      test('min on tick', () => expect(value(0.25, 0.5).move(min: true, to: 25), value(0.25, 0.5)));

      test('max on tick', () => expect(value(0.0, 0.5).move(min: false, to: 50), value(0.0, 0.5)));

      test('min shrink beyond extent', () => expect(value(0.5, 0.875).move(min: true, to: 87.5), value(0.75, 0.875)));

      test('max shrink beyond extent', () => expect(value(0.125, 0.5).move(min: false, to: 12.5), value(0.125, 0.25)));

      test('min shrink, no min extent', () {
        expect(
          value(0.25, 0.5, extent: (min: 0, max: 0.45)).move(min: true, to: 100),
          value(0.5, 0.5, extent: (min: 0, max: 0.45)),
        );
      });

      test('max shrink, no min extent', () {
        expect(
          value(0.25, 0.5, extent: (min: 0, max: 0.45)).move(min: false, to: 0),
          value(0.25, 0.25, extent: (min: 0, max: 0.45)),
        );
      });

      test('min expand beyond extent', () {
        expect(
          value(0.25, 0.5, extent: (min: 0, max: 0.45)).move(min: true, to: 0),
          value(0.125, 0.5, extent: (min: 0, max: 0.45)),
        );
      });

      test('max expand beyond extent', () {
        expect(
          value(0.5, 0.75, extent: (min: 0, max: 0.45)).move(min: false, to: 100),
          value(0.5, 0.875, extent: (min: 0, max: 0.45)),
        );
      });

      for (final (index, (value, to, expected)) in [
        (value(0.25, 0.5), 20.0, value(0.25, 0.5)),
        (value(0.25, 0.5), 30.0, value(0.25, 0.5)),
        (value(0.25, 0.5), 13.0, value(0.125, 0.5)),
        (value(0.25, 0.75), 40.0, value(0.5, 0.75)),
        (value(0.25, 0.5), 5.0, value(0, 0.5)),
        (value(0.25, 0.5), 10.0, value(0.125, 0.5)),
      ].indexed) {
        test('[$index] min extend/shrink', () => expect(value.move(min: true, to: to), expected));
      }

      for (final (index, (value, to, expected)) in [
        (value(0.5, 0.75), 55.0, value(0.5, 0.75)),
        (value(0.5, 0.75), 45.0, value(0.5, 0.75)),
        (value(0.5, 0.75), 87.0, value(0.5, 0.875)),
        (value(0.25, 0.75), 60.0, value(0.25, 0.5)),
        (value(0.5, 0.75), 95.0, value(0.5, 1)),
        (value(0.5, 0.75), 90.0, value(0.5, 0.875)),
      ].indexed) {
        test('[$index] max extend/shrink', () => expect(value.move(min: false, to: to), expected));
      }
    });
  });

  group('SplayTreeMaps', () {
    late SplayTreeMap<double, void> map;

    setUp(() {
      map = SplayTreeMap.from({1.0: null, 2.0: null, 3.0: null, 4.0: null, 5.0: null});
    });

    test('firstKeysAfter(...)', () {
      expect(map.firstKeysAfter(5), []);
      expect(map.firstKeysAfter(2), [3.0, 4.0, 5.0]);
      expect(map.firstKeysAfter(2.5), [3.0, 4.0, 5.0]);
    });

    test('lastKeysBefore(...)', () {
      expect(map.lastKeysBefore(1), []);
      expect(map.lastKeysBefore(4), [3.0, 2.0, 1.0]);
      expect(map.lastKeysBefore(3.5), [3.0, 2.0, 1.0]);
    });

    group('round(...)', () {
      test('exact', () => expect(map.round(3.0), 3.0));

      test('up', () => expect(map.round(2.6), 3.0));

      test('up - only one element', () => expect(SplayTreeMap<double, void>.from({1.0: null}).round(0.3), 1.0));

      test('down', () => expect(map.round(2.4), 2.0));

      test('down - only one element', () => expect(SplayTreeMap<double, void>.from({1.0: null}).round(1.3), 1.0));

      test('empty', () => expect(() => SplayTreeMap<double, void>().round(1.3), throwsArgumentError));
    });
  });
}

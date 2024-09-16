import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/widgets/slider/slider_selection.dart';

void main() {
  group('_Selection', () {
    test('fields', () {
      final selection = FSliderSelection(min: 0.4, max: 0.5);

      expect(selection.offset, (min: 0.4, max: 0.5));
      expect(selection.extent, (min: 0.0, max: 1.0));
      expect(selection.rawExtent, (min: 0.0, max: 0.0, total: 0));
      expect(selection.rawOffset, (min: 0.0, max: 0.0));
    });
  });

  group('ContinuousSelection', () {
    final selection = ContinuousSelection(
      step: 0.05,
      mainAxisExtent: 100.0,
      extent: (min: 0.1, max: 0.3),
      offset: (min: 0.2, max: 0.4),
    );

    test('negative step', () {
      expect(
        () => ContinuousSelection(
          step: -0.05,
          mainAxisExtent: 100.0,
          extent: (min: 0.1, max: 0.3),
          offset: (min: 0.2, max: 0.4),
        ),
        throwsAssertionError,
      );
    });

    test('too large step', () {
      expect(
            () => ContinuousSelection(
          step: 1.1,
          mainAxisExtent: 100.0,
          extent: (min: 0.1, max: 0.3),
          offset: (min: 0.2, max: 0.4),
        ),
        throwsAssertionError,
      );
    });

    group('step', () {
      test('min step negative', () {
        final selection = ContinuousSelection(
          step: 0.5,
          mainAxisExtent: 100.0,
          extent: (min: 0.1, max: 0.3),
          offset: (min: 0.1, max: 0.2),
        );

        expect(
          selection.step(min: true, extend: true),
          ContinuousSelection(
            step: 0.5,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.0, max: 0.2),
          ),
        );
      });

      test('max step > extent', () {
        final selection = ContinuousSelection(
          step: 0.5,
          mainAxisExtent: 100.0,
          extent: (min: 0.1, max: 0.3),
          offset: (min: 0.7, max: 0.8),
        );

        expect(
          selection.step(min: false, extend: true),
          ContinuousSelection(
            step: 0.5,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.7, max: 1.0),
          ),
        );
      });

      test('min step > max raw offset', () {
        final selection = ContinuousSelection(
          step: 0.5,
          mainAxisExtent: 100.0,
          extent: (min: 0.1, max: 0.3),
          offset: (min: 0.2, max: 0.4),
        );

        expect(
          selection.step(min: true, extend: false),
          ContinuousSelection(
            step: 0.5,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.3, max: 0.4),
          ),
        );
      });

      test('max step < max min offset', () {
        final selection = ContinuousSelection(
          step: 0.5,
          mainAxisExtent: 100.0,
          extent: (min: 0.1, max: 0.3),
          offset: (min: 0.2, max: 0.4),
        );

        expect(
          selection.step(min: false, extend: false),
          ContinuousSelection(
            step: 0.5,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.2, max: 0.3),
          ),
        );
      });

      test('min extend', () {
        expect(
          selection.step(min: true, extend: true),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.15, max: 0.4),
          ),
        );
      });

      test('min shrink', () {
        expect(
          selection.step(min: true, extend: false),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.25, max: 0.4),
          ),
        );
      });

      test('max extend', () {
        expect(
          selection.step(min: false, extend: true),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.2, max: 0.45),
          ),
        );
      });

      test('max shrink', () {
        expect(
            selection.step(min: false, extend: false),
            ContinuousSelection(
              step: 0.05,
              mainAxisExtent: 100.0,
              extent: (min: 0.1, max: 0.3),
              offset: (min: 0.2, max: 0.35),
            ));
      });
    });

    group('move', () {
      test('min negative offset', () {
        expect(
          selection.move(min: true, to: -1),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.1, max: 0.4),
          ),
        );
      });

      test('max negative offset', () {
        expect(
          selection.move(min: false, to: -1),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.2, max: 0.3),
          ),
        );
      });

      test('min offset > extent', () {
        expect(
          selection.move(min: true, to: 101),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.3, max: 0.4),
          ),
        );
      });

      test('max offset > extent', () {
        expect(
          selection.move(min: false, to: 101),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.2, max: 0.5),
          ),
        );
      });

      test('min offset < min raw extent', () {
        expect(
          selection.move(min: true, to: 35),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.3, max: 0.4),
          ),
        );
      });

      test('min offset > max raw extent', () {
        expect(
          selection.move(min: true, to: 0),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.1, max: 0.4),
          ),
        );
      });

      test('min offset', () {
        expect(
          selection.move(min: true, to: 25),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.25, max: 0.4),
          ),
        );
      });

      test('max offset < min raw extent', () {
        expect(
          selection.move(min: false, to: 29),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.2, max: 0.3),
          ),
        );
      });

      test('max offset > max raw extent', () {
        expect(
          selection.move(min: false, to: 51),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.2, max: 0.5),
          ),
        );
      });

      test('max offset < min raw extent', () {
        expect(
          selection.move(min: false, to: 45),
          ContinuousSelection(
            step: 0.05,
            mainAxisExtent: 100.0,
            extent: (min: 0.1, max: 0.3),
            offset: (min: 0.2, max: 0.45),
          ),
        );
      });
    });
  });

  group('SplayTreeMaps', () {
    late SplayTreeMap<double, void> map;

    setUp(() {
      map = SplayTreeMap.from({
        1.0: null,
        2.0: null,
        3.0: null,
        4.0: null,
        5.0: null,
      });
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

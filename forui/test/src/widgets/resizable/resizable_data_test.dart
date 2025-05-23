import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/widgets/resizable/resizable_region_data.dart';

void main() {
  group('FResizableRegionData', () {
    for (final (index, function) in [
      () => FResizableRegionData(index: 1, extent: (min: 1, max: -2, total: 10), offset: (min: 1, max: 2)),
      () => FResizableRegionData(index: 1, extent: (min: -1, max: 2, total: 10), offset: (min: 1, max: 2)),
      () => FResizableRegionData(index: 1, extent: (min: 1, max: 1, total: 10), offset: (min: 1, max: 2)),
      () => FResizableRegionData(index: 1, extent: (min: 2, max: 1, total: 10), offset: (min: 1, max: 2)),
      () => FResizableRegionData(index: 1, extent: (min: 1, max: 5, total: 10), offset: (min: 1, max: 1)),
      () => FResizableRegionData(index: 1, extent: (min: 1, max: 5, total: 10), offset: (min: 2, max: 1)),
      () => FResizableRegionData(index: 1, extent: (min: 1, max: 5, total: 10), offset: (min: 1, max: 1)),
      () => FResizableRegionData(index: 1, extent: (min: 1, max: 5, total: 10), offset: (min: 1, max: 10)),
      () => FResizableRegionData(index: -1, extent: (min: 1, max: 5, total: 10), offset: (min: 1, max: 3)),
    ].indexed) {
      test('[$index] constructor throws error', () => expect(function, throwsAssertionError));
    }

    test(
      'percentage',
      () => expect(
        FResizableRegionData(
          index: 1,
          extent: (min: 1, max: 10, total: 100),
          offset: (min: 0, max: 5),
        ).offsetPercentage,
        (min: 0, max: 0.05),
      ),
    );

    test(
      'size',
      () => expect(
        FResizableRegionData(index: 1, extent: (min: 1, max: 10, total: 100), offset: (min: 0, max: 5)).extent.current,
        5,
      ),
    );
  });

  group('UpdatableResizableData', () {
    for (final (index, (delta, lhs, translated, min, max)) in [
      (-10.0, true, -10, 10.0, 50.0),
      (10.0, true, 10, 30.0, 50.0),
      (50.0, true, 20, 40.0, 50.0),
      //
      (10.0, false, 10, 20.0, 60.0),
      (-10.0, false, -10, 20.0, 40.0),
      (-50.0, false, -20, 20.0, 30.0),
    ].indexed) {
      test('[$index] update(...)', () {
        final data = FResizableRegionData(
          index: 0,
          extent: (min: 10, max: 100, total: 100),
          offset: (min: 20, max: 50),
        );

        final (updated, updatedDelta) = data.update(delta, lhs: lhs);

        expect(updated.offset, (min: min, max: max));
        expect(updatedDelta, translated);
      });
    }

    test('update(...) throws error', () {
      final data = FResizableRegionData(index: 0, extent: (min: 10, max: 100, total: 100), offset: (min: 0, max: 30));

      expect(() => data.update(-10, lhs: true), throwsAssertionError);
    });

    for (final (index, (delta, lhs, min, max)) in [
      (10.0, true, 10.0, 20.0),
      (50.0, true, 10.0, 20.0),
      (-10.0, false, 10.0, 20.0),
      (-50.0, false, 10.0, 20.0),
    ].indexed) {
      test('[$index] update(...) beyond min/max size', () {
        final data = FResizableRegionData(
          index: 0,
          extent: (min: 10, max: 100, total: 100),
          offset: (min: min, max: max),
        );

        final (updated, updatedDelta) = data.update(delta, lhs: lhs);

        expect(updated.offset, (min: min, max: max));
        expect(updatedDelta, 0.0);
      });
    }

    test(
      'update(...) beyond total',
      () => expect(
        () => FResizableRegionData(
          index: 0,
          extent: (min: 1, max: 5, total: 100),
          offset: (min: 0, max: 2),
        ).update(4, lhs: false),
        throwsAssertionError,
      ),
    );
  });
}

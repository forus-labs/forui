import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/widgets/resizable/resizable_region_data.dart';

void main() {
  group('FResizableRegionData', () {
    for (final (index, function) in [
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: 1, max: -2, allRegions: 10),
            offset: (min: 1, max: 2),
          ),
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: -1, max: 2, allRegions: 10),
            offset: (min: 1, max: 2),
          ),
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: 1, max: 1, allRegions: 10),
            offset: (min: 1, max: 2),
          ),
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: 2, max: 1, allRegions: 10),
            offset: (min: 1, max: 2),
          ),
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: 1, max: 5, allRegions: 10),
            offset: (min: 1, max: 1),
          ),
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: 1, max: 5, allRegions: 10),
            offset: (min: 2, max: 1),
          ),
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: 1, max: 5, allRegions: 10),
            offset: (min: 1, max: 1),
          ),
      () => FResizableRegionData(
            index: 1,
            selected: false,
            size: (min: 1, max: 5, allRegions: 10),
            offset: (min: 1, max: 10),
          ),
      () => FResizableRegionData(
            index: -1,
            selected: false,
            size: (min: 1, max: 5, allRegions: 10),
            offset: (min: 1, max: 3),
          ),
    ].indexed) {
      test(
        '[$index] constructor throws error',
        () => expect(function, throwsAssertionError),
      );
    }

    test(
      'percentage',
      () => expect(
        FResizableRegionData(
          index: 1,
          selected: false,
          size: (min: 1, max: 10, allRegions: 100),
          offset: (min: 0, max: 5),
        ).offsetPercentage,
        (min: 0, max: 0.05),
      ),
    );

    test(
      'size',
      () => expect(
        FResizableRegionData(
          index: 1,
          selected: false,
          size: (min: 1, max: 10, allRegions: 100),
          offset: (min: 0, max: 5),
        ).size.current,
        5,
      ),
    );
  });

  group('UpdatableResizableData', () {
    for (final (index, (direction, delta, translated, min, max)) in [
      (AxisDirection.left, const Offset(-10, 0), const Offset(-10, 0), 10.0, 50.0),
      (AxisDirection.left, const Offset(10, 0), const Offset(10, 0), 30.0, 50.0),
      (AxisDirection.left, const Offset(50, 0), const Offset(20, 0), 40.0, 50.0),
      //
      (AxisDirection.right, const Offset(10, 0), const Offset(10, 0), 20.0, 60.0),
      (AxisDirection.right, const Offset(-10, 0), const Offset(-10, 0), 20.0, 40.0),
      (AxisDirection.right, const Offset(-50, 0), const Offset(-20, 0), 20.0, 30.0),
      //
      (AxisDirection.up, const Offset(0, -10), const Offset(0, -10), 10.0, 50.0),
      (AxisDirection.up, const Offset(0, 10), const Offset(0, 10), 30.0, 50.0),
      (AxisDirection.up, const Offset(0, 50), const Offset(0, 20), 40.0, 50.0),
      //
      (AxisDirection.down, const Offset(0, 10), const Offset(0, 10), 20.0, 60.0),
      (AxisDirection.down, const Offset(0, -10), const Offset(0, -10), 20.0, 40.0),
      (AxisDirection.down, const Offset(0, -50), const Offset(0, -20), 20.0, 30.0),
    ].indexed) {
      test('[$index] update(...)', () {
        final data = FResizableRegionData(
          index: 0,
          selected: true,
          size: (min: 10, max: 100, allRegions: 100),
          offset: (min: 20, max: 50),
        );

        final (updated, updatedDelta) = data.update(direction, delta);

        expect(updated.offset, (min: min, max: max));
        expect(updatedDelta, translated);
      });
    }

    test('update(...) throws error', () {
      final data = FResizableRegionData(
        index: 0,
        selected: true,
        size: (min: 10, max: 100, allRegions: 100),
        offset: (min: 0, max: 30),
      );

      expect(
        () => data.update(AxisDirection.left, const Offset(-10, 0)),
        throwsAssertionError,
      );
    });

    for (final (index, (direction, delta, min, max)) in [
      (AxisDirection.left, const Offset(10, 0), 10.0, 20.0),
      (AxisDirection.left, const Offset(50, 0), 10.0, 20.0),
      (AxisDirection.right, const Offset(-10, 0), 10.0, 20.0),
      (AxisDirection.right, const Offset(-50, 0), 10.0, 20.0),
      (AxisDirection.up, const Offset(0, 10), 10.0, 20.0),
      (AxisDirection.up, const Offset(0, 50), 10.0, 20.0),
      (AxisDirection.down, const Offset(0, -10), 10.0, 20.0),
      (AxisDirection.down, const Offset(0, -50), 10.0, 20.0),
    ].indexed) {
      test('[$index] update(...) beyond min/max size', () {
        final data = FResizableRegionData(
          index: 0,
          selected: true,
          size: (min: 10, max: 100, allRegions: 100),
          offset: (min: min, max: max),
        );
        final (updated, updatedDelta) = data.update(direction, delta);

        expect(updated.offset, (min: min, max: max));
        expect(updatedDelta, Offset.zero);
      });
    }

    test(
      'update(...) beyond total',
      () => expect(
        () => FResizableRegionData(
          index: 0,
          selected: true,
          size: (min: 1, max: 5, allRegions: 100),
          offset: (min: 0, max: 2),
        ).update(AxisDirection.right, const Offset(4, 0)),
        throwsAssertionError,
      ),
    );
  });
}

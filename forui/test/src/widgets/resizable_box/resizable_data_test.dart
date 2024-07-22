import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/widgets/resizable_box/resizable_data.dart';

void main() {
  group('FResizableData', () {
    for (final (index, function) in [
      () => FResizableData(index: 1, selected: false, constraints: (min: 1, max: -2), offsets: (min: 1, max: 2)),
      () => FResizableData(index: 1, selected: false, constraints: (min: -1, max: 2), offsets: (min: 1, max: 2)),
      () => FResizableData(index: 1, selected: false, constraints: (min: 1, max: 1), offsets: (min: 1, max: 2)),
      () => FResizableData(index: 1, selected: false, constraints: (min: 2, max: 1), offsets: (min: 1, max: 2)),
      () => FResizableData(index: 1, selected: false, constraints: (min: 1, max: 5), offsets: (min: 1, max: 1)),
      () => FResizableData(index: 1, selected: false, constraints: (min: 1, max: 5), offsets: (min: 2, max: 1)),
      () => FResizableData(index: 1, selected: false, constraints: (min: 1, max: 5), offsets: (min: 1, max: 1)),
      () => FResizableData(index: 1, selected: false, constraints: (min: 1, max: 5), offsets: (min: 1, max: 10)),
      () => FResizableData(index: -1, selected: false, constraints: (min: 1, max: 5), offsets: (min: 1, max: 3)),
    ].indexed) {
      test('[$index] constructor throws error', () => expect(function, throwsAssertionError));
    }

    test(
      'percentage',
      () => expect(
        FResizableData(index: 1, selected: false, constraints: (min: 1, max: 10), offsets: (min: 0, max: 5)).percentage,
        (min: 0, max: 0.5),
      ),
    );

    test(
      'size',
      () => expect(
        FResizableData(index: 1, selected: false, constraints: (min: 1, max: 10), offsets: (min: 0, max: 5)).size,
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
        final data = FResizableData(
          index: 0,
          selected: true,
          constraints: (min: 10, max: 100),
          offsets: (min: 20, max: 50),
        );

        final (updated, updatedDelta) = data.update(direction, delta);

        expect(updated.offsets, (min: min, max: max));
        expect(updatedDelta, translated);
      });
    }

    test('update(...) throws error', () {
      final data = FResizableData(
        index: 0,
        selected: true,
        constraints: (min: 10, max: 100),
        offsets: (min: 0, max: 30),
      );

      expect(() => data.update(AxisDirection.left, const Offset(-10, 0)), throwsAssertionError);
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
      test('[$index] update(...) beyond min/max constraint', () {
        final data =
            FResizableData(index: 0, selected: true, constraints: (min: 10, max: 100), offsets: (min: min, max: max));
        final (updated, updatedDelta) = data.update(direction, delta);

        expect(updated.offsets, (min: min, max: max));
        expect(updatedDelta, Offset.zero);
      });
    }

    test(
      'update(...) beyond total',
      () => expect(
        () => FResizableData(
          index: 0,
          selected: true,
          constraints: (min: 1, max: 5),
          offsets: (min: 0, max: 2),
        ).update(AxisDirection.right, const Offset(4, 0)),
        throwsAssertionError,
      ),
    );
  });
}

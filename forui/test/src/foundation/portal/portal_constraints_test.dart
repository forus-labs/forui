import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/portal/portal_constraints.dart';

void main() {
  group('FPortalConstraints', () {
    test('default constructor creates constraints with default values', () {
      const constraints = FPortalConstraints() as FixedConstraints;

      expect(constraints.minWidth, 0.0);
      expect(constraints.maxWidth, double.infinity);
      expect(constraints.minHeight, 0.0);
      expect(constraints.maxHeight, double.infinity);
      expect(constraints.isTight, false);
      expect(constraints.isNormalized, true);
    });

    test('constructor with parameters initializes with given values', () {
      const constraints =
          FPortalConstraints(
                minWidth: 100,
                maxWidth: 200,
                minHeight: 300,
                maxHeight: 400,
              )
              as FixedConstraints;

      expect(constraints.minWidth, 100);
      expect(constraints.maxWidth, 200);
      expect(constraints.minHeight, 300);
      expect(constraints.maxHeight, 400);
    });

    test(
      'tightFor constructor with both width and height initializes with tight constraints',
      () {
        const constraints =
            FPortalConstraints.tightFor(width: 150, height: 250)
                as FixedConstraints;

        expect(constraints.minWidth, 150);
        expect(constraints.maxWidth, 150);
        expect(constraints.minHeight, 250);
        expect(constraints.maxHeight, 250);
        expect(constraints.hasTightWidth, true);
        expect(constraints.hasTightHeight, true);
        expect(constraints.isTight, true);
      },
    );
  });

  group('FAutoHeightPortalConstraints', () {
    test('default constructor initializes with default values', () {
      const constraints = FAutoHeightPortalConstraints();

      expect(constraints.minWidth, 0.0);
      expect(constraints.maxWidth, double.infinity);
      expect(constraints.isNormalized, false);
    });

    test('constructor with parameters initializes with given values', () {
      const constraints = FAutoHeightPortalConstraints(
        minWidth: 100,
        maxWidth: 200,
      );

      expect(constraints.minWidth, 100);
      expect(constraints.maxWidth, 200);
    });

    test('tightFor constructor initializes with given width', () {
      const constraints = FAutoHeightPortalConstraints.tightFor(width: 150);

      expect(constraints.minWidth, 150);
      expect(constraints.maxWidth, 150);
    });

    test('tightFor constructor with null width uses default values', () {
      const constraints = FAutoHeightPortalConstraints.tightFor();

      expect(constraints.minWidth, 0);
      expect(constraints.maxWidth, double.infinity);
    });

    test('isTight returns true when minWidth equals maxWidth', () {
      expect(
        const FAutoHeightPortalConstraints(
          minWidth: 100,
          maxWidth: 100,
        ).isTight,
        true,
      );
    });

    test('isTight returns false when minWidth is less than maxWidth', () {
      expect(
        const FAutoHeightPortalConstraints(
          minWidth: 100,
          maxWidth: 101,
        ).isTight,
        false,
      );
    });

    test('equality and hashCode', () {
      const constraints1 = FAutoHeightPortalConstraints(
        minWidth: 100,
        maxWidth: 200,
      );
      const constraints2 = FAutoHeightPortalConstraints(
        minWidth: 100,
        maxWidth: 200,
      );
      const constraints3 = FAutoHeightPortalConstraints(
        minWidth: 150,
        maxWidth: 250,
      );

      expect(constraints1, equals(constraints2));
      expect(constraints1.hashCode, equals(constraints2.hashCode));

      expect(constraints1, isNot(equals(constraints3)));
      expect(constraints1.hashCode, isNot(equals(constraints3.hashCode)));
    });

    test('toString returns correct string representation', () {
      const constraints = FAutoHeightPortalConstraints(
        minWidth: 100,
        maxWidth: 200,
      );
      expect(
        constraints.toString(),
        'FAutoHeightPortalConstraints(minWidth: 100.0, maxWidth: 200.0)',
      );
    });
  });

  group('FAutoWidthPortalConstraints', () {
    test('default constructor initializes with default values', () {
      const constraints = FAutoWidthPortalConstraints();

      expect(constraints.minHeight, 0.0);
      expect(constraints.maxHeight, double.infinity);
      expect(constraints.isNormalized, false);
    });

    test('constructor with parameters initializes with given values', () {
      const constraints = FAutoWidthPortalConstraints(
        minHeight: 100,
        maxHeight: 200,
      );

      expect(constraints.minHeight, 100);
      expect(constraints.maxHeight, 200);
    });

    test('tightFor constructor initializes with given height', () {
      const constraints = FAutoWidthPortalConstraints.tightFor(height: 150);

      expect(constraints.minHeight, 150);
      expect(constraints.maxHeight, 150);
    });

    test('tightFor constructor with null height uses default values', () {
      const constraints = FAutoWidthPortalConstraints.tightFor();

      expect(constraints.minHeight, 0);
      expect(constraints.maxHeight, double.infinity);
    });

    test('isTight returns true when minHeight equals maxHeight', () {
      expect(
        const FAutoWidthPortalConstraints(
          minHeight: 100,
          maxHeight: 100,
        ).isTight,
        true,
      );
    });

    test('isTight returns false when minHeight is less than maxHeight', () {
      expect(
        const FAutoWidthPortalConstraints(
          minHeight: 100,
          maxHeight: 200,
        ).isTight,
        false,
      );
    });

    test('equality and hashCode', () {
      const constraints1 = FAutoWidthPortalConstraints(
        minHeight: 100,
        maxHeight: 200,
      );
      const constraints2 = FAutoWidthPortalConstraints(
        minHeight: 100,
        maxHeight: 200,
      );
      const constraints3 = FAutoWidthPortalConstraints(
        minHeight: 150,
        maxHeight: 250,
      );

      expect(constraints1, equals(constraints2));
      expect(constraints1.hashCode, equals(constraints2.hashCode));

      expect(constraints1, isNot(equals(constraints3)));
      expect(constraints1.hashCode, isNot(equals(constraints3.hashCode)));
    });

    test('toString returns correct string representation', () {
      const constraints = FAutoWidthPortalConstraints(
        minHeight: 100,
        maxHeight: 200,
      );
      expect(
        constraints.toString(),
        'FAutoWidthPortalConstraints(minHeight: 100.0, maxHeight: 200.0)',
      );
    });
  });
}

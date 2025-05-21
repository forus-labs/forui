import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/portal/portal_shift.dart';

void main() {
  group('FPortalShift', () {
    const view = Size(100, 100);

    group('flip', () {
      test('inside', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const portal = (offset: Offset.zero, size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-10, 50));
      });

      test('inside, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const portal = (offset: Offset(-10, 5), size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-20, 55));
      });

      test('outside left side, flip', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(30, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(50, -10));
      });

      test('outside left side, non-zero offset, flip', () {
        const child = (offset: Offset(10, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-10, -5), size: Size(30, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(60, -15));
      });

      test('outside left side, cannot flip', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(50, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-20, -10));
      });

      test('outside left side, non-zero offset, cannot flip', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-10, -5), size: Size(50, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-20, -15));
      });

      test('outside top side, flip', () {
        const child = (offset: Offset(20, 20), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(10, 30), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-10, 50));
      });

      test('outside top side, non-zero offset, flip', () {
        const child = (offset: Offset(20, 10), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-10, -5), size: Size(10, 30), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-20, 55));
      });

      test('outside top side, cannot flip', () {
        const child = (offset: Offset(20, 20), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-10, -20));
      });

      test('outside top side, non-zero offset, cannot flip', () {
        const child = (offset: Offset(20, 20), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-5, -10), size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, child, portal), const Offset(-15, -20));
      });

      test('outside right side, flip', () {
        const child = (offset: Offset(30, 20), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset.zero, size: Size(30, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(-30, -10));
      });

      test('outside right side, non-zero offset, flip', () {
        const child = (offset: Offset(40, 20), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset(10, -5), size: Size(30, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(-40, -15));
      });

      test('outside right side, cannot flip', () {
        const child = (offset: Offset(30, 20), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset.zero, size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(0, -10));
      });

      test('outside right side, non-zero offset, cannot flip', () {
        const child = (offset: Offset(30, 20), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset(10, -5), size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(0, -15));
      });

      test('outside bottom side, flip', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset.zero, size: Size(10, 30), anchor: Alignment.topLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(50, -30));
      });

      test('outside bottom side, non-zero offset, flip', () {
        const child = (offset: Offset(20, 40), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset(5, 10), size: Size(10, 20), anchor: Alignment.topLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(55, -30));
      });

      test('outside bottom side, cannot flip', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset.zero, size: Size(10, 50), anchor: Alignment.topLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(50, 20));
      });

      test('outside bottom side, non-zero offset, cannot flip', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset(5, 10), size: Size(10, 50), anchor: Alignment.topLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(55, 20));
      });

      test('flip both axis', () {
        const child = (offset: Offset(45, 40), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset(5, 10), size: Size(10, 20), anchor: Alignment.topLeft);

        expect(FPortalShift.flip(view, child, portal), const Offset(45, -30));
      });
    });

    group('along', () {
      test('inside', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const portal = (offset: Offset.zero, size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.along(view, child, portal), const Offset(-10, 50));
      });

      test('inside, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const portal = (offset: Offset(1, 2), size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.along(view, child, portal), const Offset(-9, 52));
      });

      test('outside left side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(70, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.along(view, child, portal), const Offset(-20, -10));
      });

      test('outside left side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-10, -5), size: Size(70, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.along(view, child, portal), const Offset(-20, -15));
      });

      test('outside top side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.along(view, child, portal), const Offset(-10, -30));
      });

      test('outside top side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-5, -10), size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.along(view, child, portal), const Offset(-15, -30));
      });

      test('outside right side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset.zero, size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.along(view, child, portal), const Offset(10, -10));
      });

      test('outside right side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset(10, -5), size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.along(view, child, portal), const Offset(10, -15));
      });

      test('outside bottom side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset.zero, size: Size(10, 70), anchor: Alignment.topLeft);

        expect(FPortalShift.along(view, child, portal), const Offset(50, 0));
      });

      test('outside bottom side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset(5, 10), size: Size(10, 70), anchor: Alignment.topLeft);

        expect(FPortalShift.along(view, child, portal), const Offset(55, 0));
      });
    });

    group('none()', () {
      test('inside', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const portal = (offset: Offset.zero, size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.none(view, child, portal), const Offset(-10, 50));
      });

      test('inside, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const portal = (offset: Offset(-5, -10), size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.none(view, child, portal), const Offset(-15, 40));
      });

      test('outside left side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(70, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.none(view, child, portal), const Offset(-70, -10));
      });

      test('outside left side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-5, -10), size: Size(70, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.none(view, child, portal), const Offset(-75, -20));
      });

      test('outside top side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset.zero, size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.none(view, child, portal), const Offset(-10, -70));
      });

      test('outside top side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const portal = (offset: Offset(-5, -10), size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.none(view, child, portal), const Offset(-15, -80));
      });

      test('outside right side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset.zero, size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.none(view, child, portal), const Offset(50, -10));
      });

      test('outside right side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topRight);
        const portal = (offset: Offset(5, -10), size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.none(view, child, portal), const Offset(55, -20));
      });

      test('outside bottom side', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset.zero, size: Size(10, 70), anchor: Alignment.topLeft);

        expect(FPortalShift.none(view, child, portal), const Offset(50, 50));
      });

      test('outside bottom side, non-zero offset', () {
        const child = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const portal = (offset: Offset(5, 10), size: Size(10, 70), anchor: Alignment.topLeft);

        expect(FPortalShift.none(view, child, portal), const Offset(55, 60));
      });
    });
  });
}

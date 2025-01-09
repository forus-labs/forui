import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/foundation/portal/portal_shift.dart';

void main() {
  group('FPortalShift', () {
    const view = Size(100, 100);

    group('flip', () {
      test('inside', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const follower = (size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.flip(view, target, follower), const Offset(-10, 50));
      });

      test('outside left side, flip', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(30, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, target, follower), const Offset(50, -10));
      });

      test('outside left side, cannot flip', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(50, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, target, follower), const Offset(-20, -10));
      });

      test('outside top side, flip', () {
        const target = (offset: Offset(20, 20), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(10, 30), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, target, follower), const Offset(-10, 50));
      });

      test('outside top side, cannot flip', () {
        const target = (offset: Offset(20, 20), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.flip(view, target, follower), const Offset(-10, -20));
      });

      test('outside right side, flip', () {
        const target = (offset: Offset(30, 20), size: Size(50, 50), anchor: Alignment.topRight);
        const follower = (size: Size(30, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.flip(view, target, follower), const Offset(-30, -10));
      });

      test('outside right side, cannot flip', () {
        const target = (offset: Offset(30, 20), size: Size(50, 50), anchor: Alignment.topRight);
        const follower = (size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.flip(view, target, follower), const Offset(0, -10));
      });

      test('outside bottom side, flip', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const follower = (size: Size(10, 30), anchor: Alignment.topLeft);

        expect(FPortalShift.flip(view, target, follower), const Offset(50, -30));
      });

      test('outside bottom side, cannot flip', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const follower = (size: Size(10, 50), anchor: Alignment.topLeft);

        expect(FPortalShift.flip(view, target, follower), const Offset(50, 20));
      });
    });

    group('along', () {
      test('inside', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const follower = (size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.along(view, target, follower), const Offset(-10, 50));
      });

      test('outside left side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(70, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.along(view, target, follower), const Offset(-20, -10));
      });

      test('outside top side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.along(view, target, follower), const Offset(-10, -30));
      });

      test('outside right side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topRight);
        const follower = (size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.along(view, target, follower), const Offset(10, -10));
      });

      test('outside bottom side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const follower = (size: Size(10, 70), anchor: Alignment.topLeft);

        expect(FPortalShift.along(view, target, follower), const Offset(50, 0));
      });
    });

    group('none()', () {
      test('inside', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomLeft);
        const follower = (size: Size(10, 15), anchor: Alignment.topRight);

        expect(FPortalShift.none(view, target, follower), const Offset(-10, 50));
      });

      test('outside left side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(70, 10), anchor: Alignment.bottomRight);

        expect(FPortalShift.none(view, target, follower), const Offset(-70, -10));
      });

      test('outside top side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topLeft);
        const follower = (size: Size(10, 70), anchor: Alignment.bottomRight);

        expect(FPortalShift.none(view, target, follower), const Offset(-10, -70));
      });

      test('outside right side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.topRight);
        const follower = (size: Size(70, 10), anchor: Alignment.bottomLeft);

        expect(FPortalShift.none(view, target, follower), const Offset(50, -10));
      });

      test('outside bottom side', () {
        const target = (offset: Offset(20, 30), size: Size(50, 50), anchor: Alignment.bottomRight);
        const follower = (size: Size(10, 70), anchor: Alignment.topLeft);

        expect(FPortalShift.none(view, target, follower), const Offset(50, 50));
      });
    });
  });
}

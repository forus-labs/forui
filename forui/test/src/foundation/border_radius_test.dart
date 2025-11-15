import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FLerpBorderRadius', () {
    for (final (Rect rect, RRect expected) in [
      (const .fromLTWH(0, 0, 30, 30), .fromLTRBR(0.0, 0.0, 30.0, 30.0, const .circular(10))),
      (const .fromLTWH(0, 0, 15, 35), .fromLTRBR(0.0, 0.0, 15.0, 35.0, const .circular(5))),
    ]) {
      test('toRRect', () {
        const radius = FLerpBorderRadius.all(.circular(10), min: 30);
        expect(radius.toRRect(rect), expected);
      });
    }
  });
}

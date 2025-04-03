import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FLerpBorderRadius', () {
    for (final (rect, expected) in [
      (const Rect.fromLTWH(0, 0, 30, 30), RRect.fromLTRBR(0.0, 0.0, 30.0, 30.0, const Radius.circular(10))),
      (const Rect.fromLTWH(0, 0, 15, 35), RRect.fromLTRBR(0.0, 0.0, 15.0, 35.0, const Radius.circular(5))),
    ]) {
      test('toRRect', () {
        const radius = FLerpBorderRadius.all(Radius.circular(10), min: 30);
        expect(radius.toRRect(rect), expected);
      });
    }
  });
}

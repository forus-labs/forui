import 'package:flutter/rendering.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FSliderMark', () {
    for (final constructor in [() => FSliderMark(value: -0.1), () => FSliderMark(value: 1.1)]) {
      test('constructor', () => expect(constructor, throwsAssertionError));
    }
  });

  group('FSliderMarkStyle', () {
    test('constructor', () {
      expect(
        () => FSliderMarkStyle(
          tickColor: FWidgetStateMap.all(const Color(0xFF000000)),
          tickSize: -1,
          labelTextStyle: FWidgetStateMap.all(const TextStyle()),
          labelAnchor: Alignment.center,
          labelOffset: 0.0,
        ),
        throwsAssertionError,
      );
    });
  });
}

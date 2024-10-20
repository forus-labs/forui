import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/theme/breakpoints.dart';

void main() {
  group('FBreakpoint', () {
    test('==', () => expect(const FBreakpoint(), const FBreakpoint()));

    test('negative min', () => expect(() => FBreakpoint(min: -1), throwsAssertionError));

    test('negative max', () => expect(() => FBreakpoint(max: -1), throwsAssertionError));

    test('max < min', () => expect(() => FBreakpoint(min: 1, max: 0), throwsAssertionError));

    for (final (size, actual) in [
      (const Size(4, 0), false),
      (const Size(5, 0), true),
      (const Size(7, 0), true),
      (const Size(8, 0), false),
    ]) {
      test('contains($size)', () => expect(const FBreakpoint(min: 5, max: 7).contains(size), actual));
    }
  });
}

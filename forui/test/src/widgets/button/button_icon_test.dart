import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FButtonIconStyle', () {
    test('invalid height', () {
      expect(
        () => FButtonIconStyle(
          size: 0,
          enabledColor: Colors.white,
          disabledColor: Colors.white,
        ),
        throwsAssertionError,
      );
    });

    test('valid height', () {
      expect(
        () => FButtonIconStyle(
          size: 1,
          enabledColor: Colors.white,
          disabledColor: Colors.white,
        ),
        returnsNormally,
      );
    });
  });
}

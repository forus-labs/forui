import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FAlertIconStyle', () {
    test('invalid height', () {
      expect(
        () => FAlertIconStyle(
          size: 0,
          color: Colors.white,
        ),
        throwsAssertionError,
      );
    });

    test('valid height', () {
      expect(
        () => FAlertIconStyle(
          size: 1,
          color: Colors.white,
        ),
        returnsNormally,
      );
    });
  });
}

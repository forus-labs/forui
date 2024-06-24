import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  group('FButtonIconStyle', () {
    test('invalid height', () {
      expect(
        () => FButtonIconStyle(height: 0, enabledColor: Colors.white, disabledColor: Colors.white),
        throwsAssertionError,
      );
    });

    test('valid height', () {
      expect(
        () => FButtonIconStyle(height: 1, enabledColor: Colors.white, disabledColor: Colors.white),
        returnsNormally,
      );
    });
  });
}

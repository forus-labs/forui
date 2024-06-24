import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  group('FButton', () {
    for (final (label, rawLabel) in [
      ('', null),
      (null, const SizedBox()),
    ]) {
      testWidgets('constructor does not throw error', (tester) async {
        expect(
          () => FButton(
            label: label,
            rawLabel: rawLabel,
            onPress: () {  },
          ),
          returnsNormally,
        );
      });
    }

    for (final (label, rawLabel) in [
      (null, null),
      ('', const SizedBox()),
    ]) {
      testWidgets('constructor throws error', (tester) async {
        expect(
          () => FButton(
            label: label,
            rawLabel: rawLabel,
            onPress: () {  },
          ),
          throwsAssertionError,
        );
      });
    }
    
  });
}

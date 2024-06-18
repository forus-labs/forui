import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FBadge', () {
    for (final (label, rawLabel) in [
      ('', null),
      (null, const SizedBox()),
    ]) {
      testWidgets('constructor does not throw error', (tester) async {
        expect(
          () => FBadge(
            label: label,
            rawLabel: rawLabel,
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
          () => FBadge(
            label: label,
            rawLabel: rawLabel,
          ),
          throwsAssertionError,
        );
      });
    }
  });
}

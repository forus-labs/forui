import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FDialog', () {
    for (final (string, raw) in [
      (null, null),
      ('', null),
      (null, const SizedBox()),
    ]) {
      testWidgets('constructor title does not throw error', (tester) async {
        expect(
          () => FDialog(
            title: string,
            rawTitle: raw,
            actions: const [],
          ),
          returnsNormally,
        );
      });

      testWidgets('constructor body does not throw error', (tester) async {
        expect(
          () => FDialog(
            body: string,
            rawBody: raw,
            actions: const [],
          ),
          returnsNormally,
        );
      });
    }

    for (final (string, raw) in [
      ('', const SizedBox()),
    ]) {
      testWidgets('constructor title throws error', (tester) async {
        expect(
          () => FDialog(
            title: string,
            rawTitle: raw,
            actions: const [],
          ),
          throwsAssertionError,
        );
      });

      testWidgets('constructor body throws error', (tester) async {
        expect(
          () => FDialog(
            body: string,
            rawBody: raw,
            actions: const [],
          ),
          throwsAssertionError,
        );
      });
    }
  });
}

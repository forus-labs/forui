import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FCard', () {
    for (final (string, raw) in [
      (null, null),
      ('', null),
      (null, const SizedBox()),
    ]) {
      testWidgets('constructor title does not throw error', (tester) async {
        expect(
          () => FCard(
            title: string,
            rawTitle: raw,
          ),
          returnsNormally,
        );
      });

      testWidgets('constructor subtitle does not throw error', (tester) async {
        expect(
          () => FCard(
            subtitle: string,
            rawSubtitle: raw,
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
          () => FCard(
            title: string,
            rawTitle: raw,
          ),
          throwsAssertionError,
        );
      });

      testWidgets('constructor subtitle throws error', (tester) async {
        expect(
          () => FCard(
            subtitle: string,
            rawSubtitle: raw,
          ),
          throwsAssertionError,
        );
      });
    }
  });
}

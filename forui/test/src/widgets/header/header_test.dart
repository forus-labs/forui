import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FHeader', () {
    for (final (title, rawTitle) in [
      ('', null),
      (null, const SizedBox()),
    ]) {
      testWidgets('constructor does not throw error', (tester) async {
        expect(
          () => FHeader(
            title: title,
            rawTitle: rawTitle,
          ),
          returnsNormally,
        );
      });
    }

    for (final (title, rawTitle) in [
      (null, null),
      ('', const SizedBox()),
    ]) {
      testWidgets('constructor throws error', (tester) async {
        expect(
          () => FHeader(
            title: title,
            rawTitle: rawTitle,
          ),
          throwsAssertionError,
        );
      });
    }
  });
}

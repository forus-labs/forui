import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/alignment.dart';

void main() {
  group('Alignments', () {
    for (final (alignment, opposite) in [
      (Alignment.topLeft, Alignment.topRight),
      (Alignment.topCenter, Alignment.topCenter),
      (Alignment.topRight, Alignment.topLeft),
      (Alignment.centerLeft, Alignment.centerRight),
      (Alignment.center, Alignment.center),
      (Alignment.centerRight, Alignment.centerLeft),
      (Alignment.bottomLeft, Alignment.bottomRight),
      (Alignment.bottomCenter, Alignment.bottomCenter),
      (Alignment.bottomRight, Alignment.bottomLeft),
    ]) {
      test('flipX()', () => expect(alignment.flipX(), opposite));
    }

    for (final (alignment, opposite) in [
      (Alignment.topLeft, Alignment.bottomLeft),
      (Alignment.topCenter, Alignment.bottomCenter),
      (Alignment.topRight, Alignment.bottomRight),
      (Alignment.centerLeft, Alignment.centerLeft),
      (Alignment.center, Alignment.center),
      (Alignment.centerRight, Alignment.centerRight),
      (Alignment.bottomLeft, Alignment.topLeft),
      (Alignment.bottomCenter, Alignment.topCenter),
      (Alignment.bottomRight, Alignment.topRight),
    ]) {
      test('flipY()', () => expect(alignment.flipY(), opposite));
    }

    for (final (alignment, offset) in [
      (Alignment.topLeft, Offset.zero),
      (Alignment.topCenter, const Offset(25, 0)),
      (Alignment.topRight, const Offset(50, 0)),
      (Alignment.centerLeft, const Offset(0, 50)),
      (Alignment.center, const Offset(25, 50)),
      (Alignment.centerRight, const Offset(50, 50)),
      (Alignment.bottomLeft, const Offset(0, 100)),
      (Alignment.bottomCenter, const Offset(25, 100)),
      (Alignment.bottomRight, const Offset(50, 100)),
    ]) {
      test('relative()', () => expect(alignment.relative(to: const Size(50, 100)), offset));
    }
  });
}

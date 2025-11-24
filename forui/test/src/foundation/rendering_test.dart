import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/src/foundation/rendering.dart';

void main() {
  group('Alignments', () {
    for (final (Alignment alignment, Alignment opposite) in [
      (.topLeft, .topRight),
      (.topCenter, .topCenter),
      (.topRight, .topLeft),
      (.centerLeft, .centerRight),
      (.center, .center),
      (.centerRight, .centerLeft),
      (.bottomLeft, .bottomRight),
      (.bottomCenter, .bottomCenter),
      (.bottomRight, .bottomLeft),
    ]) {
      test('flipX()', () => expect(alignment.flipX(), opposite));
    }

    for (final (Alignment alignment, Alignment opposite) in [
      (.topLeft, .bottomLeft),
      (.topCenter, .bottomCenter),
      (.topRight, .bottomRight),
      (.centerLeft, .centerLeft),
      (.center, .center),
      (.centerRight, .centerRight),
      (.bottomLeft, .topLeft),
      (.bottomCenter, .topCenter),
      (.bottomRight, .topRight),
    ]) {
      test('flipY()', () => expect(alignment.flipY(), opposite));
    }

    for (final (Alignment alignment, offset) in [
      (.topLeft, Offset.zero),
      (.topCenter, const Offset(25, 0)),
      (.topRight, const Offset(50, 0)),
      (.centerLeft, const Offset(0, 50)),
      (.center, const Offset(25, 50)),
      (.centerRight, const Offset(50, 50)),
      (.bottomLeft, const Offset(0, 100)),
      (.bottomCenter, const Offset(25, 100)),
      (.bottomRight, const Offset(50, 100)),
    ]) {
      test('relative()', () => expect(alignment.relative(to: const Size(50, 100)), offset));
    }
  });
}

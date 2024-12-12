import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/foundation/rendering.dart';

void main() {
  group('Alignments', () {
    const insets = EdgeInsets.only(left: 1, top: 2, right: 3, bottom: 4);

    for (final (follower, target, expected) in [
      (Alignment.topLeft, Alignment.topLeft, const Offset(-1, -2)),
      (Alignment.topLeft, Alignment.topCenter, const Offset(-1, -2)),
      (Alignment.topLeft, Alignment.topRight, const Offset(0, -2)),
      (Alignment.topLeft, Alignment.centerLeft, const Offset(-1, -2)),
      (Alignment.topLeft, Alignment.center, const Offset(-1, -2)),
      (Alignment.topLeft, Alignment.centerRight, const Offset(0, -2)),
      (Alignment.topLeft, Alignment.bottomLeft, const Offset(-1, 0)),
      (Alignment.topLeft, Alignment.bottomCenter, const Offset(-1, 0)),
      (Alignment.topLeft, Alignment.bottomRight, Offset.zero),
      //
      (Alignment.topCenter, Alignment.topLeft, const Offset(0, -2)),
      (Alignment.topCenter, Alignment.topCenter, const Offset(0, -2)),
      (Alignment.topCenter, Alignment.topRight, const Offset(0, -2)),
      (Alignment.topCenter, Alignment.centerLeft, const Offset(0, -2)),
      (Alignment.topCenter, Alignment.center, const Offset(0, -2)),
      (Alignment.topCenter, Alignment.centerRight, const Offset(0, -2)),
      (Alignment.topCenter, Alignment.bottomLeft, Offset.zero),
      (Alignment.topCenter, Alignment.bottomCenter, Offset.zero),
      (Alignment.topCenter, Alignment.bottomRight, Offset.zero),
      //
      (Alignment.topRight, Alignment.topLeft, const Offset(0, -2)),
      (Alignment.topRight, Alignment.topCenter, const Offset(3, -2)),
      (Alignment.topRight, Alignment.topRight, const Offset(3, -2)),
      (Alignment.topRight, Alignment.centerLeft, const Offset(0, -2)),
      (Alignment.topRight, Alignment.center, const Offset(3, -2)),
      (Alignment.topRight, Alignment.centerRight, const Offset(3, -2)),
      (Alignment.topRight, Alignment.bottomLeft, Offset.zero),
      (Alignment.topRight, Alignment.bottomCenter, const Offset(3, 0)),
      (Alignment.topRight, Alignment.bottomRight, const Offset(3, 0)),
      //
      (Alignment.centerLeft, Alignment.topLeft, const Offset(-1, 0)),
      (Alignment.centerLeft, Alignment.topCenter, const Offset(-1, 0)),
      (Alignment.centerLeft, Alignment.topRight, Offset.zero),
      (Alignment.centerLeft, Alignment.centerLeft, const Offset(-1, 0)),
      (Alignment.centerLeft, Alignment.center, const Offset(-1, 0)),
      (Alignment.centerLeft, Alignment.centerRight, Offset.zero),
      (Alignment.centerLeft, Alignment.bottomLeft, const Offset(-1, 0)),
      (Alignment.centerLeft, Alignment.bottomCenter, const Offset(-1, 0)),
      (Alignment.centerLeft, Alignment.bottomRight, Offset.zero),
      //
      (Alignment.center, Alignment.topLeft, Offset.zero),
      (Alignment.center, Alignment.topCenter, Offset.zero),
      (Alignment.center, Alignment.topRight, Offset.zero),
      (Alignment.center, Alignment.centerLeft, Offset.zero),
      (Alignment.center, Alignment.center, Offset.zero),
      (Alignment.center, Alignment.centerRight, Offset.zero),
      (Alignment.center, Alignment.bottomLeft, Offset.zero),
      (Alignment.center, Alignment.bottomCenter, Offset.zero),
      (Alignment.center, Alignment.bottomRight, Offset.zero),
      //
      (Alignment.centerRight, Alignment.topLeft, Offset.zero),
      (Alignment.centerRight, Alignment.topCenter, const Offset(3, 0)),
      (Alignment.centerRight, Alignment.topRight, const Offset(3, 0)),
      (Alignment.centerRight, Alignment.centerLeft, Offset.zero),
      (Alignment.centerRight, Alignment.center, const Offset(3, 0)),
      (Alignment.centerRight, Alignment.centerRight, const Offset(3, 0)),
      (Alignment.centerRight, Alignment.bottomLeft, Offset.zero),
      (Alignment.centerRight, Alignment.bottomCenter, const Offset(3, 0)),
      (Alignment.centerRight, Alignment.bottomRight, const Offset(3, 0)),
      //
      (Alignment.bottomLeft, Alignment.topLeft, const Offset(-1, 0)),
      (Alignment.bottomLeft, Alignment.topCenter, const Offset(-1, 0)),
      (Alignment.bottomLeft, Alignment.topRight, Offset.zero),
      (Alignment.bottomLeft, Alignment.centerLeft, const Offset(-1, 4)),
      (Alignment.bottomLeft, Alignment.center, const Offset(-1, 4)),
      (Alignment.bottomLeft, Alignment.centerRight, const Offset(0, 4)),
      (Alignment.bottomLeft, Alignment.bottomLeft, const Offset(-1, 4)),
      (Alignment.bottomLeft, Alignment.bottomCenter, const Offset(-1, 4)),
      (Alignment.bottomLeft, Alignment.bottomRight, const Offset(0, 4)),
      //
      (Alignment.bottomCenter, Alignment.topLeft, Offset.zero),
      (Alignment.bottomCenter, Alignment.topCenter, Offset.zero),
      (Alignment.bottomCenter, Alignment.topRight, Offset.zero),
      (Alignment.bottomCenter, Alignment.centerLeft, const Offset(0, 4)),
      (Alignment.bottomCenter, Alignment.center, const Offset(0, 4)),
      (Alignment.bottomCenter, Alignment.centerRight, const Offset(0, 4)),
      (Alignment.bottomCenter, Alignment.bottomLeft, const Offset(0, 4)),
      (Alignment.bottomCenter, Alignment.bottomCenter, const Offset(0, 4)),
      (Alignment.bottomCenter, Alignment.bottomRight, const Offset(0, 4)),
      //
      (Alignment.bottomRight, Alignment.topLeft, Offset.zero),
      (Alignment.bottomRight, Alignment.topCenter, const Offset(3, 0)),
      (Alignment.bottomRight, Alignment.topRight, const Offset(3, 0)),
      (Alignment.bottomRight, Alignment.centerLeft, const Offset(0, 4)),
      (Alignment.bottomRight, Alignment.center, const Offset(3, 4)),
      (Alignment.bottomRight, Alignment.centerRight, const Offset(3, 4)),
      (Alignment.bottomRight, Alignment.bottomLeft, const Offset(0, 4)),
      (Alignment.bottomRight, Alignment.bottomCenter, const Offset(3, 4)),
      (Alignment.bottomRight, Alignment.bottomRight, const Offset(3, 4)),
    ]) {
      test(
        'removeDirectionalPadding - $follower - $target',
        () => expect(Alignments.removeDirectionalPadding(insets, follower, target), expected),
      );
    }

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

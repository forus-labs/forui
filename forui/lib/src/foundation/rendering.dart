import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

/// Possible way to layout a sequence of items.
enum FLayout {
  /// Lays out the items horizontally from left to right.
  ltr(vertical: false),

  /// Lays out the items horizontally from right to left.
  rtl(vertical: false),

  /// Lays out the items vertically from top to bottom.
  ttb(vertical: true),

  /// Lays out the items vertically from bottom to top.
  btt(vertical: true);

  /// Whether the layout is vertical.
  final bool vertical;

  const FLayout({required this.vertical});
}

@internal
extension RenderBoxes on RenderBox {
  BoxParentData get data => parentData! as BoxParentData;
}

@internal
extension Alignments on Alignment {
  Alignment flipX() => switch (this) {
    Alignment.topLeft => Alignment.topRight,
    Alignment.topRight => Alignment.topLeft,
    Alignment.centerLeft => Alignment.centerRight,
    Alignment.centerRight => Alignment.centerLeft,
    Alignment.bottomLeft => Alignment.bottomRight,
    Alignment.bottomRight => Alignment.bottomLeft,
    _ => this,
  };

  Alignment flipY() => switch (this) {
    Alignment.topLeft => Alignment.bottomLeft,
    Alignment.topCenter => Alignment.bottomCenter,
    Alignment.topRight => Alignment.bottomRight,
    Alignment.bottomLeft => Alignment.topLeft,
    Alignment.bottomCenter => Alignment.topCenter,
    Alignment.bottomRight => Alignment.topRight,
    _ => this,
  };

  Offset relative({required Size to, Offset origin = Offset.zero}) => switch (this) {
    Alignment.topCenter => to.topCenter(origin),
    Alignment.topRight => to.topRight(origin),
    Alignment.centerLeft => to.centerLeft(origin),
    Alignment.center => to.center(origin),
    Alignment.centerRight => to.centerRight(origin),
    Alignment.bottomLeft => to.bottomLeft(origin),
    Alignment.bottomCenter => to.bottomCenter(origin),
    Alignment.bottomRight => to.bottomRight(origin),
    _ => to.topLeft(origin),
  };
}

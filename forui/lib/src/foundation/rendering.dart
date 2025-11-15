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
class DefaultData extends ContainerBoxParentData<RenderBox> with ContainerParentDataMixin<RenderBox> {}

@internal
extension RenderBoxes on RenderBox {
  BoxParentData get data => parentData! as BoxParentData;
}

@internal
extension Alignments on Alignment {
  Alignment flipX() => switch (this) {
    .topLeft => .topRight,
    .topRight => .topLeft,
    .centerLeft => .centerRight,
    .centerRight => .centerLeft,
    .bottomLeft => .bottomRight,
    .bottomRight => .bottomLeft,
    _ => this,
  };

  Alignment flipY() => switch (this) {
    .topLeft => .bottomLeft,
    .topCenter => .bottomCenter,
    .topRight => .bottomRight,
    .bottomLeft => .topLeft,
    .bottomCenter => .topCenter,
    .bottomRight => .topRight,
    _ => this,
  };

  Offset relative({required Size to, Offset origin = Offset.zero}) => switch (this) {
    .topCenter => to.topCenter(origin),
    .topRight => to.topRight(origin),
    .centerLeft => to.centerLeft(origin),
    .center => to.center(origin),
    .centerRight => to.centerRight(origin),
    .bottomLeft => to.bottomLeft(origin),
    .bottomCenter => to.bottomCenter(origin),
    .bottomRight => to.bottomRight(origin),
    _ => to.topLeft(origin),
  };
}

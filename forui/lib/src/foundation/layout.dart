import 'package:flutter/gestures.dart';

/// Possible way to layout a sequence of items.
enum Layout {
  /// Lays out the items horizontally from left to right.
  ltr(vertical: false),

  /// Lays out the items horizontally from right to left.
  rtl(vertical: false),

  /// Lays out the items vertically from bottom to top.
  ttb(vertical: true),

  /// Lays out the items vertically from top to bottom.
  btt(vertical: true);

  /// Whether the layout is vertical.
  final bool vertical;

  const Layout({required this.vertical});

  /// Translates the main axis of the offset from a coordinate system that originates from the top-left corner of the
  /// widget to one that is relative to the layout's origin.
  ///
  /// For example, given a [Layout.btt], an offset of `(0, 100)` will be translated to `(0, -100)`, and `-100` will be
  /// returned.
  double translate(Offset offset) => switch (this) {
    Layout.ltr => offset.dx,
    Layout.rtl => -offset.dx,
    Layout.ttb => offset.dy,
    Layout.btt => -offset.dy,
  };
}

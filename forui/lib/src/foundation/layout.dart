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
}

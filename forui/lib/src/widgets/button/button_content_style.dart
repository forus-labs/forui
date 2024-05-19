import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// [FButtonContent]'s style.
class FButtonContentStyle {
  /// The padding.
  final EdgeInsets padding;

  /// The title.
  final TextStyle text;

  /// The icon color.
  final Color color;

  /// Creates a [FButtonContentStyle].
  const FButtonContentStyle({required this.padding, required this.text, required this.color});

  /// Creates a [FButtonContentStyle] that inherits its properties from [style] and [font].
  FButtonContentStyle.inherit({required FStyleData style, required FFontData font})
      : padding = const EdgeInsets.fromLTRB(16, 12, 16, 16),
        text = ScaledTextStyle(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: style.foreground,
          ),
          font,
        ),
        color = Colors.white;
}

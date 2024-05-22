import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// [FButtonContent]'s style.
class FButtonContentStyle {
  /// The title.
  final TextStyle text;

  /// Creates a [FButtonContentStyle].
  const FButtonContentStyle({
    required this.text,
  });

  /// Creates a [FButtonContentStyle] that inherits its properties from [style] and [font].
  FButtonContentStyle.inherit({required FStyleData style, required FFontData font})
      : text = ScaledTextStyle(
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            //TODO: How do I make this specific to Button Type
            color: style.primaryForeground,
          ),
          font,
        );
}

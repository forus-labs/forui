import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// [FBox]'s style.
class FBoxStyle {
  /// The color.
  final Color color;

  /// The text.
  final TextStyle text;

  /// Creates a [FBoxStyle].
  const FBoxStyle({required this.color, required this.text});

  /// Creates a [FBoxStyle] that inherits its properties from [data] and [style].
  FBoxStyle.inherit({required FFontData data, required FStyleData style}):
    color = style.background, text = TextStyleBuilder.inherit(data, const TextStyle(fontSize: 20));
}

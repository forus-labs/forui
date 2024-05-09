import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A class that holds the styles for [FBox].
class FBoxStyle {
  /// The color.
  final Color color;

  /// The text.
  final TextStyle text;

  /// Creates a [FBoxStyle].
  const FBoxStyle({required this.color, required this.text});

  /// Creates a [FBoxStyle] that inherits the properties from the given [FFontData].
  FBoxStyle.inherit({required FFontData data, required FStyleData style}):
    color = style.background, text = TextStyleBuilder.inherit(data, const TextStyle(fontSize: 20));
}

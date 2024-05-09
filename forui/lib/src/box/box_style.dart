import 'package:flutter/material.dart';

import 'package:forui/src/theme/font/font_data.dart';
import 'package:forui/src/theme/font/text_style_builder.dart';
import 'package:forui/src/theme/style_data.dart';
import 'package:forui/src/box/box.dart';

/// A class that holds the styles for [FBox].
class FBoxStyle {
  /// The color.
  final Color color;

  /// The text.
  final TextStyle text; // TextStyleBuilder

  /// Creates a [FBoxStyle].
  const FBoxStyle({required this.color, required this.text});

  /// Creates a [FBoxStyle] that inherits the properties from the given [FFontData].
  FBoxStyle.inherit({required FFontData data, required FStyleData style}):
    color = style.background, text = TextStyleBuilder.inherit(data, const TextStyle(fontSize: 20));
}

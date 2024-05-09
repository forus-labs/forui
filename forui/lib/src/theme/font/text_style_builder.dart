import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A [TextStyle] that scales its properties by factors.
/// 
/// The scaled properties are:
/// * Font size
/// * Height
/// * Letter spacing
/// * Word spacing
extension type TextStyleBuilder._(TextStyle style) implements TextStyle {
  /// Creates a [TextStyle] that inherits the properties from the given [FFontData].
  TextStyleBuilder.inherit(FFontData data, TextStyle style)
      : style = TextStyle(
    fontSize: _calculateFactor(style.fontSize, data.fontSize),
    letterSpacing: _calculateFactor(style.letterSpacing, data.letterSpacing),
    wordSpacing: _calculateFactor(style.wordSpacing, data.wordSpacing),
    height: _calculateFactor(style.height, data.height),
  );

  static double? _calculateFactor(double? value, double factor) => value == null ? null : value * factor;
}

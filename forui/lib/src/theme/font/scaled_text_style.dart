import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// A [TextStyle] that scales its properties by factors.
/// 
/// The scaled properties are:
/// * Font size
/// * Height
/// * Letter spacing
/// * Word spacing
extension type ScaledTextStyle._(TextStyle style) implements TextStyle {
  /// Creates a [TextStyle] that inherits the properties from the given [FFontData].
  ScaledTextStyle(TextStyle base, FFontData data): style = base.copyWith(
    fontFamily: data.fontFamily,
    fontSize: _calculateFactor(base.fontSize, data.fontSizeScalar),
    letterSpacing: _calculateFactor(base.letterSpacing, data.letterSpacingScalar),
    wordSpacing: _calculateFactor(base.wordSpacing, data.wordSpacingScalar),
    height: _calculateFactor(base.height, data.heightScalar),
  );

  static double? _calculateFactor(double? value, double factor) => value == null ? null : value * factor;
}

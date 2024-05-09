import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/theme/theme.dart';

/// The font data that is inherited from a [FTheme] deigned to be utilized by [ScaledTextStyle] and child Forui widgets.
///
/// This class contains scalar values that are multiplied with the corresponding properties on [TextStyle] to ensure
/// that various fonts are scaled consistently across the application.
class FFontData {
  /// The font size scalar that multiplies with the `fontSize` property on [TextStyle].
  final double fontSizeScalar;

  /// The letter spacing scalar that multiplies with the `letterSpacing` property on [TextStyle].
  final double letterSpacingScalar;

  /// The word spacing scalar that multiplies with the `wordSpacing` property on [TextStyle].
  final double wordSpacingScalar;

  /// The height scalar that multiplies with the `height` property on [TextStyle].
  final double heightScalar;

  /// Creates a [FFontData].
  const FFontData({
    this.fontSizeScalar = 1,
    this.letterSpacingScalar = 1,
    this.wordSpacingScalar = 1,
    this.heightScalar = 1,
  });

  /// Creates a copy of this [FFontData] with the given properties replaced.
  FFontData copyWith({
    double? fontSizeScalar,
    double? letterSpacingScalar,
    double? wordSpacingScalar,
    double? heightScalar,
  }) =>
      FFontData(
        fontSizeScalar: fontSizeScalar ?? this.fontSizeScalar,
        letterSpacingScalar: letterSpacingScalar ?? this.letterSpacingScalar,
        wordSpacingScalar: wordSpacingScalar ?? this.wordSpacingScalar,
        heightScalar: heightScalar ?? this.heightScalar,
      );
}

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// The font data that is inherited from a [FTheme] by child Forui widgets and [ScaledTextStyle]s.
///
/// This class contains scalar values that are multiplied with the corresponding properties on [TextStyle] to ensure
/// that various fonts are scaled consistently across the application.
class FFontData {
  /// The font family.
  final String fontFamily;

  /// A value used to scale [TextStyle.fontSize].
  final double fontSizeScalar;

  /// A value used to scale [TextStyle.letterSpacing].
  final double letterSpacingScalar;

  /// A value used to scale [TextStyle.wordSpacing].
  final double wordSpacingScalar;

  /// A value used to scale [TextStyle.height].
  final double heightScalar;

  /// Creates a [FFontData].
  const FFontData({
    this.fontFamily = 'Inter',
    this.fontSizeScalar = 1,
    this.letterSpacingScalar = 1,
    this.wordSpacingScalar = 1,
    this.heightScalar = 1,
  });

  /// Creates a copy of this [FFontData] with the given properties replaced.
  FFontData copyWith({
    String? fontFamily,
    double? fontSizeScalar,
    double? letterSpacingScalar,
    double? wordSpacingScalar,
    double? heightScalar,
  }) =>
      FFontData(
        fontFamily: fontFamily ?? this.fontFamily,
        fontSizeScalar: fontSizeScalar ?? this.fontSizeScalar,
        letterSpacingScalar: letterSpacingScalar ?? this.letterSpacingScalar,
        wordSpacingScalar: wordSpacingScalar ?? this.wordSpacingScalar,
        heightScalar: heightScalar ?? this.heightScalar,
      );
}

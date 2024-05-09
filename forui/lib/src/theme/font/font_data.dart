import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/theme/theme.dart';

/// The default font data that is inherited from a [FTheme] by child Forui widgets.
class FFontData {
  /// The size that corresponds to the `fontSize` property on [TextStyle].
  final double fontSize;

  /// The letter spacing that corresponds to the `letterSpacing` property on [TextStyle].
  final double letterSpacing;

  /// The word spacing that corresponds to the `wordSpacing` property on [TextStyle].
  final double wordSpacing;

  /// The height that corresponds to the `height` property on [TextStyle].
  final double height;

  /// Creates a [FFontData].
  const FFontData({
    this.fontSize = 1,
    this.letterSpacing = 1,
    this.wordSpacing = 1,
    this.height = 1,
  });

  /// Creates a copy of this [FFontData] with the given properties replaced.
  FFontData copyWith({double? fontSize, double? letterSpacing, double? wordSpacing, double? height}) => FFontData(
        fontSize: fontSize ?? this.fontSize,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        wordSpacing: wordSpacing ?? this.wordSpacing,
        height: height ?? this.height,
      );
}

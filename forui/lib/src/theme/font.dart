import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:sugar/core.dart';

/// A Forui font that used to configure the [TextStyle]s of Forui widgets.
///
/// It is usually inherited from a ancestor [FTheme]. Besides the typical font information, a [FFont] also contains
/// scalar values used to scale a [TextStyle]'s corresponding properties. This ensures that various fonts are scaled
/// consistently throughout an application.
final class FFont with Diagnosticable {

  /// The font family. Defaults to `packages/forui/Inter`.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if blank.
  final String family;

  /// A value used to scale [TextStyle.fontSize]. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `sizeScalar` <= 0.0
  /// * `sizeScalar` is NaN
  final double sizeScalar;

  /// A value used to scale [TextStyle.letterSpacing]. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `letterSpacingScalar` <= 0.0
  /// * `letterSpacingScalar` is NaN
  final double letterSpacingScalar;

  /// A value used to scale [TextStyle.wordSpacing]. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `wordSpacingScalar` <= 0.0
  /// * `wordSpacingScalar` is NaN
  final double wordSpacingScalar;

  /// A value used to scale [TextStyle.height]. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `heightScalar` <= 0.0
  /// * `heightScalar` is NaN
  final double heightScalar;

  /// Creates a [FFont].
  FFont({
    this.family = 'packages/forui/Inter',
    this.sizeScalar = 1,
    this.letterSpacingScalar = 1,
    this.wordSpacingScalar = 1,
    this.heightScalar = 1,
  }):
    assert(family.isNotBlank, 'Font family should not be blank.'),
    assert(0 < sizeScalar, 'The sizeScalar is $sizeScalar, but it should be in range "0 < sizeScalar"'),
    assert(0 < letterSpacingScalar, 'The letterSpacingScalar is $letterSpacingScalar, but it should be in range "0 < letterSpacingScalar"'),
    assert(0 < wordSpacingScalar, 'The wordSpacingScalar is $wordSpacingScalar, but it should be in range "0 < wordSpacingScalar"'),
    assert(0 < heightScalar, 'The heightScalar is $heightScalar, but it should be in range "0 < heightScalar"');

  /// Creates a copy of this [FFont] with the given properties replaced.
  FFont copyWith({
    String? family,
    double? sizeScalar,
    double? letterSpacingScalar,
    double? wordSpacingScalar,
    double? heightScalar,
  }) =>
      FFont(
        family: family ?? this.family,
        sizeScalar: sizeScalar ?? this.sizeScalar,
        letterSpacingScalar: letterSpacingScalar ?? this.letterSpacingScalar,
        wordSpacingScalar: wordSpacingScalar ?? this.wordSpacingScalar,
        heightScalar: heightScalar ?? this.heightScalar,
      );

  /// Returns a [TextStyle] with the given properties, based on and scaled using this [FFont].
  ///
  /// ```dart
  /// final font = FFont(
  ///   family: 'packages/forui/my-font',
  ///   sizeScalar: 2,
  ///   letterSpacingScalar: 3,
  ///   wordSpacingScalar: 4,
  ///   heightScalar: 5,
  /// );
  ///
  /// final style = font.toTextStyle(
  ///   fontSize: 1,
  ///   letterSpacing: 1,
  ///   wordSpacing: 1,
  ///   height: 1,
  /// );
  ///
  /// print(style.fontFamily); // 'packages/forui/my-font'
  /// print(style.fontSize); // 2
  /// print(style.letterSpacing); // 3
  /// print(style.wordSpacing); // 4
  /// print(style.height); // 5
  /// ```
  TextStyle toTextStyle({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    TextOverflow? overflow,
  }) => TextStyle(
    inherit: inherit,
    color: color,
    backgroundColor: backgroundColor,
    fontSize: _scale(fontSize, sizeScalar),
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: _scale(letterSpacing, letterSpacingScalar),
    wordSpacing: _scale(wordSpacing, wordSpacingScalar),
    textBaseline: textBaseline,
    height: _scale(height, heightScalar),
    leadingDistribution: leadingDistribution,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    fontVariations: fontVariations,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    debugLabel: debugLabel,
    fontFamily: family,
    overflow: overflow,
  );

  double? _scale(double? value, double factor) => value == null ? null : value * factor;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('family', family, defaultValue: 'packages/forui/Inter'))
      ..add(DoubleProperty('sizeScalar', sizeScalar, defaultValue: 1))
      ..add(DoubleProperty('letterSpacingScalar', letterSpacingScalar, defaultValue: 1))
      ..add(DoubleProperty('wordSpacingScalar', wordSpacingScalar, defaultValue: 1))
      ..add(DoubleProperty('heightScalar', heightScalar, defaultValue: 1));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FFont &&
    family == other.family &&
    sizeScalar == other.sizeScalar &&
    letterSpacingScalar == other.letterSpacingScalar &&
    wordSpacingScalar == other.wordSpacingScalar &&
    heightScalar == other.heightScalar;

  @override
  int get hashCode =>
    family.hashCode ^
    sizeScalar.hashCode ^
    letterSpacingScalar.hashCode ^
    wordSpacingScalar.hashCode ^
    heightScalar.hashCode;

}

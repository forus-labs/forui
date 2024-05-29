import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:sugar/core.dart';

import 'package:forui/forui.dart';

double? _scale(double? value, double factor) => value == null ? null : value * factor;

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

  /// The font size for extra small text. Defaults to 12.
  /// 
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `xs` <= 0.0
  /// * `xs` is NaN
  final double xs;

  /// The font size for small text. Defaults to 14.
  ///
  /// ## Contract: 
  /// Throws an [AssertionError] if:
  /// * `sm` <= 0.0
  /// * `sm` is NaN
  final double sm;

  /// The font size for base text. Defaults to 16.
  ///
  /// ## Contract: 
  /// Throws an [AssertionError] if:
  /// * `base` <= 0.0
  /// * `base` is NaN
  final double base;

  /// The font size for large text. Defaults to 18.
  ///
  /// ## Contract: 
  /// Throws an [AssertionError] if:
  /// * `lg` <= 0.0
  /// * `lg` is NaN
  final double lg;

  /// The font size for extra large text. Defaults to 20.
  ///
  /// ## Contract: 
  /// Throws an [AssertionError] if:
  /// * `xl` <= 0.0
  /// * `xl` is NaN
  final double xl;

  /// The font size for extra large text. Defaults to 22.
  ///
  /// ## Contract: 
  /// Throws an [AssertionError] if:
  /// * `xl2` <= 0.0
  /// * `xl2` is NaN
  final double xl2;

  /// The font size for extra large text. Defaults to 30.
  ///
  /// Throws an [AssertionError] if:
  /// * `xl3` <= 0.0
  /// * `xl3` is NaN
  final double xl3;

  /// The font size for extra large text. Defaults to 36.
  ///
  /// Throws an [AssertionError] if:
  /// * `xl4` <= 0.0
  /// * `xl4` is NaN
  final double xl4;

  /// The font size for extra large text. Defaults to 48.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `xl5` <= 0.0
  /// * `xl5` is NaN
  final double xl5;

  /// The font size for extra large text. Defaults to 60.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `xl6` <= 0.0
  /// * `xl6` is NaN
  final double xl6;

  /// The font size for extra large text. Defaults to 72.
  ///
  /// Throws an [AssertionError] if:
  /// * `xl7` <= 0.0
  /// * `xl7` is NaN
  final double xl7;

  /// The font size for extra large text. Defaults to 96.
  ///
  /// Throws an [AssertionError] if:
  /// * `xl8` <= 0.0
  /// * `xl8` is NaN
  final double xl8;

  /// Creates a [FFont].
  FFont({
    this.family = 'packages/forui/Inter',
    this.sizeScalar = 1,
    this.letterSpacingScalar = 1,
    this.wordSpacingScalar = 1,
    this.heightScalar = 1,
    this.xs = 12,
    this.sm = 14,
    this.base = 16,
    this.lg = 18,
    this.xl = 20,
    this.xl2 = 22,
    this.xl3 = 30,
    this.xl4 = 36,
    this.xl5 = 48,
    this.xl6 = 60,
    this.xl7 = 72,
    this.xl8 = 96,
  }):
    assert(family.isNotBlank, 'Font family should not be blank.'),
    assert(0 < sizeScalar, 'The sizeScalar is $sizeScalar, but it should be in the range "0 < sizeScalar".'),
    assert(0 < letterSpacingScalar, 'The letterSpacingScalar is $letterSpacingScalar, but it should be in the range "0 < letterSpacingScalar".'),
    assert(0 < wordSpacingScalar, 'The wordSpacingScalar is $wordSpacingScalar, but it should be in the range "0 < wordSpacingScalar".'),
    assert(0 < heightScalar, 'The heightScalar is $heightScalar, but it should be in the range "0 < heightScalar".'),
    assert(0 < xs, 'The xs is $xs, but it should be in the range "0 < xs".'),
    assert(0 < sm, 'The sm is $sm, but it should be in the range "0 < sm".'),
    assert(0 < base, 'The base is $base, but it should be in the range "0 < base".'),
    assert(0 < lg, 'The lg is $lg, but it should be in the range "0 < lg".'),
    assert(0 < xl, 'The xl is $xl, but it should be in the range "0 < xl".'),
    assert(0 < xl2, 'The xl2 is $xl2, but it should be in the range "0 < xl2".'),
    assert(0 < xl3, 'The xl3 is $xl3, but it should be in the range "0 < xl3".'),
    assert(0 < xl4, 'The xl4 is $xl4, but it should be in the range "0 < xl4".'),
    assert(0 < xl5, 'The xl5 is $xl5, but it should be in the range "0 < xl5".'),
    assert(0 < xl6, 'The xl6 is $xl6, but it should be in the range "0 < xl6".'),
    assert(0 < xl7, 'The xl7 is $xl7, but it should be in the range "0 < xl7".'),
    assert(0 < xl8, 'The xl8 is $xl8, but it should be in the range "0 < xl8".');

  /// Creates a copy of this [FFont] with the given properties replaced.
  FFont copyWith({
    String? family,
    double? sizeScalar,
    double? letterSpacingScalar,
    double? wordSpacingScalar,
    double? heightScalar,
    double? xs,
    double? sm,
    double? base,
    double? lg,
    double? xl,
    double? xl2,
    double? xl3,
    double? xl4,
    double? xl5,
    double? xl6,
    double? xl7,
    double? xl8,
  }) =>
      FFont(
        family: family ?? this.family,
        sizeScalar: sizeScalar ?? this.sizeScalar,
        letterSpacingScalar: letterSpacingScalar ?? this.letterSpacingScalar,
        wordSpacingScalar: wordSpacingScalar ?? this.wordSpacingScalar,
        heightScalar: heightScalar ?? this.heightScalar,
        xs: xs ?? this.xs,
        sm: sm ?? this.sm,
        base: base ?? this.base,
        lg: lg ?? this.lg,
        xl: xl ?? this.xl,
        xl2: xl2 ?? this.xl2,
        xl3: xl3 ?? this.xl3,
        xl4: xl4 ?? this.xl4,
        xl5: xl5 ?? this.xl5,
        xl6: xl6 ?? this.xl6,
        xl7: xl7 ?? this.xl7,
        xl8: xl8 ?? this.xl8,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('family', family, defaultValue: 'packages/forui/Inter'))
      ..add(DoubleProperty('sizeScalar', sizeScalar, defaultValue: 1))
      ..add(DoubleProperty('letterSpacingScalar', letterSpacingScalar, defaultValue: 1))
      ..add(DoubleProperty('wordSpacingScalar', wordSpacingScalar, defaultValue: 1))
      ..add(DoubleProperty('heightScalar', heightScalar, defaultValue: 1))
      ..add(DoubleProperty('xs', xs))
      ..add(DoubleProperty('sm', sm))
      ..add(DoubleProperty('base', base))
      ..add(DoubleProperty('lg', lg))
      ..add(DoubleProperty('xl', xl))
      ..add(DoubleProperty('xl2', xl2))
      ..add(DoubleProperty('xl3', xl3))
      ..add(DoubleProperty('xl4', xl4))
      ..add(DoubleProperty('xl5', xl5))
      ..add(DoubleProperty('xl6', xl6))
      ..add(DoubleProperty('xl7', xl7))
      ..add(DoubleProperty('xl8', xl8));
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

/// Provides functions for working with [FFont]s.
extension FontTextStyle on TextStyle {

  /// Returns a [TextStyle] scaled using the given [font].
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
  /// final style = TextStyle(
  ///   fontFamily: 'default-font',
  ///   fontSize: 1,
  ///   letterSpacing: 1,
  ///   wordSpacing: 1,
  ///   height: 1,
  /// ).withFont(font);
  ///
  /// print(style.fontFamily); // 'packages/forui/my-font'
  /// print(style.fontSize); // 2
  /// print(style.letterSpacing); // 3
  /// print(style.wordSpacing); // 4
  /// print(style.height); // 5
  /// ```
  TextStyle withFont(FFont font) => copyWith(
    fontFamily: font.family,
    fontSize: _scale(fontSize, font.sizeScalar),
    letterSpacing: _scale(letterSpacing, font.letterSpacingScalar),
    wordSpacing: _scale(wordSpacing, font.wordSpacingScalar),
    height: _scale(height, font.heightScalar),
  );

}

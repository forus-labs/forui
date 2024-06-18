import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

// TODO: replace with nullable number operations in Sugar 4.
double? _scale(double? value, double factor) => value == null ? null : value * factor;

/// Definitions for the various typographical styles that are part of a [FThemeData].
///
/// A [FTypography] contains scalar values for scaling a [TextStyle]'s corresponding properties. It also contains labelled
/// font sizes, such as [FTypography.xs], which are based on [Tailwind CSS](https://tailwindcss.com/docs/font-size).
///
/// The scaling is applied automatically in all Forui widgets while the labelled font sizes are used as the defaults
/// for the corresponding properties of widget styles configured via `inherit(...)` constructors.
final class FTypography with Diagnosticable {

  /// The default font family. Defaults to [`packages/forui/Inter`](https://fonts.google.com/specimen/Inter).
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if empty.
  final String defaultFontFamily;

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
  /// ## Contract: 
  /// Throws an [AssertionError] if:
  /// * `xl3` <= 0.0
  /// * `xl3` is NaN
  final double xl3;

  /// The font size for extra large text. Defaults to 36.
  ///
  /// ## Contract:
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
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `xl7` <= 0.0
  /// * `xl7` is NaN
  final double xl7;

  /// The font size for extra large text. Defaults to 96.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `xl8` <= 0.0
  /// * `xl8` is NaN
  final double xl8;

  /// Creates a [FTypography].
  const FTypography({
    this.defaultFontFamily = 'packages/forui/Inter',
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
    assert(0 < defaultFontFamily.length, 'The defaultFontFamily should not be empty.'),
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

  /// Creates a copy of this [FTypography] with the given properties replaced.
  ///
  /// ```dart
  /// const typography = FTypography(
  ///   defaultFontFamily: 'packages/forui/my-font',
  ///   sizeScalar: 2,
  /// );
  ///
  /// final copy = typography.copyWith(sizeScalar: 3);
  ///
  /// print(copy.defaultFontFamily); // 'packages/forui/my-font'
  /// print(copy.sizeScalar); // 3
  /// ```
  @useResult FTypography copyWith({
    String? defaultFontFamily,
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
      FTypography(
        defaultFontFamily: defaultFontFamily ?? this.defaultFontFamily,
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

  /// Returns a [TextStyle] with the given properties, based on, and scaled using this [FTypography].
  ///
  /// ```dart
  /// final typography = FTypography(
  ///   defaultFontFamily: 'packages/forui/my-font',
  ///   sizeScalar: 2,
  ///   letterSpacingScalar: 3,
  ///   wordSpacingScalar: 4,
  ///   heightScalar: 5,
  /// );
  ///
  /// final style = typography.toTextStyle(
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
  @useResult TextStyle toTextStyle({
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
    fontFamily: defaultFontFamily,
    overflow: overflow,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('family', defaultFontFamily, defaultValue: 'packages/forui/Inter'))
      ..add(DoubleProperty('sizeScalar', sizeScalar, defaultValue: 1))
      ..add(DoubleProperty('letterSpacingScalar', letterSpacingScalar, defaultValue: 1))
      ..add(DoubleProperty('wordSpacingScalar', wordSpacingScalar, defaultValue: 1))
      ..add(DoubleProperty('heightScalar', heightScalar, defaultValue: 1))
      ..add(DoubleProperty('xs', xs, defaultValue: 12))
      ..add(DoubleProperty('sm', sm, defaultValue: 14))
      ..add(DoubleProperty('base', base, defaultValue: 16))
      ..add(DoubleProperty('lg', lg, defaultValue: 18))
      ..add(DoubleProperty('xl', xl, defaultValue: 20))
      ..add(DoubleProperty('xl2', xl2, defaultValue: 22))
      ..add(DoubleProperty('xl3', xl3, defaultValue: 30))
      ..add(DoubleProperty('xl4', xl4, defaultValue: 36))
      ..add(DoubleProperty('xl5', xl5, defaultValue: 48))
      ..add(DoubleProperty('xl6', xl6, defaultValue: 60))
      ..add(DoubleProperty('xl7', xl7, defaultValue: 72))
      ..add(DoubleProperty('xl8', xl8, defaultValue: 96));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTypography &&
          runtimeType == other.runtimeType &&
          defaultFontFamily == other.defaultFontFamily &&
          sizeScalar == other.sizeScalar &&
          letterSpacingScalar == other.letterSpacingScalar &&
          wordSpacingScalar == other.wordSpacingScalar &&
          heightScalar == other.heightScalar &&
          xs == other.xs &&
          sm == other.sm &&
          base == other.base &&
          lg == other.lg &&
          xl == other.xl &&
          xl2 == other.xl2 &&
          xl3 == other.xl3 &&
          xl4 == other.xl4 &&
          xl5 == other.xl5 &&
          xl6 == other.xl6 &&
          xl7 == other.xl7 &&
          xl8 == other.xl8;

  @override
  int get hashCode =>
      defaultFontFamily.hashCode ^
      sizeScalar.hashCode ^
      letterSpacingScalar.hashCode ^
      wordSpacingScalar.hashCode ^
      heightScalar.hashCode ^
      xs.hashCode ^
      sm.hashCode ^
      base.hashCode ^
      lg.hashCode ^
      xl.hashCode ^
      xl2.hashCode ^
      xl3.hashCode ^
      xl4.hashCode ^
      xl5.hashCode ^
      xl6.hashCode ^
      xl7.hashCode ^
      xl8.hashCode;
}

/// Provides functions for working with [FTypography]s.
extension TypographyTextStyle on TextStyle {

  /// Scales a [TextStyle] using the given [typography].
  ///
  /// ```dart
  /// final typography = FTypography(
  ///   defaultFontFamily: 'packages/forui/my-font',
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
  /// ).scale(typography);
  ///
  /// print(style.fontFamily); // 'default-font'
  /// print(style.fontSize); // 2
  /// print(style.letterSpacing); // 3
  /// print(style.wordSpacing); // 4
  /// print(style.height); // 5
  /// ```
  @useResult TextStyle scale(FTypography typography) => copyWith(
    fontSize: _scale(fontSize, typography.sizeScalar),
    letterSpacing: _scale(letterSpacing, typography.letterSpacingScalar),
    wordSpacing: _scale(wordSpacing, typography.wordSpacingScalar),
    height: _scale(height, typography.heightScalar),
  );

}

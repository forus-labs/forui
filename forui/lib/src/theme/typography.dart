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
  // final double sizeScalar;

  /// A value used to scale [TextStyle.letterSpacing]. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `letterSpacingScalar` <= 0.0
  /// * `letterSpacingScalar` is NaN
  // final double letterSpacingScalar;

  /// A value used to scale [TextStyle.wordSpacing]. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `wordSpacingScalar` <= 0.0
  /// * `wordSpacingScalar` is NaN
  // final double wordSpacingScalar;

  /// A value used to scale [TextStyle.height]. Defaults to 1.
  ///
  /// ## Contract:
  /// Throws an [AssertionError] if:
  /// * `heightScalar` <= 0.0
  /// * `heightScalar` is NaN
  // final double heightScalar;

  /// The font size for extra small text.
  ///
  /// Defaults to:
  /// * `fontSize` = 12.
  /// * `height` = 1.
  final TextStyle xs;

  /// The font size for small text. Defaults to 14.
  ///
  /// Defaults to:
  /// * `fontSize` = 14.
  /// * `height` = 1.25.
  final TextStyle sm;

  /// The font size for base text. Defaults to 16.
  ///
  /// Defaults to:
  /// * `fontSize` = 16.
  /// * `height` = 1.5.
  final TextStyle base;

  /// The font size for large text. Defaults to 18.
  final TextStyle lg;

  /// The font size for extra large text. Defaults to 20.
  final TextStyle xl;

  /// The font size for extra large text. Defaults to 22.
  final TextStyle xl2;

  /// The font size for extra large text. Defaults to 30.
  final TextStyle xl3;

  /// The font size for extra large text. Defaults to 36.
  final TextStyle xl4;

  /// The font size for extra large text. Defaults to 48.
  final TextStyle xl5;

  /// The font size for extra large text. Defaults to 60.
  final TextStyle xl6;

  /// The font size for extra large text. Defaults to 72.
  final TextStyle xl7;

  /// The font size for extra large text. Defaults to 96.
  final TextStyle xl8;

  /// Creates a [FTypography].
  const FTypography({
    this.defaultFontFamily = 'packages/forui/Inter',
    this.xs = const TextStyle(fontSize: 12, height: 1),
    this.sm = const TextStyle(fontSize: 14, height: 1.25),
    this.base = const TextStyle(fontSize: 16, height: 1.5),
    this.lg = const TextStyle(fontSize: 18, height: 1.75),
    this.xl = const TextStyle(fontSize: 20, height: 1.75),
    this.xl2 = const TextStyle(fontSize: 22, height: 2),
    this.xl3 = const TextStyle(fontSize: 30, height: 2.25),
    this.xl4 = const TextStyle(fontSize: 36, height: 2.5),
    this.xl5 = const TextStyle(fontSize: 48, height: 1),
    this.xl6 = const TextStyle(fontSize: 60, height: 1),
    this.xl7 = const TextStyle(fontSize: 72, height: 1),
    this.xl8 = const TextStyle(fontSize: 96, height: 1),
  }) : assert(0 < defaultFontFamily.length, 'The defaultFontFamily should not be empty.');

  /// Scales the fields of this [FTypography] by the given fields.
  ///
  /// ```dart
  /// const typography = FTypography(
  ///   sm: TextStyle(fontSize: 10),
  ///   base: TextStyle(fontSize: 20),
  /// );
  ///
  /// final scaled = typography.scale(sizeScalar: 1.5);
  ///
  /// print(scaled.sm.fontSize); // 15
  /// print(scaled.base.fontSize); // 30
  /// ```
  @useResult
  FTypography scale({double sizeScalar = 1}) => FTypography(
        defaultFontFamily: defaultFontFamily,
        xs: _scaleTextStyle(style: xs, sizeScalar: sizeScalar),
        sm: sm,
        base: base,
        lg: lg,
        xl: xl,
        xl2: xl2,
        xl3: xl3,
        xl4: xl4,
        xl5: xl5,
        xl6: xl6,
        xl7: xl7,
        xl8: xl8,
      );

  TextStyle _scaleTextStyle({
    required TextStyle style,
    required double sizeScalar,
  }) {
    // default font size; https://api.flutter.dev/flutter/painting/TextStyle/fontSize.html
    final double fontSize = style.fontSize ?? 14;

    return style.copyWith(fontSize: fontSize * sizeScalar);
  }

  /// Creates a copy of this [FTypography] with the given properties replaced.
  ///
  /// ```dart
  /// const typography = FTypography(
  ///   defaultFontFamily: 'packages/forui/my-font',
  ///   sm: TextStyle(fontSize: 10),
  ///   base: TextStyle(fontSize: 20),
  /// );
  ///
  /// final copy = typography.copyWith(defaultFontFamily: 'packages/forui/another-font');
  ///
  /// print(copy.defaultFontFamily); // 'packages/forui/another-font'
  /// print(copy.sm.fontSize); // 10
  /// print(copy.base.fontSize); // 20
  /// ```
  @useResult
  FTypography copyWith({
    String? defaultFontFamily,
    TextStyle? xs,
    TextStyle? sm,
    TextStyle? base,
    TextStyle? lg,
    TextStyle? xl,
    TextStyle? xl2,
    TextStyle? xl3,
    TextStyle? xl4,
    TextStyle? xl5,
    TextStyle? xl6,
    TextStyle? xl7,
    TextStyle? xl8,
  }) =>
      FTypography(
        defaultFontFamily: defaultFontFamily ?? this.defaultFontFamily,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('family', defaultFontFamily, defaultValue: 'packages/forui/Inter'))
      ..add(DiagnosticsProperty('xs', xs, defaultValue: 12))
      ..add(DiagnosticsProperty('sm', sm, defaultValue: 14))
      ..add(DiagnosticsProperty('base', base, defaultValue: 16))
      ..add(DiagnosticsProperty('lg', lg, defaultValue: 18))
      ..add(DiagnosticsProperty('xl', xl, defaultValue: 20))
      ..add(DiagnosticsProperty('xl2', xl2, defaultValue: 22))
      ..add(DiagnosticsProperty('xl3', xl3, defaultValue: 30))
      ..add(DiagnosticsProperty('xl4', xl4, defaultValue: 36))
      ..add(DiagnosticsProperty('xl5', xl5, defaultValue: 48))
      ..add(DiagnosticsProperty('xl6', xl6, defaultValue: 60))
      ..add(DiagnosticsProperty('xl7', xl7, defaultValue: 72))
      ..add(DiagnosticsProperty('xl8', xl8, defaultValue: 96));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTypography &&
          runtimeType == other.runtimeType &&
          defaultFontFamily == other.defaultFontFamily &&
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

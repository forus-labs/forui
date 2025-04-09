import 'package:forui/forui.dart';
import 'package:flutter/material.dart';

/// Generated by Forui CLI.
///
/// Modify the generated function bodies to create your own custom style.
/// Then, call the modified function and pass it to [FTheme].
///
/// You can also generate styles to be used in the generated [FThemeData] using:
/// ```shell
/// dart forui style create [styles]
/// ```
///
/// See https://forui.dev/docs/themes#customize-themes for more information.
FThemeData get zincLight {
  const colors = FColors(
    brightness: Brightness.light,
    barrier: Color(0x33000000),
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF09090B),
    primary: Color(0xFF18181B),
    primaryForeground: Color(0xFFFAFAFA),
    secondary: Color(0xFFF4F4F5),
    secondaryForeground: Color(0xFF18181B),
    muted: Color(0xFFF4F4F5),
    mutedForeground: Color(0xFF71717A),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFFEF4444),
    errorForeground: Color(0xFFFAFAFA),
    border: Color(0xFFE4E4E7),
  );

  final typography = _typography(colors: colors);
  final style = _style(colors: colors, typography: typography);

  return FThemeData(colors: colors, typography: typography, style: style);
}

FThemeData get zincDark {
  const colors = FColors(
    brightness: Brightness.dark,
    barrier: Color(0x7A000000),
    background: Color(0xFF09090B),
    foreground: Color(0xFFFAFAFA),
    primary: Color(0xFFFAFAFA),
    primaryForeground: Color(0xFF18181B),
    secondary: Color(0xFF27272A),
    secondaryForeground: Color(0xFFFAFAFA),
    muted: Color(0xFF27272A),
    mutedForeground: Color(0xFFA1A1AA),
    destructive: Color(0xFF7F1D1D),
    destructiveForeground: Color(0xFFFAFAFA),
    error: Color(0xFF7F1D1D),
    errorForeground: Color(0xFFFAFAFA),
    border: Color(0xFF27272A),
  );

  final typography = _typography(colors: colors);
  final style = _style(colors: colors, typography: typography);

  return FThemeData(colors: colors, typography: typography, style: style);
}

FTypography _typography({
  required FColors colors,
  String defaultFontFamily = 'packages/forui/Inter',
}) => FTypography(
  xs: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 12,
    height: 1,
  ),
  sm: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 14,
    height: 1.25,
  ),
  base: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 16,
    height: 1.5,
  ),
  lg: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 18,
    height: 1.75,
  ),
  xl: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 20,
    height: 1.75,
  ),
  xl2: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 22,
    height: 2,
  ),
  xl3: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 30,
    height: 2.25,
  ),
  xl4: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 36,
    height: 2.5,
  ),
  xl5: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 48,
    height: 1,
  ),
  xl6: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 60,
    height: 1,
  ),
  xl7: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 72,
    height: 1,
  ),
  xl8: TextStyle(
    color: colors.foreground,
    fontFamily: defaultFontFamily,
    fontSize: 96,
    height: 1,
  ),
);

FStyle _style({required FColors colors, required FTypography typography}) =>
    FStyle(
      enabledFormFieldStyle: FFormFieldStyle.inherit(
        labelColor: colors.primary,
        descriptionColor: colors.mutedForeground,
        typography: typography,
      ),
      disabledFormFieldStyle: FFormFieldStyle.inherit(
        labelColor: colors.disable(colors.primary),
        descriptionColor: colors.disable(colors.mutedForeground),
        typography: typography,
      ),
      errorFormFieldStyle: FFormFieldErrorStyle.inherit(
        labelColor: colors.error,
        descriptionColor: colors.mutedForeground,
        errorColor: colors.error,
        typography: typography,
      ),
      focusedOutlineStyle: FFocusedOutlineStyle(
        color: colors.primary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      iconStyle: IconThemeData(color: colors.primary, size: 20),
      tappableStyle: FTappableStyle(),
    );

import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The Forui themes.
extension FThemes on Never {

  /// The light and dark variants of the [Zinc](https://ui.shadcn.com/themes) theme.
  static final zinc = (
    light: FThemeData.inherit(
      font: FFont(),
      colorScheme: const FColorScheme(
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
        border: Color(0xFFE4E4E7),
      ),
      style: FStyle(
        textStyle: const TextStyle(
          fontSize: 10,
          color: Color(0xFF09090B),
        ),
      ),
    ),
    dark: FThemeData.inherit(
      font: FFont(),
      colorScheme: const FColorScheme(
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
        border: Color(0xFF27272A),
      ),
      style: FStyle(
        textStyle: const TextStyle(
          fontSize: 10,
          color: Color(0xFFFAFAFA),
        ),
      ),
    ),
  );
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The Forui themes.
extension FThemes on Never {
  /// The light and dark variants of the [Zinc](https://ui.shadcn.com/themes) theme.
  static final zinc = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
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
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
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
      ),
    ),
  );

  /// The light and dark variants of the [Red](https://ui.shadcn.com/themes) theme.
  static final red = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF09090B),
        primary: Color(0xFFDC2626),
        primaryForeground: Color(0xFFFEF2F2),
        secondary: Color(0xFFF5F5F5),
        secondaryForeground: Color(0xFF171717),
        muted: Color(0xFFF5F5F5),
        mutedForeground: Color(0xFF71717A),
        destructive: Color(0xFFEF4444),
        destructiveForeground: Color(0xFFFAFAFA),
        error: Color(0xFFEF4444),
        errorForeground: Color(0xFFFAFAFA),
        border: Color(0xFFE5E5E5),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        background: Color(0xFF0A0A0A),
        foreground: Color(0xFFFAFAFA),
        primary: Color(0xFFDC2626),
        primaryForeground: Color(0xFFFEF2F2),
        secondary: Color(0xFF262626),
        secondaryForeground: Color(0xFFFAFAFA),
        muted: Color(0xFF262626),
        mutedForeground: Color(0xFFA3A3A3),
        destructive: Color(0xFF7F1D1D),
        destructiveForeground: Color(0xFFFEF2F2),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFFAFAFA),
        border: Color(0xFF262626),
      ),
    ),
  );

  /// The light and dark variants of the [Rose](https://ui.shadcn.com/themes) theme.
  static final rose = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF09090B),
        primary: Color(0xFFE11D48),
        primaryForeground: Color(0xFFFFF1F2),
        secondary: Color(0xFFF4F4F5),
        secondaryForeground: Color(0xFF18181B),
        muted: Color(0xFFF4F4F5),
        mutedForeground: Color(0xFF71717A),
        destructive: Color(0xFFEF4444),
        destructiveForeground: Color(0xFFFAFAFA),
        error: Color(0xFFEF4444),
        errorForeground: Color(0xFFFAFAFA),
        border: Color(0xFFE4E4E7),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        background: Color(0xFF0C0A09),
        foreground: Color(0xFFF2F2F2),
        primary: Color(0xFFE11D48),
        primaryForeground: Color(0xFFFFF1F2),
        secondary: Color(0xFF27272A),
        secondaryForeground: Color(0xFFFAFAFA),
        muted: Color(0xFF262626),
        mutedForeground: Color(0xFFA1A1AA),
        destructive: Color(0xFF7F1D1D),
        destructiveForeground: Color(0xFFFEF2F2),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFFAFAFA),
        border: Color(0xFF27272A),
      ),
    ),
  );

  /// The light and dark variants of the [Orange](https://ui.shadcn.com/themes) theme.
  static final orange = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF0C0A09),
        primary: Color(0xFFF97316),
        primaryForeground: Color(0xFFFFF1F2),
        secondary: Color(0xFFF5F5F4),
        secondaryForeground: Color(0xFF1C1917),
        muted: Color(0xFFF5F5F4),
        mutedForeground: Color(0xFF78716C),
        destructive: Color(0xFFEF4444),
        destructiveForeground: Color(0xFFFAFAF9),
        error: Color(0xFFEF4444),
        errorForeground: Color(0xFFFAFAFA),
        border: Color(0xFFE4E4E7),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        background: Color(0xFF0C0A09),
        foreground: Color(0xFFFAFAF9),
        primary: Color(0xFFEA580C),
        primaryForeground: Color(0xFFFAFAF9),
        secondary: Color(0xFF292524),
        secondaryForeground: Color(0xFFFAFAF9),
        muted: Color(0xFF292524),
        mutedForeground: Color(0xFFA8A29E),
        destructive: Color(0xFFDC2626),
        destructiveForeground: Color(0xFFFAFAF9),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFFAFAFA),
        border: Color(0xFF292524),
      ),
    ),
  );
}

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
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
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
      ),
    ),
  );

  /// The light and dark variants of the [Slate](https://ui.shadcn.com/themes) theme.
  static final slate = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF020817),
        primary: Color(0xFF0F172A),
        primaryForeground: Color(0xFFF8FAFC),
        secondary: Color(0xFFF1F5F9),
        secondaryForeground: Color(0xFF0F172A),
        muted: Color(0xFFF1F5F9),
        mutedForeground: Color(0xFF64748B),
        destructive: Color(0xFFEF4444),
        destructiveForeground: Color(0xFFF8FAFC),
        error: Color(0xFFEF4444),
        errorForeground: Color(0xFFF8FAFC),
        border: Color(0xFFE2E8F0),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        barrier: Color(0x7A000000),
        background: Color(0xFF020817),
        foreground: Color(0xFFF8FAFC),
        primary: Color(0xFFF8FAFC),
        primaryForeground: Color(0xFF0F172A),
        secondary: Color(0xFF1E293B),
        secondaryForeground: Color(0xFFF8FAFC),
        muted: Color(0xFF1E293B),
        mutedForeground: Color(0xFF94A3B8),
        destructive: Color(0xFF7F1D1D),
        destructiveForeground: Color(0xFFF8FAFC),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFF8FAFC),
        border: Color(0xFF1E293B),
      ),
    ),
  );

  /// The light and dark variants of the [Red](https://ui.shadcn.com/themes) theme.
  static final red = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
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
        barrier: Color(0x7A000000),
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
        errorForeground: Color(0xFFFEF2F2),
        border: Color(0xFF262626),
      ),
    ),
  );

  /// The light and dark variants of the [Rose](https://ui.shadcn.com/themes) theme.
  static final rose = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
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
        barrier: Color(0x7A000000),
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
        errorForeground: Color(0xFFFEF2F2),
        border: Color(0xFF27272A),
      ),
    ),
  );

  /// The light and dark variants of the [Orange](https://ui.shadcn.com/themes) theme.
  static final orange = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
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
        errorForeground: Color(0xFFFAFAF9),
        border: Color(0xFFE4E4E7),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        barrier: Color(0x7A000000),
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
        errorForeground: Color(0xFFFAFAF9),
        border: Color(0xFF292524),
      ),
    ),
  );

  /// The light and dark variants of the [Green](https://ui.shadcn.com/themes) theme.
  static final green = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF09090B),
        primary: Color(0xFF16A34A),
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
        barrier: Color(0x7A000000),
        background: Color(0xFF0C0A09),
        foreground: Color(0xFFF2F2F2),
        primary: Color(0xFF22C55E),
        primaryForeground: Color(0xFF052E16),
        secondary: Color(0xFF27272A),
        secondaryForeground: Color(0xFFFAFAFA),
        muted: Color(0xFF262626),
        mutedForeground: Color(0xFFA1A1AA),
        destructive: Color(0xFF7F1D1D),
        destructiveForeground: Color(0xFFFEF2F2),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFFEF2F2),
        border: Color(0xFF27272A),
      ),
    ),
  );

  /// The light and dark variants of the [Blue](https://ui.shadcn.com/themes) theme.
  static final blue = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF020817),
        primary: Color(0xFF2563EB),
        primaryForeground: Color(0xFFF8FAFC),
        secondary: Color(0xFFF1F5F9),
        secondaryForeground: Color(0xFF0F172A),
        muted: Color(0xFFF1F5F9),
        mutedForeground: Color(0xFF64748B),
        destructive: Color(0xFFEF4444),
        destructiveForeground: Color(0xFFF8FAFC),
        error: Color(0xFFEF4444),
        errorForeground: Color(0xFFF8FAFC),
        border: Color(0xFFE2E8F0),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        barrier: Color(0x7A000000),
        background: Color(0xFF020817),
        foreground: Color(0xFFF8FAFC),
        primary: Color(0xFF3B82F6),
        primaryForeground: Color(0xFF0F172A),
        secondary: Color(0xFF1E293B),
        secondaryForeground: Color(0xFFF8FAFC),
        muted: Color(0xFF1E293B),
        mutedForeground: Color(0xFF94A3B8),
        destructive: Color(0xFF7F1D1D),
        destructiveForeground: Color(0xFFF8FAFC),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFF8FAFC),
        border: Color(0xFF1E293B),
      ),
    ),
  );

  /// The light and dark variants of the [Yellow](https://ui.shadcn.com/themes) theme.
  static final yellow = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF0C0A09),
        primary: Color(0xFFFACC15),
        primaryForeground: Color(0xFF422006),
        secondary: Color(0xFFF5F5F4),
        secondaryForeground: Color(0xFF1C1917),
        muted: Color(0xFFF5F5F4),
        mutedForeground: Color(0xFF78716C),
        destructive: Color(0xFFEF4444),
        destructiveForeground: Color(0xFFFAFAF9),
        error: Color(0xFFEF4444),
        errorForeground: Color(0xFFFAFAF9),
        border: Color(0xFFE7E5E4),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        barrier: Color(0x7A000000),
        background: Color(0xFF0C0A09),
        foreground: Color(0xFFFAFAF9),
        primary: Color(0xFFFACC15),
        primaryForeground: Color(0xFF422006),
        secondary: Color(0xFF292524),
        secondaryForeground: Color(0xFFFAFAF9),
        muted: Color(0xFF292524),
        mutedForeground: Color(0xFFA8A29E),
        destructive: Color(0xFF7F1D1D),
        destructiveForeground: Color(0xFFFAFAF9),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFFAFAF9),
        border: Color(0xFF292524),
      ),
    ),
  );

  /// The light and dark variants of the [Violet](https://ui.shadcn.com/themes) theme.
  static final violet = (
    light: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.light,
        barrier: Color(0x33000000),
        background: Color(0xFFFFFFFF),
        foreground: Color(0xFF030712),
        primary: Color(0xFF7C3AED),
        primaryForeground: Color(0xFFF9FAFB),
        secondary: Color(0xFFF3F4F6),
        secondaryForeground: Color(0xFF111827),
        muted: Color(0xFFF3F4F6),
        mutedForeground: Color(0xFF6B7280),
        destructive: Color(0xFFEF4444),
        destructiveForeground: Color(0xFFF9FAFB),
        error: Color(0xFFEF4444),
        errorForeground: Color(0xFFF9FAFB),
        border: Color(0xFFE5E7EB),
      ),
    ),
    dark: FThemeData.inherit(
      colorScheme: const FColorScheme(
        brightness: Brightness.dark,
        barrier: Color(0x7A000000),
        background: Color(0xFF030712),
        foreground: Color(0xFFF9FAFB),
        primary: Color(0xFF6D28D9),
        primaryForeground: Color(0xFFF9FAFB),
        secondary: Color(0xFF1F2937),
        secondaryForeground: Color(0xFFF9FAFB),
        muted: Color(0xFF1F2937),
        mutedForeground: Color(0xFF9CA3AF),
        destructive: Color(0xFF7F1D1D),
        destructiveForeground: Color(0xFFF9FAFB),
        error: Color(0xFF7F1D1D),
        errorForeground: Color(0xFFF9FAFB),
        border: Color(0xFF1F2937),
      ),
    ),
  );
}

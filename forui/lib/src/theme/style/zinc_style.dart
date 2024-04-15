import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// Zinc style of [FThemeData].
///
/// The zinc style is based on [shadcn/ui](https://ui.shadcn.com/themes).
extension FZincThemeData on Never {
  // TODO: Manually verify fields. Currently generated with a LLM.

  /// The light theme of [FZincThemeData].
  static FThemeData light = FThemeData(
    background: const Color(0xFFFFFFFF),
    foreground: const Color(0xFF09090B),
    primary: const Color(0xFF18181B),
    primaryForeground: const Color(0xFFFAFAFA),
    secondary: const Color(0xFFF4F4F5),
    secondaryForeground: const Color(0xFF18181B),
    muted: const Color(0xFFF4F4F5),
    mutedForeground: const Color(0xFF71717A),
    destructive: const Color(0xFFEF4444),
    destructiveForeground: const Color(0xFFFAFAFA),
    border: const Color(0xFFE4E4E7),
    borderRadius: BorderRadius.circular(8),
  );

  /// The dark theme of [FZincThemeData].
  static FThemeData dark = FThemeData(
    background: const Color(0xFF09090B),
    foreground: const Color(0xFFFAFAFA),
    primary: const Color(0xFFFAFAFA),
    primaryForeground: const Color(0xFF18181B),
    secondary: const Color(0xFF27272A),
    secondaryForeground: const Color(0xFFFAFAFA),
    muted: const Color(0xFF27272A),
    mutedForeground: const Color(0xFFA1A1AA),
    destructive: const Color(0xFF7F1D1D),
    destructiveForeground: const Color(0xFFFAFAFA),
    border: const Color(0xFF27272A),
    borderRadius: BorderRadius.circular(8),
  );
}

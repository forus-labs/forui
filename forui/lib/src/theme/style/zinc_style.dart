import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// Zinc style of [FThemeData].
///
/// The zinc style is based on [shadcn/ui](https://ui.shadcn.com/themes).
extension FZincStyle on Never {
  // TODO: Manually verify fields. Currently generated with a LLM.

  /// The light theme of [FZincStyle].
  static FThemeData light = FThemeData(
    background: const Color(0xFFFFFFFF),
    foreground: const Color(0xFF191919),
    primary: const Color(0xFF191F26),
    primaryForeground: const Color(0xFFFAFAFA),
    secondary: const Color(0xFFE6E6E6),
    secondaryForeground: const Color(0xFF191F26),
    muted: const Color(0xFFE6E6E6),
    mutedForeground: const Color(0xFF757575),
    destructive: const Color(0xFFD62828),
    destructiveForeground: const Color(0xFFFAFAFA),
    border: const Color(0xFF191F26),
    borderRadius: BorderRadius.circular(8),
  );

  /// The dark theme of [FZincStyle].
  static FThemeData dark = FThemeData(
    background: const Color(0xFF191919),
    foreground: const Color(0xFFFAFAFA),
    primary: const Color(0xFFFAFAFA),
    primaryForeground: const Color(0xFF191F26),
    secondary: const Color(0xFF282828),
    secondaryForeground: const Color(0xFFFAFAFA),
    muted: const Color(0xFF282828),
    mutedForeground: const Color(0xFFA6A6A6),
    destructive: const Color(0xFF7F1D1D),
    destructiveForeground: const Color(0xFFFAFAFA),
    border: const Color(0xFF282828),
    borderRadius: BorderRadius.circular(8),
  );
}

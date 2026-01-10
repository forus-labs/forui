import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

final typography = FThemes.zinc.light.typography;
final colors = FThemes.zinc.light.colors;

final map =
    // {@snippet constructor}
    FWidgetStateMap({
      // ❌ Don't declare more general constraints above more specific ones!
      // 1st constraint: applied when the accordion is hovered.
      WidgetState.hovered: typography.base.copyWith(
        fontWeight: .w500,
        color: colors.foreground,
        decoration: .underline,
      ),
      // 2nd constraint: applied when the accordion is hovered OR pressed.
      WidgetState.hovered | WidgetState.pressed: typography.base.copyWith(
        fontWeight: .w500,
        color: colors.foreground,
        decoration: .underline,
      ),
      // 3rd constraint: This text style is applied when the accordion is NOT hovered OR pressed.
      WidgetState.any: typography.base.copyWith(fontWeight: .w500, color: colors.foreground),
    });
// {@endsnippet}

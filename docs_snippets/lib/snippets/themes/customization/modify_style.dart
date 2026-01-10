// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

// {@snippet}
FAccordionStyle accordionStyle({required FColors colors, required FTypography typography, required FStyle style}) =>
    FAccordionStyle(
      titleTextStyle: FWidgetStateMap({
        // This text style is applied when the accordion is hovered OR pressed OR focused (new).
        // {@highlight}
        WidgetState.hovered | WidgetState.pressed | WidgetState.focused: typography.base.copyWith(
          // {@endhighlight}
          fontWeight: .w500,
          color: colors.foreground,
          decoration: .underline,
        ),

        // This text style is applied when the accordion is NOT hovered OR pressed.
        WidgetState.any: typography.base.copyWith(fontWeight: .w500, color: colors.foreground),
      }),
      // {@endsnippet}
      childTextStyle: typography.sm.copyWith(color: colors.foreground),
      // This decoration is ALWAYS applied.
      iconStyle: .all(IconThemeData(color: colors.primary, size: 20)),
      focusedOutlineStyle: style.focusedOutlineStyle,
      dividerStyle: FDividerStyle(color: colors.border, padding: .zero),
      tappableStyle: style.tappableStyle.copyWith(
        motion: (motion) => motion.copyWith(bounceTween: FTappableMotion.noBounceTween),
      ),
      titlePadding: const .symmetric(vertical: 15),
      childPadding: const .only(bottom: 15),
      motion: const FAccordionMotion(),
      // {@snippet}
    );
// {@endsnippet}

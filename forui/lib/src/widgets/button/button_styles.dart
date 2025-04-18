import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_styles.style.dart';

/// [FButtonStyle]'s style.
final class FButtonStyles with Diagnosticable, _$FButtonStylesFunctions {
  /// The primary button style.
  @override
  final FButtonStyle primary;

  /// The secondary  button style.
  @override
  final FButtonStyle secondary;

  /// The destructive button style.
  @override
  final FButtonStyle destructive;

  /// The outlined button style.
  @override
  final FButtonStyle outline;

  /// The ghost button style.
  @override
  final FButtonStyle ghost;

  /// Creates a [FButtonStyle].
  const FButtonStyles({
    required this.primary,
    required this.secondary,
    required this.destructive,
    required this.outline,
    required this.ghost,
  });

  /// Creates a [FButtonStyle] that inherits its properties.
  FButtonStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        primary: FButtonStyle.inherit(
          colors: colors,
          style: style,
          typography: typography,
          color: colors.primary,
          foregroundColor: colors.primaryForeground,
        ),
        secondary: FButtonStyle.inherit(
          colors: colors,
          style: style,
          typography: typography,
          color: colors.secondary,
          foregroundColor: colors.secondaryForeground,
        ),
        destructive: FButtonStyle.inherit(
          colors: colors,
          style: style,
          typography: typography,
          color: colors.destructive,
          foregroundColor: colors.destructiveForeground,
        ),
        outline: FButtonStyle(
          decoration: FWidgetStateMap({
            WidgetState.disabled: BoxDecoration(
              border: Border.all(color: colors.disable(colors.border)),
              borderRadius: style.borderRadius,
            ),
            WidgetState.hovered | WidgetState.pressed: BoxDecoration(
              border: Border.all(color: colors.border),
              borderRadius: style.borderRadius,
              color: colors.secondary,
            ),
            WidgetState.any: BoxDecoration(border: Border.all(color: colors.border), borderRadius: style.borderRadius),
          }),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle.inherit(
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          tappableStyle: style.tappableStyle,
        ),
        ghost: FButtonStyle(
          decoration: FWidgetStateMap({
            WidgetState.disabled: BoxDecoration(borderRadius: style.borderRadius),
            WidgetState.hovered | WidgetState.pressed: BoxDecoration(
              borderRadius: style.borderRadius,
              color: colors.secondary,
            ),
            WidgetState.any: BoxDecoration(borderRadius: style.borderRadius),
          }),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle.inherit(
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          tappableStyle: style.tappableStyle,
        ),
      );
}

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

  /// Creates a [FButtonStyle] that inherits its properties from the provided [colorScheme], [typography], and
  /// [style].
  factory FButtonStyles.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) {
    final contentColor = FWidgetStateMap({
      WidgetState.disabled: colorScheme.disable(colorScheme.secondaryForeground),
      WidgetState.any: colorScheme.secondaryForeground,
    });

    return FButtonStyles(
      primary: FButtonStyle.inherit(
        style: style,
        typography: typography,
        boxColor: FWidgetStateMap({
          WidgetState.disabled: colorScheme.disable(colorScheme.primary),
          WidgetState.hovered | WidgetState.pressed: colorScheme.hover(colorScheme.primary),
          WidgetState.any: colorScheme.primary,
        }),
        contentColor: FWidgetStateMap({
          WidgetState.disabled: colorScheme.disable(colorScheme.primaryForeground),
          WidgetState.any: colorScheme.primaryForeground,
        }),
      ),
      secondary: FButtonStyle.inherit(
        style: style,
        typography: typography,
        boxColor: FWidgetStateMap({
          WidgetState.disabled: colorScheme.disable(colorScheme.secondary),
          WidgetState.hovered | WidgetState.pressed: colorScheme.hover(colorScheme.secondary),
          WidgetState.any: colorScheme.secondary,
        }),
        contentColor: FWidgetStateMap({
          WidgetState.disabled: colorScheme.disable(
            colorScheme.secondaryForeground,
            colorScheme.disable(colorScheme.secondary),
          ),
          WidgetState.any: colorScheme.secondaryForeground,
        }),
      ),
      destructive: FButtonStyle.inherit(
        style: style,
        typography: typography,
        boxColor: FWidgetStateMap({
          WidgetState.disabled: colorScheme.disable(colorScheme.destructive),
          WidgetState.hovered | WidgetState.pressed: colorScheme.hover(colorScheme.destructive),
          WidgetState.any: colorScheme.destructive,
        }),
        contentColor: FWidgetStateMap({
          WidgetState.disabled: colorScheme.disable(
            colorScheme.destructiveForeground,
            colorScheme.disable(colorScheme.destructive),
          ),
          WidgetState.any: colorScheme.destructiveForeground,
        }),
      ),
      outline: FButtonStyle(
        boxDecoration: FWidgetStateMap({
          WidgetState.disabled: BoxDecoration(
            border: Border.all(color: colorScheme.disable(colorScheme.border)),
            borderRadius: style.borderRadius,
          ),
          WidgetState.hovered | WidgetState.pressed: BoxDecoration(
            border: Border.all(color: colorScheme.border),
            borderRadius: style.borderRadius,
            color: colorScheme.secondary,
          ),
          WidgetState.any: BoxDecoration(
            border: Border.all(color: colorScheme.border),
            borderRadius: style.borderRadius,
          ),
        }),
        focusedOutlineStyle: style.focusedOutlineStyle,
        contentStyle: FButtonContentStyle.inherit(typography: typography, color: contentColor),
        iconContentStyle: FButtonIconContentStyle(color: contentColor),
        spinnerStyle: FButtonSpinnerStyle(color: contentColor),
      ),
      ghost: FButtonStyle(
        boxDecoration: FWidgetStateMap({
          WidgetState.disabled: BoxDecoration(borderRadius: style.borderRadius),
          WidgetState.hovered | WidgetState.pressed: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.secondary,
          ),
          WidgetState.any: BoxDecoration(borderRadius: style.borderRadius),
        }),
        focusedOutlineStyle: style.focusedOutlineStyle,
        contentStyle: FButtonContentStyle.inherit(typography: typography, color: contentColor),
        iconContentStyle: FButtonIconContentStyle(color: contentColor),
        spinnerStyle: FButtonSpinnerStyle(color: contentColor),
      ),
    );
  }
}

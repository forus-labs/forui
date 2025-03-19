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
  FButtonStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        primary: FButtonStyle.inherit(
          style: style,
          typography: typography,
          enabledBoxColor: colorScheme.primary,
          enabledHoveredBoxColor: colorScheme.hover(colorScheme.primary),
          disabledBoxColor: colorScheme.disable(colorScheme.primary),
          enabledContentColor: colorScheme.primaryForeground,
          disabledContentColor: colorScheme.disable(
            colorScheme.primaryForeground,
            colorScheme.disable(colorScheme.primary),
          ),
        ),
        secondary: FButtonStyle.inherit(
          style: style,
          typography: typography,
          enabledBoxColor: colorScheme.secondary,
          enabledHoveredBoxColor: colorScheme.hover(colorScheme.secondary),
          disabledBoxColor: colorScheme.disable(colorScheme.secondary),
          enabledContentColor: colorScheme.secondaryForeground,
          disabledContentColor: colorScheme.disable(
            colorScheme.secondaryForeground,
            colorScheme.disable(colorScheme.secondary),
          ),
        ),
        destructive: FButtonStyle.inherit(
          style: style,
          typography: typography,
          enabledBoxColor: colorScheme.destructive,
          enabledHoveredBoxColor: colorScheme.hover(colorScheme.destructive),
          disabledBoxColor: colorScheme.disable(colorScheme.destructive),
          enabledContentColor: colorScheme.destructiveForeground,
          disabledContentColor: colorScheme.disable(
            colorScheme.destructiveForeground,
            colorScheme.disable(colorScheme.destructive),
          ),
        ),
        outline: FButtonStyle(
          enabledBoxDecoration: BoxDecoration(
            border: Border.all(color: colorScheme.border),
            borderRadius: style.borderRadius,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            border: Border.all(color: colorScheme.border),
            borderRadius: style.borderRadius,
            color: colorScheme.secondary,
          ),
          disabledBoxDecoration: BoxDecoration(
            border: Border.all(color: colorScheme.disable(colorScheme.border)),
            borderRadius: style.borderRadius,
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colorScheme.secondaryForeground,
            disabled: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle(
            enabledColor: colorScheme.secondaryForeground,
            disabledColor: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          enabledCircularProgressStyle: FCircularIconProgressStyle(color: colorScheme.secondaryForeground),
          disabledenabledCircularProgressStyle: FCircularIconProgressStyle(
            color: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          tappableStyle: style.tappableStyle,
        ),
        ghost: FButtonStyle(
          enabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
          enabledHoverBoxDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colorScheme.secondary),
          disabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colorScheme.secondaryForeground,
            disabled: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle(
            enabledColor: colorScheme.secondaryForeground,
            disabledColor: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          enabledCircularProgressStyle: FCircularIconProgressStyle(color: colorScheme.secondaryForeground),
          disabledenabledCircularProgressStyle: FCircularIconProgressStyle(
            color: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          tappableStyle: style.tappableStyle,
        ),
      );
}

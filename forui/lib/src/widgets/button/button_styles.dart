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
          background: colors.primary,
          foreground: colors.primaryForeground,
        ),
        secondary: FButtonStyle.inherit(
          colors: colors,
          style: style,
          typography: typography,
          background: colors.secondary,
          foreground: colors.secondaryForeground,
        ),
        destructive: FButtonStyle.inherit(
          colors: colors,
          style: style,
          typography: typography,
          background: colors.destructive,
          foreground: colors.destructiveForeground,
        ),
        outline: FButtonStyle(
          enabledBoxDecoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: style.borderRadius,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: style.borderRadius,
            color: colors.secondary,
          ),
          disabledBoxDecoration: BoxDecoration(
            border: Border.all(color: colors.disable(colors.border)),
            borderRadius: style.borderRadius,
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle(
            enabledStyle: IconThemeData(color: colors.secondaryForeground, size: 20),
            disabledStyle: IconThemeData(color: colors.disable(colors.secondaryForeground), size: 20),
          ),
          tappableStyle: style.tappableStyle,
        ),
        ghost: FButtonStyle(
          enabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
          enabledHoverBoxDecoration: BoxDecoration(borderRadius: style.borderRadius, color: colors.secondary),
          disabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colors.secondaryForeground,
            disabled: colors.disable(colors.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle(
            enabledStyle: IconThemeData(color: colors.secondaryForeground, size: 20),
            disabledStyle: IconThemeData(color: colors.disable(colors.secondaryForeground), size: 20),
          ),
          tappableStyle: style.tappableStyle,
        ),
      );
}

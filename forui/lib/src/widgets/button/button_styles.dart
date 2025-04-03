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

  /// Creates a [FButtonStyle] that inherits its properties from the provided [color], [text], and
  /// [style].
  FButtonStyles.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        primary: FButtonStyle.inherit(
          color: color,
          style: style,
          text: text,
          background: color.primary,
          foreground: color.primaryForeground,
        ),
        secondary: FButtonStyle.inherit(
          color: color,
          style: style,
          text: text,
          background: color.secondary,
          foreground: color.secondaryForeground,
        ),
        destructive: FButtonStyle.inherit(
          color: color,
          style: style,
          text: text,
          background: color.destructive,
          foreground: color.destructiveForeground,
        ),
        outline: FButtonStyle(
          enabledBoxDecoration: BoxDecoration(
            border: Border.all(color: color.border),
            borderRadius: style.borderRadius,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            border: Border.all(color: color.border),
            borderRadius: style.borderRadius,
            color: color.secondary,
          ),
          disabledBoxDecoration: BoxDecoration(
            border: Border.all(color: color.disable(color.border)),
            borderRadius: style.borderRadius,
          ),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            text: text,
            enabled: color.secondaryForeground,
            disabled: color.disable(color.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle(
            enabledStyle: IconThemeData(color: color.secondaryForeground, size: 20),
            disabledStyle: IconThemeData(color: color.disable(color.secondaryForeground), size: 20),
          ),
          tappableStyle: style.tappableStyle,
        ),
        ghost: FButtonStyle(
          enabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
          enabledHoverBoxDecoration: BoxDecoration(borderRadius: style.borderRadius, color: color.secondary),
          disabledBoxDecoration: BoxDecoration(borderRadius: style.borderRadius),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: FButtonContentStyle.inherit(
            text: text,
            enabled: color.secondaryForeground,
            disabled: color.disable(color.secondaryForeground),
          ),
          iconContentStyle: FButtonIconContentStyle(
            enabledStyle: IconThemeData(color: color.secondaryForeground, size: 20),
            disabledStyle: IconThemeData(color: color.disable(color.secondaryForeground), size: 20),
          ),
          tappableStyle: style.tappableStyle,
        ),
      );
}

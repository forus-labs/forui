import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'button_styles.style.dart';

/// [FButtonCustomStyle]'s style.
final class FButtonStyles with Diagnosticable, _$FButtonStylesFunctions {
  /// The primary button style.
  @override
  final FButtonCustomStyle primary;

  /// The secondary  button style.
  @override
  final FButtonCustomStyle secondary;

  /// The destructive button style.
  @override
  final FButtonCustomStyle destructive;

  /// The outlined button style.
  @override
  final FButtonCustomStyle outline;

  /// The ghost button style.
  @override
  final FButtonCustomStyle ghost;

  /// Creates a [FButtonCustomStyle].
  const FButtonStyles({
    required this.primary,
    required this.secondary,
    required this.destructive,
    required this.outline,
    required this.ghost,
  });

  /// Creates a [FButtonCustomStyle] that inherits its properties from the provided [colorScheme], [typography], and
  /// [style].
  FButtonStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        primary: FButtonCustomStyle.inherit(
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
        secondary: FButtonCustomStyle.inherit(
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
        destructive: FButtonCustomStyle.inherit(
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
        outline: FButtonCustomStyle(
          decoration: WidgetStateMapper({
            WidgetState.disabled: BoxDecoration(
              border: Border.all(color: colorScheme.disable(colorScheme.border)),
              borderRadius: style.borderRadius,
            ),
            WidgetState.hovered: BoxDecoration(
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
          contentStyle: WidgetStateMapper({
            WidgetState.disabled: FButtonContentStyle.inherit(
              typography: typography,
              color: colorScheme.disable(colorScheme.secondaryForeground),
            ),
            WidgetState.any: FButtonContentStyle.inherit(
              typography: typography,
              color: colorScheme.secondaryForeground,
            ),
          }),
          iconContentStyle: FButtonIconContentStyle(
            enabledColor: colorScheme.secondaryForeground,
            disabledColor: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          spinnerStyle: FButtonSpinnerStyle.inherit(
            enabled: colorScheme.secondaryForeground,
            disabled: colorScheme.disable(colorScheme.secondaryForeground),
          ),
        ),
        ghost: FButtonCustomStyle(
          decoration: WidgetStateMapper({
            ~WidgetState.hovered: BoxDecoration(borderRadius: style.borderRadius),
            WidgetState.hovered: BoxDecoration(borderRadius: style.borderRadius, color: colorScheme.secondary),
          }),
          focusedOutlineStyle: style.focusedOutlineStyle,
          contentStyle: WidgetStateMapper({
            WidgetState.disabled: FButtonContentStyle.inherit(
              typography: typography,
              color: colorScheme.disable(colorScheme.secondaryForeground),
            ),
            WidgetState.any: FButtonContentStyle.inherit(
              typography: typography,
              color: colorScheme.secondaryForeground,
            ),
          }),
          iconContentStyle: FButtonIconContentStyle(
            enabledColor: colorScheme.secondaryForeground,
            disabledColor: colorScheme.disable(colorScheme.secondaryForeground),
          ),
          spinnerStyle: FButtonSpinnerStyle.inherit(
            enabled: colorScheme.secondaryForeground,
            disabled: colorScheme.disable(colorScheme.secondaryForeground),
          ),
        ),
      );
}

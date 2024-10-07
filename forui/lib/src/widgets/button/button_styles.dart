import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// [FButtonCustomStyle]'s style.
final class FButtonStyles with Diagnosticable {
  /// The primary button style.
  final FButtonCustomStyle primary;

  /// The secondary  button style.
  final FButtonCustomStyle secondary;

  /// The destructive button style.
  final FButtonCustomStyle destructive;

  /// The outlined button style.
  final FButtonCustomStyle outline;

  /// Creates a [FButtonCustomStyle].
  const FButtonStyles({
    required this.primary,
    required this.secondary,
    required this.destructive,
    required this.outline,
  });

  /// Creates a [FButtonCustomStyle] that inherits its properties from the provided [colorScheme], [typography], and
  /// [style].
  FButtonStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          primary: FButtonCustomStyle.inherit(
            style: style,
            typography: typography,
            enabledBoxColor: colorScheme.enabled.primary,
            enabledHoveredBoxColor: colorScheme.enabledHovered.primary,
            disabledBoxColor: colorScheme.disabled.primary,
            enabledContentColor: colorScheme.enabled.primaryForeground,
            disabledContentColor: colorScheme.disabled.primaryForeground,
          ),
          secondary: FButtonCustomStyle.inherit(
            style: style,
            typography: typography,
            enabledBoxColor: colorScheme.enabled.secondary,
            enabledHoveredBoxColor: colorScheme.enabledHovered.secondary,
            disabledBoxColor: colorScheme.disabled.secondary,
            enabledContentColor: colorScheme.enabled.secondaryForeground,
            disabledContentColor: colorScheme.disabled.secondaryForeground,
          ),
          destructive: FButtonCustomStyle.inherit(
            style: style,
            typography: typography,
            enabledBoxColor: colorScheme.enabled.destructive,
            enabledHoveredBoxColor: colorScheme.enabledHovered.destructive,
            disabledBoxColor: colorScheme.disabled.destructive,
            enabledContentColor: colorScheme.enabled.destructiveForeground,
            disabledContentColor: colorScheme.disabled.destructiveForeground,
          ),
          outline: FButtonCustomStyle(
            enabledBoxDecoration: BoxDecoration(
              border: Border.all(color: colorScheme.enabled.border),
              borderRadius: style.borderRadius,
              color: colorScheme.enabled.background,
            ),
            enabledHoverBoxDecoration: BoxDecoration(
              border: Border.all(color: colorScheme.enabled.border),
              borderRadius: style.borderRadius,
              color: colorScheme.enabled.secondary,
            ),
            disabledBoxDecoration: BoxDecoration(
              border: Border.all(color: colorScheme.disabled.border),
              borderRadius: style.borderRadius,
              color: colorScheme.enabled.background,
            ),
            contentStyle: FButtonContentStyle.inherit(
              typography: typography,
              enabled: colorScheme.enabled.secondaryForeground,
              disabled: colorScheme.disabled.secondaryForeground,
            ),
            iconContentStyle: FButtonIconContentStyle(
              enabledColor: colorScheme.enabled.secondaryForeground,
              disabledColor: colorScheme.disabled.secondaryForeground,
            ),
          ),
        );

  /// Returns a copy of this [FButtonStyles] with the given properties replaced.
  @useResult
  FButtonStyles copyWith({
    FButtonCustomStyle? primary,
    FButtonCustomStyle? secondary,
    FButtonCustomStyle? destructive,
    FButtonCustomStyle? outline,
  }) =>
      FButtonStyles(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        destructive: destructive ?? this.destructive,
        outline: outline ?? this.outline,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('destructive', destructive))
      ..add(DiagnosticsProperty('outlined', outline));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FButtonStyles &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          secondary == other.secondary &&
          destructive == other.destructive &&
          outline == other.outline;

  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode ^ destructive.hashCode ^ outline.hashCode;
}

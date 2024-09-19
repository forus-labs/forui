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
      : primary = FButtonCustomStyle(
          enabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.primary,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.primary.withOpacity(0.9),
          ),
          disabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.primary.withOpacity(0.5),
          ),
          content: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colorScheme.primaryForeground,
            disabled: colorScheme.primaryForeground.withOpacity(0.5),
          ),
          icon: FButtonIconStyle(
            enabledColor: colorScheme.primaryForeground,
            disabledColor: colorScheme.primaryForeground.withOpacity(0.5),
          ),
        ),
        secondary = FButtonCustomStyle(
          enabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.secondary,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.secondary.withOpacity(0.9),
          ),
          disabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.secondary.withOpacity(0.5),
          ),
          content: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colorScheme.secondaryForeground,
            disabled: colorScheme.secondaryForeground.withOpacity(0.5),
          ),
          icon: FButtonIconStyle(
            enabledColor: colorScheme.secondaryForeground,
            disabledColor: colorScheme.secondaryForeground.withOpacity(0.5),
          ),
        ),
        destructive = FButtonCustomStyle(
          enabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.destructive,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.destructive.withOpacity(0.9),
          ),
          disabledBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.destructive.withOpacity(0.5),
          ),
          content: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colorScheme.destructiveForeground,
            disabled: colorScheme.destructiveForeground.withOpacity(0.5),
          ),
          icon: FButtonIconStyle(
            enabledColor: colorScheme.destructiveForeground,
            disabledColor: colorScheme.destructiveForeground.withOpacity(0.5),
          ),
        ),
        outline = FButtonCustomStyle(
          enabledBoxDecoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.border,
            ),
            borderRadius: style.borderRadius,
            color: colorScheme.background,
          ),
          enabledHoverBoxDecoration: BoxDecoration(
            borderRadius: style.borderRadius,
            color: colorScheme.secondary,
          ),
          disabledBoxDecoration: BoxDecoration(
            border: Border.all(color: colorScheme.border.withOpacity(0.5)),
            borderRadius: style.borderRadius,
            color: colorScheme.background,
          ),
          content: FButtonContentStyle.inherit(
            typography: typography,
            enabled: colorScheme.secondaryForeground,
            disabled: colorScheme.secondaryForeground.withOpacity(0.5),
          ),
          icon: FButtonIconStyle(
            enabledColor: colorScheme.secondaryForeground,
            disabledColor: colorScheme.secondaryForeground.withOpacity(0.5),
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

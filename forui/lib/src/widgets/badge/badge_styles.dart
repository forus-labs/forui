import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// The [FBadgeCustomStyle]s.
final class FBadgeStyles with Diagnosticable {
  /// The primary badge style.
  final FBadgeCustomStyle primary;

  /// The secondary badge style.
  final FBadgeCustomStyle secondary;

  /// The outlined badge style.
  final FBadgeCustomStyle outline;

  /// The destructive badge style.
  final FBadgeCustomStyle destructive;

  /// Creates a [FBadgeStyles].
  FBadgeStyles({
    required this.primary,
    required this.secondary,
    required this.outline,
    required this.destructive,
  });

  /// Creates a [FBadgeStyles] that inherits its properties from the provided [colorScheme], [typography], and [style].
  FBadgeStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
            primary: FBadgeCustomStyle(
              backgroundColor: colorScheme.enabled.primary,
              borderColor: colorScheme.enabled.primary,
              borderWidth: style.borderWidth,
              contentStyle: FBadgeContentStyle(
                labelTextStyle: typography.sm.copyWith(
                  color: colorScheme.enabled.primaryForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            secondary: FBadgeCustomStyle(
              backgroundColor: colorScheme.enabled.secondary,
              borderColor: colorScheme.enabled.secondary,
              borderWidth: style.borderWidth,
              contentStyle: FBadgeContentStyle(
                labelTextStyle: typography.sm.copyWith(
                  color: colorScheme.enabled.secondaryForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            outline: FBadgeCustomStyle(
              backgroundColor: colorScheme.enabled.background,
              borderColor: colorScheme.enabled.border,
              borderWidth: style.borderWidth,
              contentStyle: FBadgeContentStyle(
                labelTextStyle: typography.sm.copyWith(
                  color: colorScheme.enabled.foreground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            destructive: FBadgeCustomStyle(
              backgroundColor: colorScheme.enabled.destructive,
              borderColor: colorScheme.enabled.destructive,
              borderWidth: style.borderWidth,
              contentStyle: FBadgeContentStyle(
                labelTextStyle: typography.sm.copyWith(
                  color: colorScheme.enabled.destructiveForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ));

  /// Returns a copy of this [FBadgeStyles] with the given properties replaced.
  @useResult
  FBadgeStyles copyWith({
    FBadgeCustomStyle? primary,
    FBadgeCustomStyle? secondary,
    FBadgeCustomStyle? outline,
    FBadgeCustomStyle? destructive,
  }) =>
      FBadgeStyles(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        outline: outline ?? this.outline,
        destructive: destructive ?? this.destructive,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('outline', outline))
      ..add(DiagnosticsProperty('destructive', destructive));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeStyles &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          secondary == other.secondary &&
          outline == other.outline &&
          destructive == other.destructive;

  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode ^ outline.hashCode ^ destructive.hashCode;
}

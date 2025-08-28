import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'badge_styles.design.dart';

/// The [FBadgeStyle]s.
class FBadgeStyles with Diagnosticable, _$FBadgeStylesFunctions {
  /// The default border radius for badges.
  static const BorderRadius defaultRadius = BorderRadius.all(Radius.circular(100));

  /// The primary badge style.
  @override
  final FBadgeStyle primary;

  /// The secondary badge style.
  @override
  final FBadgeStyle secondary;

  /// The outlined badge style.
  @override
  final FBadgeStyle outline;

  /// The destructive badge style.
  @override
  final FBadgeStyle destructive;

  /// Creates a [FBadgeStyles].
  FBadgeStyles({required this.primary, required this.secondary, required this.outline, required this.destructive});

  /// Creates a [FBadgeStyles] that inherits its properties.
  FBadgeStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        primary: FBadgeStyle(
          decoration: BoxDecoration(color: colors.primary, borderRadius: FBadgeStyles.defaultRadius),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(color: colors.primaryForeground, fontWeight: FontWeight.w600),
          ),
        ),
        secondary: FBadgeStyle(
          decoration: BoxDecoration(color: colors.secondary, borderRadius: FBadgeStyles.defaultRadius),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(color: colors.secondaryForeground, fontWeight: FontWeight.w600),
          ),
        ),
        outline: FBadgeStyle(
          decoration: BoxDecoration(
            border: Border.all(color: colors.border, width: style.borderWidth),
            borderRadius: FBadgeStyles.defaultRadius,
          ),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(color: colors.foreground, fontWeight: FontWeight.w600),
          ),
        ),
        destructive: FBadgeStyle(
          decoration: BoxDecoration(color: colors.destructive, borderRadius: FBadgeStyles.defaultRadius),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(color: colors.destructiveForeground, fontWeight: FontWeight.w600),
          ),
        ),
      );
}

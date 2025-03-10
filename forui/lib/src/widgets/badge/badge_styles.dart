import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'badge_styles.style.dart';

/// The [FBadgeStyle]s.
final class FBadgeStyles with Diagnosticable, _$FBadgeStylesFunctions {
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

  /// Creates a [FBadgeStyles] that inherits its properties from the provided [colorScheme], [typography], and [style].
  FBadgeStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
    : this(
        primary: FBadgeStyle(
          backgroundColor: colorScheme.primary,
          borderColor: colorScheme.primary,
          borderWidth: style.borderWidth,
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground, fontWeight: FontWeight.w600),
          ),
        ),
        secondary: FBadgeStyle(
          backgroundColor: colorScheme.secondary,
          borderColor: colorScheme.secondary,
          borderWidth: style.borderWidth,
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(color: colorScheme.secondaryForeground, fontWeight: FontWeight.w600),
          ),
        ),
        outline: FBadgeStyle(
          backgroundColor: colorScheme.background,
          borderColor: colorScheme.border,
          borderWidth: style.borderWidth,
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(color: colorScheme.foreground, fontWeight: FontWeight.w600),
          ),
        ),
        destructive: FBadgeStyle(
          backgroundColor: colorScheme.destructive,
          borderColor: colorScheme.destructive,
          borderWidth: style.borderWidth,
          contentStyle: FBadgeContentStyle(
            labelTextStyle: typography.sm.copyWith(
              color: colorScheme.destructiveForeground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}

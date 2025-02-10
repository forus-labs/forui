import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'badge_styles.style.dart';

/// The [FBadgeCustomStyle]s.
final class FBadgeStyles with Diagnosticable, _$FBadgeStylesFunctions {
  /// The primary badge style.
  @override
  final FBadgeCustomStyle primary;

  /// The secondary badge style.
  @override
  final FBadgeCustomStyle secondary;

  /// The outlined badge style.
  @override
  final FBadgeCustomStyle outline;

  /// The destructive badge style.
  @override
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
            backgroundColor: colorScheme.primary,
            borderColor: colorScheme.primary,
            borderWidth: style.borderWidth,
            contentStyle: FBadgeContentStyle(
              labelTextStyle: typography.sm.copyWith(color: colorScheme.primaryForeground, fontWeight: FontWeight.w600),
            ),
          ),
          secondary: FBadgeCustomStyle(
            backgroundColor: colorScheme.secondary,
            borderColor: colorScheme.secondary,
            borderWidth: style.borderWidth,
            contentStyle: FBadgeContentStyle(
              labelTextStyle: typography.sm.copyWith(
                color: colorScheme.secondaryForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          outline: FBadgeCustomStyle(
            backgroundColor: colorScheme.background,
            borderColor: colorScheme.border,
            borderWidth: style.borderWidth,
            contentStyle: FBadgeContentStyle(
              labelTextStyle: typography.sm.copyWith(
                color: colorScheme.foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          destructive: FBadgeCustomStyle(
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

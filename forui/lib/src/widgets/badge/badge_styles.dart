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

  /// Creates a [FBadgeStyles] that inherits its properties from the provided [color], [text], and [style].
  FBadgeStyles.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        primary: FBadgeStyle(
          decoration: BoxDecoration(color: color.primary, borderRadius: const BorderRadius.all(Radius.circular(100))),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: text.sm.copyWith(color: color.primaryForeground, fontWeight: FontWeight.w600),
          ),
        ),
        secondary: FBadgeStyle(
          decoration: BoxDecoration(color: color.secondary, borderRadius: const BorderRadius.all(Radius.circular(100))),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: text.sm.copyWith(color: color.secondaryForeground, fontWeight: FontWeight.w600),
          ),
        ),
        outline: FBadgeStyle(
          decoration: BoxDecoration(
            border: Border.all(color: color.border, width: style.borderWidth),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: text.sm.copyWith(color: color.foreground, fontWeight: FontWeight.w600),
          ),
        ),
        destructive: FBadgeStyle(
          decoration: BoxDecoration(
            color: color.destructive,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: text.sm.copyWith(color: color.destructiveForeground, fontWeight: FontWeight.w600),
          ),
        ),
      );
}

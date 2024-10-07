import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/badge/badge_content.dart';

/// A badge. Badges are typically used to draw attention to specific information, such as labels and counts.
///
/// The constants in [FBadgeStyle] provide a convenient way to style a badge.
///
/// See:
/// * https://forui.dev/docs/badge for working examples.
/// * [FBadgeCustomStyle] for customizing a badge's appearance.
class FBadge extends StatelessWidget {
  /// The style. Defaults to [FBadgeStyle.primary].
  ///
  /// Although typically one of the pre-defined styles in [FBadgeStyle], it can also be a [FBadgeCustomStyle].
  final FBadgeStyle style;

  /// The builder used to build the badge's content.
  final Widget Function(BuildContext, FBadgeCustomStyle) builder;

  /// Creates a [FBadge] that contains a [label].
  FBadge({
    required Widget label,
    this.style = FBadgeStyle.primary,
    super.key,
  }) : builder = ((context, style) => Content(label: label, style: style));

  /// Creates a [FBadge] with custom content.
  const FBadge.raw({
    required this.builder,
    this.style = FBadgeStyle.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FBadgeCustomStyle style => style,
      FBadgeStyle.primary => context.theme.badgeStyles.primary,
      FBadgeStyle.secondary => context.theme.badgeStyles.secondary,
      FBadgeStyle.outline => context.theme.badgeStyles.outline,
      FBadgeStyle.destructive => context.theme.badgeStyles.destructive,
    };

    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: style.borderColor,
              width: style.borderWidth,
            ),
            borderRadius: style.borderRadius,
            color: style.backgroundColor,
          ),
          child: builder(context, style),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, defaultValue: FBadgeStyle.primary))
      ..add(DiagnosticsProperty('builder', builder, level: DiagnosticLevel.debug));
  }
}

/// A [FBadge]'s style.
///
/// A style can be either one of the pre-defined styles in [FBadgeStyle] or a [FBadgeCustomStyle]. The pre-defined
/// styles are a convenient shorthand for the various [FBadgeCustomStyle]s in the current context's [FBadgeStyles].
sealed class FBadgeStyle {
  /// The badge's primary style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.primary] style.
  static const FBadgeStyle primary = Variant.primary;

  /// The badge's secondary style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.secondary] style.
  static const FBadgeStyle secondary = Variant.secondary;

  /// The badge's outline style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.outline] style.
  static const FBadgeStyle outline = Variant.outline;

  /// The badge's destructive style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.destructive] style.
  static const FBadgeStyle destructive = Variant.destructive;
}

@internal
enum Variant implements FBadgeStyle {
  primary,
  secondary,
  outline,
  destructive,
}

/// A custom [FBadge] style.
final class FBadgeCustomStyle with Diagnosticable implements FBadgeStyle {
  /// The background color.
  final Color backgroundColor;

  /// The border color.
  final Color borderColor;

  /// The border radius. Defaults to `BorderRadius.circular(100)`.
  final BorderRadius borderRadius;

  /// The border width (thickness).
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * `borderWidth` <= 0.0
  /// * `borderWidth` is Nan
  final double borderWidth;

  /// The badge content's style.
  final FBadgeContentStyle contentStyle;

  /// Creates a [FBadgeCustomStyle].
  const FBadgeCustomStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.contentStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(100)),
  }) : assert(0 < borderWidth, 'The borderWidth is $borderWidth, but it should be in the range "0 < borderWidth".');

  /// Returns a copy of this [FBadgeCustomStyle] with the given properties replaced.
  @useResult
  FBadgeCustomStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    double? borderWidth,
    FBadgeContentStyle? contentStyle,
  }) =>
      FBadgeCustomStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        borderColor: borderColor ?? this.borderColor,
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        contentStyle: contentStyle ?? this.contentStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('borderColor', borderColor))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, defaultValue: BorderRadius.circular(100)))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty('contentStyle', contentStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBadgeCustomStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          borderColor == other.borderColor &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          contentStyle == other.contentStyle;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      borderColor.hashCode ^
      borderRadius.hashCode ^
      borderWidth.hashCode ^
      contentStyle.hashCode;
}

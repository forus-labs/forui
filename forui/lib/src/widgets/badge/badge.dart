import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/badge/badge_content.dart';

part 'badge.style.dart';

/// A badge. Badges are typically used to draw attention to specific information, such as labels and counts.
///
/// The constants in [FBadgeStyle] provide a convenient way to style a badge.
///
/// See:
/// * https://forui.dev/docs/data/badge for working examples.
/// * [FBadgeStyle] for customizing a badge's appearance.
class FBadge extends StatelessWidget {
  /// The style. Defaults to [FBadgeStyle.primary].
  final FBaseBadgeStyle style;

  /// The builder used to build the badge's content.
  final Widget Function(BuildContext, FBadgeStyle) builder;

  /// Creates a [FBadge].
  FBadge({required Widget child, this.style = FBadgeStyle.primary, super.key})
    : builder = ((_, style) => Content(style: style, child: child));

  /// Creates a [FBadge] with no defaults applied.
  const FBadge.raw({required this.builder, this.style = FBadgeStyle.primary, super.key});

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FBadgeStyle style => style,
      FBadgeStyle.primary => context.theme.badgeStyles.primary,
      FBadgeStyle.secondary => context.theme.badgeStyles.secondary,
      FBadgeStyle.outline => context.theme.badgeStyles.outline,
      FBadgeStyle.destructive => context.theme.badgeStyles.destructive,
    };

    return IntrinsicWidth(
      child: IntrinsicHeight(child: DecoratedBox(decoration: style.decoration, child: builder(context, style))),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, defaultValue: FBadgeStyle.primary))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

/// A [FBadge]'s style.
///
/// A style can be either one of the pre-defined styles in [FBadgeStyle] or a [FBadgeStyle] itself.
sealed class FBaseBadgeStyle {}

@internal
enum Variant implements FBaseBadgeStyle { primary, secondary, outline, destructive }

/// A [FBadge]'s style.
///
/// The pre-defined styles are a convenient shorthand for the various [FBadgeStyle]s in the current context's
/// [FBadgeStyles].
class FBadgeStyle with Diagnosticable, _$FBadgeStyleFunctions implements FBaseBadgeStyle {
  /// The badge's primary style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.primary] style.
  static const FBaseBadgeStyle primary = Variant.primary;

  /// The badge's secondary style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.secondary] style.
  static const FBaseBadgeStyle secondary = Variant.secondary;

  /// The badge's outline style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.outline] style.
  static const FBaseBadgeStyle outline = Variant.outline;

  /// The badge's destructive style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.destructive] style.
  static const FBaseBadgeStyle destructive = Variant.destructive;

  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The content's style.
  @override
  final FBadgeContentStyle contentStyle;

  /// Creates a [FBadgeStyle].
  const FBadgeStyle({required this.decoration, required this.contentStyle});
}

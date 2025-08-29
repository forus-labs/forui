import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/badge/badge_content.dart';

part 'badge.design.dart';

/// A badge. Badges are typically used to draw attention to specific information, such as labels and counts.
///
/// The constants in [FBadgeStyle] provide a convenient way to style a badge.
///
/// See:
/// * https://forui.dev/docs/data/badge for working examples.
/// * [FBadgeStyle] for customizing a badge's appearance.
class FBadge extends StatelessWidget {
  static _Resolve _primary(FBadgeStyle _) => _Resolve((context) => context.theme.badgeStyles.primary);

  /// The style. Defaults to [FBadgeStyle.primary].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create badges
  /// ```
  final FBaseBadgeStyle Function(FBadgeStyle style) style;

  /// The builder used to build the badge's content.
  final Widget Function(BuildContext context, FBadgeStyle style) builder;

  /// Creates a [FBadge].
  FBadge({required Widget child, this.style = _primary, super.key})
    : builder = ((_, style) => Content(style: style, child: child));

  /// Creates a [FBadge] with no defaults applied.
  const FBadge.raw({required this.builder, this.style = _primary, super.key});

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style(context.theme.badgeStyles.primary)) {
      final FBadgeStyle style => style,
      final _Resolve resolver => resolver._resolve(context),
    };

    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: DecoratedBox(decoration: style.decoration, child: builder(context, style)),
      ),
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

class _Resolve extends FBaseBadgeStyle {
  final FBadgeStyle Function(BuildContext context) _resolve;

  _Resolve(this._resolve);
}

/// A [FBadge]'s style.
///
/// The pre-defined styles are a convenient shorthand for the various [FBadgeStyle]s in the current context's
/// [FBadgeStyles].
class FBadgeStyle with Diagnosticable, _$FBadgeStyleFunctions implements FBaseBadgeStyle {
  /// The badge's primary style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.primary] style.
  static FBaseBadgeStyle Function(FBadgeStyle) primary([FBadgeStyle Function(FBadgeStyle)? style]) =>
      (_) => _Resolve((context) => style?.call(context.theme.badgeStyles.primary) ?? context.theme.badgeStyles.primary);

  /// The badge's secondary style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.secondary] style.
  static FBaseBadgeStyle Function(FBadgeStyle) secondary([FBadgeStyle Function(FBadgeStyle)? style]) =>
      (_) => _Resolve(
        (context) => style?.call(context.theme.badgeStyles.secondary) ?? context.theme.badgeStyles.secondary,
      );

  /// The badge's outline style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.outline] style.
  static FBaseBadgeStyle Function(FBadgeStyle) outline([FBadgeStyle Function(FBadgeStyle)? style]) =>
      (_) => _Resolve((context) => style?.call(context.theme.badgeStyles.outline) ?? context.theme.badgeStyles.outline);

  /// The badge's destructive style.
  ///
  /// Shorthand for the current context's [FBadgeStyles.destructive] style.
  static FBaseBadgeStyle Function(FBadgeStyle) destructive([FBadgeStyle Function(FBadgeStyle)? style]) =>
      (_) => _Resolve(
        (context) => style?.call(context.theme.badgeStyles.destructive) ?? context.theme.badgeStyles.destructive,
      );

  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The content's style.
  @override
  final FBadgeContentStyle contentStyle;

  /// Creates a [FBadgeStyle].
  const FBadgeStyle({required this.decoration, required this.contentStyle});
}

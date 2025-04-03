import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'alert.style.dart';

/// An alert.
///
/// Displays a callout for user attention.
///
/// See:
/// * https://forui.dev/docs/navigation/alert for working examples.
/// * [FBaseAlertStyle] for customizing an alert's appearance.
class FAlert extends StatelessWidget {
  /// The icon, wrapped in [IconThemeData]. Defaults to `FIcons.circleAlert`.
  final Widget icon;

  /// The title.
  final Widget title;

  /// The subtitle.
  final Widget? subtitle;

  /// The style. Defaults to [FAlertStyle.primary].
  ///
  /// Although typically one of the pre-defined styles in [FBaseAlertStyle], it can also be a [FAlertStyle].
  final FBaseAlertStyle style;

  /// Creates a [FAlert] with a tile, subtitle, and icon.
  ///
  /// The alert's layout is as follows:
  /// ```diagram
  /// |---------------------------|
  /// |  [icon]  [title]          |
  /// |          [subtitle]       |
  /// |---------------------------|
  /// ```
  const FAlert({
    required this.title,
    this.icon = const Icon(FIcons.circleAlert),
    this.subtitle,
    this.style = FAlertStyle.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FAlertStyle style => style,
      Variant.primary => context.theme.alertStyles.primary,
      Variant.destructive => context.theme.alertStyles.destructive,
    };

    return DecoratedBox(
      decoration: style.decoration,
      child: Padding(
        padding: style.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconTheme(data: style.iconStyle, child: icon),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DefaultTextStyle.merge(style: style.titleTextStyle, child: title),
                  ),
                ),
              ],
            ),
            if (subtitle case final subtitle?)
              Row(
                children: [
                  SizedBox(width: style.iconStyle.size),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, left: 8),
                      child: DefaultTextStyle.merge(style: style.subtitleTextStyle, child: subtitle),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// [FAlertStyle]'s style.
final class FAlertStyles with Diagnosticable, _$FAlertStylesFunctions {
  /// The primary alert style.
  @override
  final FAlertStyle primary;

  /// The destructive alert style.
  @override
  final FAlertStyle destructive;

  /// Creates a [FAlertStyles].
  const FAlertStyles({required this.primary, required this.destructive});

  /// Creates a [FAlertStyles] that inherits its properties.
  FAlertStyles.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        primary: FAlertStyle(
          iconStyle: IconThemeData(color: color.foreground, size: 20),
          titleTextStyle: text.base.copyWith(
            fontWeight: FontWeight.w500,
            color: color.foreground,
            height: 1.2,
          ),
          subtitleTextStyle: text.sm.copyWith(color: color.foreground),
          decoration: BoxDecoration(
            border: Border.all(color: color.border),
            borderRadius: style.borderRadius,
            color: color.background,
          ),
        ),
        destructive: FAlertStyle(
          iconStyle: IconThemeData(color: color.destructive, size: 20),
          titleTextStyle: text.base.copyWith(
            fontWeight: FontWeight.w500,
            color: color.destructive,
            height: 1.2,
          ),
          subtitleTextStyle: text.sm.copyWith(color: color.destructive),
          decoration: BoxDecoration(
            border: Border.all(color: color.destructive),
            borderRadius: style.borderRadius,
            color: color.background,
          ),
        ),
      );
}

/// A [FAlert]'s style.
///
/// A style can be either one of the pre-defined styles in [FButtonStyle] or a [FButtonStyle] itself.
sealed class FBaseAlertStyle {}

@internal
enum Variant implements FBaseAlertStyle { primary, destructive }

/// A custom [FAlert] style.
///
/// The pre-defined styles are a convenient shorthand for the various [FAlertStyle]s in the current context.
final class FAlertStyle extends FBaseAlertStyle with Diagnosticable, _$FAlertStyleFunctions {
  /// The alert's primary style.
  ///
  /// Shorthand for the current context's [FAlertStyle.primary] style.
  static const FBaseAlertStyle primary = Variant.primary;

  /// The alert's destructive style.
  ///
  /// Shorthand for the current context's [FAlertStyle.destructive] style.
  static const FBaseAlertStyle destructive = Variant.destructive;

  /// The decoration.
  @override
  final BoxDecoration decoration;

  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 12)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The icon's style.
  @override
  final IconThemeData iconStyle;

  /// The title's [TextStyle].
  @override
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  @override
  final TextStyle subtitleTextStyle;

  /// Creates a [FAlertStyle].
  FAlertStyle({
    required this.decoration,
    required this.iconStyle,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 12),
  });
}

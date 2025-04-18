import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'alert.style.dart';

/// A visual element displaying status information (info, warning, success, or error).
///
/// Use alerts to communicate statuses, provide feedback, or convey important contextual information.
///
/// See:
/// * https://forui.dev/docs/feedback/alert for working examples.
/// * [FAlertStyle] for customizing an alert's appearance.
class FAlert extends StatelessWidget {
  /// The style. Defaults to [FAlertStyle.primary].
  ///
  /// Although typically one of the pre-defined styles in [FBaseAlertStyle], it can also be a [FAlertStyle]
  final FBaseAlertStyle style;

  /// The title of the alert.
  final Widget title;

  /// The subtitle of the alert.
  final Widget? subtitle;

  /// The icon displayed on the left side of the alert.
  final Widget icon;

  /// Creates a [FAlert] with a title, subtitle, and icon.
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

/// The alert styles.
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
  FAlertStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        primary: FAlertStyle(
          iconStyle: IconThemeData(color: colors.foreground, size: 20),
          titleTextStyle: typography.base.copyWith(fontWeight: FontWeight.w500, color: colors.foreground, height: 1.2),
          subtitleTextStyle: typography.sm.copyWith(color: colors.foreground),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: style.borderRadius,
            color: colors.background,
          ),
        ),
        destructive: FAlertStyle(
          iconStyle: IconThemeData(color: colors.destructive, size: 20),
          titleTextStyle: typography.base.copyWith(fontWeight: FontWeight.w500, color: colors.destructive, height: 1.2),
          subtitleTextStyle: typography.sm.copyWith(color: colors.destructive),
          decoration: BoxDecoration(
            border: Border.all(color: colors.destructive),
            borderRadius: style.borderRadius,
            color: colors.background,
          ),
        ),
      );
}

/// A [FAlert]'s style.
///
/// A style can be either one of the pre-defined styles in [FAlertStyle] or an [FAlertStyle] itself.
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

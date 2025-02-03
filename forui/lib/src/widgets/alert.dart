import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// An alert.
///
/// Displays a callout for user attention.
///
/// See:
/// * https://forui.dev/docs/navigation/alert for working examples.
/// * [FAlertStyle] for customizing an alert's appearance.
class FAlert extends StatelessWidget {
  /// The icon. Defaults to `FAssets.icons.circleAlert`.
  ///
  /// [icon] is wrapped in [FIconStyle], and therefore works with [FIcon]s.
  final Widget icon;

  /// The title.
  final Widget title;

  /// The subtitle.
  final Widget? subtitle;

  /// The style. Defaults to [FAlertStyle.primary].
  ///
  /// Although typically one of the pre-defined styles in [FAlertStyle], it can also be a [FAlertCustomStyle].
  final FAlertStyle style;

  /// Creates a [FAlert] with a tile, subtitle, and icon.
  ///
  /// The alert's layout is as follows:
  /// ```diagram
  /// |---------------------------|
  /// |  [icon]  [title]          |
  /// |          [subtitle]       |
  /// |---------------------------|
  /// ```
  FAlert({
    required this.title,
    Widget? icon,
    this.subtitle,
    this.style = FAlertStyle.primary,
    super.key,
  }) : icon = icon ?? FIcon(FAssets.icons.circleAlert);

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FAlertCustomStyle style => style,
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
                FIconStyleData(
                  style: FIconStyle(color: style.iconColor, size: style.iconSize),
                  child: icon,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DefaultTextStyle.merge(
                      style: style.titleTextStyle,
                      child: title,
                    ),
                  ),
                ),
              ],
            ),
            if (subtitle != null)
              Row(
                children: [
                  SizedBox(width: style.iconSize),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, left: 8),
                      child: DefaultTextStyle.merge(
                        style: style.subtitleTextStyle,
                        child: subtitle!,
                      ),
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

/// [FAlertCustomStyle]'s style.
final class FAlertStyles with Diagnosticable {
  /// The primary alert style.
  final FAlertCustomStyle primary;

  /// The destructive alert style.
  final FAlertCustomStyle destructive;

  /// Creates a [FAlertStyles].
  const FAlertStyles({
    required this.primary,
    required this.destructive,
  });

  /// Creates a [FAlertStyles] that inherits its properties from the provided [colorScheme], [typography], and [style].
  FAlertStyles.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          primary: FAlertCustomStyle(
            iconColor: colorScheme.foreground,
            titleTextStyle: typography.base.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.foreground,
              height: 1.2,
            ),
            subtitleTextStyle: typography.sm.copyWith(color: colorScheme.foreground),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.border),
              borderRadius: style.borderRadius,
              color: colorScheme.background,
            ),
          ),
          destructive: FAlertCustomStyle(
            iconColor: colorScheme.destructive,
            titleTextStyle: typography.base.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.destructive,
              height: 1.2,
            ),
            subtitleTextStyle: typography.sm.copyWith(color: colorScheme.destructive),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.destructive),
              borderRadius: style.borderRadius,
              color: colorScheme.background,
            ),
          ),
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('destructive', destructive));
  }

  /// Returns a copy of this [FAlertStyles] with the given properties replaced.
  @useResult
  FAlertStyles copyWith({
    FAlertCustomStyle? primary,
    FAlertCustomStyle? destructive,
  }) =>
      FAlertStyles(
        primary: primary ?? this.primary,
        destructive: destructive ?? this.destructive,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAlertStyles &&
          runtimeType == other.runtimeType &&
          primary == other.primary &&
          destructive == other.destructive;

  @override
  int get hashCode => primary.hashCode ^ destructive.hashCode;
}

/// A [FAlert]'s style.
///
/// A style can be either one of the pre-defined styles in [FAlertStyle] or a [FAlertCustomStyle]. The pre-defined
/// styles are a convenient shorthand for the various [FAlertCustomStyle]s in the current context's [FAlertStyles].
sealed class FAlertStyle {
  /// The alert's primary style.
  ///
  /// Shorthand for the current context's [FAlertStyle.primary] style.
  static const FAlertStyle primary = Variant.primary;

  /// The alert's destructive style.
  ///
  /// Shorthand for the current context's [FAlertStyle.destructive] style.
  static const FAlertStyle destructive = Variant.destructive;
}

@internal
enum Variant implements FAlertStyle {
  primary,
  destructive,
}

/// A custom [FAlert] style.
final class FAlertCustomStyle extends FAlertStyle with Diagnosticable {
  /// The decoration.
  final BoxDecoration decoration;

  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 12)`.
  final EdgeInsets padding;

  /// The icon's color.
  ///
  /// Defaults to 20.
  final Color iconColor;

  /// The icon's size. Defaults to 20.
  ///
  /// ## Contract
  /// Throws [AssertionError] if `iconSize` is not positive.
  final double iconSize;

  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  final TextStyle subtitleTextStyle;

  /// Creates a [FAlertCustomStyle].
  FAlertCustomStyle({
    required this.decoration,
    required this.iconColor,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 12),
    this.iconSize = 20,
  }) : assert(0 < iconSize, 'iconSize is $iconSize, but it should be positive.');

  /// Returns a copy of this [FAlertCustomStyle] with the given properties replaced.
  @useResult
  FAlertCustomStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsets? padding,
    Color? iconColor,
    double? iconSize,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) =>
      FAlertCustomStyle(
        decoration: decoration ?? this.decoration,
        padding: padding ?? this.padding,
        iconColor: iconColor ?? this.iconColor,
        iconSize: iconSize ?? this.iconSize,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(ColorProperty('iconColor', iconColor))
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FAlertCustomStyle &&
          runtimeType == other.runtimeType &&
          decoration == other.decoration &&
          padding == other.padding &&
          iconColor == other.iconColor &&
          iconSize == other.iconSize &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle;

  @override
  int get hashCode =>
      decoration.hashCode ^
      padding.hashCode ^
      iconColor.hashCode ^
      iconSize.hashCode & titleTextStyle.hashCode ^
      subtitleTextStyle.hashCode;
}

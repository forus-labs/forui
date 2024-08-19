import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// An alert.
///
/// Displays a callout for user attention.
///
/// See:
/// * https://forui.dev/docs/alert for working examples.
/// * [FAlertStyle] for customizing an alert's appearance.
class FAlert extends StatelessWidget {
  /// The icon. Defaults to [FAssets.icons.circleAlert].
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
  /// ```
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
  }) : icon = icon ?? FAlertIcon(icon: FAssets.icons.circleAlert);

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
                InheritedData(style: style, child: icon),
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
                  SizedBox(width: style.icon.size),
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

  /// The padding. Defaults to `const EdgeInsets.all(16)`.
  final EdgeInsets padding;

  /// The icon's style.
  final FAlertIconStyle icon;

  /// The title's [TextStyle].
  final TextStyle titleTextStyle;

  /// The subtitle's [TextStyle].
  final TextStyle subtitleTextStyle;

  /// Creates a [FAlertCustomStyle].
  FAlertCustomStyle({
    required this.decoration,
    required this.icon,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    this.padding = const EdgeInsets.all(16),
  });

  /// Returns a copy of this [FAlertCustomStyle] with the given properties replaced.
  @useResult
  FAlertCustomStyle copyWith({
    BoxDecoration? decoration,
    EdgeInsets? padding,
    FAlertIconStyle? icon,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) => FAlertCustomStyle(
      decoration: decoration ?? this.decoration,
      padding: padding ?? this.padding,
      icon: icon ?? this.icon,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('icon', icon))
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
          icon == other.icon &&
          titleTextStyle == other.titleTextStyle &&
          subtitleTextStyle == other.subtitleTextStyle;

  @override
  int get hashCode =>
      decoration.hashCode ^ padding.hashCode ^ icon.hashCode ^ titleTextStyle.hashCode ^ subtitleTextStyle.hashCode;
}

@internal
class InheritedData extends InheritedWidget {
  @useResult
  static FAlertCustomStyle of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    return theme?.style ?? context.theme.alertStyles.primary;
  }

  final FAlertCustomStyle style;

  const InheritedData({
    required this.style,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant InheritedData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

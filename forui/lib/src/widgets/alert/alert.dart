import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'alert_styles.dart';

part 'alert_icon.dart';

/// An alert.
///
/// Displays a callout for user attention.
///
/// See:
/// * https://forui.dev/docs/alert for working examples.
/// * [FAlertStyle] for customizing an alert's appearance.
class FAlert extends StatelessWidget {
  @useResult
  static _Data _of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_InheritedData>();
    return theme?.data ?? (style: context.theme.alertStyles.primary);
  }

  /// The icon. Defaults to [FAssets.icons.circleAlert].
  final Widget? icon;

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
  const FAlert({
    required this.title,
    this.icon,
    this.subtitle,
    this.style = FAlertStyle.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = switch (this.style) {
      final FAlertCustomStyle style => style,
      Variant.primary => context.theme.alertStyles.primary,
      Variant.destructive => context.theme.alertStyles.destructive,
    };
    final icon = this.icon ?? FAlertIcon(icon: FAssets.icons.circleAlert);

    return DecoratedBox(
      decoration: style.decoration,
      child: Padding(
        padding: style.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _InheritedData(data: (style: style), child: icon),
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
                  SizedBox(width: style.icon.height),
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
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('icon', icon));
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

  /// The padding. Defaults to `EdgeInsets.fromLTRB(16, 12, 16, 16)`.
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

typedef _Data = ({FAlertCustomStyle style});

class _InheritedData extends InheritedWidget {
  final _Data data;

  const _InheritedData({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _InheritedData old) => data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', data.style));
  }
}

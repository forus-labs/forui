import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A [FBottomNavigationBar] item.
class FBottomNavigationBarItem extends StatelessWidget {
  /// The style.
  final FBottomNavigationBarItemStyle? style;

  /// The icon.
  ///
  /// [icon] is wrapped in [FIconStyle], and therefore works with [FIcon]s.
  final Widget icon;

  /// The label.
  final Widget label;

  /// Creates a [FBottomNavigationBarItem].
  const FBottomNavigationBarItem({
    required this.label,
    required this.icon,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = FBottomNavigationBarData.of(context);
    final FBottomNavigationBarData(:itemStyle, :selected) = data;
    final style = this.style ?? itemStyle;

    return Padding(
      padding: style.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(
            child: FInheritedIconStyle(
              style: FIconStyle(
                color: data.selected ? data.itemStyle.activeIconColor : data.itemStyle.inactiveIconColor,
                size: data.itemStyle.iconSize,
              ),
              child: icon,
            ),
          ),
          const SizedBox(height: 2),
          DefaultTextStyle.merge(
            style: selected ? style.activeTextStyle : style.inactiveTextStyle,
            overflow: TextOverflow.ellipsis,
            child: label,
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// [FBottomNavigationBarItem]'s style.
final class FBottomNavigationBarItemStyle with Diagnosticable {
  /// The icon's size. Defaults to `28`.
  final double iconSize;

  /// The icon's color when this item is active.
  final Color activeIconColor;

  /// The icon's color when this item is inactive.
  final Color inactiveIconColor;

  /// The text's style when this item is active.
  final TextStyle activeTextStyle;

  /// The text's style when this item is inactive.
  final TextStyle inactiveTextStyle;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  final EdgeInsets padding;

  /// Creates a [FBottomNavigationBarItemStyle].
  FBottomNavigationBarItemStyle({
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
    this.iconSize = 28,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties from the given [FStateColorScheme] and [FTypography].
  FBottomNavigationBarItemStyle.inherit({required FStateColorScheme colorScheme, required FTypography typography})
      : iconSize = 24,
        activeIconColor = colorScheme.primary,
        inactiveIconColor = colorScheme.foreground.withOpacity(0.5),
        activeTextStyle = typography.base.copyWith(
          color: colorScheme.primary,
          fontSize: 10,
        ),
        inactiveTextStyle = typography.base.copyWith(
          color: colorScheme.foreground.withOpacity(0.5),
          fontSize: 10,
        ),
        padding = const EdgeInsets.all(5);

  /// Returns a copy of this [FBottomNavigationBarItemStyle] with the given properties replaced.
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    double? iconSize,
    Color? activeIconColor,
    Color? inactiveIconColor,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    EdgeInsets? padding,
  }) =>
      FBottomNavigationBarItemStyle(
        iconSize: iconSize ?? this.iconSize,
        activeIconColor: activeIconColor ?? this.activeIconColor,
        inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
        activeTextStyle: activeTextStyle ?? this.activeTextStyle,
        inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(ColorProperty('activeIconColor', activeIconColor))
      ..add(ColorProperty('inactiveIconColor', inactiveIconColor))
      ..add(DiagnosticsProperty('activeTextStyle', activeTextStyle))
      ..add(DiagnosticsProperty('inactiveTextStyle', inactiveTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBottomNavigationBarItemStyle &&
          runtimeType == other.runtimeType &&
          iconSize == other.iconSize &&
          activeIconColor == other.activeIconColor &&
          inactiveIconColor == other.inactiveIconColor &&
          activeTextStyle == other.activeTextStyle &&
          inactiveTextStyle == other.inactiveTextStyle &&
          padding == other.padding;

  @override
  int get hashCode =>
      iconSize.hashCode ^
      activeIconColor.hashCode ^
      inactiveIconColor.hashCode ^
      activeTextStyle.hashCode ^
      inactiveTextStyle.hashCode ^
      padding.hashCode;
}

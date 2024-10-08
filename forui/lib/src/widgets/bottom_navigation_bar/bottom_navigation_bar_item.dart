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
            child: FIconStyleData(
              style: FIconStyle(
                color: data.selected ? style.activeIconColor : style.inactiveIconColor,
                size: style.iconSize,
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
  /// The icon's color when this item is active.
  final Color activeIconColor;

  /// The icon's color when this item is inactive.
  final Color inactiveIconColor;

  /// The icon's size. Defaults to `24`.
  final double iconSize;

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
    this.iconSize = 24,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties from the given [FColorScheme] and
  /// [FTypography].
  FBottomNavigationBarItemStyle.inherit({required FColorScheme colorScheme, required FTypography typography}):
      this(
        activeIconColor: colorScheme.primary,
        inactiveIconColor: colorScheme.disable(colorScheme.foreground),
        activeTextStyle: typography.base.copyWith(
          color: colorScheme.primary,
          fontSize: 10,
        ),
        inactiveTextStyle: typography.base.copyWith(
          color: colorScheme.disable(colorScheme.foreground),
          fontSize: 10,
        ),
      );

  /// Returns a copy of this [FBottomNavigationBarItemStyle] with the given properties replaced.
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    Color? activeIconColor,
    Color? inactiveIconColor,
    double? iconSize,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
    EdgeInsets? padding,
  }) =>
      FBottomNavigationBarItemStyle(
        activeIconColor: activeIconColor ?? this.activeIconColor,
        inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
        iconSize: iconSize ?? this.iconSize,
        activeTextStyle: activeTextStyle ?? this.activeTextStyle,
        inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
        padding: padding ?? this.padding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('activeIconColor', activeIconColor))
      ..add(ColorProperty('inactiveIconColor', inactiveIconColor))
      ..add(DoubleProperty('iconSize', iconSize))
      ..add(DiagnosticsProperty('activeTextStyle', activeTextStyle))
      ..add(DiagnosticsProperty('inactiveTextStyle', inactiveTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FBottomNavigationBarItemStyle &&
          runtimeType == other.runtimeType &&
          activeIconColor == other.activeIconColor &&
          inactiveIconColor == other.inactiveIconColor &&
          iconSize == other.iconSize &&
          activeTextStyle == other.activeTextStyle &&
          inactiveTextStyle == other.inactiveTextStyle &&
          padding == other.padding;

  @override
  int get hashCode =>
      activeIconColor.hashCode ^
      inactiveIconColor.hashCode ^
      iconSize.hashCode ^
      activeTextStyle.hashCode ^
      inactiveTextStyle.hashCode ^
      padding.hashCode;
}

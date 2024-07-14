part of 'bottom_navigation_bar.dart';

class _FBottomNavigationBarWidget extends StatelessWidget {
  final FBottomNavigationBarItem item;

  final bool active;

  const _FBottomNavigationBarWidget({
    required this.item,
    required this.active,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = item.style!; // TODO: fix.

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          item.icon(
            height: style.iconSize,
            colorFilter: ColorFilter.mode(
              active ? style.activeIconColor : style.inactiveIconColor,
              BlendMode.srcIn,
            ),
          ),
          Text(
            item.label,
            style: active ? style.activeTextStyle : style.inactiveTextStyle,
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('item', item))
      ..add(FlagProperty('active', value: active, ifTrue: 'active'));
  }
}

/// A [FBottomNavigationBar] item.
class FBottomNavigationBarItem {
  /// The style.
  final FBottomNavigationBarItemStyle? style;

  /// The icon.
  final SvgAsset icon;

  /// The label.
  final String label;

  /// Creates a [FBottomNavigationBarItem].
  const FBottomNavigationBarItem({
    required this.icon,
    required this.label,
    this.style,
  });
}

/// [FBottomNavigationBarItem]'s style.
class FBottomNavigationBarItemStyle with Diagnosticable {
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

  /// Creates a [FBottomNavigationBarItemStyle].
  FBottomNavigationBarItemStyle({
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.iconSize,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FBottomNavigationBarItemStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
      : activeIconColor = colorScheme.primary,
        inactiveIconColor = colorScheme.foreground.withOpacity(0.5),
        iconSize = 24,
        activeTextStyle = typography.sm.copyWith(color: colorScheme.primary),
        inactiveTextStyle = typography.sm.copyWith(color: colorScheme.foreground.withOpacity(0.5));

  /// Returns a copy of this [FBottomNavigationBarItemStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FBottomNavigationBarItemStyle(
  ///   activeIconColor: Colors.black,
  ///   inactiveIconColor: Colors.white,
  ///   ...
  /// );
  ///
  /// final copy = style.copyWith(
  ///   inactiveIconColor: Colors.blue,
  /// );
  ///
  /// print(copy.activeIconColor); // black
  /// print(copy.inactiveIconColor); // blue
  /// ```
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    Color? activeIconColor,
    Color? inactiveIconColor,
    double? iconSize,
    TextStyle? activeTextStyle,
    TextStyle? inactiveTextStyle,
  }) =>
      FBottomNavigationBarItemStyle(
        activeIconColor: activeIconColor ?? this.activeIconColor,
        inactiveIconColor: inactiveIconColor ?? this.inactiveIconColor,
        iconSize: iconSize ?? this.iconSize,
        activeTextStyle: activeTextStyle ?? this.activeTextStyle,
        inactiveTextStyle: inactiveTextStyle ?? this.inactiveTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('activeIconColor', activeIconColor))
      ..add(ColorProperty('inactiveIconColor', inactiveIconColor))
      ..add(DiagnosticsProperty('iconSize', iconSize))
      ..add(DiagnosticsProperty('activeTextStyle', activeTextStyle))
      ..add(DiagnosticsProperty('inactiveTextStyle', inactiveTextStyle));
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
          inactiveTextStyle == other.inactiveTextStyle;

  @override
  int get hashCode =>
      activeIconColor.hashCode ^
      inactiveIconColor.hashCode ^
      iconSize.hashCode ^
      activeTextStyle.hashCode ^
      inactiveTextStyle.hashCode;
}

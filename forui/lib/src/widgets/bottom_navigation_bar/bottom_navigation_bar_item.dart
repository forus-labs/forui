part of 'bottom_navigation_bar.dart';

class _FBottomNavigationBarWidget extends StatelessWidget {
  final FBottomNavigationBarItemStyle? style;

  final FBottomNavigationBarItem item;

  final bool active;

  const _FBottomNavigationBarWidget({
    required this.item,
    required this.active,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final style = item.style ?? this.style ?? context.theme.bottomNavigationBarStyle.item;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: style.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            item.icon(
              height: style.iconSize,
              colorFilter: ColorFilter.mode(
                active ? style.activeIconColor : style.inactiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              overflow: TextOverflow.ellipsis,
              style: active ? style.activeTextStyle : style.inactiveTextStyle,
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

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FBottomNavigationBarItemStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
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
      ..add(DiagnosticsProperty('iconSize', iconSize))
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

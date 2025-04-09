import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'bottom_navigation_bar_item.style.dart';

/// A [FBottomNavigationBar] item.
class FBottomNavigationBarItem extends StatelessWidget {
  /// The style.
  final FBottomNavigationBarItemStyle? style;

  /// The icon, wrapped in a [IconTheme].
  final Widget icon;

  /// The label.
  final Widget label;

  /// Creates a [FBottomNavigationBarItem].
  const FBottomNavigationBarItem({required this.icon, required this.label, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final FBottomNavigationBarData(:itemStyle, :selected) = FBottomNavigationBarData.of(context);
    final style = this.style ?? itemStyle;

    return Padding(
      padding: style.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: style.spacing,
        children: [
          ExcludeSemantics(
            child: IconTheme(data: selected ? style.selectedIconStyle : style.unselectedIconStyle, child: icon),
          ),
          DefaultTextStyle.merge(
            style: selected ? style.selectedTextStyle : style.unselectedTextStyle,
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
final class FBottomNavigationBarItemStyle with Diagnosticable, _$FBottomNavigationBarItemStyleFunctions {
  /// The icon's style when an item is selected.
  @override
  final IconThemeData selectedIconStyle;

  /// The icon's style when an item is unselected.
  @override
  final IconThemeData unselectedIconStyle;

  /// The text style when an item is selected.
  @override
  final TextStyle selectedTextStyle;

  /// The text style when an item is unselected.
  @override
  final TextStyle unselectedTextStyle;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between the icon and the label. Defaults to `2`.
  @override
  final double spacing;

  /// Creates a [FBottomNavigationBarItemStyle].
  FBottomNavigationBarItemStyle({
    required this.selectedIconStyle,
    required this.unselectedIconStyle,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    this.padding = const EdgeInsets.all(5),
    this.spacing = 2,
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties from the given [FColors] and
  /// [FTypography].
  FBottomNavigationBarItemStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        selectedIconStyle: IconThemeData(color: colors.primary, size: 24),
        unselectedIconStyle: IconThemeData(color: colors.disable(colors.foreground), size: 24),
        selectedTextStyle: typography.base.copyWith(color: colors.primary, fontSize: 10),
        unselectedTextStyle: typography.base.copyWith(color: colors.disable(colors.foreground), fontSize: 10),
      );
}

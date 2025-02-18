import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'bottom_navigation_bar_item.style.dart';

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
  const FBottomNavigationBarItem({required this.label, required this.icon, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final FBottomNavigationBarData(:itemStyle, :selected) = FBottomNavigationBarData.of(context);
    final style = this.style ?? itemStyle;

    return Padding(
      padding: style.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [
          ExcludeSemantics(
            child: FIconStyleData(
              style: FIconStyle(
                color: selected ? style.activeIconColor : style.inactiveIconColor,
                size: style.iconSize,
              ),
              child: icon,
            ),
          ),
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
final class FBottomNavigationBarItemStyle with Diagnosticable, _$FBottomNavigationBarItemStyleFunctions {
  /// The icon's color when this item is active.
  @override
  final Color activeIconColor;

  /// The icon's color when this item is inactive.
  @override
  final Color inactiveIconColor;

  /// The icon's size. Defaults to `24`.
  @override
  final double iconSize;

  /// The text's style when this item is active.
  @override
  final TextStyle activeTextStyle;

  /// The text's style when this item is inactive.
  @override
  final TextStyle inactiveTextStyle;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  @override
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
  FBottomNavigationBarItemStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
    : this(
        activeIconColor: colorScheme.primary,
        inactiveIconColor: colorScheme.disable(colorScheme.foreground),
        activeTextStyle: typography.base.copyWith(color: colorScheme.primary, fontSize: 10),
        inactiveTextStyle: typography.base.copyWith(color: colorScheme.disable(colorScheme.foreground), fontSize: 10),
      );
}

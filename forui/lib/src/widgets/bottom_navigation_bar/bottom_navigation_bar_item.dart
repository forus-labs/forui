import 'package:collection/collection.dart';
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
    final FBottomNavigationBarData(:itemStyle, :states) = FBottomNavigationBarData.of(context);
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
                color: style.iconColor.resolve(states),
                size: style.iconSize,
              ),
              child: icon,
            ),
          ),
          DefaultTextStyle.merge(
            style: style.textStyle.resolve(states),
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
  /// The icon's color.
  ///
  /// {@macro forui.foundation.FTappable.builder}
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<Color> iconColor;

  /// The icon's size. Defaults to `24`.
  @override
  final double iconSize;

  /// The text's style.
  ///
  /// {@macro forui.foundation.FTappable.builder}
  /// * [WidgetState.selected]
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// Creates a [FBottomNavigationBarItemStyle].
  FBottomNavigationBarItemStyle({
    required this.iconColor,
    required this.textStyle,
    this.iconSize = 24,
    this.padding = const EdgeInsets.all(5),
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties from the given [FColorScheme] and
  /// [FTypography].
  FBottomNavigationBarItemStyle.inherit({required FColorScheme colorScheme, required FTypography typography})
    : this(
        iconColor: FWidgetStateMap({
          WidgetState.selected: colorScheme.primary,
          WidgetState.any: colorScheme.disable(colorScheme.foreground),
        }),
        textStyle: FWidgetStateMap({
          WidgetState.selected: typography.base.copyWith(color: colorScheme.primary, fontSize: 10),
          WidgetState.any: typography.base.copyWith(color: colorScheme.disable(colorScheme.foreground), fontSize: 10),
        }),
      );
}

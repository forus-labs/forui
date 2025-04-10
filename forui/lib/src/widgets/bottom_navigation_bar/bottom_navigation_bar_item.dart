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
    final FBottomNavigationBarData(:itemStyle, :states) = FBottomNavigationBarData.of(context);
    final style = this.style ?? itemStyle;

    return Padding(
      padding: style.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: style.spacing,
        children: [
          ExcludeSemantics(child: IconTheme(data: style.iconStyle.resolve(states), child: icon)),
          DefaultTextStyle.merge(style: style.textStyle.resolve(states), overflow: TextOverflow.ellipsis, child: label),
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
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The padding. Defaults to `EdgeInsets.all(5)`.
  @override
  final EdgeInsetsGeometry padding;

  /// The spacing between the icon and the label. Defaults to `2`.
  @override
  final double spacing;

  /// Creates a [FBottomNavigationBarItemStyle].
  FBottomNavigationBarItemStyle({
    required this.iconStyle,
    required this.textStyle,
    this.padding = const EdgeInsets.all(5),
    this.spacing = 2,
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties.
  FBottomNavigationBarItemStyle.inherit({required FColors colors, required FTypography typography})
    : this(
        iconStyle: FWidgetStateMap({
          WidgetState.selected: IconThemeData(color: colors.primary, size: 24),
          WidgetState.any: IconThemeData(color: colors.disable(colors.foreground), size: 24),
        }),
        textStyle: FWidgetStateMap({
          WidgetState.selected: typography.base.copyWith(color: colors.primary, fontSize: 10),
          WidgetState.any: typography.base.copyWith(color: colors.disable(colors.foreground), fontSize: 10),
        }),
      );
}

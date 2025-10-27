import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'bottom_navigation_bar_item.design.dart';

/// A [FBottomNavigationBar] item.
class FBottomNavigationBarItem extends StatelessWidget {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create bottom-navigation-bar-item
  /// ```
  final FBottomNavigationBarItemStyle Function(FBottomNavigationBarItemStyle style)? style;

  /// The icon, wrapped in a [IconTheme].
  final Widget icon;

  /// The label.
  final Widget? label;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

  /// {@macro forui.foundation.FTappable.onHoverChange}
  final ValueChanged<bool>? onHoverChange;

  /// {@macro forui.foundation.FTappable.onStateChange}
  final ValueChanged<FWidgetStatesDelta>? onStateChange;

  /// Creates a [FBottomNavigationBarItem].
  const FBottomNavigationBarItem({
    required this.icon,
    this.label,
    this.style,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FBottomNavigationBarData(:itemStyle, :selected, :index, :onChange) = FBottomNavigationBarData.of(context);
    final style = this.style?.call(itemStyle) ?? itemStyle;

    return FTappable(
      style: style.tappableStyle,
      focusedOutlineStyle: style.focusedOutlineStyle,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onStateChange: onStateChange,
      behavior: HitTestBehavior.opaque,
      selected: selected,
      onPress: () => onChange?.call(index),
      builder: (_, states, _) => Padding(
        padding: style.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: style.spacing,
          children: [
            ExcludeSemantics(
              child: IconTheme(data: style.iconStyle.resolve(states), child: icon),
            ),
            if (label case final label?)
              DefaultTextStyle.merge(
                style: style.textStyle.resolve(states),
                overflow: TextOverflow.ellipsis,
                child: label,
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
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(ObjectFlagProperty.has('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange));
  }
}

/// [FBottomNavigationBarItem]'s style.
class FBottomNavigationBarItemStyle with Diagnosticable, _$FBottomNavigationBarItemStyleFunctions {
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

  /// The spacing between the icon and the label. Defaults to 2.
  @override
  final double spacing;

  /// The item's tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The item's focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FBottomNavigationBarItemStyle].
  FBottomNavigationBarItemStyle({
    required this.iconStyle,
    required this.textStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.padding = const EdgeInsets.all(5),
    this.spacing = 2,
  });

  /// Creates a [FBottomNavigationBarItemStyle] that inherits its properties.
  FBottomNavigationBarItemStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) : this(
         iconStyle: FWidgetStateMap({
           WidgetState.selected: IconThemeData(color: colors.primary, size: 24),
           WidgetState.any: IconThemeData(color: colors.disable(colors.foreground), size: 24),
         }),
         textStyle: FWidgetStateMap({
           WidgetState.selected: typography.base.copyWith(color: colors.primary, fontSize: 10),
           WidgetState.any: typography.base.copyWith(color: colors.disable(colors.foreground), fontSize: 10),
         }),
         tappableStyle: style.tappableStyle,
         focusedOutlineStyle: style.focusedOutlineStyle,
       );
}

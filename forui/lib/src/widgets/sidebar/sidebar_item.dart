import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'sidebar_item.style.dart';

/// A sidebar item.
///
/// The [FSidebarItem] widget is useful for creating interactive items in a sidebar.
/// It can display an icon, label, and optional action, with support for selected and
/// enabled states.
///
/// See:
/// * https://forui.dev/docs/layout/sidebar for working examples.
/// * [FSidebarItemStyle] for customizing a sidebar item's appearance.
class FSidebarItem extends StatelessWidget {
  /// The sidebar item's style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create sidebar
  /// ```
  final FSidebarItemStyle? style;

  /// The icon to display before the label.
  final Widget? icon;

  /// The main content of the item.
  final Widget? label;

  /// An optional action widget to display after the label.
  final Widget? action;

  /// Whether this item is currently selected.
  final bool selected;

  /// Whether this item is enabled.
  final bool enabled;

  /// Called when the item is pressed.
  final VoidCallback? onPress;

  /// Called when the item is long pressed.
  final VoidCallback? onLongPress;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when the state changes.
  final ValueChanged<Set<WidgetState>>? onStateChange;

  /// Creates a [FSidebarItem].
  const FSidebarItem({
    this.style,
    this.icon,
    this.label,
    this.action,
    this.selected = false,
    this.enabled = true,
    this.onPress,
    this.onLongPress,
    this.onHoverChange,
    this.onStateChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.sidebarStyle.itemStyle;

    return FTappable(
      style: style.tappableStyle,
      focusedOutlineStyle: style.focusedOutlineStyle,
      selected: selected,
      onPress: enabled ? onPress : null,
      onLongPress: enabled ? onLongPress : null,
      onHoverChange: onHoverChange,
      onStateChange: onStateChange,
      builder:
          (_, states, child) => Container(
            padding: style.padding,
            decoration: BoxDecoration(color: style.backgroundColor.resolve(states), borderRadius: style.borderRadius),
            child: Row(
              spacing: style.actionSpacing,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: style.iconSpacing,
                    children: [
                      if (icon != null) IconTheme(data: style.iconStyle.resolve(states), child: icon!),
                      if (label != null)
                        Expanded(child: DefaultTextStyle.merge(style: style.textStyle.resolve(states), child: label!)),
                    ],
                  ),
                ),
                if (action != null) IconTheme(data: style.actionStyle.resolve(states), child: action!),
              ],
            ),
          ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// The style for a [FSidebarItem].
class FSidebarItemStyle with Diagnosticable, _$FSidebarItemStyleFunctions {
  /// The text style for the label.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The spacing between the icon and label.
  @override
  final double iconSpacing;

  /// The style for the icon.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

  /// The spacing between the label and action.
  @override
  final double actionSpacing;

  /// The style for the action widget.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> actionStyle;

  /// The background color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<Color> backgroundColor;

  /// The padding around the content.
  @override
  final EdgeInsetsGeometry padding;

  /// The border radius of the item.
  @override
  final BorderRadius borderRadius;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FSidebarItemStyle].
  const FSidebarItemStyle({
    required this.textStyle,
    required this.iconStyle,
    required this.actionStyle,
    required this.backgroundColor,
    required this.borderRadius,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.iconSpacing = 8,
    this.actionSpacing = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  });

  /// Creates a [FSidebarItemStyle] that inherits its properties.
  FSidebarItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        textStyle: FWidgetStateMap.all(typography.base.copyWith(
          color: colors.foreground,
          height: 1,
          overflow: TextOverflow.ellipsis,
        )),
        iconStyle: FWidgetStateMap.all(IconThemeData(color: colors.foreground, size: 16)),
        actionStyle: FWidgetStateMap.all(IconThemeData(color: colors.foreground, size: 16)),
        backgroundColor: FWidgetStateMap({
          WidgetState.selected | WidgetState.hovered | WidgetState.pressed: colors.primary.withValues(alpha: 0.03),
          WidgetState.any: Colors.transparent,
        }),
        borderRadius: style.borderRadius,
        tappableStyle: style.tappableStyle.copyWith(
          animationTween: FTappableAnimations.none,
          pressedEnterDuration: Duration.zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

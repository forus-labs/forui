import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'sidebar_item.style.dart';

/// A sidebar item that can display an icon, label, and optional action.
class FSidebarItem extends StatelessWidget {
  /// The icon to display before the label.
  final Widget? icon;

  /// The main content of the item.
  final Widget? label;

  /// An optional action widget to display after the label.
  final Widget? action;

  /// Whether this item is currently active.
  final bool active;

  /// Whether this item is disabled.
  final bool disabled;

  /// The style to use for this item.
  final FSidebarItemStyle? style;

  /// Called when the hover state changes.
  final ValueChanged<bool>? onHoverChange;

  /// Called when the state changes.
  final ValueChanged<Set<WidgetState>>? onStateChange;

  /// Creates a [FSidebarItem].
  const FSidebarItem({
    this.icon,
    this.label,
    this.action,
    this.active = false,
    this.disabled = false,
    this.style,
    this.onHoverChange,
    this.onStateChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? FTheme.of(context).sidebarStyle.itemStyle;

    return FTappable(
      style: style.tappableStyle,
      focusedOutlineStyle: style.focusedOutlineStyle,
      selected: active,
      onHoverChange: onHoverChange,
      onStateChange: onStateChange,
      builder:
          (_, states, child) => Container(
            padding: style.padding,
            decoration: BoxDecoration(color: style.backgroundColor.resolve(states), borderRadius: style.borderRadius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (icon != null) IconTheme(data: style.iconStyle.resolve(states), child: icon!),
                    if (label != null)
                      Expanded(child: DefaultTextStyle.merge(style: style.textStyle.resolve(states), child: label!)),
                  ],
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
      ..add(FlagProperty('active', value: active, ifTrue: 'active'))
      ..add(FlagProperty('disabled', value: disabled, ifTrue: 'disabled'))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onStateChange', onStateChange));
  }
}

/// The style for a [FSidebarItem].
class FSidebarItemStyle with Diagnosticable, _$FSidebarItemStyleFunctions {
  /// The text style for the label.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<TextStyle> textStyle;

  /// The style for the icon.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<IconThemeData> iconStyle;

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
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius = BorderRadius.zero,
  });

  /// Creates a [FSidebarItemStyle] that inherits its properties.
  FSidebarItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        textStyle: FWidgetStateMap({
          WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): typography.base.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
          WidgetState.selected: typography.base.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
          WidgetState.disabled: typography.base.copyWith(color: colors.muted, fontWeight: FontWeight.w500),
          WidgetState.hovered | WidgetState.pressed: typography.base.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w500,
          ),
          // Default state
          WidgetState.any: typography.base.copyWith(color: colors.foreground, fontWeight: FontWeight.w500),
        }),
        iconStyle: FWidgetStateMap({
          WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): IconThemeData(
            color: colors.primary,
            size: 20,
          ),
          WidgetState.selected: IconThemeData(color: colors.primary, size: 20),
          WidgetState.disabled: IconThemeData(color: colors.muted, size: 20),
          WidgetState.hovered | WidgetState.pressed: IconThemeData(color: colors.primary, size: 20),
          WidgetState.any: IconThemeData(color: colors.foreground, size: 20),
        }),
        actionStyle: FWidgetStateMap({
          WidgetState.selected & (WidgetState.hovered | WidgetState.pressed): IconThemeData(
            color: colors.primary,
            size: 16,
          ),
          WidgetState.selected: IconThemeData(color: colors.primary, size: 16),
          WidgetState.disabled: IconThemeData(color: colors.muted, size: 16),
          WidgetState.hovered | WidgetState.pressed: IconThemeData(color: colors.primary, size: 16),
          WidgetState.any: IconThemeData(color: colors.foreground, size: 16),
        }),
        backgroundColor: FWidgetStateMap({
          WidgetState.selected: colors.primary.withValues(alpha: 0.1),
          WidgetState.hovered | WidgetState.pressed: colors.primary.withValues(alpha: 0.05),
          WidgetState.any: Colors.transparent,
        }),
        tappableStyle: style.tappableStyle,
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

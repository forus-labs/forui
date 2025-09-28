import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/item/item_content.dart';
import 'package:forui/src/widgets/item/raw_item_content.dart';

part 'item.design.dart';

/// A marker interface which denotes that mixed-in widgets is an item.
mixin FItemMixin on Widget {}

/// An item that is typically used to group related information together.
///
/// ## Using [FItem] in a [FPopover] when wrapped in a [FItemGroup]
/// When a [FPopover] is used inside an [FItemGroup], items inside the popover will inherit styling from the parent group.
/// This happens because [FPopover]'s content shares the same `BuildContext` as its child, causing data inheritance
/// that may lead to unexpected rendering issues.
///
/// To prevent this styling inheritance, wrap the popover in a [FInheritedItemData] with null data to reset the
/// inherited data:
/// ```dart
/// FItemGroup(
///   children: [
///     FItem(title: Text('Item with popover')),
///     FPopoverWrapperItem(
///       popoverBuilder: (_, _) => FInheritedItemData(
///         child: FItemGroup(
///           children: [
///             FItem(title: Text('Popover Item 1')),
///             FItem(title: Text('Popover Item 2')),
///           ],
///         ),
///       ),
///       child: FButton(child: Text('Open Popover')),
///     ),
///   ],
/// );
/// ```
///
/// See:
/// * https://forui.dev/docs/data/item for working examples.
/// * [FTile] for a specialized item for touch devices.
/// * [FItemStyle] for customizing an item's appearance.
class FItem extends StatelessWidget with FItemMixin {
  /// The item's style. Defaults to [FItemData.style] if present.
  ///
  /// Provide a style to prevent inheritance from [FInheritedItemData].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create item
  /// ```
  final FItemStyle Function(FItemStyle style)? style;

  /// Whether the item is enabled. Defaults to true.
  final bool? enabled;

  /// True if this item is currently selected. Defaults to false.
  final bool selected;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

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

  /// A callback for when the item is pressed.
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onPress;

  /// A callback for when the item is long pressed.
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onLongPress;

  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onSecondaryPress;

  /// A callback for when the widget is pressed with a secondary button (usually right-click on desktop).
  ///
  /// The item is not interactable if the following are all null:
  /// * [onPress]
  /// * [onLongPress]
  /// * [onSecondaryPress]
  /// * [onSecondaryLongPress]
  final VoidCallback? onSecondaryLongPress;

  /// {@macro forui.foundation.FTappable.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// {@macro forui.foundation.FTappable.actions}
  final Map<Type, Action<Intent>>? actions;

  final Widget Function(
    BuildContext context,
    FItemStyle style,
    double top,
    double bottom,
    Set<WidgetState> states,
    FWidgetStateMap<Color>? color,
    double? width,
    FItemDivider divider,
  )
  _builder;

  /// Creates a [FItem].
  ///
  /// Assuming LTR locale:
  /// ```diagram
  /// -----------------------------------------------------
  /// | [prefix] [title]       [details] [suffix]         |
  /// |          [subtitle]                               |
  /// -----------------------------------------------------
  /// ```
  ///
  /// The order is reversed for RTL locales.
  ///
  /// ## Overflow behavior
  /// [FItem] has custom layout behavior to handle overflow of its content. If [details] is text, it is truncated,
  /// else [title] and [subtitle] are truncated.
  ///
  /// ## Why isn't my [title] [subtitle], or [details] rendered?
  /// Using widgets that try to fill the available space, such as [Expanded] or [FTextField], as [details] will cause
  /// the [title] and [subtitle] to never be rendered.
  ///
  /// Use [FItem.raw] in these cases.
  FItem({
    required Widget title,
    this.style,
    this.enabled,
    this.selected = false,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.onPress,
    this.onLongPress,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.shortcuts,
    this.actions,
    Widget? prefix,
    Widget? subtitle,
    Widget? details,
    Widget? suffix,
    super.key,
  }) : _builder = ((context, style, top, bottom, states, color, width, divider) => ItemContent(
         style: style.contentStyle,
         margin: style.margin,
         top: top,
         bottom: bottom,
         states: states,
         dividerColor: color,
         dividerWidth: width,
         dividerType: divider,
         prefix: prefix,
         title: title,
         subtitle: subtitle,
         details: details,
         suffix: suffix,
       ));

  /// Creates a [FItem] without custom layout behavior.
  ///
  /// Assuming LTR locale:
  /// ```diagram
  /// ----------------------------------------
  /// | [prefix] [child]                     |
  /// ----------------------------------------
  /// ```
  ///
  /// The order is reversed for RTL locales.
  FItem.raw({
    required Widget child,
    this.style,
    this.enabled,
    this.selected = false,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onStateChange,
    this.onPress,
    this.onLongPress,
    this.onSecondaryPress,
    this.onSecondaryLongPress,
    this.shortcuts,
    this.actions,
    Widget? prefix,
    super.key,
  }) : _builder = ((context, style, top, bottom, states, color, width, divider) => RawItemContent(
         style: style.rawItemContentStyle,
         margin: style.margin,
         top: top,
         bottom: bottom,
         states: states,
         dividerColor: color,
         dividerWidth: width,
         dividerType: divider,
         prefix: prefix,
         child: child,
       ));

  @override
  Widget build(BuildContext context) {
    final data = FInheritedItemData.maybeOf(context) ?? const FItemData();
    final inheritedStyle = data.style ?? context.theme.itemStyle;

    final style = this.style?.call(inheritedStyle) ?? inheritedStyle;
    final enabled = this.enabled ?? data.enabled;
    final states = {if (!enabled) WidgetState.disabled};
    final divider = data.divider;

    // We increase the bottom margin to draw the divider.
    final top = data.index == 0 ? data.spacing : 0.0;
    final bottom = data.last ? data.spacing : 0.0;

    var margin = style.margin.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);
    margin = margin.copyWith(
      top: margin.top + top,
      bottom: margin.bottom + bottom + (divider == FItemDivider.none ? 0 : data.dividerWidth),
    );

    if (onPress == null && onLongPress == null && onSecondaryPress == null && onSecondaryLongPress == null) {
      return ColoredBox(
        color: style.backgroundColor.resolve(states) ?? Colors.transparent,
        child: Padding(
          padding: margin,
          child: DecoratedBox(
            decoration: style.decoration.resolve(states) ?? const BoxDecoration(),
            child: _builder(context, style, top, bottom, states, data.dividerColor, data.dividerWidth, divider),
          ),
        ),
      );
    }

    return ColoredBox(
      color: style.backgroundColor.resolve(states) ?? Colors.transparent,
      child: Padding(
        padding: margin,
        child: FTappable(
          style: style.tappableStyle,
          semanticsLabel: semanticsLabel,
          autofocus: autofocus,
          focusNode: focusNode,
          onFocusChange: onFocusChange,
          onHoverChange: onHoverChange,
          onStateChange: onStateChange,
          selected: selected,
          onPress: enabled ? (onPress ?? () {}) : null,
          onLongPress: enabled ? (onLongPress ?? () {}) : null,
          onSecondaryPress: enabled ? (onSecondaryPress ?? () {}) : null,
          onSecondaryLongPress: enabled ? (onSecondaryLongPress ?? () {}) : null,
          shortcuts: shortcuts,
          actions: actions,
          builder: (context, states, _) => DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: switch (style.focusedOutlineStyle) {
              final outline? when states.contains(WidgetState.focused) => BoxDecoration(
                border: Border.all(color: outline.color, width: outline.width),
                borderRadius: outline.borderRadius,
              ),
              _ => const BoxDecoration(),
            },
            child: DecoratedBox(
              decoration: style.decoration.maybeResolve(states) ?? const BoxDecoration(),
              child: _builder(context, style, top, bottom, states, data.dividerColor, data.dividerWidth, divider),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('selected', value: selected, ifTrue: 'selected'))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onChange', onStateChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions));
  }
}

/// A [FItem]'s style.
class FItemStyle with Diagnosticable, _$FItemStyleFunctions {
  /// The item's background color.
  ///
  /// It is applied to the entire item, including [margin]. Since it is applied before [decoration] in the z-layer,
  /// it is not visible if [decoration] has a background color.
  ///
  /// This is useful for setting a background color when [margin] is not zero.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  @override
  final FWidgetStateMap<Color?> backgroundColor;

  /// The margin around the item, including the [decoration].
  ///
  /// Defaults to `const EdgeInsets.symmetric(vertical: 2, horizontal: 4)`.
  @override
  final EdgeInsetsGeometry margin;

  /// The item's decoration.
  ///
  /// An [FItem] is considered tappable if [FItem.onPress] or [FItem.onLongPress] is not null.
  ///
  /// The supported states if the item is tappable:
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  /// * [WidgetState.disabled]
  ///
  /// The supported states if the item is untappable:
  /// * [WidgetState.disabled]
  @override
  final FWidgetStateMap<BoxDecoration?> decoration;

  /// The default item content's style.
  @override
  final FItemContentStyle contentStyle;

  /// THe default raw item content's style.
  @override
  final FRawItemContentStyle rawItemContentStyle;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle? focusedOutlineStyle;

  /// Creates a [FItemStyle].
  FItemStyle({
    required this.backgroundColor,
    required this.decoration,
    required this.contentStyle,
    required this.rawItemContentStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
    this.margin = const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  FItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        backgroundColor: FWidgetStateMap({
          WidgetState.disabled: colors.disable(colors.secondary),
          WidgetState.any: colors.background,
        }),
        decoration: FWidgetStateMap({
          WidgetState.disabled: BoxDecoration(
            color: colors.disable(colors.secondary),
            borderRadius: style.borderRadius,
          ),
          WidgetState.hovered | WidgetState.pressed: BoxDecoration(
            color: colors.secondary,
            borderRadius: style.borderRadius,
          ),
          WidgetState.any: BoxDecoration(color: colors.background, borderRadius: style.borderRadius),
        }),
        contentStyle: FItemContentStyle.inherit(colors: colors, typography: typography),
        rawItemContentStyle: FRawItemContentStyle.inherit(colors: colors, typography: typography),
        tappableStyle: style.tappableStyle.copyWith(
          motion: FTappableMotion.none,
          pressedEnterDuration: Duration.zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

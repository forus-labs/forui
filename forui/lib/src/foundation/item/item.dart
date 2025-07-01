import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:forui/src/foundation/item/item_content.dart';
import 'package:forui/src/foundation/item/raw_item_content.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'item.style.dart';

/// A marker interface which denotes that mixed-in widgets is an item.
mixin FItemMixin on Widget {}

/// An item that is typically used to group related information together.
///
/// See:
/// * https://forui.dev/docs/data/item for working examples.
/// * [FTile] for a specialized item for touch devices.
/// * [FItemStyle] for customizing an item's appearance.
class FItem extends StatelessWidget with FItemMixin {
  /// The item's style. Defaults to [FItemContainerItemData.style] if present.
  ///
  /// Provide a style to prevent inheritance from [FItemContainerItemData].
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create item
  /// ```
  final FItemStyle Function(FItemStyle)? style;

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
  final ValueChanged<Set<WidgetState>>? onStateChange;

  /// A callback for when the item is pressed.
  ///
  /// The item is not hoverable if both [onPress] and [onLongPress] are null.
  final VoidCallback? onPress;

  /// A callback for when the item is long pressed.
  ///
  /// The item is not hoverable if both [onPress] and [onLongPress] are null.
  final VoidCallback? onLongPress;

  final Widget Function(BuildContext, FItemStyle, Set<WidgetState>, FWidgetStateMap<Color>?, double?, FItemDivider)
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
    Widget? prefix,
    Widget? subtitle,
    Widget? details,
    Widget? suffix,
    super.key,
  }) : _builder = ((context, style, states, color, width, divider) => ItemContent(
         style: style.contentStyle,
         dividerColor: color,
         dividerWidth: width,
         dividerType: divider,
         margin: style.margin,
         states: states,
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
    Widget? prefix,
    super.key,
  }) : _builder = ((context, style, states, color, width, divider) => RawItemContent(
         style: style.rawItemContentStyle,
         dividerColor: color,
         dividerWidth: width,
         dividerType: divider,
         margin: style.margin,
         states: states,
         prefix: prefix,
         child: child,
       ));

  @override
  Widget build(BuildContext context) {
    final container = FItemContainerData.of(context);
    final item = FItemContainerItemData.of(context);

    final style = this.style?.call(item.style) ?? item.style;
    final enabled = this.enabled ?? container.enabled;
    final states = {if (!enabled) WidgetState.disabled};
    final divider = switch (container.index) {
      final i when i < container.length - 1 && item.last => container.divider,
      final i when i == container.length - 1 && item.last => FItemDivider.none,
      _ => item.divider,
    };

    // We increase the bottom margin to draw the divider.
    var margin = style.margin.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr);
    if (divider != FItemDivider.none) {
      final width = container.dividerWidth ?? 0;
      margin = margin.copyWith(bottom: margin.bottom + width);
    }

    if (onPress == null && onLongPress == null) {
      return ColoredBox(
        color: style.backgroundColor.resolve(states) ?? Colors.transparent,
        child: Padding(
          padding: margin,
          child: DecoratedBox(
            decoration: style.decoration.resolve(states) ?? const BoxDecoration(),
            child: _builder(context, style, states, container.dividerColor, container.dividerWidth, divider),
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
          builder: (context, states, _) => Stack(
            children: [
              DecoratedBox(
                decoration: style.decoration.maybeResolve(states) ?? const BoxDecoration(),
                child: _builder(context, style, states, container.dividerColor, container.dividerWidth, divider),
              ),
              if (style.focusedOutlineStyle case final outline? when states.contains(WidgetState.focused))
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: outline.color, width: outline.width),
                      borderRadius: outline.borderRadius,
                    ),
                  ),
                ),
            ],
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
      ..add(StringProperty('semanticsLabel', semanticsLabel, defaultValue: null, quoted: false))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty.has('onHoverChange', onHoverChange))
      ..add(ObjectFlagProperty.has('onChange', onStateChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
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

  /// The margin around the item, including the [decoration]. Defaults to `EdgeInsets.zero`.
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
    this.margin = EdgeInsets.zero,
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
          bounceTween: FTappableStyle.noBounceTween,
          pressedEnterDuration: Duration.zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/item/item_content.dart';

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

  final Widget Function(BuildContext, FItemStyle, Set<WidgetState>, FWidgetStateMap<FDividerStyle>?, FItemDivider)
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
  /// ## Why isn't my [title] or [subtitle] rendered?
  /// Using widgets that try to fill the available space, such as [Expanded] or [FTextField], as [details] will cause
  /// the [title] and [subtitle] to never be rendered.
  ///
  /// It is recommended to use [FItem.raw] in these cases.
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
  }) : _builder = ((context, style, states, dividerStyle, divider) => FItemContent(
         style: style.contentStyle,
         dividerStyle: dividerStyle,
         dividerType: divider,
         states: states,
         title: title,
         prefix: prefix,
         subtitle: subtitle,
         details: details,
         suffix: suffix,
       ));

  @override
  Widget build(BuildContext context) {
    final container = FItemContainerData.of(context);
    final item = FItemContainerItemData.of(context);

    final style = this.style?.call(item.style) ?? item.style;
    final enabled = this.enabled ?? container.enabled;
    final divider = switch (container.index) {
      final i when i < container.length - 1 && item.last => container.divider,
      final i when i == container.length - 1 && item.last => FItemDivider.none,
      _ => item.divider,
    };


    if (onPress == null && onLongPress == null) {
      final states = {if (!enabled) WidgetState.disabled};
      return DecoratedBox(
        decoration: style.decoration.resolve(states),
        child: _builder(context, style, states, container.dividerStyle, divider),
      );
    }

    return FTappable(
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
            decoration: style.decoration.resolve(states),
            child: _builder(context, style, states, container.dividerStyle, divider),
          ),
          if (states.contains(WidgetState.focused))
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: style.focusedOutlineStyle.color, width: style.focusedOutlineStyle.width),
                  borderRadius: style.focusedOutlineStyle.borderRadius,
                ),
              ),
            ),
        ],
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
  final FWidgetStateMap<BoxDecoration> decoration;

  /// The default item content's style.
  @override
  final FItemContentStyle contentStyle;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FItemStyle].
  FItemStyle({
    required this.decoration,
    required this.contentStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  FItemStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
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
        tappableStyle: style.tappableStyle.copyWith(
          bounceTween: FTappableStyle.noBounceTween,
          pressedEnterDuration: Duration.zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

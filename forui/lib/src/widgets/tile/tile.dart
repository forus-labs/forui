import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tile.design.dart';

/// A marker interface which denotes that mixed-in widgets can be used in a [FTileGroup].
mixin FTileMixin on Widget {}

/// A specialized [FItem] for touch devices.
///
/// Multiple tiles can be grouped together in a [FTileGroup]. Tiles grouped together will be separated by a divider,
/// specified by a [FItemDivider].
///
/// ## Using [FTile] in a [FPopover] when wrapped in a [FTileGroup]
/// When a [FPopover] is used inside an [FTileGroup], tiles & groups inside the popover will inherit styling from the
/// parent group. This happens because [FPopover]'s content shares the same `BuildContext` as its child, causing data
/// inheritance that may lead to unexpected rendering issues.
///
/// To prevent this styling inheritance, wrap the popover in a [FInheritedItemData] with null data to reset the
/// inherited data:
/// ```dart
/// FTileGroup(
///   children: [
///     FTile(title: Text('Tile with popover')),
///     FPopoverWrapperTile(
///       popoverBuilder: (_, _) => FInheritedItemData(
///         child: FTileGroup(
///           children: [
///             FTile(title: Text('Popover Tile 1')),
///             FTile(title: Text('Popover Tile 2')),
///           ],
///         ),
///       ),
///       child: FButton(child: Text('Open Popover')),
///     ),
///   ],
/// );
/// ```
///
///
/// See:
/// * https://forui.dev/docs/tile/tile for working examples.
/// * [FItem] for a more generic item that can be used in any context.
/// * [FTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a tile's appearance.
class FTile extends StatelessWidget with FTileMixin {
  // The fields aren't strictly needed, but we keep them to improve documentation.

  /// The tile's style. Defaults to the ancestor tile group's style if present.
  ///
  /// Provide a style to prevent inheritance from the ancestor tile group.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tile
  /// ```
  final FItemStyle Function(FItemStyle style)? style;

  /// Whether the tile is enabled. Defaults to true.
  final bool? enabled;

  /// True if this tile is currently selected. Defaults to false.
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

  /// {@macro forui.foundation.FTappable.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// {@macro forui.foundation.FTappable.actions}
  final Map<Type, Action<Intent>>? actions;

  /// A callback for when the tile is pressed.
  ///
  /// The tile is not hoverable if both [onPress] and [onLongPress] are null.
  final VoidCallback? onPress;

  /// A callback for when the tile is long pressed.
  ///
  /// The tile is not hoverable if both [onPress] and [onLongPress] are null.
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

  final Widget _child;

  /// Creates a [FTile].
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
  /// [FTile] has custom layout behavior to handle overflow of its content. If [details] is text, it is truncated,
  /// else [title] and [subtitle] are truncated.
  ///
  /// ## Why isn't my [title] [subtitle], or [details] rendered?
  /// Using widgets that try to fill the available space, such as [Expanded] or [FTextField], as [details] will cause
  /// the [title] and [subtitle] to never be rendered.
  ///
  /// Use [FTile.raw] in these cases.
  FTile({
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
  }) : _child = FItem(
         title: title,
         style: style,
         enabled: enabled,
         selected: selected,
         semanticsLabel: semanticsLabel,
         autofocus: autofocus,
         focusNode: focusNode,
         onFocusChange: onFocusChange,
         onHoverChange: onHoverChange,
         onStateChange: onStateChange,
         onPress: onPress,
         onLongPress: onLongPress,
         onSecondaryPress: onSecondaryPress,
         onSecondaryLongPress: onSecondaryLongPress,
         shortcuts: shortcuts,
         actions: actions,
         prefix: prefix,
         subtitle: subtitle,
         details: details,
         suffix: suffix,
       );

  /// Creates a [FTile] without custom layout behavior.
  ///
  /// Assuming LTR locale:
  /// ```diagram
  /// ----------------------------------------
  /// | [prefix] [child]                     |
  /// ----------------------------------------
  /// ```
  ///
  /// The order is reversed for RTL locales.
  FTile.raw({
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
  }) : _child = FItem.raw(
         style: style,
         enabled: enabled,
         selected: selected,
         semanticsLabel: semanticsLabel,
         autofocus: autofocus,
         focusNode: focusNode,
         onFocusChange: onFocusChange,
         onHoverChange: onHoverChange,
         onStateChange: onStateChange,
         onPress: onPress,
         onLongPress: onLongPress,
         onSecondaryPress: onSecondaryPress,
         onSecondaryLongPress: onSecondaryLongPress,
         shortcuts: shortcuts,
         actions: actions,
         prefix: prefix,
         child: child,
       );

  @override
  Widget build(BuildContext context) {
    final parent = FInheritedItemData.maybeOf(context);
    final style = parent == null ? this.style?.call(context.theme.tileStyle) ?? context.theme.tileStyle : null;
    return FInheritedItemData.merge(style: style, last: true, child: _child);
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
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress))
      ..add(ObjectFlagProperty.has('onSecondaryPress', onSecondaryPress))
      ..add(ObjectFlagProperty.has('onSecondaryLongPress', onSecondaryLongPress))
      ..add(DiagnosticsProperty('shortcuts', shortcuts))
      ..add(DiagnosticsProperty('actions', actions));
  }
}

/// A [FTile]'s style.
class FTileStyle extends FItemStyle with Diagnosticable, _$FTileStyleFunctions {
  /// Creates a [FTileStyle].
  FTileStyle({
    required super.backgroundColor,
    required super.decoration,
    required super.contentStyle,
    required super.rawItemContentStyle,
    required super.tappableStyle,
    required super.focusedOutlineStyle,
    super.margin = EdgeInsets.zero,
  });

  /// Creates a [FTileStyle].
  FTileStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        backgroundColor: FWidgetStateMap.all(colors.background),
        decoration: FWidgetStateMap({
          WidgetState.disabled: BoxDecoration(
            color: colors.disable(colors.secondary),
            border: Border.all(color: colors.border),
            borderRadius: style.borderRadius,
          ),
          WidgetState.hovered | WidgetState.pressed: BoxDecoration(
            color: colors.secondary,
            border: Border.all(color: colors.border),
            borderRadius: style.borderRadius,
          ),
          WidgetState.any: BoxDecoration(
            color: colors.background,
            border: Border.all(color: colors.border),
            borderRadius: style.borderRadius,
          ),
        }),
        contentStyle: FItemContentStyle(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 13, 10, 13),
          prefixIconStyle: FWidgetStateMap({
            WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 18),
            WidgetState.any: IconThemeData(color: colors.primary, size: 18),
          }),
          titleTextStyle: FWidgetStateMap({
            WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.primary)),
            WidgetState.any: typography.base,
          }),
          subtitleTextStyle: FWidgetStateMap({
            WidgetState.disabled: typography.xs.copyWith(color: colors.disable(colors.mutedForeground)),
            WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground),
          }),
          detailsTextStyle: FWidgetStateMap({
            WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.mutedForeground)),
            WidgetState.any: typography.base.copyWith(color: colors.mutedForeground),
          }),
          suffixIconStyle: FWidgetStateMap({
            WidgetState.disabled: IconThemeData(color: colors.disable(colors.mutedForeground), size: 18),
            WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 18),
          }),
        ),
        rawItemContentStyle: FRawItemContentStyle(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 13, 10, 13),
          prefixIconStyle: FWidgetStateMap({
            WidgetState.disabled: IconThemeData(color: colors.disable(colors.primary), size: 18),
            WidgetState.any: IconThemeData(color: colors.primary, size: 18),
          }),
          childTextStyle: FWidgetStateMap({
            WidgetState.disabled: typography.base.copyWith(color: colors.disable(colors.primary)),
            WidgetState.any: typography.base,
          }),
        ),
        tappableStyle: style.tappableStyle.copyWith(
          motion: FTappableMotion.none,
          pressedEnterDuration: Duration.zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
        focusedOutlineStyle: style.focusedOutlineStyle,
      );
}

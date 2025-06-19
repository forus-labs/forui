import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile_content.dart';

part 'tile.style.dart';

/// The divider between tiles in a group.
enum FTileDivider {
  /// Represents a divider that spans the entire tile horizontally.
  full,

  /// Represents a divider that partially spans the tile horizontally. A tile is always responsible for the divider
  /// directly below it.
  ///
  /// For [FTile.new], the divider spans from the title's left edge to the tile's right edge. It is always aligned to
  /// the title of the tile above the divider.
  /// ```diagram
  /// -----------------------------
  /// | [prefixIcon] [title]      | <- Tile A
  /// |              ------------ |
  /// | [title]                   | <- Tile B
  /// -----------------------------
  /// ```
  indented,

  /// No divider between tiles.
  none,
}

/// A marker interface which denotes that mixed-in widgets can be used in a [FTileGroup].
mixin FTileMixin on Widget {}

/// A tile that is typically used to group related information together.
///
/// Multiple tiles can be grouped together in a [FTileGroup]. Tiles grouped together will be separated by a divider,
/// specified by a [FTileDivider].
///
/// See:
/// * https://forui.dev/docs/tile/tile for working examples.
/// * [FTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a tile's appearance.
class FTile extends StatelessWidget with FTileMixin {
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
  final FTileStyle Function(FTileStyle)? style;

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
  final ValueChanged<Set<WidgetState>>? onStateChange;

  /// A callback for when the tile is pressed.
  ///
  /// The tile is not hoverable if both [onPress] and [onLongPress] are null.
  final VoidCallback? onPress;

  /// A callback for when the tile is long pressed.
  ///
  /// The tile is not hoverable if both [onPress] and [onLongPress] are null.
  final VoidCallback? onLongPress;

  final Widget Function(BuildContext, FTileStyle, Set<WidgetState>, FTileDivider) _builder;

  /// Creates a [FTile].
  ///
  /// Assuming LTR locale:
  /// ```diagram
  /// -----------------------------------------------------
  /// | [prefixIcon] [title]       [details] [suffixIcon] |
  /// |              [subtitle]                           |
  /// ----------------------------------------------------
  /// ```
  ///
  /// The order is reversed for RTL locales.
  ///
  /// ## Overflow behavior
  /// If the tile's content overflows and `details` is text, `details` will be truncated first. Otherwise, `title` and
  /// `subtitle` will be truncated first.
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
    Widget? prefixIcon,
    Widget? subtitle,
    Widget? details,
    Widget? suffixIcon,
    super.key,
  }) : _builder = ((context, style, states, divider) => FTileContent(
         style: style.contentStyle,
         dividerStyle: style.dividerStyle,
         dividerType: divider,
         states: states,
         title: title,
         prefixIcon: prefixIcon,
         subtitle: subtitle,
         details: details,
         suffixIcon: suffixIcon,
       ));

  @override
  Widget build(BuildContext context) {
    final group = FTileGroupData.of(context);
    final item = FTileGroupItemData.of(context);
    final enabled = this.enabled ?? item.enabled;
    final tappable = onPress != null || onLongPress != null;
    final stateStyle = tappable ? item.style.tappableTileStyle : item.style.untappableTileStyle;
    final style = this.style?.call(stateStyle) ?? stateStyle;
    final divider = switch (group.index) {
      final i when i < group.length - 1 && item.last => group.divider,
      final i when i == group.length - 1 && item.last => FTileDivider.none,
      _ => item.divider,
    };

    if (!tappable) {
      return _content(context, style, {if (!enabled) WidgetState.disabled}, divider);
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
          _content(context, style, states, divider),
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

  Widget _content(BuildContext context, FTileStyle style, Set<WidgetState> states, FTileDivider divider) {
    final decoration = style.decoration.resolve(states);
    final root = FTileGroupItemData.maybeOf(context) == null;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: decoration.color,
        image: decoration.image,
        border: root ? decoration.border : null,
        borderRadius: root ? decoration.borderRadius : null,
        boxShadow: decoration.boxShadow,
        gradient: decoration.gradient,
        backgroundBlendMode: decoration.backgroundBlendMode,
        shape: decoration.shape,
      ),
      child: _builder(context, style, states, divider),
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

/// A [FTile]'s style.
class FTileStyle with Diagnosticable, _$FTileStyleFunctions {
  //// The tile's border.
  ///
  /// ## Note
  /// If wrapped in a [FTileGroup], the [BoxDecoration.border] and [BoxDecoration.borderRadius] are ignored. Configure
  /// [FTileGroupStyle] instead.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<BoxDecoration> decoration;

  /// The divider's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<FDividerStyle> dividerStyle;

  /// The default tile content's style.
  @override
  final FTileContentStyle contentStyle;

  /// The tappable style.
  @override
  final FTappableStyle tappableStyle;

  /// The focused outline style.
  @override
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// Creates a [FTileStyle].
  FTileStyle({
    required this.decoration,
    required this.dividerStyle,
    required this.contentStyle,
    required this.tappableStyle,
    required this.focusedOutlineStyle,
  });
}

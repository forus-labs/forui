import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile_content.dart';
import 'package:forui/src/widgets/tile/tile_group.dart';

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
/// * [FTileStateStyle] for customizing a tile's appearance.
class FTile extends StatelessWidget with FTileMixin {
  /// The tile's style. Defaults to the ancestor tile group's style if present, and [FThemeData.tileGroupStyle] otherwise.
  ///
  /// Provide a style to prevent inheriting from the ancestor tile group's style.
  final FTileStyle? style;

  /// Whether the `FTile` is enabled. Defaults to true.
  final bool? enabled;

  /// True if this tappable is currently selected. Defaults to false.
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

  /// {@macro forui.foundation.FTappable.onChange}
  final ValueChanged<Set<WidgetState>>? onChange;

  /// A callback for when the tile is pressed.
  ///
  /// The tile is not hoverable if both [onPress] and [onLongPress] are null.
  final VoidCallback? onPress;

  /// A callback for when the tile is long pressed.
  ///
  /// The tile is not hoverable if both [onPress] and [onLongPress] are null.
  final VoidCallback? onLongPress;

  /// The child.
  final Widget child;

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
    this.onChange,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    Widget? prefixIcon,
    Widget? subtitle,
    Widget? details,
    Widget? suffixIcon,
    super.key,
  }) : onPress = (enabled ?? true) ? onPress : null,
       onLongPress = (enabled ?? true) ? onLongPress : null,
       child = FTileContent(
         title: title,
         prefixIcon: prefixIcon,
         subtitle: subtitle,
         details: details,
         suffixIcon: suffixIcon,
       );

  @override
  Widget build(BuildContext context) {
    final tileData = FTileData.maybeOf(context);

    final pressable = onPress != null || onLongPress != null;
    final style = this.style ?? tileData?.style ?? context.theme.tileGroupStyle.tileStyle;
    final stateStyle = pressable ? style.pressable : style.unpressable;

    final group = extractTileGroup(FTileGroupData.maybeOf(context));
    final tile = extractTile(tileData);

    final enabled = this.enabled ?? !tile.states.contains(WidgetState.disabled);

    final curveTop = group.index == 0 && tile.index == 0;
    final curveBottom = group.index == group.length - 1 && tile.last;

    return FTappable(
      style: stateStyle.tappableStyle,
      semanticsLabel: semanticsLabel,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onChange: onChange,
      selected: selected,
      onPress: enabled ? (onPress ?? () {}) : null,
      onLongPress: enabled ? (onLongPress ?? () {}) : null,
      builder: (_, states, _) {
        final border = stateStyle.border.resolve(states);
        return DecoratedBox(
          decoration: BoxDecoration(
            color: stateStyle.backgroundColor.resolve(states),
            border: Border(
              top: curveTop ? border.top : BorderSide.none,
              left: border.left,
              right: border.right,
              bottom: curveBottom ? border.top : BorderSide.none,
            ),
            borderRadius: BorderRadius.only(
              topLeft: curveTop ? stateStyle.borderRadius.topLeft : Radius.zero,
              topRight: curveTop ? stateStyle.borderRadius.topRight : Radius.zero,
              bottomLeft: curveBottom ? stateStyle.borderRadius.bottomLeft : Radius.zero,
              bottomRight: curveBottom ? stateStyle.borderRadius.bottomLeft : Radius.zero,
            ),
          ),
          child: FTileData(
            style: style,
            divider: tile.divider,
            states: states,
            index: tile.index,
            last: tile.last,
            pressable: pressable,
            child: child,
          ),
        );
      },
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
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onPress', onPress))
      ..add(ObjectFlagProperty.has('onLongPress', onLongPress));
  }
}

@internal
({Set<WidgetState> states, int index, bool last, FTileDivider divider}) extractTile(FTileData? data) => (
  states: data?.states ?? {},
  index: data?.index ?? 0,
  last: data?.last ?? true,
  divider: data?.divider ?? FTileDivider.indented,
);

/// A tile's data.
class FTileData extends InheritedWidget {
  /// Returns the [FTileData] of the [FTile] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FTile] in the given [context].
  static FTileData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FTileData>();

  /// The tile's style.
  final FTileStyle style;

  /// The divider if there are more than 1 tiles in the current group.
  final FTileDivider divider;

  /// The currently active states.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  final Set<WidgetState> states;

  /// The tile's index in the current group.
  final int index;

  /// True if the tile is the last in the group.
  final bool last;

  /// True if the tile is pressable.
  final bool pressable;

  /// Creates a [FTileData].
  const FTileData({
    required this.style,
    required this.divider,
    required this.states,
    required this.index,
    required this.last,
    required this.pressable,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FTileData old) =>
      style != old.style ||
      divider != old.divider ||
      !setEquals(states, old.states) ||
      index != old.index ||
      last != old.last;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(IterableProperty('states', states))
      ..add(IntProperty('index', index))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'))
      ..add(FlagProperty('pressable', value: pressable, ifTrue: 'pressable'));
  }
}

/// A tile's style.
class FTileStyle with Diagnosticable, _$FTileStyleFunctions {
  /// A pressable tile's style.
  @override
  final FTileStateStyle pressable;

  /// A unpressable tile's style.
  @override
  final FTileStateStyle unpressable;

  /// Creates a [FTileStyle].
  FTileStyle({required this.pressable, required this.unpressable});

  /// Creates a [FTileStyle] that inherits its properties.
  factory FTileStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) {
    final border = FWidgetStateMap({
      WidgetState.focused: Border.all(width: style.borderWidth, color: colors.primary),
      WidgetState.any: Border.all(width: style.borderWidth, color: colors.border),
    });

    final divider = FWidgetStateMap({
      WidgetState.any: FDividerStyle(color: colors.border, width: style.borderWidth, padding: EdgeInsets.zero),
    });

    return FTileStyle(
      pressable: FTileStateStyle(
        border: border,
        borderRadius: style.borderRadius,
        backgroundColor: FWidgetStateMap({
          WidgetState.disabled: colors.disable(colors.secondary),
          WidgetState.hovered: colors.secondary,
          WidgetState.any: colors.background,
        }),
        dividerStyle: divider,
        contentStyle: FTileContentStyle.inherit(colors: colors, typography: typography),
        tappableStyle: style.tappableStyle.copyWith(
          animationTween: FTappableAnimations.none,
          pressedEnterDuration: Duration.zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
      ),
      unpressable: FTileStateStyle(
        border: border,
        borderRadius: style.borderRadius,
        backgroundColor: FWidgetStateMap({
          WidgetState.disabled: colors.disable(colors.secondary),
          WidgetState.any: colors.background,
        }),
        dividerStyle: divider,
        contentStyle: FTileContentStyle.inherit(colors: colors, typography: typography),
        tappableStyle: style.tappableStyle.copyWith(
          cursor: FWidgetStateMap.all(MouseCursor.defer),
          animationTween: FTappableAnimations.none,
          pressedEnterDuration: Duration.zero,
          pressedExitDuration: const Duration(milliseconds: 25),
        ),
      ),
    );
  }
}

/// A [FTile]'s state style.
class FTileStateStyle with Diagnosticable, _$FTileStateStyleFunctions {
  /// The tile's border.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<Border> border;

  /// The tile's border radius.
  @override
  final BorderRadius borderRadius;

  /// The tile's background color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  @override
  final FWidgetStateMap<Color> backgroundColor;

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

  /// Creates a [FTileStateStyle].
  FTileStateStyle({
    required this.border,
    required this.borderRadius,
    required this.backgroundColor,
    required this.dividerStyle,
    required this.contentStyle,
    required this.tappableStyle,
  });
}

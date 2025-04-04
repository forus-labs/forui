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
/// * [FTileStyle] for customizing a tile's appearance.
class FTile extends StatelessWidget with FTileMixin {
  /// The tile's style. Defaults to the ancestor tile group's style if present, and [FThemeData.tileGroupStyle] otherwise.
  ///
  /// Provide a style to prevent inheriting from the ancestor tile group's style.
  final FTileStyle? style;

  /// Whether the `FTile` is enabled. Defaults to true.
  final bool? enabled;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// {@macro forui.foundation.doc_templates.autofocus}
  final bool autofocus;

  /// {@macro forui.foundation.doc_templates.focusNode}
  final FocusNode? focusNode;

  /// {@macro forui.foundation.doc_templates.onFocusChange}
  final ValueChanged<bool>? onFocusChange;

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
  /// If the tile's content overflows and `details` is text, it'll be truncated first. Otherwise, `title` and `subtitle`
  /// will be truncated first.
  FTile({
    required Widget title,
    this.style,
    this.enabled,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
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
    final style = this.style ?? tileData?.style ?? context.theme.tileGroupStyle.tileStyle;

    final group = extractTileGroup(FTileGroupData.maybeOf(context));
    final tile = extractTile(tileData);
    final enabled = this.enabled ?? tile.enabled;
    final curveTop = group.index == 0 && tile.index == 0;
    final curveBottom = group.index == group.length - 1 && tile.last;

    Widget content(FTappableData data) => DecoratedBox(
      decoration: BoxDecoration(
        color: switch ((enabled, data.hovered)) {
          (true, true) => style.enabledHoveredBackgroundColor,
          (true, false) => style.enabledBackgroundColor,
          (false, _) => style.disabledBackgroundColor,
        },
        border:
            data.focused
                ? Border(
                  // style.focusedBorder.left is used so that the top is always painted.
                  top: curveTop ? style.focusedBorder.top : style.focusedBorder.left,
                  left: style.focusedBorder.left,
                  right: style.focusedBorder.right,
                  bottom: curveBottom ? style.focusedBorder.top : BorderSide.none,
                )
                : Border(
                  top: curveTop ? style.border.top : BorderSide.none,
                  left: style.border.left,
                  right: style.border.right,
                  bottom: curveBottom ? style.border.top : BorderSide.none,
                ),
        borderRadius: BorderRadius.only(
          topLeft: curveTop ? style.borderRadius.topLeft : Radius.zero,
          topRight: curveTop ? style.borderRadius.topRight : Radius.zero,
          bottomLeft: curveBottom ? style.borderRadius.bottomLeft : Radius.zero,
          bottomRight: curveBottom ? style.borderRadius.bottomLeft : Radius.zero,
        ),
      ),
      child: FTileData(
        style: style,
        divider: tile.divider,
        enabled: enabled,
        hovered: data.hovered || data.pressed,
        focused: data.focused,
        index: tile.index,
        last: tile.last,
        child: child,
      ),
    );

    return FTappable(
      style: style.tappableStyle,
      semanticsLabel: semanticsLabel,
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onPress: onPress,
      onLongPress: onLongPress,
      builder: (_, data, _) => content(data),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', level: DiagnosticLevel.debug))
      ..add(StringProperty('semanticsLabel', semanticsLabel, defaultValue: null, quoted: false))
      ..add(FlagProperty('autofocus', value: autofocus, ifTrue: 'autofocus'))
      ..add(DiagnosticsProperty('focusNode', focusNode))
      ..add(ObjectFlagProperty.has('onFocusChange', onFocusChange))
      ..add(ObjectFlagProperty('onPress', onPress, ifPresent: 'onPress', level: DiagnosticLevel.debug))
      ..add(ObjectFlagProperty('onLongPress', onLongPress, ifPresent: 'onLongPress', level: DiagnosticLevel.debug));
  }
}

/// Extracts the data from the given [FTileData].
@internal
({int index, bool last, FTileDivider divider, bool enabled}) extractTile(FTileData? data) => (
  enabled: data?.enabled ?? true,
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

  /// True if the tile is enabled.
  final bool enabled;

  /// True if the tile is hovered over.
  final bool hovered;

  /// True if the tile is focused.
  final bool focused;

  /// The tile's index in the current group.
  final int index;

  /// True if the tile is the last in the group.
  final bool last;

  /// Creates a [FTileData].
  const FTileData({
    required this.style,
    required this.divider,
    required this.enabled,
    required this.hovered,
    required this.focused,
    required this.index,
    required this.last,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FTileData old) =>
      style != old.style ||
      divider != old.divider ||
      enabled != old.enabled ||
      hovered != old.hovered ||
      focused != old.focused ||
      index != old.index ||
      last != old.last;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(FlagProperty('hovered', value: hovered, ifTrue: 'hovered'))
      ..add(FlagProperty('focused', value: focused, ifTrue: 'focused'))
      ..add(IntProperty('index', index))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'));
  }
}

/// A [FTile]'s style.
final class FTileStyle with Diagnosticable, _$FTileStyleFunctions {
  /// The tile's border.
  @override
  final Border border;

  /// The tile's focused border.
  @override
  final Border focusedBorder;

  /// The tile's border radius.
  @override
  final BorderRadius borderRadius;

  /// The background color when the tile is enabled.
  @override
  final Color enabledBackgroundColor;

  /// The background color when the tile is enabled and hovered.
  @override
  final Color enabledHoveredBackgroundColor;

  /// The background color when the tile is disabled.
  @override
  final Color disabledBackgroundColor;

  /// The divider's style.
  @override
  final FDividerStyle dividerStyle;

  /// The focused divider's style.
  @override
  final FDividerStyle focusedDividerStyle;

  /// The tappable's style.
  @override
  final FTappableStyle tappableStyle;

  /// The default tile content's style.
  @override
  final FTileContentStyle contentStyle;

  /// Creates a [FTileStyle].
  FTileStyle({
    required this.border,
    required this.focusedBorder,
    required this.borderRadius,
    required this.enabledBackgroundColor,
    required this.enabledHoveredBackgroundColor,
    required this.disabledBackgroundColor,
    required this.dividerStyle,
    required this.focusedDividerStyle,
    required this.tappableStyle,
    required this.contentStyle,
  });

  /// Creates a [FTileStyle] that inherits its properties.
  FTileStyle.inherit({required FColorScheme color, required FTypography text, required FStyle style})
    : this(
        border: Border.all(width: style.borderWidth, color: color.border),
        focusedBorder: Border.all(width: style.borderWidth, color: color.primary),
        borderRadius: style.borderRadius,
        enabledBackgroundColor: color.background,
        enabledHoveredBackgroundColor: color.secondary,
        disabledBackgroundColor: color.disable(color.secondary),
        dividerStyle: FDividerStyle(color: color.border, width: style.borderWidth, padding: EdgeInsets.zero),
        focusedDividerStyle: FDividerStyle(color: color.primary, width: style.borderWidth, padding: EdgeInsets.zero),
        tappableStyle: style.tappableStyle.copyWith(
          touchHoverEnterDuration: Duration.zero,
          touchHoverExitDuration: const Duration(milliseconds: 25),
        ),
        contentStyle: FTileContentStyle.inherit(color: color, text: text),
      );
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';
import 'package:forui/src/widgets/tile/tile_content.dart';

/// A tile that is typically used to group related information together.
///
/// Multiple tiles can be grouped together in a [FTileGroup]. Tiles grouped together will be separated by a divider,
/// specified by a [FTileDivider].
///
/// See:
/// * https://forui.dev/docs/tile/tile for working examples.
/// * [FTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a tile's appearance.
class FTile extends StatelessWidget {
  /// The tile's style. Defaults to the ancestor tile group's style if present, and [FThemeData.tileGroupStyle] otherwise.
  ///
  /// Provide a style to prevent inheriting from the ancestor tile group's style.
  final FTileStyle? style;

  /// Whether the FTile is enabled. Defaults to true.
  final bool enabled;

  /// The semantic label.
  final String? semanticLabel;

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
  /// ```
  /// -----------------------------------------------------
  /// | [prefixIcon] [title]       [details] [suffixIcon] |
  /// |              [subtitle]                           |
  /// ----------------------------------------------------
  /// ```
  ///
  /// ## Overflow behavior
  /// If the tile's content overflows and `details` is text, it'll be truncated first. Otherwise, `title` and `subtitle`
  /// will be truncated first.
  FTile({
    required Widget title,
    this.style,
    this.enabled = true,
    this.semanticLabel,
    this.onPress,
    this.onLongPress,
    Widget? prefixIcon,
    Widget? subtitle,
    Widget? details,
    Widget? suffixIcon,
    super.key,
  }) : child = FTileContent(
          title: title,
          prefixIcon: prefixIcon,
          subtitle: subtitle,
          details: details,
          suffixIcon: suffixIcon,
        );

  @override
  Widget build(BuildContext context) {
    final inherited = FTileData.maybeOf(context);
    final style = this.style ?? inherited?.style ?? context.theme.tileGroupStyle.tileStyle;
    final divider = inherited?.divider ?? FTileDivider.full;
    final index = inherited?.index ?? 0;
    final length = inherited?.length ?? 1;

    Widget content({required bool hovered}) => DecoratedBox(
          decoration: BoxDecoration(
            color: switch ((enabled, hovered)) {
              (true, true) => style.enabledHoveredBackgroundColor,
              (true, false) => style.enabledBackgroundColor,
              (false, _) => style.disabledBackgroundColor,
            },
            border: Border(
              top: index == 0 ? style.border.top : BorderSide.none,
              left: style.border.left,
              right: style.border.right,
              bottom: index == length - 1 ? style.border.top : BorderSide.none,
            ),
            borderRadius: BorderRadius.only(
              topLeft: index == 0 ? style.borderRadius.topLeft : Radius.zero,
              topRight: index == 0 ? style.borderRadius.topRight : Radius.zero,
              bottomLeft: index == length - 1 ? style.borderRadius.bottomLeft : Radius.zero,
              bottomRight: index == length - 1 ? style.borderRadius.bottomLeft : Radius.zero,
            ),
          ),
          child: FTileData(
            style: style,
            divider: divider,
            enabled: enabled,
            hovered: hovered,
            index: index,
            length: length,
            child: child,
          ),
        );

    return enabled && (onPress != null || onLongPress != null)
        ? FTappable(
            behavior: HitTestBehavior.translucent,
            semanticLabel: semanticLabel,
            touchHoverEnterDuration: style.touchHoverEnterDuration,
            touchHoverExitDuration: style.touchHoverExitDuration,
            onPress: onPress,
            onLongPress: onLongPress,
            builder: (_, state, __) => content(hovered: state.hovered),
          )
        : Semantics(
            container: true,
            enabled: enabled,
            label: semanticLabel,
            child: content(hovered: false),
          );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style, level: DiagnosticLevel.debug))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', level: DiagnosticLevel.debug))
      ..add(StringProperty('semanticLabel', semanticLabel, defaultValue: null, quoted: false))
      ..add(ObjectFlagProperty('onPress', onPress, ifPresent: 'onPress', level: DiagnosticLevel.debug))
      ..add(ObjectFlagProperty('onLongPress', onLongPress, ifPresent: 'onLongPress', level: DiagnosticLevel.debug));
  }
}

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

  /// The tile's index in the current group.
  final int index;

  /// The number of tiles in the current group.
  final int length;

  /// Creates a [FTileData].
  const FTileData({
    required this.style,
    required this.divider,
    required this.enabled,
    required this.hovered,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  }) : super();

  @override
  bool updateShouldNotify(FTileData old) =>
      style != old.style ||
      divider != old.divider ||
      enabled != old.enabled ||
      hovered != old.hovered ||
      index != old.index ||
      length != old.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', level: DiagnosticLevel.debug))
      ..add(FlagProperty('hovered', value: hovered, ifTrue: 'hovered', level: DiagnosticLevel.debug))
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length));
  }
}

/// A [FTile]'s style.
final class FTileStyle with Diagnosticable {
  /// The tile's border.
  final Border border;

  /// The tile's border radius.
  final BorderRadius borderRadius;

  /// The background color when the tile is enabled.
  final Color enabledBackgroundColor;

  /// The background color when the tile is enabled and hovered.
  final Color enabledHoveredBackgroundColor;

  /// The background color when the tile is disabled.
  final Color disabledBackgroundColor;

  /// The duration to wait before applying the hover effect after the user presses the tile. Defaults to 0 seconds.
  final Duration touchHoverEnterDuration;

  /// The duration to wait before removing the hover effect after the user stops pressing the tile. Defaults to 25ms.
  final Duration touchHoverExitDuration;

  /// The divider's style.
  final FDividerStyle dividerStyle;

  /// The default tile content's style.
  final FTileContentStyle contentStyle;

  /// Creates a [FTileStyle].
  FTileStyle({
    required this.border,
    required this.borderRadius,
    required this.enabledBackgroundColor,
    required this.enabledHoveredBackgroundColor,
    required this.disabledBackgroundColor,
    required this.dividerStyle,
    required this.contentStyle,
    this.touchHoverEnterDuration = Duration.zero,
    this.touchHoverExitDuration = const Duration(milliseconds: 25),
  });

  /// Creates a [FTileStyle] that inherits from the given [colorScheme] and [typography].
  FTileStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          border: Border.all(width: style.borderWidth, color: colorScheme.border),
          borderRadius: style.borderRadius,
          enabledBackgroundColor: colorScheme.background,
          enabledHoveredBackgroundColor: colorScheme.secondary,
          disabledBackgroundColor: colorScheme.disable(colorScheme.secondary),
          dividerStyle: FDividerStyle(color: colorScheme.border, width: style.borderWidth, padding: EdgeInsets.zero),
          contentStyle: FTileContentStyle.inherit(colorScheme: colorScheme, typography: typography),
        );

  /// Returns a copy of this [FTileStyle] with the given fields replaced with the new values.
  @useResult
  FTileStyle copyWith({
    Border? border,
    BorderRadius? borderRadius,
    Color? enabledBackgroundColor,
    Color? enabledHoveredBackgroundColor,
    Color? disabledBackgroundColor,
    Duration? touchHoverEnterDuration,
    Duration? touchHoverExitDuration,
    FDividerStyle? dividerStyle,
    FTileContentStyle? contentStyle,
  }) =>
      FTileStyle(
        border: border ?? this.border,
        borderRadius: borderRadius ?? this.borderRadius,
        enabledBackgroundColor: enabledBackgroundColor ?? this.enabledBackgroundColor,
        enabledHoveredBackgroundColor: enabledHoveredBackgroundColor ?? this.enabledHoveredBackgroundColor,
        disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
        touchHoverEnterDuration: touchHoverEnterDuration ?? this.touchHoverEnterDuration,
        touchHoverExitDuration: touchHoverExitDuration ?? this.touchHoverExitDuration,
        dividerStyle: dividerStyle ?? this.dividerStyle,
        contentStyle: contentStyle ?? this.contentStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('border', border))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(ColorProperty('enabledBackgroundColor', enabledBackgroundColor))
      ..add(ColorProperty('enabledHoveredBackgroundColor', enabledHoveredBackgroundColor))
      ..add(ColorProperty('disabledBackgroundColor', disabledBackgroundColor))
      ..add(DiagnosticsProperty('touchHoverEnterDuration', touchHoverEnterDuration))
      ..add(DiagnosticsProperty('touchHoverExitDuration', touchHoverExitDuration))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTileStyle &&
          runtimeType == other.runtimeType &&
          border == other.border &&
          borderRadius == other.borderRadius &&
          enabledBackgroundColor == other.enabledBackgroundColor &&
          enabledHoveredBackgroundColor == other.enabledHoveredBackgroundColor &&
          disabledBackgroundColor == other.disabledBackgroundColor &&
          touchHoverEnterDuration == other.touchHoverEnterDuration &&
          touchHoverExitDuration == other.touchHoverExitDuration &&
          dividerStyle == other.dividerStyle &&
          contentStyle == other.contentStyle;

  @override
  int get hashCode =>
      border.hashCode ^
      borderRadius.hashCode ^
      enabledBackgroundColor.hashCode ^
      enabledHoveredBackgroundColor.hashCode ^
      disabledBackgroundColor.hashCode ^
      touchHoverEnterDuration.hashCode ^
      touchHoverExitDuration.hashCode ^
      dividerStyle.hashCode ^
      contentStyle.hashCode;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile_content.dart';
import 'package:meta/meta.dart';

/// The divider between tiles in a group.
enum FTileDivider {
  /// A divider that spans the entire tile horizontally.
  full,

  /// A divider that spans the tile horizontally from the title's left edge to the tile's right edge.
  title,

  /// No divider.
  none,
}

/// A tile.
///
/// Multiple tiles can be grouped together in a [FTileGroup]. Tiles grouped together will be separated by a divider,
/// specified by a [FTileDivider].
///
/// See:
/// * https://forui.dev/docs/tile for working examples.
/// * [FTileStyle] for customizing a tile's appearance.
class FTile extends StatelessWidget {
  /// The tile's style. Defaults to the ancestor tile group's style if present, and [FThemeData.tileStyle] otherwise.
  ///
  /// Provide a style to prevent inheriting from the ancestor tile group's style.
  final FTileStyle? style;

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
  FTile({
    required Widget title,
    this.style,
    Widget? prefixIcon,
    Widget? subtitle,
    Widget? details,
    Widget? suffixIcon,
    String? semanticLabel,
    bool enabled = true,
    VoidCallback? onPress,
    VoidCallback? onLongPress,
    super.key,
  }) : child = FTileContent(
          title: title,
          prefixIcon: prefixIcon,
          subtitle: subtitle,
          details: details,
          suffixIcon: suffixIcon,
          semanticLabel: semanticLabel,
          enabled: enabled,
          onPress: onPress,
          onLongPress: onLongPress,
        );

  @override
  Widget build(BuildContext context) {
    final data = FTileData.maybeOf(context);
    if (data == null) {
      return FTileData(
        style: style ?? context.theme.tileStyle,
        divider: FTileDivider.full,
        index: 0,
        length: 1,
        child: child,
      );
    }

    if (style case final style?) {
      return FTileData(
        style: style,
        divider: data.divider,
        index: data.index,
        length: data.length,
        child: child,
      );
    }

    return child;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
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

  /// The tile's index in the current group.
  final int index;

  /// The number of tiles in the current group.
  final int length;

  /// Creates a [FTileData].
  const FTileData({
    required this.style,
    required this.divider,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  }) : super();

  @override
  bool updateShouldNotify(FTileData old) =>
      style != old.style || divider != old.divider || index != old.index || length != old.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length));
  }
}

/// A [FTile]'s style.
final class FTileStyle with Diagnosticable {
  /// The box decoration for an enabled tile.
  final BoxDecoration enabledDecoration;

  /// Th box decoration for an enabled tile when hovered.
  final BoxDecoration enabledHoverDecoration;

  /// The box decoration for a disabled tile.
  final BoxDecoration disabledDecoration;

  /// The divider's style.
  final FDividerStyle dividerStyle;

  /// The default tile content's style.
  final FTileContentStyle contentStyle;

  /// Creates a [FTileStyle].
  FTileStyle({
    required this.enabledDecoration,
    required this.enabledHoverDecoration,
    required this.disabledDecoration,
    required this.dividerStyle,
    required this.contentStyle,
  });

  /// Creates a [FTileStyle] that inherits from the given [colorScheme] and [typography].
  FTileStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          enabledDecoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: style.borderRadius,
            border: Border.all(
              color: colorScheme.border,
            ),
          ),
          enabledHoverDecoration: BoxDecoration(
            color: colorScheme.secondary,
            borderRadius: style.borderRadius,
            border: Border.all(
              color: colorScheme.border,
            ),
          ),
          disabledDecoration: BoxDecoration(
            color: colorScheme.disable(colorScheme.secondary),
            borderRadius: style.borderRadius,
            border: Border.all(
              color: colorScheme.disable(colorScheme.border),
            ),
          ),
          dividerStyle: FDividerStyle.inherit(colorScheme: colorScheme, style: style, padding: EdgeInsets.zero),
          contentStyle: FTileContentStyle.inherit(colorScheme: colorScheme, typography: typography),
        );

  /// Returns a copy of this [FTileStyle] with the given fields replaced with the new values.
  @useResult
  FTileStyle copyWith({
    BoxDecoration? enabledDecoration,
    BoxDecoration? enabledHoverDecoration,
    BoxDecoration? disabledDecoration,
    FDividerStyle? dividerStyle,
    FTileContentStyle? contentStyle,
  }) =>
      FTileStyle(
        enabledDecoration: enabledDecoration ?? this.enabledDecoration,
        enabledHoverDecoration: enabledHoverDecoration ?? this.enabledHoverDecoration,
        disabledDecoration: disabledDecoration ?? this.disabledDecoration,
        dividerStyle: dividerStyle ?? this.dividerStyle,
        contentStyle: contentStyle ?? this.contentStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledDecoration', enabledDecoration))
      ..add(DiagnosticsProperty('enabledHoverDecoration', enabledHoverDecoration))
      ..add(DiagnosticsProperty('disabledDecoration', disabledDecoration))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('contentStyle', contentStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTileStyle &&
          runtimeType == other.runtimeType &&
          enabledDecoration == other.enabledDecoration &&
          enabledHoverDecoration == other.enabledHoverDecoration &&
          disabledDecoration == other.disabledDecoration &&
          dividerStyle == other.dividerStyle &&
          contentStyle == other.contentStyle;

  @override
  int get hashCode =>
      enabledDecoration.hashCode ^
      enabledHoverDecoration.hashCode ^
      disabledDecoration.hashCode ^
      dividerStyle.hashCode ^
      contentStyle.hashCode;
}

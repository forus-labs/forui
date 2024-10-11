import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/tile_content.dart';

/// A tile that is typically used to group related information together.
///
/// Multiple tiles can be grouped together in a [FTileGroup]. Tiles grouped together will be separated by a divider,
/// specified by a [FTileDivider].
///
/// See:
/// * https://forui.dev/docs/tile for working examples.
/// * [FTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a tile's appearance.
class FTile extends StatelessWidget {
  /// The tile's style. Defaults to the ancestor tile group's style if present, and [FThemeData.tileGroupStyle] otherwise.
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
      final style = this.style ?? context.theme.tileGroupStyle.tileStyle;
      return FTileData(
        style: style,
        divider: FTileDivider.full,
        index: 0,
        length: 1,
        // DecoratedBox doesn't inset the child, resulting in an invisible border.
        // ignore: use_decorated_box - https://github.com/flutter/flutter/issues/2386
        child: Container(
          decoration: BoxDecoration(
            border: style.border,
            borderRadius: style.borderRadius,
            color: style.enabledBackgroundColor,
          ),
          child: child,
        ),
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
    FDividerStyle? dividerStyle,
    FTileContentStyle? contentStyle,
  }) =>
      FTileStyle(
        border: border ?? this.border,
        borderRadius: borderRadius ?? this.borderRadius,
        enabledBackgroundColor: enabledBackgroundColor ?? this.enabledBackgroundColor,
        enabledHoveredBackgroundColor: enabledHoveredBackgroundColor ?? this.enabledHoveredBackgroundColor,
        disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
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
          dividerStyle == other.dividerStyle &&
          contentStyle == other.contentStyle;

  @override
  int get hashCode =>
      border.hashCode ^
      borderRadius.hashCode ^
      enabledBackgroundColor.hashCode ^
      enabledHoveredBackgroundColor.hashCode ^
      disabledBackgroundColor.hashCode ^
      dividerStyle.hashCode ^
      contentStyle.hashCode;
}

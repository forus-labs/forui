import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// A tile group's data.
class FTileGroupData extends InheritedWidget {
  /// Returns the [FTileGroupData] of the [FTile] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FTile] in the given [context].
  static FTileGroupData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FTileGroupData>();

  /// The tile group's style.
  final FTileGroupStyle style;

  /// The divider if there are more than 1 tiles in the current group.
  final FTileDivider divider;

  /// The states.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  final bool enabled;

  /// The group's index.
  final int index;

  /// The number of groups.
  final int length;

  /// Creates a [FTileGroupData].
  const FTileGroupData({
    required this.style,
    required this.divider,
    required this.enabled,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  });

  /// Returns the [FTileGroupData] of the [FTile] in the given [context], or a default [FTileGroupData] if none is found.
  factory FTileGroupData.of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FTileGroupData>() ??
      FTileGroupData(
        style: context.theme.tileGroupStyle,
        divider: FTileDivider.full,
        enabled: true,
        index: 0,
        length: 1,
        child: const SizedBox(),
      );

  @override
  bool updateShouldNotify(FTileGroupData old) =>
      style != old.style ||
      divider != old.divider ||
      enabled != old.enabled ||
      index != old.index ||
      length != old.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length));
  }
}

/// A tile group item's data.
class FTileGroupItemData extends InheritedWidget {
  /// Returns the [FTileGroupItemData] of the [FTile] in the given [context].
  static FTileGroupItemData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FTileGroupItemData>();

  /// The tile's style.
  final FTileGroupStyle style;

  /// The divider if there are more than 1 tiles in the current group.
  final FTileDivider divider;

  /// True if enabled.
  final bool enabled;

  /// True if the tile is the last in the group.
  final bool last;

  /// The tile's index in the current group.
  final int index;

  /// Creates a [FTileGroupItemData].
  const FTileGroupItemData({
    required this.style,
    required this.divider,
    required this.enabled,
    required this.index,
    required this.last,
    required super.child,
    super.key,
  });

  /// Returns the [FTileGroupItemData] of the [FTile] in the given [context], or a default [FTileGroupItemData] if none is found.
  factory FTileGroupItemData.of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FTileGroupItemData>() ??
      FTileGroupItemData(
        style: context.theme.tileGroupStyle,
        divider: FTileDivider.indented,
        enabled: true,
        index: 0,
        last: true,
        child: const SizedBox(),
      );

  @override
  bool updateShouldNotify(FTileGroupItemData old) =>
      style != old.style || divider != old.divider || enabled != old.enabled || index != old.index || last != old.last;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(IntProperty('index', index))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'));
  }
}

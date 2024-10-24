import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/util.dart';

/// A marker interface which denotes that mixed-in widgets can group tiles and be used in a [FTileGroups].
mixin FTileGroupMixin on Widget {}

/// A tile group that groups multiple [FTile]s.
///
/// Tiles grouped together will be separated by a divider, specified by [divider].
///
/// See:
/// * https://forui.dev/docs/tile/tile-group for working examples.
/// * [FTileGroups] for grouping groups together.
/// * [FTileGroupStyle] for customizing a tile's appearance.
class FTileGroup extends StatelessWidget with FTileGroupMixin {
  /// The style.
  final FTileGroupStyle? style;

  /// The divider between tiles. Defaults tp [FTileDivider.indented].
  final FTileDivider divider;

  /// The group's semantic label.
  final String? semanticLabel;

  /// The group's label. It is ignored if the group is part of a [FTileGroup]s.
  final Widget? label;

  /// The tiles in the group.
  final List<FTileMixin> children;

  /// Creates a [FTileGroup].
  const FTileGroup({
    required this.children,
    this.style,
    this.divider = FTileDivider.indented,
    this.semanticLabel,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = FTileGroupData.maybeOf(context);
    final style = this.style ?? data?.style ?? context.theme.tileGroupStyle;

    return Semantics(
      label: semanticLabel,
      container: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label case final label? when data == null)
            Padding(
              padding: style.labelPadding,
              child: merge(
                style: style.labelTextStyle,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                overflow: TextOverflow.ellipsis,
                child: label,
              ),
            ),
          for (final (index, child) in children.indexed)
            FTileData(
              style: style.tileStyle,
              divider: divider,
              enabled: true,
              hovered: false,
              index: index,
              length: children.length,
              child: child,
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
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

/// A [FTileGroup]'s style.
class FTileGroupStyle with Diagnosticable {
  /// The label's padding.
  final EdgeInsets labelPadding;

  /// The label's text style.
  final TextStyle labelTextStyle;

  /// The tile's style.
  final FTileStyle tileStyle;

  /// Creates a [FTileGroupStyle].
  FTileGroupStyle({
    required this.labelTextStyle,
    required this.tileStyle,
    this.labelPadding = const EdgeInsets.symmetric(vertical: 7.5),
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  FTileGroupStyle.inherit({required FColorScheme colorScheme, required FTypography typography, required FStyle style})
      : this(
          labelTextStyle: typography.base.copyWith(fontWeight: FontWeight.w600),
          tileStyle: FTileStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
        );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('tileStyle', tileStyle));
  }
}

/// Extracts the data from the given [FTileGroupData].
@internal
({int index, int length, FTileDivider divider}) extractTileGroup(FTileGroupData? data) => (
      index: data?.index ?? 0,
      length: data?.length ?? 1,
      divider: data?.divider ?? FTileDivider.full,
    );

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

  /// The group's index.
  final int index;

  /// The number of groups.
  final int length;

  /// Creates a [FTileGroupData].
  const FTileGroupData({
    required this.style,
    required this.divider,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FTileGroupData old) =>
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

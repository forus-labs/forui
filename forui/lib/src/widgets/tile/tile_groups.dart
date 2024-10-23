import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/util.dart';

/// A tile group that groups multiple [FTileGroup]s.
///
/// Groups will be separated by a divider, specified by [divider].
///
/// See:
/// * https://forui.dev/docs/tile/tile-groups for working examples.
/// * [FTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a tile's appearance.
class FTileGroups extends StatelessWidget {
  /// The style.
  final FTileGroupStyle? style;

  /// The divider between groups. Defaults to [FTileDivider.full].
  final FTileDivider divider;

  /// The group's semantic label.
  final String? semanticLabel;

  /// The group's label. It is ignored if the group is part of a [FTileGroup]s.
  final Widget? label;

  /// The tile groups.
  final List<FTileGroupMixin> children;

  /// Creates a [FTileGroups].
  const FTileGroups({
    required this.children,
    this.style,
    this.divider = FTileDivider.full,
    this.semanticLabel,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.tileGroupStyle;

    return Semantics(
      label: semanticLabel,
      container: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label case final label?)
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
            FTileGroupData(
              style: style,
              divider: divider,
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

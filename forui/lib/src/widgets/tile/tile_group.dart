import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/util.dart';

/// The divider between tiles in a group.
enum FTileDivider {
  /// Represents a divider that spans the entire tile horizontally.
  full,

  /// Represents a divider that partially spans the tile horizontally. A tile is always responsible for the divider
  /// directly below it.
  ///
  /// For [FTile.new], the divider spans from the title's left edge to the tile's right edge. It is always aligned to
  /// the title of the tile above the divider.
  /// ```
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

/// A tile group that groups multiple [FTile]s.
///
/// Tiles grouped together will be separated by a divider, specified by [divider].
///
/// See:
/// * https://forui.dev/docs/tile/tile-group for working examples.
/// * [FTileGroup] for grouping tiles together.
/// * [FTileStyle] for customizing a tile's appearance.
class FTileGroup extends StatelessWidget {
  /// The style.
  final FTileGroupStyle? style;

  /// The divider between tiles in a group.
  final FTileDivider divider;

  /// The group's semantic label.
  final String? semanticLabel;

  /// The group's label.
  final Widget? label;

  /// The tiles in the group.
  final List<Widget> children;

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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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

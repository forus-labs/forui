import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// The divider between tiles in a group.
enum FTileDivider {
  /// A divider that spans the entire tile horizontally.
  full,

  /// A divider that spans the tile horizontally from the title's left edge to the tile's right edge.
  title,

  /// No divider.
  none,
}

class FTileGroup extends StatelessWidget {
  final FTileStyle? style;

  /// The divider between tiles in a group.
  final FTileDivider divider;

  /// The tiles in the group.
  final List<Widget> children;

  /// Creates a [FTileGroup].
  const FTileGroup({
    required this.children,
    this.style,
    this.divider = FTileDivider.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.tileStyle;
    // DecoratedBox doesn't inset the child, resulting in an invisible border.
    // ignore: use_decorated_box - https://github.com/flutter/flutter/issues/2386
    return Container(
      decoration: BoxDecoration(
        color: style.enabledBackgroundColor,
        borderRadius: style.borderRadius,
        border: style.border,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final (index, child) in children.indexed)
            FTileData(
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
}

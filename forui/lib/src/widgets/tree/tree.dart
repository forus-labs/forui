import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tree.design.dart';

/// A hierarchical tree widget for displaying nested data with visual connecting lines.
///
/// The [FTree] widget is useful for creating tree-like structures such as file explorers, organization charts,
/// or any hierarchical data representation.
///
/// See:
/// * https://forui.dev/docs/data/tree for working examples.
/// * [FTreeStyle] for customizing a tree's appearance.
/// * [FTreeItem] for creating individual tree nodes.
class FTree extends StatelessWidget {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tree
  /// ```
  final FTreeStyle Function(FTreeStyle style)? style;

  /// The root-level tree items.
  final List<Widget> children;

  /// Creates a [FTree].
  const FTree({required this.children, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.treeStyle) ?? context.theme.treeStyle;

    return FTreeData(
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: style.spacing,
        children: children,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FTree]'s data.
@internal
class FTreeData extends InheritedWidget {
  /// Returns the [FTreeData] of the [FTree] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FTree] in the given [context].
  static FTreeData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FTreeData>();

  /// The [FTree]'s style.
  final FTreeStyle style;

  /// Creates a [FTreeData].
  const FTreeData({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FTreeData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FTree]'s style.
class FTreeStyle with Diagnosticable, _$FTreeStyleFunctions {
  /// The spacing between root-level tree items. Defaults to 2.
  @override
  final double spacing;

  /// The indentation for each nesting level. Defaults to 20.
  @override
  final double indentWidth;

  /// The item's style.
  @override
  final FTreeItemStyle itemStyle;

  /// Creates a [FTreeStyle].
  const FTreeStyle({
    required this.itemStyle,
    this.spacing = 2,
    this.indentWidth = 20,
  });

  /// Creates a [FTreeStyle] that inherits its properties.
  FTreeStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        itemStyle: FTreeItemStyle.inherit(colors: colors, typography: typography, style: style),
      );
}

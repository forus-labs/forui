import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// The divider between items in a container.
enum FItemDivider {
  /// Represents a divider that spans the entire item horizontally.
  full,

  /// Represents a divider that partially spans the item horizontally.
  ///
  /// A item is always responsible for the divider
  /// directly below it.
  ///
  /// For [FItem.new], the divider spans from the title's left edge to the item's right edge. It is always aligned to
  /// the title of the item above the divider.
  /// ```diagram
  /// -----------------------------
  /// | [prefix] [title]          | <- Item A
  /// |          ---------------- |
  /// | [title]                   | <- Item B
  /// -----------------------------
  ///
  /// // TODO: FItem.raw
  /// ```
  indented,

  /// No divider between items.
  none,
}

/// A [FItemContainerData] is used to provide data about the item container, i.e. [FTileGroup], to its children.
///
/// Users that wish to create their own custom container should pass additional data to the children using a separate
/// inherited widget.
final class FItemContainerData extends InheritedWidget {
  /// Returns the [FItemContainerData] in the given [context].
  static FItemContainerData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FItemContainerData>();

  /// The divider's style.
  final FWidgetStateMap<FDividerStyle>? dividerStyle;

  /// The divider used to visually separate the different item containers.
  final FItemDivider divider;

  /// True if the container is enabled.
  final bool enabled;

  /// The container's index.
  final int index;

  /// The number of item containers.
  final int length;

  /// Returns the [FItemContainerData] in the given [context], or a default [FItemContainerData] if none is found.
  factory FItemContainerData.of(BuildContext context) =>
      maybeOf(context) ??
      const FItemContainerData(
        dividerStyle: null,
        divider: FItemDivider.none,
        enabled: true,
        index: 0,
        length: 1,
        child: SizedBox(),
      );

  /// Creates a [FItemContainerData].
  const FItemContainerData({
    required this.dividerStyle,
    required this.divider,
    required this.enabled,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FItemContainerData old) =>
      divider != old.divider || enabled != old.enabled || index != old.index || length != old.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length));
  }
}

/// A [FItemContainerItemData] is used to provide data about an item in the context of a container, i.e. [FTileGroup].
///
/// Users that wish to create their own custom container should pass additional data to the children using a separate
/// inherited widget.
final class FItemContainerItemData extends InheritedWidget {
  /// Returns the [FItemContainerItemData] in the given [context].
  static FItemContainerItemData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FItemContainerItemData>();

  /// The item's style.
  final FItemStyle style;

  /// The divider used to visually separate the different [FItem]s.
  final FItemDivider divider;

  /// The item's index in the item container.
  final int index;

  /// True if the item is the last in the item container.
  final bool last;

  /// Returns the [FItemContainerItemData] in the given [context], or a default [FItemContainerItemData] if none is found.
  factory FItemContainerItemData.of(BuildContext context) =>
      maybeOf(context) ??
      FItemContainerItemData(
        style: context.theme.itemStyle,
        divider: FItemDivider.none,
        index: 0,
        last: true,
        child: const SizedBox(),
      );

  /// Creates a [FItemContainerItemData].
  const FItemContainerItemData({
    required this.style,
    required this.divider,
    required this.index,
    required this.last,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FItemContainerItemData old) =>
      style != old.style || divider != old.divider || index != old.index || last != old.last;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(IntProperty('index', index))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  /// ```
  ///
  /// For [FItem.raw], the divider spans from the child's left edge to the item's right edge. It is always aligned to
  /// the child of the item above the divider.
  /// ```diagram
  /// -----------------------------
  /// | [prefix] [child]          | <- Item A
  /// |          ---------------- |
  /// | [child]                   | <- Item B
  /// -----------------------------
  indented,

  /// No divider between items.
  none,
}

/// A [FItemContainerData] is used to provide data about the item container, i.e. [FTileGroup], to its children.
///
/// Users that wish to create their own custom container should pass additional data to the children using a separate
/// inherited widget.
final class FItemContainerData extends InheritedWidget {
  /// The divider's style.
  final FWidgetStateMap<Color> dividerColor;

  /// The divider's width.
  final double dividerWidth;

  /// The divider used to visually separate the different item containers.
  final FItemDivider divider;

  /// True if the container is enabled.
  final bool enabled;

  /// The container's index.
  final int index;

  /// The number of item containers.
  final int length;

  /// Creates a [FItemContainerData].
  const FItemContainerData({
    required this.dividerColor,
    required this.dividerWidth,
    required this.divider,
    required this.enabled,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  });

  /// Creates a [FItemContainerData] that merges the given fields with the current [FItemContainerData].
  static Widget merge({
    required Widget child,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    FItemDivider? divider,
    bool? enabled,
    int? index,
    int? length,
  }) => Builder(
    builder: (context) {
      final FItemContainerData? parent = maybeOf(context);
      return FItemContainerData(
        dividerColor: dividerColor ?? parent?.dividerColor ?? FWidgetStateMap.all(Colors.transparent),
        dividerWidth: dividerWidth ?? parent?.dividerWidth ?? 0,
        divider: divider ?? parent?.divider ?? FItemDivider.none,
        enabled: enabled ?? parent?.enabled ?? true,
        index: index ?? parent?.index ?? 0,
        length: length ?? parent?.length ?? 1,
        child: child,
      );
    },
  );

  /// Returns the [FItemContainerData] in the given [context].
  static FItemContainerData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FItemContainerData>();

  /// Returns the [FItemContainerData] in the given [context], or a default [FItemContainerData] if none is found.
  factory FItemContainerData.of(BuildContext context) =>
      maybeOf(context) ??
      FItemContainerData(
        dividerColor: FWidgetStateMap.all(Colors.transparent),
        dividerWidth: 0,
        divider: FItemDivider.none,
        enabled: true,
        index: 0,
        length: 1,
        child: const SizedBox(),
      );

  @override
  bool updateShouldNotify(FItemContainerData old) =>
      divider != old.divider || enabled != old.enabled || index != old.index || length != old.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
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

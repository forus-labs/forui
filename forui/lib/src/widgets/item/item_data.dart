import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';

/// The divider between items in a group.
enum FItemDivider {
  /// Represents a divider that horizontally spans the entire item.
  full,

  /// Represents a divider that partially spans the item horizontally.
  ///
  /// An item is always responsible for the divider directly below it.
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

/// An [FInheritedItemData] is used to provide data about the item's position in the current nesting level, i.e. [FTileGroup].
///
/// Users that wish to create their own custom group should pass additional data to the children using a separate
/// inherited widget.
final class FInheritedItemData extends InheritedWidget {
  /// Returns the [FItemData] in the given [context].
  static FItemData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FInheritedItemData>()?.data;

  /// The item's properties.
  final FItemData? data;

  /// Creates a [FInheritedItemData].
  const FInheritedItemData({required super.child, this.data, super.key});

  /// Creates a [FInheritedItemData] that merges the given fields with the current [FInheritedItemData].
  static Widget merge({
    required bool last,
    required Widget child,
    FItemStyle? style,
    double? spacing,
    FItemDivider? divider,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    bool? enabled,
    int? index,
  }) => Builder(
    builder: (context) {
      final parent = maybeOf(context);
      final globalLast = last && (parent?.globalLast ?? true);

      return FInheritedItemData(
        data: FItemData(
          style: style ?? parent?.style,
          spacing: max(spacing ?? 0, parent?.spacing ?? 0),
          dividerColor: dividerColor ?? parent?.dividerColor ?? FWidgetStateMap.all(Colors.transparent),
          dividerWidth: dividerWidth ?? parent?.dividerWidth ?? 0,
          divider: switch ((last, globalLast)) {
            // The first/middle items of a group.
            (false, false) => divider ?? FItemDivider.none,
            // Last of a group which itself isn't the last.
            // propagatedLast can only be false if parent?.last is false since last must always be true.
            // Hence, parent!.divider can never be null.
            (true, false) => parent!.divider,
            // The last item in the last group.
            (_, true) => FItemDivider.none,
          },
          enabled: enabled ?? parent?.enabled ?? true,
          index: index ?? parent?.index ?? 0,
          last: last,
          globalLast: globalLast,
        ),
        child: child,
      );
    },
  );

  @override
  bool updateShouldNotify(FInheritedItemData old) => data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('data', data));
  }
}

/// The item's data.
final class FItemData with Diagnosticable {
  /// The item's style.
  final FItemStyle? style;

  /// The vertical spacing at the top and bottom of each level.
  final double spacing;

  /// The divider's style.
  final FWidgetStateMap<Color> dividerColor;

  /// The divider's width.
  final double dividerWidth;

  /// The divider used to visually separate the different items.
  final FItemDivider divider;

  /// True if enabled.
  final bool enabled;

  /// The item's index in the current nesting level.
  final int index;

  /// True if the item is the last item in the current nesting level.
  final bool last;

  /// True if the item is the last item across all levels.
  final bool globalLast;

  /// Creates a new [FItemData].
  const FItemData({
    this.style,
    this.spacing = 0,
    this.dividerColor = const FWidgetStateMap({WidgetState.any: Colors.transparent}),
    this.dividerWidth = 0,
    this.divider = FItemDivider.none,
    this.enabled = true,
    this.index = 0,
    this.last = true,
    this.globalLast = true,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(IntProperty('index', index))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'))
      ..add(FlagProperty('globalLast', value: globalLast, ifTrue: 'globalLast'));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FItemData &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          spacing == other.spacing &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          divider == other.divider &&
          enabled == other.enabled &&
          index == other.index &&
          last == other.last &&
          globalLast == other.globalLast;

  @override
  int get hashCode =>
      Object.hash(style, spacing, dividerColor, dividerWidth, divider, enabled, index, last, globalLast);
}

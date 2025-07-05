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

/// An [FItemData] is used to provide data about the item's position in the current nesting level, i.e. [FTileGroup].
///
/// Users that wish to create their own custom group should pass additional data to the children using a separate
/// inherited widget.
final class FItemData extends InheritedWidget {
  /// The item's style.
  final FItemStyle? style;

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

  /// True if the item is the last item across all levels.
  final bool last;

  /// Creates a [FItemData].
  const FItemData({
    required this.style,
    required this.dividerColor,
    required this.dividerWidth,
    required this.divider,
    required this.enabled,
    required this.index,
    required this.last,
    required super.child,
    super.key,
  });

  /// Creates a [FItemData] that merges the given fields with the current [FItemData].
  static Widget merge({
    required bool last,
    required Widget child,
    FItemStyle? style,
    FItemDivider? divider,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    bool? enabled,
    int? index,
  }) => Builder(
    builder: (context) {
      final parent = context.dependOnInheritedWidgetOfExactType<FItemData>();
      final propagatedLast = last && (parent?.last ?? true);

      return FItemData(
        style: style ?? parent?.style,
        dividerColor: dividerColor ?? parent?.dividerColor ?? FWidgetStateMap.all(Colors.transparent),
        dividerWidth: dividerWidth ?? parent?.dividerWidth ?? 0,
        divider: switch ((last, propagatedLast)) {
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
        last: propagatedLast,
        child: child,
      );
    },
  );

  /// Returns the [FItemData] in the given [context].
  static FItemData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FItemData>();

  /// Returns the [FItemData] in the given [context], or a default [FItemData] if none is found.
  factory FItemData.of(BuildContext context) =>
      maybeOf(context) ??
      FItemData(
        style: null,
        dividerColor: FWidgetStateMap.all(Colors.transparent),
        dividerWidth: 0,
        divider: FItemDivider.none,
        enabled: true,
        index: 0,
        last: true,
        child: const SizedBox(),
      );

  @override
  bool updateShouldNotify(FItemData old) =>
      style != old.style ||
      dividerColor != old.dividerColor ||
      dividerWidth != old.dividerWidth ||
      divider != old.divider ||
      enabled != old.enabled ||
      index != old.index ||
      last != old.last;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(IntProperty('index', index))
      ..add(FlagProperty('last', value: last, ifTrue: 'last'));
  }
}

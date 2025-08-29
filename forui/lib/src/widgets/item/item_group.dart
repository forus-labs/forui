import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'item_group.design.dart';

/// A marker interface which denotes that mixed-in widgets can group items and be used in a [FItemGroup.merge].
mixin FItemGroupMixin on Widget {}

/// An item group that groups multiple [FItemMixin]s together.
///
/// Items grouped together will be separated by a divider, specified by [divider].
///
/// ## Using [FItemGroup] in a [FPopover] when wrapped in a [FItemGroup]
/// When a [FPopover] is used inside an [FItemGroup], items & groups inside the popover will inherit styling from the
/// parent group. This happens because [FPopover]'s content shares the same `BuildContext` as its child, causing data
/// inheritance that may lead to unexpected rendering issues.
///
/// To prevent this styling inheritance, wrap the popover in a [FInheritedItemData] with null data to reset the
/// inherited data:
/// ```dart
/// FItemGroup(
///   children: [
///     FItem(title: Text('Item with popover')),
///     FPopoverWrapperItem(
///       popoverBuilder: (_, _) => FInheritedItemData(
///         child: FItemGroup(
///           children: [
///             FItem(title: Text('Popover Item 1')),
///             FItem(title: Text('Popover Item 2')),
///           ],
///         ),
///       ),
///       child: FButton(child: Text('Open Popover')),
///     ),
///   ],
/// );
/// ```
///
///
/// See:
/// * https://forui.dev/docs/data/item-group for working examples.
/// * [FItemGroupStyle] for customizing a item group's appearance.
class FItemGroup extends StatelessWidget with FItemGroupMixin {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create item-group
  /// ```
  final FItemGroupStyle Function(FItemGroupStyle style)? style;

  /// {@template forui.widgets.FItemGroup.scrollController}
  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behavior.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  /// {@endtemplate}
  final ScrollController? scrollController;

  /// {@template forui.widgets.FItemGroup.cacheExtent}
  /// The scrollable area's cache extent in logical pixels.
  ///
  /// Items that fall in this cache area are laid out even though they are not (yet) visible on screen. It describes
  /// how many pixels the cache area extends before the leading edge and after the trailing edge of the viewport.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  /// {@endtemplate}
  final double? cacheExtent;

  /// {@template forui.widgets.FItemGroup.maxHeight}
  /// The max height, in logical pixels. Defaults to infinity.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [maxHeight] is not positive.
  /// {@endtemplate}
  final double maxHeight;

  /// {@template forui.widgets.FItemGroup.dragStartBehavior}
  /// Determines the way that drag start behavior is handled. Defaults to [DragStartBehavior.start].
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  /// {@template forui.widgets.FItemGroup.physics}
  /// The scroll physics of the group. Defaults to [ClampingScrollPhysics].
  /// {@endtemplate}
  final ScrollPhysics physics;

  /// {@template forui.widgets.FItemGroup.divider}
  /// The divider between items.
  /// {@endtemplate}
  ///
  /// Defaults to [FItemDivider.indented].
  final FItemDivider divider;

  /// True if the group is enabled. Defaults to true.
  final bool? enabled;

  /// The group's semantic label.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  final String? semanticsLabel;

  /// The delegate that builds the sliver children.
  // ignore: avoid_positional_boolean_parameters
  final Widget Function(FItemGroupStyle style, bool enabled) _builder;

  /// Creates a [FItemGroup].
  FItemGroup({
    required List<FItemMixin> children,
    this.style,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = FItemDivider.none,
    this.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled) => SliverList.list(
         children: [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               style: style.itemStyle,
               spacing: style.spacing,
               enabled: enabled,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: index == children.length - 1,
               child: child,
             ),
         ],
       ));

  /// Creates a [FItemGroup] that lazily builds its children.
  ///
  /// {@template forui.widgets.FItemGroup.builder}
  /// The [itemBuilder] is called for each item that should be built. The current level's [FInheritedItemData] is **not**
  /// visible to `itemBuilder`.
  /// * It may return null to signify the end of the group.
  /// * It may be called more than once for the same index.
  /// * It will be called only for indices <= [count] if [count] is given.
  ///
  /// The [count] is the number of items to build. If null, [itemBuilder] will be called until it returns null.
  ///
  /// ## Notes
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e. [Column].
  /// * [count] is null and [itemBuilder] always provides a zero-size widget, i.e. SizedBox(). If possible, provide
  ///   items with non-zero size, return null from builder, or set [count] to non-null.
  /// {@endtemplate}
  FItemGroup.builder({
    required NullableIndexedWidgetBuilder itemBuilder,
    int? count,
    this.style,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = FItemDivider.none,
    this.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       assert(count == null || 0 <= count, 'count ($count) must be >= 0'),
       _builder = ((style, enabled) => SliverList.builder(
         itemCount: count,
         itemBuilder: (context, index) {
           if (itemBuilder(context, index) case final item?) {
             return FInheritedItemData.merge(
               style: style.itemStyle,
               spacing: style.spacing,
               enabled: enabled,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: (count != null && index == count - 1) || itemBuilder(context, index + 1) == null,
               child: item,
             );
           }

           return null;
         },
       ));

  /// Creates a [FItemGroup] that merges multiple [FItemGroupMixin]s together.
  ///
  /// All group labels will be ignored.
  FItemGroup.merge({
    required List<FItemGroupMixin> children,
    this.style,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = FItemDivider.full,
    this.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled) => SliverMainAxisGroup(
         slivers: [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               style: style.itemStyle,
               spacing: style.spacing,
               enabled: enabled,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: index == children.length - 1,
               child: child,
             ),
         ],
       ));

  @override
  Widget build(BuildContext context) {
    final data = FInheritedItemData.maybeOf(context);
    final inheritedStyle = FItemGroupStyleData.of(context);
    final style = this.style?.call(inheritedStyle) ?? inheritedStyle;
    final enabled = this.enabled ?? data?.enabled ?? true;

    final sliver = _builder(style, enabled);
    if (data != null) {
      return sliver;
    }

    return Semantics(
      container: true,
      label: semanticsLabel,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        // We use a Container instead of DecoratedBox as using a DecoratedBox will cause the border to be clipped.
        // ignore: use_decorated_box
        child: Container(
          decoration: style.decoration,
          child: ClipRRect(
            borderRadius:
                style.decoration.borderRadius?.resolve(Directionality.maybeOf(context) ?? TextDirection.ltr) ??
                BorderRadius.zero,
            child: FItemGroupStyleData(
              style: style,
              child: CustomScrollView(
                controller: scrollController,
                cacheExtent: cacheExtent,
                dragStartBehavior: dragStartBehavior,
                shrinkWrap: true,
                physics: physics,
                slivers: [sliver],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', scrollController))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticsLabel', semanticsLabel));
  }
}

/// An inherited widget that provides the [FItemGroupStyle] to its descendants.
class FItemGroupStyleData extends InheritedWidget {
  /// Returns the [FItemGroupStyle] in the given [context], or null if none is found.
  static FItemGroupStyle? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FItemGroupStyleData>()?.style;

  /// Returns the [FItemGroupStyle] in the given [context].
  static FItemGroupStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FItemGroupStyleData>()?.style ?? context.theme.itemGroupStyle;

  /// The style of the group.
  final FItemGroupStyle style;

  /// Creates a [FItemGroupStyleData].
  const FItemGroupStyleData({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FItemGroupStyleData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// An [FItemGroup]'s style.
class FItemGroupStyle with Diagnosticable, _$FItemGroupStyleFunctions {
  /// The group's decoration.
  @override
  final BoxDecoration decoration;

  /// The vertical spacing at the top and bottom of each group. Defaults to 4.
  @override
  final double spacing;

  /// The divider's style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  @override
  final FWidgetStateMap<Color> dividerColor;

  /// The divider's width.
  @override
  final double dividerWidth;

  /// The item's style.
  @override
  final FItemStyle itemStyle;

  /// Creates a [FItemGroupStyle].
  FItemGroupStyle({
    required this.dividerColor,
    required this.dividerWidth,
    required this.itemStyle,
    this.decoration = const BoxDecoration(),
    this.spacing = 4,
  });

  /// Creates a [FItemGroupStyle] that inherits from the given arguments.
  FItemGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        itemStyle: FItemStyle.inherit(colors: colors, typography: typography, style: style),
        dividerColor: FWidgetStateMap.all(colors.border),
        dividerWidth: style.borderWidth,
      );
}

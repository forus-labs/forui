import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

part 'item_group.style.dart';

/// A marker interface which denotes that mixed-in widgets can group items and be used in a [FTileGroup.merge].
mixin FItemGroupMixin<T extends Widget> on Widget {}

/// A item group that groups multiple [FItemMixin]s and [FItemGroupMixin]s together.
///
/// Items grouped together will be separated by a divider, specified by [divider].
///
/// See:
/// * https://forui.dev/docs/data/item-group for working examples.
/// * [FItemStyle] for customizing a tile's appearance.
class FItemGroup extends _Group {
  /// The delegate that builds the sliver children.
  final SliverChildDelegate Function(FItemGroupStyle) _delegate;

  /// Creates a [FItemGroup].
  FItemGroup({
    required List<FTileMixin> children,
    super.style,
    super.scrollController,
    super.cacheExtent,
    super.maxHeight,
    super.dragStartBehavior,
    super.physics,
    super.enabled,
    super.divider,
    super.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight must be positive.'),
       _delegate = ((style) => SliverChildListDelegate([
         for (final (index, child) in children.indexed)
           FItemContainerItemData(
             style: style.itemStyle,
             divider: divider,
             index: index,
             last: index == children.length - 1,
             child: child,
           ),
       ]));

  /// Creates a [FItemGroup] that lazily builds its children.
  ///
  /// {@template forui.widgets.FTileGroup.builder}
  /// The [itemBuilder] is called for each tile that should be built. [FItemContainerItemData] is **not** visible to
  /// `itemBuilder`.
  /// * It may return null to signify the end of the group.
  /// * It may be called more than once for the same index.
  /// * It will be called only for indices <= [count] if [count] is given.
  ///
  /// The [count] is the number of tiles to build. If null, [itemBuilder] will be called until it returns null.
  ///
  /// ## Notes
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e. [Column].
  /// * [count] is null and [itemBuilder] always provides a zero-size widget, i.e. SizedBox(). If possible, provide
  ///   tiles with non-zero size, return null from builder, or set [count] to non-null.
  /// {@endtemplate}
  FItemGroup.builder({
    required NullableIndexedWidgetBuilder itemBuilder,
    int? count,
    super.style,
    super.scrollController,
    super.cacheExtent,
    super.maxHeight,
    super.dragStartBehavior,
    super.physics,
    super.enabled,
    super.divider,
    super.semanticsLabel,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight must be positive.'),
       assert(count == null || 0 <= count, 'count must be non-negative.'),
       _delegate = ((style) => SliverChildBuilderDelegate((context, index) {
         if (itemBuilder(context, index) case final item?) {
           return FItemContainerItemData(
             style: style.itemStyle,
             divider: divider,
             index: index,
             last: (count != null && index == count - 1) || itemBuilder(context, index + 1) == null,
             child: item,
           );
         }

         return null;
       }, childCount: count));

  @override
  Widget build(BuildContext context) {
    final data = FItemContainerData.maybeOf(context);
    final inheritedStyle = _GroupStyle.maybeOf(context)?.style ?? context.theme.itemGroupStyle;
    final style = this.style?.call(inheritedStyle) ?? inheritedStyle;
    final enabled = this.enabled ?? data?.enabled ?? true;

    Widget sliver = SliverList(delegate: _delegate(style));
    if (data == null || this.style != null || (this.enabled != null && this.enabled != data.enabled)) {
      sliver = FItemContainerData(
        dividerColor: style.dividerColor,
        dividerWidth: style.dividerWidth,
        divider: data?.divider ?? FItemDivider.none,
        enabled: enabled,
        index: data?.index ?? 0,
        length: data?.length ?? 1,
        child: sliver,
      );
    }

    return data == null ? _scrollView(enabled, [sliver]) : sliver;
  }
}

abstract class _Group extends StatelessWidget {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create item-group
  /// ```
  final FItemGroupStyle Function(FItemGroupStyle)? style;

  /// {@template forui.widgets.FItemGroup.scrollController}
  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behaviour.
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
  /// The divider between tiles.
  /// {@endtemplate}
  ///
  /// Defaults to [FItemDivider.none].
  final FItemDivider divider;

  /// True if the group is enabled. Defaults to true.
  final bool? enabled;

  /// The group's semantic label.
  ///
  /// It is ignored if the group is part of a merged [FItemGroup].
  final String? semanticsLabel;

  const _Group({
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
  });

  Widget _scrollView(bool enabled, List<Widget> slivers) => Semantics(
    container: true,
    label: semanticsLabel,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: CustomScrollView(
        controller: scrollController,
        cacheExtent: cacheExtent,
        dragStartBehavior: dragStartBehavior,
        shrinkWrap: true,
        physics: physics,
        slivers: slivers,
      ),
    ),
  );

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

class _GroupStyle extends InheritedWidget {
  static _GroupStyle? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_GroupStyle>();

  final FItemGroupStyle style;

  const _GroupStyle({required this.style, required super.child});

  @override
  bool updateShouldNotify(_GroupStyle old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// An [FItemGroup]'s style.
class FItemGroupStyle with Diagnosticable, _$FItemGroupStyleFunctions {
  /// The divider's style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  @override
  final FWidgetStateMap<Color>? dividerColor;

  /// The divider's width.
  @override
  final double? dividerWidth;

  /// The tile's style.
  @override
  final FItemStyle itemStyle;

  /// Creates a [FItemGroupStyle].
  FItemGroupStyle({required this.itemStyle, required this.dividerColor, required this.dividerWidth});

  /// Creates a [FItemGroupStyle] that inherits from the given arguments.
  FItemGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        dividerColor: FWidgetStateMap.all(colors.border),
        dividerWidth: style.borderWidth,
        itemStyle: FItemStyle.inherit(colors: colors, typography: typography, style: style),
      );
}

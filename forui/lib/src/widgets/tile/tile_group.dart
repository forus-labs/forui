import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tile_group.style.dart';

/// A marker interface which denotes that mixed-in widgets can group tiles and be used in a [FTileGroup.merge].
mixin FTileGroupMixin<T extends Widget> on Widget {}

class _MergeTileGroups extends _Group with FTileGroupMixin<FTileGroupMixin<FItemMixin>> {
  final List<FTileGroupMixin> children;

  const _MergeTileGroups({
    required this.children,
    required super.style,
    required super.scrollController,
    required super.cacheExtent,
    required super.maxHeight,
    required super.dragStartBehavior,
    required super.physics,
    required super.enabled,
    required super.divider,
    required super.semanticsLabel,
    required super.label,
    required super.description,
    required super.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style?.call(context.theme.tileGroupStyle) ?? context.theme.tileGroupStyle;
    final enabled = this.enabled ?? true;

    return _label(
      context,
      style,
      true,
      enabled,
      _GroupStyle(
        style: style,
        child: _scrollView([
          for (final (index, child) in children.indexed)
            FItemContainerData(
              dividerStyle: style.dividerStyle,
              divider: divider,
              enabled: enabled,
              index: index,
              length: children.length,
              child: child,
            ),
        ]),
      ),
    );
  }
}

/// A tile group that groups multiple [FItemMixin]s and [FTileGroupMixin]s together.
///
/// Tiles grouped together will be separated by a divider, specified by [divider].
///
/// See:
/// * https://forui.dev/docs/tile/tile-group for working examples.
/// * [FTileGroupStyle] for customizing a tile's appearance.
class FTileGroup extends _Group with FTileGroupMixin<FItemMixin> {
  /// The delegate that builds the sliver children.
  final SliverChildDelegate Function(FTileGroupStyle) _delegate;

  /// Creates a [FTileGroup] that merges multiple [FTileGroupMixin]s together.
  ///
  /// All group labels will be ignored.
  static FTileGroupMixin<FTileGroupMixin<FItemMixin>> merge({
    required List<FTileGroupMixin<FItemMixin>> children,
    FTileGroupStyle Function(FTileGroupStyle)? style,
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight = double.infinity,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    bool enabled = true,
    FItemDivider divider = FItemDivider.full,
    String? semanticsLabel,
    Widget? label,
    Widget? description,
    Widget? error,
    Key? key,
  }) => _MergeTileGroups(
    key: key,
    style: style,
    scrollController: scrollController,
    cacheExtent: cacheExtent,
    maxHeight: maxHeight,
    dragStartBehavior: dragStartBehavior,
    physics: physics,
    enabled: enabled,
    divider: divider,
    semanticsLabel: semanticsLabel,
    label: label,
    description: description,
    error: error,
    children: children,
  );

  /// Creates a [FTileGroup].
  FTileGroup({
    required List<FItemMixin> children,
    super.style,
    super.scrollController,
    super.cacheExtent,
    super.maxHeight = double.infinity,
    super.dragStartBehavior = DragStartBehavior.start,
    super.physics = const ClampingScrollPhysics(),
    super.enabled,
    super.divider = FItemDivider.indented,
    super.semanticsLabel,
    super.label,
    super.description,
    super.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight must be positive.'),
       _delegate = ((style) => SliverChildListDelegate([
         for (final (index, child) in children.indexed)
           FItemContainerItemData(
             style: style.tileStyle,
             divider: divider,
             index: index,
             last: index == children.length - 1,
             child: child,
           ),
       ]));

  /// Creates a [FTileGroup] that lazily builds its children.
  ///
  /// {@template forui.widgets.FTileGroup.builder}
  /// The [tileBuilder] is called for each tile that should be built. [FItemContainerItemData] is **not** visible to `tileBuilder`.
  /// * It may return null to signify the end of the group.
  /// * It may be called more than once for the same index.
  /// * It will be called only for indices <= [count] if [count] is given.
  ///
  /// The [count] is the number of tiles to build. If null, [tileBuilder] will be called until it returns null.
  ///
  /// ## Notes
  /// May result in an infinite loop or run out of memory if:
  /// * Placed in a parent widget that does not constrain its size, i.e. [Column].
  /// * [count] is null and [tileBuilder] always provides a zero-size widget, i.e. SizedBox(). If possible, provide
  ///   tiles with non-zero size, return null from builder, or set [count] to non-null.
  /// {@endtemplate}
  FTileGroup.builder({
    required NullableIndexedWidgetBuilder tileBuilder,
    int? count,
    super.style,
    super.scrollController,
    super.cacheExtent,
    super.maxHeight = double.infinity,
    super.dragStartBehavior = DragStartBehavior.start,
    super.physics = const ClampingScrollPhysics(),
    super.enabled,
    super.divider = FItemDivider.indented,
    super.semanticsLabel,
    super.label,
    super.description,
    super.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight must be positive.'),
       assert(count == null || 0 <= count, 'count must be non-negative.'),
       _delegate = ((style) => SliverChildBuilderDelegate((context, index) {
         final tile = tileBuilder(context, index);
         return tile == null
             ? null
             : FItemContainerItemData(
                 style: style.tileStyle,
                 divider: divider,
                 index: index,
                 last: (count != null && index == count - 1) || tileBuilder(context, index + 1) == null,
                 child: tile,
               );
       }, childCount: count));

  @override
  Widget build(BuildContext context) {
    final data = FItemContainerData.maybeOf(context);
    final inheritedStyle = _GroupStyle.maybeOf(context)?.style ?? context.theme.tileGroupStyle;
    final style = this.style?.call(inheritedStyle) ?? inheritedStyle;
    final enabled = this.enabled ?? data?.enabled ?? true;

    Widget sliver = SliverList(delegate: _delegate(style));
    if (data == null || this.style != null || (this.enabled != null && this.enabled != data.enabled)) {
      sliver = FItemContainerData(
        dividerStyle: style.dividerStyle,
        divider: data?.divider ?? FItemDivider.none,
        enabled: enabled,
        index: data?.index ?? 0,
        length: data?.length ?? 1,
        child: sliver,
      );
    }

    return data == null ? _label(context, style, data == null, enabled, _scrollView([sliver])) : sliver;
  }
}

abstract class _Group extends StatelessWidget {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tile-group
  /// ```
  final FTileGroupStyle Function(FTileGroupStyle)? style;

  /// {@template forui.widgets.FTileGroup.scrollController}
  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behaviour.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  /// {@endtemplate}
  final ScrollController? scrollController;

  /// {@template forui.widgets.FTileGroup.cacheExtent}
  /// The scrollable area's cache extent in logical pixels.
  ///
  /// Items that fall in this cache area are laid out even though they are not (yet) visible on screen. It describes
  /// how many pixels the cache area extends before the leading edge and after the trailing edge of the viewport.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  /// {@endtemplate}
  final double? cacheExtent;

  /// {@template forui.widgets.FTileGroup.maxHeight}
  /// The max height, in logical pixels. Defaults to infinity.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [maxHeight] is not positive.
  /// {@endtemplate}
  final double maxHeight;

  /// {@template forui.widgets.FTileGroup.dragStartBehavior}
  /// Determines the way that drag start behavior is handled. Defaults to [DragStartBehavior.start].
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  /// {@template forui.widgets.FTileGroup.physics}
  /// The scroll physics of the group. Defaults to [ClampingScrollPhysics].
  /// {@endtemplate}
  final ScrollPhysics physics;

  /// {@template forui.widgets.FTileGroup.divider}
  /// The divider between tiles.
  /// {@endtemplate}
  ///
  /// Defaults to [FItemDivider.indented].
  final FItemDivider divider;

  /// True if the group is enabled. Defaults to true.
  final bool? enabled;

  /// The group's semantic label.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  final String? semanticsLabel;

  /// The label above the group.
  ///
  /// It is not rendered if the group is disabled or part of a merged [FTileGroup].
  final Widget? label;

  /// The description below the group.
  ///
  /// It is not rendered if the group is disabled or part of a merged [FTileGroup].
  final Widget? description;

  /// The error below the [description].
  ///
  /// It is not rendered if the group is disabled or part of a merged [FTileGroup].
  final Widget? error;

  const _Group({
    this.style,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = FItemDivider.indented,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  });

  Widget _label(BuildContext context, FTileGroupStyle style, bool root, bool enabled, Widget child) => FLabel(
    style: style,
    axis: Axis.vertical,
    states: {if (!enabled) WidgetState.disabled, if (error != null) WidgetState.error},
    label: label,
    description: description,
    error: error,
    child: Semantics(
      container: true,
      label: semanticsLabel,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        // We use a Container instead of DecoratedBox as using a DecoratedBox will cause the border to be clipped.
        // ignore: use_decorated_box
        child: Container(
          decoration: root ? BoxDecoration(border: style.border, borderRadius: style.borderRadius) : null,
          child: ClipRRect(borderRadius: style.borderRadius, child: child),
        ),
      ),
    ),
  );

  Widget _scrollView(List<Widget> slivers) => CustomScrollView(
    controller: scrollController,
    cacheExtent: cacheExtent,
    dragStartBehavior: dragStartBehavior,
    shrinkWrap: true,
    physics: physics,
    slivers: slivers,
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

  final FTileGroupStyle style;

  const _GroupStyle({required this.style, required super.child});

  @override
  bool updateShouldNotify(_GroupStyle old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FTileGroup]'s style.
class FTileGroupStyle extends FLabelStyle with _$FTileGroupStyleFunctions {
  /// The group's border.
  ///
  /// ## Note
  /// If wrapped in a [FTileGroup], this [border] is ignored. Configure the nesting [FTileGroupStyle] instead.
  @override
  final Border border;

  /// The group's border radius.
  @override
  final BorderRadiusGeometry borderRadius;

  /// The tile's style.
  @override
  final FTileStyle tileStyle;

  /// The tile's divider.
  @override
  final FWidgetStateMap<FDividerStyle> dividerStyle;

  /// Creates a [FTileGroupStyle].
  FTileGroupStyle({
    required this.border,
    required this.borderRadius,
    required this.tileStyle,
    required this.dividerStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    super.labelPadding = const EdgeInsets.symmetric(vertical: 7.7),
    super.descriptionPadding = const EdgeInsets.only(top: 7.5),
    super.errorPadding = const EdgeInsets.only(top: 5),
    super.childPadding,
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  factory FTileGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style}) {
    final tileStyle = FTileStyle.inherit(colors: colors, typography: typography, style: style);
    return FTileGroupStyle(
      border: Border.all(color: colors.border, width: style.borderWidth),
      borderRadius: style.borderRadius,
      tileStyle: tileStyle.copyWith(
        decoration: tileStyle.decoration.map(
          (d) => BoxDecoration(
            color: d.color,
            image: d.image,
            boxShadow: d.boxShadow,
            gradient: d.gradient,
            backgroundBlendMode: d.backgroundBlendMode,
            shape: d.shape,
          ),
        ),
      ),
      dividerStyle: FWidgetStateMap.all(
        FDividerStyle(color: colors.border, width: style.borderWidth, padding: EdgeInsets.zero),
      ),
      labelTextStyle: FWidgetStateMap({
        WidgetState.error: typography.base.copyWith(
          color: style.formFieldStyle.labelTextStyle.maybeResolve({})?.color ?? colors.primary,
          fontWeight: FontWeight.w600,
        ),
        WidgetState.disabled: typography.base.copyWith(
          color:
              style.formFieldStyle.labelTextStyle.maybeResolve({WidgetState.disabled})?.color ??
              colors.disable(colors.primary),
          fontWeight: FontWeight.w600,
        ),
        WidgetState.any: typography.base.copyWith(
          color: style.formFieldStyle.labelTextStyle.maybeResolve({})?.color ?? colors.primary,
          fontWeight: FontWeight.w600,
        ),
      }),
      descriptionTextStyle: style.formFieldStyle.descriptionTextStyle.map(
        (s) => typography.xs.copyWith(color: s.color),
      ),
      errorTextStyle: typography.xs.copyWith(color: style.formFieldStyle.errorTextStyle.color),
    );
  }
}

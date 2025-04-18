import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tile_group.style.dart';

/// A marker interface which denotes that mixed-in widgets can group tiles and be used in a [_MergeTileGroups].
mixin FTileGroupMixin<T extends Widget> on Widget {}

/// A tile group that groups multiple [FTileMixin]s and [FTileGroupMixin]s together.
///
/// Tiles grouped together will be separated by a divider, specified by [divider].
///
/// See:
/// * https://forui.dev/docs/tile/tile-group for working examples.
/// * [FTileGroupStyle] for customizing a tile's appearance.
class FTileGroup extends StatelessWidget with FTileGroupMixin<FTileMixin> {
  /// The style.
  final FTileGroupStyle? style;

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
  /// Defaults to [FTileDivider.indented].
  final FTileDivider divider;

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

  /// The delegate.
  final SliverChildDelegate Function(FTileStyle style, {required bool enabled}) delegate;

  /// Creates a [FTileGroup] that merges multiple [FTileGroupMixin]s together.
  ///
  /// All group labels will be ignored.
  static FTileGroupMixin<FTileGroupMixin<FTileMixin>> merge({
    required List<FTileGroupMixin<FTileMixin>> children,
    FTileGroupStyle? style,
    ScrollController? scrollController,
    double? cacheExtent,
    double maxHeight = double.infinity,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollPhysics physics = const ClampingScrollPhysics(),
    bool enabled = true,
    FTileDivider divider = FTileDivider.full,
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
    required List<FTileMixin> children,
    this.style,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = FTileDivider.indented,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight must be positive.'),
       delegate =
           ((style, {required enabled}) => SliverChildListDelegate([
             for (final (index, child) in children.indexed)
               FTileData(
                 style: style,
                 divider: divider,
                 states: {if (!enabled) WidgetState.disabled},
                 index: index,
                 last: index == children.length - 1,
                 child: child,
               ),
           ]));

  /// Creates a [FTileGroup] that lazily builds its children.
  ///
  /// {@template forui.widgets.FTileGroup.builder}
  /// The [tileBuilder] is called for each tile that should be built. [FTileData] is **not** visible to `tileBuilder`.
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
    this.style,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = FTileDivider.indented,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight must be positive.'),
       assert(count == null || 0 <= count, 'count must be non-negative.'),
       delegate =
           ((style, {required enabled}) => SliverChildBuilderDelegate((context, index) {
             final tile = tileBuilder(context, index);
             if (tile == null) {
               return null;
             }

             return FTileData(
               style: style,
               divider: divider,
               states: {if (!enabled) WidgetState.disabled},
               index: index,
               last: (count != null && index == count - 1) || tileBuilder(context, index + 1) == null,
               child: tile,
             );
           }, childCount: count));

  @override
  Widget build(BuildContext context) {
    final data = FTileGroupData.maybeOf(context);
    final style = this.style ?? data?.style ?? context.theme.tileGroupStyle;
    final enabled = this.enabled ?? !(data?.states.contains(WidgetState.disabled) ?? false);

    // The only shard state between a tile group and tile is [WidgetState.disabled].
    final sliver = SliverList(delegate: delegate(style.tileStyle, enabled: enabled));

    if (data == null) {
      return FLabel(
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
            child: ClipRRect(
              borderRadius: style.borderRadius,
              child: FFocusedOutline(
                focused: true,
                style: FFocusedOutlineStyle(
                  color: style.borderColor,
                  width: style.borderWidth,
                  borderRadius: style.borderRadius,
                  spacing: 0,
                ),
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

    return sliver;
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
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(ObjectFlagProperty.has('delegate', delegate));
  }
}

class _MergeTileGroups extends StatelessWidget with FTileGroupMixin<FTileGroupMixin<FTileMixin>> {
  final FTileGroupStyle? style;
  final ScrollController? scrollController;
  final double? cacheExtent;
  final double maxHeight;
  final DragStartBehavior dragStartBehavior;
  final ScrollPhysics physics;
  final bool enabled;
  final FTileDivider divider;
  final String? semanticsLabel;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final List<FTileGroupMixin> children;

  const _MergeTileGroups({
    required this.children,
    required this.style,
    required this.scrollController,
    required this.cacheExtent,
    required this.maxHeight,
    required this.dragStartBehavior,
    required this.physics,
    required this.enabled,
    required this.divider,
    required this.semanticsLabel,
    required this.label,
    required this.description,
    required this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.tileGroupStyle;
    final states = {if (!enabled) WidgetState.disabled, if (error != null) WidgetState.error};

    return FLabel(
      style: style,
      axis: Axis.vertical,
      states: states,
      label: label,
      description: description,
      error: error,
      child: Semantics(
        container: true,
        label: semanticsLabel,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: ClipRRect(
            borderRadius: style.borderRadius,
            child: FFocusedOutline(
              focused: true,
              style: FFocusedOutlineStyle(
                color: style.borderColor,
                width: style.borderWidth,
                borderRadius: style.borderRadius,
                spacing: 0,
              ),
              child: CustomScrollView(
                controller: scrollController,
                cacheExtent: cacheExtent,
                dragStartBehavior: dragStartBehavior,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  for (final (index, child) in children.indexed)
                    FTileGroupData(
                      style: style,
                      divider: divider,
                      states: states,
                      index: index,
                      length: children.length,
                      child: child,
                    ),
                ],
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

/// A [FTileGroup]'s style.
class FTileGroupStyle extends FLabelStyle with _$FTileGroupStyleFunctions {
  /// The group's border color.
  @override
  final Color borderColor;

  /// The group's border width.
  @override
  final double borderWidth;

  /// The group's border radius.
  @override
  final BorderRadiusGeometry borderRadius;

  /// The tile's style.
  @override
  final FTileStyle tileStyle;

  /// Creates a [FTileGroupStyle].
  FTileGroupStyle({
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.tileStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    super.labelPadding = const EdgeInsets.symmetric(vertical: 7.7),
    super.descriptionPadding = const EdgeInsets.only(top: 7.5),
    super.errorPadding = const EdgeInsets.only(top: 5),
    super.childPadding,
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  FTileGroupStyle.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        borderColor: colors.border,
        borderWidth: style.borderWidth,
        borderRadius: style.borderRadius,
        tileStyle: FTileStyle.inherit(colors: colors, typography: typography, style: style),
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

/// Extracts the data from the given [FTileGroupData].
@internal
({int index, int length, FTileDivider divider}) extractTileGroup(FTileGroupData? data) => (
  index: data?.index ?? 0,
  length: data?.length ?? 1,
  divider: data?.divider ?? FTileDivider.full,
);

/// A tile group's data.
class FTileGroupData extends InheritedWidget {
  /// Returns the [FTileGroupData] of the [FTile] in the given [context].
  ///
  /// ## Contract
  /// Throws [AssertionError] if there is no ancestor [FTile] in the given [context].
  static FTileGroupData? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<FTileGroupData>();

  /// The tile group's style.
  final FTileGroupStyle style;

  /// The divider if there are more than 1 tiles in the current group.
  final FTileDivider divider;

  /// The states.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  final Set<WidgetState> states;

  /// The group's index.
  final int index;

  /// The number of groups.
  final int length;

  /// Creates a [FTileGroupData].
  const FTileGroupData({
    required this.style,
    required this.divider,
    required this.states,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FTileGroupData old) =>
      style != old.style ||
      divider != old.divider ||
      !setEquals(states, old.states) ||
      index != old.index ||
      length != old.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(IterableProperty('states', states))
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length));
  }
}

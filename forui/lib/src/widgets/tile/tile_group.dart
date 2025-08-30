import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'tile_group.design.dart';

/// A marker interface which denotes that mixed-in widgets can group tiles and be used in a [FTileGroup.merge].
mixin FTileGroupMixin on Widget {}

/// A tile group that groups multiple [FTileMixin]s together.
///
/// Tiles grouped together will be separated by a divider, specified by [divider].
///
/// ## Using [FTileGroup] in a [FPopover] when wrapped in a [FTileGroup]
/// When a [FPopover] is used inside an [FTileGroup], tiles & groups inside the popover will inherit styling from the
/// parent group. This happens because [FPopover]'s content shares the same `BuildContext` as its child, causing data
/// inheritance that may lead to unexpected rendering issues.
///
/// To prevent this styling inheritance, wrap the popover in a [FInheritedItemData] with null data to reset the
/// inherited data:
/// ```dart
/// FTileGroup(
///   children: [
///     FTile(title: Text('Tile with popover')),
///     FPopoverWrapperTile(
///       popoverBuilder: (_, _) => FInheritedItemData(
///         child: FTileGroup(
///           children: [
///             FTile(title: Text('Popover Tile 1')),
///             FTile(title: Text('Popover Tile 2')),
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
/// * https://forui.dev/docs/tile/tile-group for working examples.
/// * [FTileGroupStyle] for customizing a tile group's appearance.
class FTileGroup extends StatelessWidget with FTileGroupMixin {
  /// The style.
  ///
  /// ## CLI
  /// To generate and customize this style:
  ///
  /// ```shell
  /// dart run forui style create tile-group
  /// ```
  final FTileGroupStyle Function(FTileGroupStyle style)? style;

  /// {@template forui.widgets.FTileGroup.scrollController}
  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behavior.
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

  /// The delegate that builds the sliver children.
  // ignore: avoid_positional_boolean_parameters
  final Widget Function(FTileGroupStyle style, bool scrollable) _builder;

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
    this.divider = FItemDivider.indented,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled) => SliverList.list(
         children: [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               style: style.tileStyle,
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

  /// Creates a [FTileGroup] that lazily builds its children.
  ///
  /// {@template forui.widgets.FTileGroup.builder}
  /// The [tileBuilder] is called for each tile that should be built. The current level's [FInheritedItemData] is **not**
  /// visible to `tileBuilder`.
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
    this.divider = FItemDivider.indented,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       assert(count == null || 0 <= count, 'count ($count) must be >= 0'),
       _builder = ((style, enabled) => SliverList.builder(
         itemCount: count,
         itemBuilder: (context, index) {
           if (tileBuilder(context, index) case final tile?) {
             return FInheritedItemData.merge(
               style: style.tileStyle,
               enabled: enabled,
               dividerColor: style.dividerColor,
               dividerWidth: style.dividerWidth,
               divider: divider,
               index: index,
               last: (count != null && index == count - 1) || tileBuilder(context, index + 1) == null,
               child: tile,
             );
           }

           return null;
         },
       ));

  /// Creates a [FTileGroup] that merges multiple [FTileGroupMixin]s together.
  ///
  /// All group labels will be ignored.
  FTileGroup.merge({
    required List<FTileGroupMixin> children,
    this.style,
    this.scrollController,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.enabled,
    this.divider = FItemDivider.full,
    this.semanticsLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  }) : assert(0 < maxHeight, 'maxHeight ($maxHeight) must be > 0'),
       _builder = ((style, enabled) => SliverMainAxisGroup(
         slivers: [
           for (final (index, child) in children.indexed)
             FInheritedItemData.merge(
               style: style.tileStyle,
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
    final inheritedStyle = FTileGroupStyleData.of(context);
    final style = this.style?.call(inheritedStyle) ?? inheritedStyle;
    final enabled = this.enabled ?? data?.enabled ?? true;

    final sliver = _builder(style, enabled);
    if (data != null) {
      return sliver;
    }

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
          // We use a Container instead of DecoratedBox as using a DecoratedBox will cause the border to be clipped.
          // ignore: use_decorated_box
          child: Container(
            decoration: style.decoration,
            child: ClipRRect(
              borderRadius: style.decoration.borderRadius ?? BorderRadius.zero,
              child: FTileGroupStyleData(
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

/// An inherited widget that provides the [FTileGroupStyle] to its descendants.
class FTileGroupStyleData extends InheritedWidget {
  /// Returns the [FTileGroupStyle] in the given [context], or null if none is found.
  static FTileGroupStyle? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FTileGroupStyleData>()?.style;

  /// Returns the [FTileGroupStyle] in the given [context].
  static FTileGroupStyle of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FTileGroupStyleData>()?.style ?? context.theme.tileGroupStyle;

  /// The style of the group.
  final FTileGroupStyle style;

  /// Creates a [FTileGroupStyleData].
  const FTileGroupStyleData({required this.style, required super.child, super.key});

  @override
  bool updateShouldNotify(FTileGroupStyleData old) => style != old.style;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('style', style));
  }
}

/// A [FTileGroup]'s style.
class FTileGroupStyle extends FLabelStyle with _$FTileGroupStyleFunctions {
  /// The group's decoration.
  @override
  final BoxDecoration decoration;

  /// The tile's style.
  @override
  final FTileStyle tileStyle;

  /// The divider's style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  @override
  final FWidgetStateMap<Color> dividerColor;

  /// The divider's width.
  @override
  final double dividerWidth;

  /// Creates a [FTileGroupStyle].
  FTileGroupStyle({
    required this.decoration,
    required this.tileStyle,
    required this.dividerColor,
    required this.dividerWidth,
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
      decoration: BoxDecoration(
        border: Border.all(color: colors.border, width: style.borderWidth),
        borderRadius: style.borderRadius,
      ),

      tileStyle: tileStyle.copyWith(
        decoration: tileStyle.decoration.map(
          (d) => d == null
              ? null
              : BoxDecoration(
                  color: d.color,
                  image: d.image,
                  boxShadow: d.boxShadow,
                  gradient: d.gradient,
                  backgroundBlendMode: d.backgroundBlendMode,
                  shape: d.shape,
                ),
        ),
      ),
      dividerColor: FWidgetStateMap.all(colors.border),
      dividerWidth: style.borderWidth,
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

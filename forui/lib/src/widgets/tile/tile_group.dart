import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

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

  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behaviour.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  final ScrollController? controller;

  /// The cache extent in logical pixels.
  ///
  /// Items that fall in this cache area are laid out even though they are not (yet) visible on screen. It describes
  /// how many pixels the cache area extends before the leading edge and after the trailing edge of the viewport.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  final double? cacheExtent;

  /// The max height, in logical pixels. Defaults to infinity.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  ///
  /// ## Contract
  /// Throws [AssertionError] if [maxHeight] is not positive.
  final double maxHeight;

  /// Determines the way that drag start behavior is handled. Defaults to [DragStartBehavior.start].
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  final DragStartBehavior dragStartBehavior;

  /// True if the group is enabled. Defaults to true.
  final bool? enabled;

  /// The divider between tiles. Defaults to [FTileDivider.indented].
  final FTileDivider divider;

  /// The group's semantic label.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  final String? semanticLabel;

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
    ScrollController? controller,
    double? cacheExtent,
    double maxHeight = double.infinity,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enabled = true,
    FTileDivider divider = FTileDivider.full,
    String? semanticLabel,
    Widget? label,
    Widget? description,
    Widget? error,
    Key? key,
  }) =>
      _MergeTileGroups(
        key: key,
        style: style,
        controller: controller,
        cacheExtent: cacheExtent,
        maxHeight: maxHeight,
        dragStartBehavior: dragStartBehavior,
        enabled: enabled,
        divider: divider,
        semanticLabel: semanticLabel,
        label: label,
        description: description,
        error: error,
        children: children,
      );

  /// Creates a [FTileGroup].
  FTileGroup({
    required List<FTileMixin> children,
    this.style,
    this.controller,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enabled,
    this.divider = FTileDivider.indented,
    this.semanticLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  })  : assert(0 < maxHeight, 'maxHeight must be positive.'),
        delegate = ((style, {required enabled}) => SliverChildListDelegate([
              for (final (index, child) in children.indexed)
                FTileData(
                  style: style,
                  divider: divider,
                  enabled: enabled,
                  hovered: false,
                  focused: false,
                  index: index,
                  last: index == children.length - 1,
                  child: child,
                ),
            ]));

  /// Creates a [FTileGroup] that lazily builds its children.
  ///
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
  FTileGroup.builder({
    required NullableIndexedWidgetBuilder tileBuilder,
    int? count,
    this.style,
    this.controller,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enabled,
    this.divider = FTileDivider.indented,
    this.semanticLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  })  : assert(0 < maxHeight, 'maxHeight must be positive.'),
        assert(count == null || 0 <= count, 'count must be non-negative.'),
        delegate = ((style, {required enabled}) => SliverChildBuilderDelegate(
              (context, index) {
                final tile = tileBuilder(context, index);
                if (tile == null) {
                  return null;
                }

                return FTileData(
                  style: style,
                  divider: divider,
                  enabled: enabled,
                  hovered: false,
                  focused: false,
                  index: index,
                  last: (count != null && index == count - 1) || tileBuilder(context, index + 1) == null,
                  child: tile,
                );
              },
              childCount: count,
            ));

  @override
  Widget build(BuildContext context) {
    final data = FTileGroupData.maybeOf(context);
    final style = this.style ?? data?.style ?? context.theme.tileGroupStyle;
    final enabled = this.enabled ?? data?.enabled ?? true;

    final sliver = SliverList(delegate: delegate(style.tileStyle, enabled: enabled));

    if (data == null) {
      return FLabel(
        style: style.labelStyle,
        axis: Axis.vertical,
        state: switch ((enabled, error)) {
          _ when !enabled => FLabelState.disabled,
          (_, null) => FLabelState.enabled,
          _ => FLabelState.error,
        },
        label: label,
        description: description,
        error: error,
        child: Semantics(
          container: true,
          label: semanticLabel,
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
                  controller: controller,
                  cacheExtent: cacheExtent,
                  dragStartBehavior: dragStartBehavior,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
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
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(ObjectFlagProperty.has('delegate', delegate));
  }
}

class _MergeTileGroups extends StatelessWidget with FTileGroupMixin<FTileGroupMixin<FTileMixin>> {
  final FTileGroupStyle? style;
  final ScrollController? controller;
  final double? cacheExtent;
  final double maxHeight;
  final DragStartBehavior dragStartBehavior;
  final bool enabled;
  final FTileDivider divider;
  final String? semanticLabel;
  final Widget? label;
  final Widget? description;
  final Widget? error;
  final List<FTileGroupMixin> children;

  const _MergeTileGroups({
    required this.children,
    this.style,
    this.controller,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enabled = true,
    this.divider = FTileDivider.full,
    this.semanticLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.tileGroupStyle;

    return FLabel(
      style: style.labelStyle,
      axis: Axis.vertical,
      state: switch ((enabled, error)) {
        _ when !enabled => FLabelState.disabled,
        (_, null) => FLabelState.enabled,
        _ => FLabelState.error,
      },
      label: label,
      description: description,
      error: error,
      child: Semantics(
        container: true,
        label: semanticLabel,
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
                controller: controller,
                cacheExtent: cacheExtent,
                dragStartBehavior: dragStartBehavior,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  for (final (index, child) in children.indexed)
                    FTileGroupData(
                      style: style,
                      divider: divider,
                      enabled: enabled,
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
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

/// A [FTileGroup]'s style.
class FTileGroupStyle extends FLabelStateStyles with Diagnosticable {
  /// The group label's layout style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The group's border color.
  final Color borderColor;

  /// the group's border width.
  final double borderWidth;

  /// The group's border radius.
  final BorderRadius borderRadius;

  /// The tile's style.
  final FTileStyle tileStyle;

  /// Creates a [FTileGroupStyle].
  FTileGroupStyle({
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.tileStyle,
    required super.enabledStyle,
    required super.disabledStyle,
    required super.errorStyle,
    this.labelLayoutStyle = const FLabelLayoutStyle(
      labelPadding: EdgeInsets.symmetric(vertical: 7.7),
      descriptionPadding: EdgeInsets.only(top: 7.5),
      errorPadding: EdgeInsets.only(top: 5),
    ),
  });

  /// Creates a [FTileGroupStyle] that inherits from the given arguments.
  FTileGroupStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) : this(
          borderColor: colorScheme.border,
          borderWidth: style.borderWidth,
          borderRadius: style.borderRadius,
          tileStyle: FTileStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
          enabledStyle: FFormFieldStyle(
            labelTextStyle: typography.base.copyWith(
              color: style.enabledFormFieldStyle.labelTextStyle.color,
              fontWeight: FontWeight.w600,
            ),
            descriptionTextStyle: typography.xs.copyWith(
              color: style.enabledFormFieldStyle.descriptionTextStyle.color,
            ),
          ),
          disabledStyle: FFormFieldStyle(
            labelTextStyle: typography.base.copyWith(
              color: style.disabledFormFieldStyle.labelTextStyle.color,
              fontWeight: FontWeight.w600,
            ),
            descriptionTextStyle: typography.xs.copyWith(
              color: style.disabledFormFieldStyle.descriptionTextStyle.color,
            ),
          ),
          errorStyle: FFormFieldErrorStyle(
            labelTextStyle: typography.base.copyWith(
              color: style.enabledFormFieldStyle.labelTextStyle.color,
              fontWeight: FontWeight.w600,
            ),
            descriptionTextStyle: typography.xs.copyWith(
              color: style.errorFormFieldStyle.descriptionTextStyle.color,
            ),
            errorTextStyle: typography.xs.copyWith(
              color: style.errorFormFieldStyle.errorTextStyle.color,
            ),
          ),
        );

  /// Returns a copy of this style with the given fields replaced by the new values.
  @override
  @useResult
  FTileGroupStyle copyWith({
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    FTileStyle? tileStyle,
    FLabelLayoutStyle? labelLayoutStyle,
    FFormFieldStyle? enabledStyle,
    FFormFieldStyle? disabledStyle,
    FFormFieldErrorStyle? errorStyle,
  }) =>
      FTileGroupStyle(
        borderColor: borderColor ?? this.borderColor,
        borderWidth: borderWidth ?? this.borderWidth,
        borderRadius: borderRadius ?? this.borderRadius,
        tileStyle: tileStyle ?? this.tileStyle,
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  /// The label's style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (layout: labelLayoutStyle, state: this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is FTileGroupStyle &&
          runtimeType == other.runtimeType &&
          labelLayoutStyle == other.labelLayoutStyle &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          borderRadius == other.borderRadius &&
          tileStyle == other.tileStyle;

  @override
  int get hashCode =>
      super.hashCode ^
      labelLayoutStyle.hashCode ^
      borderColor.hashCode ^
      borderWidth.hashCode ^
      borderRadius.hashCode ^
      tileStyle.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(ColorProperty('borderColor', borderColor))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('tileStyle', tileStyle));
  }
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

  /// True if the group is enabled.
  final bool enabled;

  /// The group's index.
  final int index;

  /// The number of groups.
  final int length;

  /// Creates a [FTileGroupData].
  const FTileGroupData({
    required this.style,
    required this.divider,
    required this.enabled,
    required this.index,
    required this.length,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(FTileGroupData old) =>
      style != old.style ||
      divider != old.divider ||
      enabled != old.enabled ||
      index != old.index ||
      length != old.length;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(EnumProperty('divider', divider))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled', ifFalse: 'disabled'))
      ..add(IntProperty('index', index))
      ..add(IntProperty('length', length));
  }
}

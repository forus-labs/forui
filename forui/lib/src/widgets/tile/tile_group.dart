import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

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

  /// True if the group is enabled. Defaults to true.
  final bool? enabled;

  /// The divider between tiles. Defaults to [FTileDivider.indented].
  final FTileDivider divider;

  /// The group's semantic label.
  final String? semanticLabel;

  /// The group's label. It is ignored if the group is part of a merged [FTileGroup].
  final Widget? label;

  /// The group's description. It is ignored if the group is part of a merged [FTileGroup].
  final Widget? description;

  /// The group's error. It is ignored if the group is part of a merged [FTileGroup] or if the group is disabled.
  final Widget? error;

  /// The tiles in the group.
  final List<FTileMixin> children;

  /// Creates a [FTileGroup] that merges multiple [FTileGroupMixin]s together.
  ///
  /// All group labels will be ignored.
  static FTileGroupMixin<FTileGroupMixin<FTileMixin>> merge({
    required List<FTileGroupMixin<FTileMixin>> children,
    FTileGroupStyle? style,
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
        enabled: enabled,
        divider: divider,
        semanticLabel: semanticLabel,
        label: label,
        description: description,
        error: error,
        children: children,
      );

  /// Creates a [FTileGroup].
  const FTileGroup({
    required this.children,
    this.style,
    this.enabled,
    this.divider = FTileDivider.indented,
    this.semanticLabel,
    this.label,
    this.description,
    this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = FTileGroupData.maybeOf(context);
    final style = this.style ?? data?.style ?? context.theme.tileGroupStyle;
    final enabled = this.enabled ?? data?.enabled ?? true;

    Widget group = Semantics(
      container: true,
      label: semanticLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (index, child) in children.indexed)
            FTileData(
              style: style.tileStyle,
              divider: divider,
              enabled: enabled,
              hovered: false,
              index: index,
              length: children.length,
              child: child,
            ),
        ],
      ),
    );

    if (data == null) {
      group = FLabel(
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
        child: group,
      );
    }

    return group;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _MergeTileGroups extends StatelessWidget with FTileGroupMixin<FTileGroupMixin<FTileMixin>> {
  final FTileGroupStyle? style;
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(FlagProperty('enabled', value: enabled, ifTrue: 'enabled'))
      ..add(EnumProperty('divider', divider))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

/// A [FTileGroup]'s style.
class FTileGroupStyle extends FLabelStateStyles with Diagnosticable {
  /// The group label's layout style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The tile's style.
  final FTileStyle tileStyle;

  /// Creates a [FTileGroupStyle].
  FTileGroupStyle({
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

  /// The label's style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (layout: labelLayoutStyle, state: this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
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

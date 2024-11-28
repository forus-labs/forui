// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_tile_group/select_tile.dart';

/// A set of tiles that are treated as a single selection.
///
/// A [FSelectTileGroup] is internally a [FormField], therefore it can be used in a [Form].
///
/// For desktop, a [FSelectGroup] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/tile/select-tile-group for working examples.
/// * [FSelectTile] for a single select tile.
/// * [FTileGroupStyle] for customizing a select group's appearance.
class FSelectTileGroup<T> extends FormField<Set<T>> with FTileGroupMixin<FTileMixin> {
  static Widget _errorBuilder(BuildContext context, String error) => Text(error);

  /// The controller.
  ///
  /// See:
  /// * [FRadioSelectGroupController] for a single radio button like selection.
  /// * [FMultiSelectGroupController] for multiple selections.
  final FSelectGroupController<T> groupController;

  /// The scroll controller used to control the position to which this group is scrolled.
  ///
  /// Scrolling past the end of the group using the controller will result in undefined behaviour.
  ///
  /// It is ignored if the group is part of a merged [FTileGroup].
  final ScrollController? scrollController;

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

  /// The style. Defaults to [FThemeData.tileGroupStyle].
  final FTileGroupStyle? style;

  /// The divider between tiles. Defaults tp [FTileDivider.indented].
  final FTileDivider divider;

  /// The label displayed above the group.
  ///
  /// It is not rendered if the group is disabled or part of a [FTileGroup].
  final Widget? label;

  /// The description displayed below the group.
  ///
  /// It is not rendered if the group is disabled or part of a [FTileGroup].
  final Widget? description;

  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  ///
  /// It is not rendered if the group is disabled or part of a [FTileGroup].
  final Widget Function(BuildContext, String) errorBuilder;

  /// The semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// Creates a [FSelectTileGroup].
  FSelectTileGroup({
    required this.groupController,
    required List<FSelectTile<T>> children,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FTileDivider.indented,
    this.label,
    this.description,
    this.errorBuilder = _errorBuilder,
    this.semanticLabel,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
          builder: (field) {
            final state = field as _State;
            final groupStyle = style ?? state.context.theme.tileGroupStyle;
            final (labelState, error) = switch (state.errorText) {
              _ when !enabled => (FLabelState.disabled, null),
              final text? => (FLabelState.error, errorBuilder(state.context, text)),
              null => (FLabelState.enabled, null),
            };

            return FTileGroup(
              controller: scrollController,
              style: groupStyle,
              cacheExtent: cacheExtent,
              maxHeight: maxHeight,
              dragStartBehavior: dragStartBehavior,
              divider: divider,
              label: label,
              enabled: enabled,
              description: description,
              error: error,
              semanticLabel: semanticLabel,
              children: [
                for (final child in children)
                  FSelectTileData<T>(
                    controller: groupController,
                    selected: groupController.contains(child.value),
                    child: child,
                  ),
              ],
            );
          },
        );

  /// Creates a [FSelectTileGroup] that lazily builds its children.
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
  FSelectTileGroup.builder({
    required this.groupController,
    required FSelectTile<T>? Function(BuildContext, int) tileBuilder,
    int? count,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.divider = FTileDivider.indented,
    this.label,
    this.description,
    this.errorBuilder = _errorBuilder,
    this.semanticLabel,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(
          builder: (field) {
            final state = field as _State;
            final groupStyle = style ?? state.context.theme.tileGroupStyle;
            final (labelState, error) = switch (state.errorText) {
              _ when !enabled => (FLabelState.disabled, null),
              final text? => (FLabelState.error, errorBuilder(state.context, text)),
              null => (FLabelState.enabled, null),
            };

            return FTileGroup.builder(
              controller: scrollController,
              style: groupStyle,
              cacheExtent: cacheExtent,
              maxHeight: maxHeight,
              dragStartBehavior: dragStartBehavior,
              count: count,
              divider: divider,
              label: label,
              enabled: enabled,
              description: description,
              error: error,
              semanticLabel: semanticLabel,
              tileBuilder: (context, index) {
                final child = tileBuilder(context, index);
                return child == null ? null : FSelectTileData<T>(
                  controller: groupController,
                  selected: groupController.contains(child.value),
                  child: child,
                );
              },
            );
          },
        );

  @override
  FormFieldState<Set<T>> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('groupController', groupController))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('divider', divider))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _State<T> extends FormFieldState<Set<T>> {
  @override
  void initState() {
    super.initState();
    widget.groupController.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FSelectTileGroup<T> old) {
    super.didUpdateWidget(old);
    if (widget.groupController == old.groupController) {
      return;
    }

    widget.groupController.addListener(_handleControllerChanged);
    old.groupController.removeListener(_handleControllerChanged);
  }

  @override
  void didChange(Set<T>? values) {
    super.didChange(values);
    if (!setEquals(widget.groupController.values, values)) {
      widget.groupController.values = values ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.groupController.values = widget.initialValue ?? {};
    super.reset();
  }

  @override
  void dispose() {
    widget.groupController.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (widget.groupController.values != value) {
      didChange(widget.groupController.values);
    }
  }

  @override
  FSelectTileGroup<T> get widget => super.widget as FSelectTileGroup<T>;
}

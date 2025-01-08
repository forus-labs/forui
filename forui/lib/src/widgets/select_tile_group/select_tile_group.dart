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
class FSelectTileGroup<T> extends FormField<Set<T>> with FTileGroupMixin<FTileMixin>, FFormFieldProperties<Set<T>> {
  /// The controller.
  ///
  /// See:
  /// * [FRadioSelectGroupController] for a single radio button like selection.
  /// * [FMultiSelectGroupController] for multiple selections.
  final FSelectGroupController<T> groupController;

  /// {@macro forui.widgets.FTileGroup.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.widgets.FTileGroup.cacheExtent}
  final double? cacheExtent;

  /// {@macro forui.widgets.FTileGroup.maxHeight}
  final double maxHeight;

  /// {@macro forui.widgets.FTileGroup.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// The style. Defaults to [FThemeData.tileGroupStyle].
  final FTileGroupStyle? style;

  /// {@macro forui.widgets.FTileGroup.divider}
  ///
  /// Defaults to [FTileDivider.indented].
  final FTileDivider divider;

  /// The label displayed above the group.
  ///
  /// It is not rendered if the group is disabled or part of a [FTileGroup].
  @override
  final Widget? label;

  /// The description displayed below the group.
  ///
  /// It is not rendered if the group is disabled or part of a [FTileGroup].
  @override
  final Widget? description;

  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  ///
  /// It is not rendered if the group is disabled or part of a [FTileGroup].
  @override
  final Widget Function(BuildContext, String) errorBuilder;

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
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
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.semanticLabel,
    super.onSaved,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
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
              scrollController: scrollController,
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
  /// {@macro forui.widgets.FTileGroup.builder}
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
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.semanticLabel,
    super.onSaved,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
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
              scrollController: scrollController,
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
                return child == null
                    ? null
                    : FSelectTileData<T>(
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
      ..add(EnumProperty('divider', divider))
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

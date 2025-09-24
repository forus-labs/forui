import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_tile_group/select_tile.dart';

/// A controller for a [FSelectTileGroup].
typedef FSelectTileGroupController<T> = FMultiValueNotifier<T>;

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
class FSelectTileGroup<T> extends FormField<Set<T>> with FTileGroupMixin, FFormFieldProperties<Set<T>> {
  /// The controller.
  final FSelectTileGroupController<T> selectController;

  /// {@macro forui.widgets.FTileGroup.scrollController}
  final ScrollController? scrollController;

  /// {@macro forui.widgets.FTileGroup.cacheExtent}
  final double? cacheExtent;

  /// {@macro forui.widgets.FTileGroup.maxHeight}
  final double maxHeight;

  /// {@macro forui.widgets.FTileGroup.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro forui.widgets.FTileGroup.physics}
  final ScrollPhysics physics;

  /// The style. Defaults to [FThemeData.tileGroupStyle].
  final FTileGroupStyle? style;

  /// {@macro forui.widgets.FTileGroup.divider}
  ///
  /// Defaults to [FItemDivider.indented].
  final FItemDivider divider;

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

  /// {@macro forui.foundation.doc_templates.semanticsLabel}
  final String? semanticsLabel;

  /// The callback that is called when the value changes.
  final ValueChanged<Set<T>>? onChange;

  /// The callback that is called when an item is selected.
  final ValueChanged<(T, bool)>? onSelect;

  /// Creates a [FSelectTileGroup].
  FSelectTileGroup({
    required this.selectController,
    required List<FSelectTile<T>> children,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = FItemDivider.indented,
    this.label,
    this.description,
    this.semanticsLabel,
    this.onChange,
    this.onSelect,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    super.onSaved,
    super.onReset,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.key,
  }) : super(
         initialValue: selectController.value,
         builder: (field) {
           final state = field as _State;
           return FTileGroup(
             scrollController: scrollController,
             style: style ?? state.context.theme.tileGroupStyle,
             cacheExtent: cacheExtent,
             maxHeight: maxHeight,
             dragStartBehavior: dragStartBehavior,
             physics: physics,
             divider: divider,
             label: label,
             enabled: enabled,
             description: description,
             error: switch (state.errorText) {
               _ when !enabled => null,
               final text? => errorBuilder(state.context, text),
               null => null,
             },
             semanticsLabel: semanticsLabel,
             children: [
               for (final child in children)
                 FSelectTileData<T>(
                   controller: selectController,
                   selected: selectController.contains(child.value),
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
    required this.selectController,
    required FSelectTile<T>? Function(BuildContext context, int index) tileBuilder,
    int? count,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = double.infinity,
    this.dragStartBehavior = DragStartBehavior.start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = FItemDivider.indented,
    this.label,
    this.description,
    this.semanticsLabel,
    this.onChange,
    this.onSelect,
    Widget Function(BuildContext context, String message) errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    super.onSaved,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.key,
  }) : super(
         initialValue: selectController.value,
         errorBuilder: errorBuilder,
         builder: (field) {
           final state = field as _State;

           return FTileGroup.builder(
             scrollController: scrollController,
             style: style ?? state.context.theme.tileGroupStyle,
             cacheExtent: cacheExtent,
             maxHeight: maxHeight,
             dragStartBehavior: dragStartBehavior,
             physics: physics,
             count: count,
             divider: divider,
             label: label,
             enabled: enabled,
             description: description,
             error: switch (state.errorText) {
               _ when !enabled => null,
               final text? => errorBuilder(state.context, text),
               null => null,
             },
             semanticsLabel: semanticsLabel,
             tileBuilder: (context, index) {
               final child = tileBuilder(context, index);
               return child == null
                   ? null
                   : FSelectTileData<T>(
                       controller: selectController,
                       selected: selectController.contains(child.value),
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
      ..add(DiagnosticsProperty('groupController', selectController))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(EnumProperty('divider', divider))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(ObjectFlagProperty.has('onChange', onChange))
      ..add(ObjectFlagProperty.has('onSelect', onSelect));
  }
}

class _State<T> extends FormFieldState<Set<T>> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.selectController.addListener(_handleControllerChanged);
    widget.selectController.addValueListener(widget.onChange);
    widget.selectController.addUpdateListener(widget.onSelect);
  }

  @override
  void didUpdateWidget(covariant FSelectTileGroup<T> old) {
    super.didUpdateWidget(old);
    if (widget.selectController != old.selectController) {
      widget.selectController.addListener(_handleControllerChanged);
      old.selectController.removeListener(_handleControllerChanged);
    }

    old.selectController.removeValueListener(old.onChange);
    old.selectController.removeUpdateListener(old.onSelect);
    widget.selectController.addValueListener(widget.onChange);
    widget.selectController.addUpdateListener(widget.onSelect);
  }

  @override
  void didChange(Set<T>? value) {
    super.didChange(value);
    if (!setEquals(widget.selectController.value, value)) {
      widget.selectController.value = value ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.selectController.value = widget.initialValue ?? {};
    super.reset();
  }

  @override
  void dispose() {
    widget.selectController
      ..removeListener(_handleControllerChanged)
      ..removeValueListener(widget.onChange)
      ..removeUpdateListener(widget.onSelect);
    _focus.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (!setEquals(widget.selectController.value, value)) {
      didChange(widget.selectController.value);
    }
  }

  @protected
  @override
  Widget build(BuildContext context) {
    // This is a workaround the default FormField.build() function wrapping the child (a SliverList) in a Semantics
    // which results in:
    // "A RenderSemanticsAnnotations expected a child of type RenderBox but received a child of type RenderSliverList."
    //
    // This behavior was introduced without any prior notice in Flutter 3.32.
    super.build(context);

    final child = widget.builder(this);
    if (Form.maybeOf(context)?.widget.autovalidateMode == AutovalidateMode.onUnfocus &&
            widget.autovalidateMode != AutovalidateMode.always ||
        widget.autovalidateMode == AutovalidateMode.onUnfocus) {
      return Focus(
        canRequestFocus: false,
        skipTraversal: true,
        onFocusChange: (value) {
          if (!value) {
            validate();
          }
        },
        focusNode: _focus,
        child: child,
      );
    }

    return child;
  }

  @override
  FSelectTileGroup<T> get widget => super.widget as FSelectTileGroup<T>;
}

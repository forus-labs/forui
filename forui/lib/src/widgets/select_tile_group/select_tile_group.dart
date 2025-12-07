import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form/multi_value_form_field.dart';
import 'package:forui/src/widgets/select_group/select_group_controller.dart';
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
class FSelectTileGroup<T> extends StatefulWidget with FTileGroupMixin, FFormFieldProperties<Set<T>> {
  /// Defines how the select tile group's value is controlled.
  ///
  /// Defaults to [FSelectGroupControl.managed].
  final FSelectGroupControl<T>? control;

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

  @override
  final Widget Function(BuildContext context, String message) errorBuilder;

  /// {@macro flutter.widgets.FormField.onSaved}
  @override
  final FormFieldSetter<Set<T>>? onSaved;

  /// {@macro forui.widgets.FFormField.onReset}
  @override
  final VoidCallback? onReset;

  /// {@macro flutter.widgets.FormField.validator}
  @override
  final FormFieldValidator<Set<T>>? validator;

  /// {@macro flutter.widgets.FormField.forceErrorText}
  @override
  final String? forceErrorText;

  /// Whether the form field is enabled. Defaults to true.
  @override
  final bool enabled;

  /// {@macro flutter.widgets.FormField.autovalidateMode}
  @override
  final AutovalidateMode autovalidateMode;

  final List<FSelectTile<T>>? _children;
  final FSelectTile<T>? Function(BuildContext context, int index)? _tileBuilder;
  final int? _count;

  /// {@template forui.widgets.FSelectTileGroup.new}
  /// Creates a [FSelectTileGroup].
  /// {@endtemplate}
  FSelectTileGroup({
    required List<FSelectTile<T>> children,
    this.control,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = .indented,
    this.label,
    this.description,
    this.semanticsLabel,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.onSaved,
    this.onReset,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode = .disabled,
    super.key,
  })  : _children = children,
        _tileBuilder = null,
        _count = null;

  /// {@template forui.widgets.FSelectTileGroup.builder}
  /// Creates a [FSelectTileGroup] that lazily builds its children.
  ///
  /// {@macro forui.widgets.FTileGroup.builder}
  /// {@endtemplate}
  FSelectTileGroup.builder({
    required FSelectTile<T>? Function(BuildContext context, int index) tileBuilder,
    int? count,
    this.control,
    this.scrollController,
    this.style,
    this.cacheExtent,
    this.maxHeight = .infinity,
    this.dragStartBehavior = .start,
    this.physics = const ClampingScrollPhysics(),
    this.divider = .indented,
    this.label,
    this.description,
    this.semanticsLabel,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    this.onSaved,
    this.onReset,
    this.validator,
    this.forceErrorText,
    this.enabled = true,
    this.autovalidateMode = .disabled,
    super.key,
  })  : _children = null,
        _tileBuilder = tileBuilder,
        _count = count;

  @override
  State<FSelectTileGroup<T>> createState() => _FSelectTileGroupState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('control', control))
      ..add(DiagnosticsProperty('scrollController', scrollController))
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('cacheExtent', cacheExtent))
      ..add(DoubleProperty('maxHeight', maxHeight))
      ..add(EnumProperty('dragStartBehavior', dragStartBehavior))
      ..add(DiagnosticsProperty('physics', physics))
      ..add(EnumProperty('divider', divider))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(StringProperty('semanticsLabel', semanticsLabel))
      ..add(ObjectFlagProperty.has('onSaved', onSaved))
      ..add(ObjectFlagProperty.has('onReset', onReset))
      ..add(ObjectFlagProperty.has('validator', validator))
      ..add(StringProperty('forceErrorText', forceErrorText))
      ..add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'))
      ..add(EnumProperty('autovalidateMode', autovalidateMode));
  }
}

class _FSelectTileGroupState<T> extends State<FSelectTileGroup<T>> {
  late FSelectGroupController<T> _controller;

  @override
  void initState() {
    super.initState();
    _controller = (widget.control ?? FSelectGroupControl<T>.managed()).create(_handleChange);
  }

  @override
  void didUpdateWidget(covariant FSelectTileGroup<T> old) {
    super.didUpdateWidget(old);
    final current = widget.control ?? FSelectGroupControl<T>.managed();
    final previous = old.control ?? FSelectGroupControl<T>.managed();
    _controller = current.update(previous, _controller, _handleChange).$1;
  }

  void _handleChange() {
    if (widget.control case Managed(:final onChange?)) {
      onChange(_controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupStyle = widget.style ?? context.theme.tileGroupStyle;

    return MultiValueFormField<T>(
      controller: _controller,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: widget.validator,
      forceErrorText: widget.forceErrorText,
      autovalidateMode: widget.autovalidateMode,
      builder: (state) {
        final error = switch (state.errorText) {
          _ when !widget.enabled => null,
          final text? => widget.errorBuilder(context, text),
          null => null,
        };

        if (widget._children case final children?) {
          return FTileGroup(
            scrollController: widget.scrollController,
            style: groupStyle,
            cacheExtent: widget.cacheExtent,
            maxHeight: widget.maxHeight,
            dragStartBehavior: widget.dragStartBehavior,
            physics: widget.physics,
            divider: widget.divider,
            label: widget.label,
            enabled: widget.enabled,
            description: widget.description,
            error: error,
            semanticsLabel: widget.semanticsLabel,
            children: [
              for (final child in children)
                FSelectTileData<T>(
                  controller: _controller,
                  selected: _controller.contains(child.value),
                  child: child,
                ),
            ],
          );
        }

        return FTileGroup.builder(
          scrollController: widget.scrollController,
          style: groupStyle,
          cacheExtent: widget.cacheExtent,
          maxHeight: widget.maxHeight,
          dragStartBehavior: widget.dragStartBehavior,
          physics: widget.physics,
          count: widget._count,
          divider: widget.divider,
          label: widget.label,
          enabled: widget.enabled,
          description: widget.description,
          error: error,
          semanticsLabel: widget.semanticsLabel,
          tileBuilder: (context, index) {
            final child = widget._tileBuilder!(context, index);
            return child == null
                ? null
                : FSelectTileData<T>(
                    controller: _controller,
                    selected: _controller.contains(child.value),
                    child: child,
                  );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    (widget.control ?? FSelectGroupControl<T>.managed()).dispose(_controller, _handleChange);
    super.dispose();
  }
}

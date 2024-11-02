// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
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
  final FSelectGroupController<T> controller;

  /// The style. Defaults to [FThemeData.tileGroupStyle].
  final FTileGroupStyle? style;

  /// The divider between tiles. Defaults tp [FTileDivider.indented].
  final FTileDivider divider;

  /// The label displayed next to the select group.
  final Widget? label;

  /// The description displayed below the group.
  final Widget? description;

  /// The builder for errors displayed below the [description]. Defaults to displaying the error message.
  final Widget Function(BuildContext, String) errorBuilder;

  /// The semantic label used by accessibility frameworks.
  final String? semanticLabel;

  /// The items.
  final List<FSelectTile<T>> children;

  /// Creates a [FSelectTileGroup].
  FSelectTileGroup({
    required this.controller,
    required this.children,
    this.style,
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
              style: groupStyle,
              divider: divider,
              label: label,
              enabled: enabled,
              description: description,
              error: error,
              semanticLabel: semanticLabel,
              children: [
                for (final child in children)
                  FSelectTileData<T>(
                    controller: controller,
                    selected: controller.contains(child.value),
                    child: child,
                  ),
              ],
            );
          },
        );

  @override
  FormFieldState<Set<T>> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('divider', divider))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _State<T> extends FormFieldState<Set<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FSelectTileGroup<T> old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    widget.controller.addListener(_handleControllerChanged);
    old.controller.removeListener(_handleControllerChanged);
  }

  @override
  void didChange(Set<T>? values) {
    super.didChange(values);
    if (!setEquals(widget.controller.values, values)) {
      widget.controller.values = values ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.controller.values = widget.initialValue ?? {};
    super.reset();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChanged);
    super.dispose();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we register this change listener. In these
    // cases, we'll also receive change notifications for changes originating from within this class -- for example, the
    // reset() method. In such cases, the FormField value will already have been set.
    if (widget.controller.values != value) {
      didChange(widget.controller.values);
    }
  }

  @override
  FSelectTileGroup<T> get widget => super.widget as FSelectTileGroup<T>;
}

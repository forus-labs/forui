// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A set of tiles that are treated as a single selection.
///
/// See:
/// * https://forui.dev/docs/tile/select-tile-group for working examples.
/// * [FSelectTile] for a single select tile.
/// * [FSelectTileGroupStyle] for customizing a select group's appearance.
class FSelectTileGroup<T> extends FormField<Set<T>> with FTileGroupMixin<FTileMixin> {
  static Widget _errorBuilder(BuildContext context, String error) => Text(error);

  /// The controller.
  ///
  /// See:
  /// * [FRadioSelectGroupController] for a single radio button like selection.
  /// * [FMultiSelectGroupController] for multiple selections.
  final FSelectGroupController<T> controller;

  // /// The style. Defaults to [FThemeData.selectGroupStyle].
  // final FSelectTileGroupStyle? style;

  /// The divider between tiles. Defaults tp [FTileDivider.indented].
  final FTileDivider divider;

  /// The label displayed next to the select group.
  final Widget? label;

  /// The description displayed below the [label].
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
    // this.style,
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
            final groupStyle = state.context.theme.selectGroupStyle; // TODO:
            final (labelState, error) = switch (state.errorText) {
              _ when !enabled => (FLabelState.disabled, null),
              final text? => (FLabelState.error, errorBuilder(state.context, text)),
              null => (FLabelState.enabled, null),
            };

            Widget group = FTileGroup(
              divider: divider,
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

            final data = FTileGroupData.maybeOf(state.context);
            if (data == null) {
              return FLabel(
                axis: Axis.vertical,
                state: labelState,
                style: groupStyle.labelStyle,
                label: label,
                description: description,
                error: error,
                child: group,
              );
            }
          },
        );

  @override
  FormFieldState<Set<T>> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      // ..add(DiagnosticsProperty('style', style))
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

/// [FSelectGroup]'s style.
class FSelectGroupStyle with Diagnosticable {
  /// The label's style.
  final FLabelStateStyles labelLayoutStyle;



  /// The group's style.
  final FTileGroupStyle groupStyle;

  /// Creates a [FSelectGroupStyle].
  const FSelectGroupStyle({
    required this.labelLayoutStyle,
    required this.groupStyle,
  });

  /// Creates a [FSelectGroupStyle] that inherits its properties from the given parameters.
  factory FSelectGroupStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) => FSelectGroupStyle(
      labelLayoutStyle: const FLabelLayoutStyle(
          labelPadding: EdgeInsets.only(bottom: 5),
          descriptionPadding: EdgeInsets.only(top: 5),
          errorPadding: EdgeInsets.only(top: 5),
        ),
      groupStyle: FTileGroupStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
    );

  /// The [FLabel]'s style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (
        layout: labelLayoutStyle,
        state: FLabelStateStyles(
          enabledStyle: enabledStyle,
          disabledStyle: disabledStyle,
          errorStyle: errorStyle,
        ),
      );

  /// Returns a copy of this [FSelectGroupStyle] with the given properties replaced.
  @useResult
  FSelectGroupStyle copyWith({
    FLabelLayoutStyle? labelLayoutStyle,
    FSelectGroupStateStyle? enabledStyle,
    FSelectGroupStateStyle? disabledStyle,
    FSelectGroupErrorStyle? errorStyle,
    FCheckboxSelectGroupStyle? checkboxStyle,
    FRadioSelectGroupStyle? radioStyle,
  }) =>
      FSelectGroupStyle(
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
        checkboxStyle: checkboxStyle ?? this.checkboxStyle,
        radioStyle: radioStyle ?? this.radioStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle))
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle))
      ..add(DiagnosticsProperty('radioStyle', radioStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSelectGroupStyle &&
          runtimeType == other.runtimeType &&
          labelLayoutStyle == other.labelLayoutStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle &&
          checkboxStyle == other.checkboxStyle &&
          radioStyle == other.radioStyle;

  @override
  int get hashCode =>
      labelLayoutStyle.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode ^
      checkboxStyle.hashCode ^
      radioStyle.hashCode;
}

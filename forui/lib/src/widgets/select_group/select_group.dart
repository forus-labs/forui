// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_group/select_group_item.dart';
import 'package:meta/meta.dart';

/// A set of items that are treated as a single selection.
///
/// Typically used to group multiple [FSelectGroupItem.checkbox]s or [FSelectGroupItem.radio]s.
///
/// For touch devices, a [FSelectTileGroup] is generally recommended over this.
///
/// See:
/// * https://forui.dev/docs/form/select-group for working examples.
/// * [FSelectGroupStyle] for customizing a select group's appearance.
class FSelectGroup<T> extends FormField<Set<T>> with FFormFieldProperties<Set<T>> {
  /// The controller.
  ///
  /// See:
  /// * [FRadioSelectGroupController] for a single radio button like selection.
  /// * [FMultiSelectGroupController] for multiple selections.
  final FSelectGroupController<T> controller;

  /// The style. Defaults to [FThemeData.selectGroupStyle].
  final FSelectGroupStyle? style;

  @override
  final Widget? label;

  @override
  final Widget? description;

  @override
  final Widget Function(BuildContext, String) errorBuilder;

  /// The items.
  final List<FSelectGroupItem<T>> items;

  /// Creates a [FSelectGroup].
  FSelectGroup({
    required this.controller,
    required this.items,
    this.style,
    this.label,
    this.description,
    this.errorBuilder = FFormFieldProperties.defaultErrorBuilder,
    super.onSaved,
    super.validator,
    super.forceErrorText,
    super.enabled = true,
    super.autovalidateMode,
    super.key,
  }) : super(
          builder: (field) {
            final state = field as _State;
            final groupStyle = style ?? state.context.theme.selectGroupStyle;
            final (labelState, error) = switch (state.errorText) {
              _ when !enabled => (FLabelState.disabled, null),
              final text? => (FLabelState.error, errorBuilder(state.context, text)),
              null => (FLabelState.enabled, null),
            };

            return FLabel(
              axis: Axis.vertical,
              state: labelState,
              style: groupStyle.labelStyle,
              label: label,
              description: description,
              error: error,
              child: Column(
                children: [
                  for (final child in items)
                    FSelectGroupItemData<T>(
                      controller: controller,
                      style: groupStyle,
                      selected: controller.contains(child.value),
                      child: child,
                    ),
                ],
              ),
            );
          },
        );

  @override
  FormFieldState<Set<T>> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(ObjectFlagProperty.has('errorBuilder', errorBuilder));
  }
}

class _State<T> extends FormFieldState<Set<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateWidget(covariant FSelectGroup<T> old) {
    super.didUpdateWidget(old);
    if (widget.controller == old.controller) {
      return;
    }

    widget.controller.addListener(_handleControllerChanged);
    old.controller.removeListener(_handleControllerChanged);
  }

  @override
  void didChange(Set<T>? value) {
    super.didChange(value);
    if (!setEquals(widget.controller.value, value)) {
      widget.controller.value = value ?? {};
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let _handleControllerChanged suppress the change.
    widget.controller.value = widget.initialValue ?? {};
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
    if (widget.controller.value != value) {
      didChange(widget.controller.value);
    }
  }

  @override
  FSelectGroup<T> get widget => super.widget as FSelectGroup<T>;
}

/// [FSelectGroup]'s style.
class FSelectGroupStyle with Diagnosticable {
  /// The [FLabel]'s style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The [FSelectGroup]'s style when it's enabled.
  final FSelectGroupStateStyle enabledStyle;

  /// The [FSelectGroup]'s style when it's disabled.
  final FSelectGroupStateStyle disabledStyle;

  /// The [FSelectGroup]'s style when it has an error.
  final FSelectGroupErrorStyle errorStyle;

  /// The [FSelectGroupItem.checkbox]'s style.
  final FCheckboxSelectGroupStyle checkboxStyle;

  /// The [FSelectGroupItem.radio]'s style.
  final FRadioSelectGroupStyle radioStyle;

  /// Creates a [FSelectGroupStyle].
  const FSelectGroupStyle({
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    required this.checkboxStyle,
    required this.radioStyle,
  });

  /// Creates a [FSelectGroupStyle] that inherits its properties from the given parameters.
  factory FSelectGroupStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) {
    final checkboxStyle = FCheckboxStyle.inherit(colorScheme: colorScheme, style: style);
    final checkboxSelectGroupStyle = FCheckboxSelectGroupStyle.inherit(
      style: checkboxStyle.copyWith(
        enabledStyle: checkboxStyle.enabledStyle.copyWith(
          labelTextStyle: typography.sm.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          descriptionTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
        ),
        disabledStyle: checkboxStyle.disabledStyle.copyWith(
          labelTextStyle: typography.sm.copyWith(
            color: colorScheme.disable(colorScheme.primary),
            fontWeight: FontWeight.w500,
          ),
          descriptionTextStyle: typography.sm.copyWith(color: colorScheme.disable(colorScheme.mutedForeground)),
        ),
        errorStyle: checkboxStyle.errorStyle.copyWith(
          labelTextStyle: typography.sm.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          descriptionTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
          errorTextStyle: typography.sm.copyWith(
            color: colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    final radioStyle = FRadioStyle.inherit(colorScheme: colorScheme, style: style);
    final radioSelectGroupStyle = FRadioSelectGroupStyle.inherit(
      style: radioStyle.copyWith(
        enabledStyle: radioStyle.enabledStyle.copyWith(
          labelTextStyle: typography.sm.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          descriptionTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
        ),
        disabledStyle: radioStyle.disabledStyle.copyWith(
          labelTextStyle: typography.sm.copyWith(
            color: colorScheme.disable(colorScheme.primary),
            fontWeight: FontWeight.w500,
          ),
          descriptionTextStyle: typography.sm.copyWith(color: colorScheme.disable(colorScheme.mutedForeground)),
        ),
        errorStyle: radioStyle.errorStyle.copyWith(
          labelTextStyle: typography.sm.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          descriptionTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground),
          errorTextStyle: typography.sm.copyWith(
            color: colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    return FSelectGroupStyle(
      labelLayoutStyle: FLabelStyles.inherit(style: style).verticalStyle.layout,
      enabledStyle: FSelectGroupStateStyle(
        labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
        descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
      ),
      disabledStyle: FSelectGroupStateStyle(
        labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
        descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
      ),
      errorStyle: FSelectGroupErrorStyle(
        labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
        descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
        errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
      ),
      checkboxStyle: checkboxSelectGroupStyle,
      radioStyle: radioSelectGroupStyle,
    );
  }

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

/// [FSelectGroup]'s state style.
// ignore: avoid_implementing_value_types
class FSelectGroupStateStyle with Diagnosticable implements FFormFieldStyle {
  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  /// Creates a [FSelectGroupStateStyle].
  FSelectGroupStateStyle({required this.labelTextStyle, required this.descriptionTextStyle});

  @override
  FSelectGroupStateStyle copyWith({TextStyle? labelTextStyle, TextStyle? descriptionTextStyle}) =>
      FSelectGroupStateStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSelectGroupStateStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode;
}

/// [FSelectGroup]'s error style.
// ignore: avoid_implementing_value_types
class FSelectGroupErrorStyle with Diagnosticable implements FFormFieldErrorStyle {
  @override
  final TextStyle labelTextStyle;

  @override
  final TextStyle descriptionTextStyle;

  @override
  final TextStyle errorTextStyle;

  /// Creates a [FSelectGroupErrorStyle].
  FSelectGroupErrorStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
    required this.errorTextStyle,
  });

  @override
  FSelectGroupErrorStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) =>
      FSelectGroupErrorStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSelectGroupErrorStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode ^ errorTextStyle.hashCode;
}

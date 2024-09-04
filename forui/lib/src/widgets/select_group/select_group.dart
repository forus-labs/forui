import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/form_field.dart';

/// A group of form fields that represent a single selection.
///
/// A [FSelectGroup] is internally a [FormField], therefore it can be used in a form.
///
/// See:
/// * https://forui.dev/docs/select-group for working examples.
/// * [FSelectGroupStyle] for customizing a select group's appearance.
class FSelectGroup<T> extends FFormField<Set<T>> {
  /// The style. Defaults to [FThemeData.selectGroupStyle].
  final FSelectGroupStyle? style;

  /// The label displayed next to the checkbox.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The controller.
  final FSelectGroupController<T> controller;

  /// The items.
  final List<FSelectGroupItem<T>> items;

  /// Creates a [FSelectGroup].
  FSelectGroup({
    required this.controller,
    required this.items,
    this.style,
    this.label,
    this.description,
    super.onSave,
    super.forceErrorText,
    super.validator,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,
    super.key,
  }) : super(initialValue: controller.values);

  @override
  Widget builder(BuildContext context, FormFieldState<Set<T>> state) {
    final style = this.style ?? context.theme.selectGroupStyle;
    final labelState = switch ((enabled, state.hasError)) {
      (true, false) => FLabelState.enabled,
      (false, false) => FLabelState.disabled,
      (_, true) => FLabelState.error,
    };
    final value = state.value ?? initialValue;

    return FLabel(
      axis: Axis.vertical,
      state: labelState,
      style: style.labelStyle,
      label: label,
      description: description,
      error: Text(state.errorText ?? ''),
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) => Column(
            children: [
              for (final item in items)
                item.builder(
                  context,
                      (value, selected) {
                    controller.onChange(value, selected);
                    state.didChange(controller.values);
                  },
                  value.contains(item.value),
                )
            ]
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
      ..add(IterableProperty('items', items));
  }
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

  /// Creates a [FSelectGroupStyle].
  const FSelectGroupStyle({
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
  });

  /// Creates a [FSelectGroupStyle] that inherits its properties from the given parameters.
  FSelectGroupStyle.inherit({required FStyle style})
      : labelLayoutStyle = FLabelStyles.inherit(style: style).vertical.layout,
        enabledStyle = FSelectGroupStateStyle(
          labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
        ),
        disabledStyle = FSelectGroupStateStyle(
          labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
        ),
        errorStyle = FSelectGroupErrorStyle(
          labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
          descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
          errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
        );

  /// The [FLabel]'s style.
  FLabelStyle get labelStyle => (
        layout: labelLayoutStyle,
        state: FLabelStateStyle(
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
  }) =>
      FSelectGroupStyle(
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle))
      ..add(DiagnosticsProperty('labelStyle', labelStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSelectGroupStyle &&
          runtimeType == other.runtimeType &&
          labelLayoutStyle == other.labelLayoutStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode => labelLayoutStyle.hashCode ^ enabledStyle.hashCode ^ disabledStyle.hashCode ^ errorStyle.hashCode;
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

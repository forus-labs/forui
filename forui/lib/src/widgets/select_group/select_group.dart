import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A set of items that are treated as a single selection.
///
/// Typically used to group multiple [FSelectGroupItem.checkbox]s.
///
/// See:
/// * https://forui.dev/docs/select-group for working examples.
/// * [FSelectGroupStyle] for customizing a select group's appearance.
class FSelectGroup<T> extends StatelessWidget {
  /// The controller.
  ///
  /// See:
  /// * [FRadioSelectGroupController] for a single radio button like selection.
  /// * [FMultiSelectGroupController] for multiple selections.
  final FSelectGroupController<T> controller;

  /// The style. Defaults to [FThemeData.selectGroupStyle].
  final FSelectGroupStyle? style;

  /// The label displayed next to the select group.
  final Widget? label;

  /// The description displayed below the [label].
  final Widget? description;

  /// The error displayed below the [description].
  ///
  /// If the value is present, the select group is in an error state.
  final Widget? error;

  /// The items.
  final List<FSelectGroupItem<T>> items;

  /// Creates a [FSelectGroup].
  const FSelectGroup({
    required this.controller,
    required this.items,
    this.style,
    this.label,
    this.description,
    this.error,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.selectGroupStyle;
    final labelState = error != null ? FLabelState.error : FLabelState.enabled;

    return FLabel(
      axis: Axis.vertical,
      state: labelState,
      style: style.labelStyle,
      label: label,
      description: description,
      error: error,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) => Column(
          children: [
            for (final item in items)
              item.builder(
                context,
                controller.select,
                controller.contains(item.value),
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

  /// The [FSelectGroupItem.checkbox]'s style.
  final FCheckboxSelectGroupStyle checkboxStyle;

  /// Creates a [FSelectGroupStyle].
  const FSelectGroupStyle({
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    required this.checkboxStyle,
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
            color: colorScheme.primary.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
          descriptionTextStyle: typography.sm.copyWith(color: colorScheme.mutedForeground.withOpacity(0.7)),
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

    return FSelectGroupStyle(
      labelLayoutStyle: FLabelStyles.inherit(style: style).vertical.layout,
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
    );
  }

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
    FCheckboxSelectGroupStyle? checkboxStyle,
  }) =>
      FSelectGroupStyle(
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
        checkboxStyle: checkboxStyle ?? this.checkboxStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle))
      ..add(DiagnosticsProperty('labelStyle', labelStyle))
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle));
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
          checkboxStyle == other.checkboxStyle;

  @override
  int get hashCode =>
      labelLayoutStyle.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode ^
      checkboxStyle.hashCode;
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

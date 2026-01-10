// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'time_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTimeFieldStyleTransformations on FTimeFieldStyle {
  /// Returns a copy of this [FTimeFieldStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FTimeFieldStyle.fieldStyle] - The time field's text field style.
  /// * [FTimeFieldStyle.popoverStyle] - The time field picker's popover style.
  /// * [FTimeFieldStyle.pickerStyle] - The time field's picker style.
  @useResult
  FTimeFieldStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? fieldStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FTimePickerStyle Function(FTimePickerStyle style)? pickerStyle,
  }) => .new(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    pickerStyle: pickerStyle != null ? pickerStyle(this.pickerStyle) : this.pickerStyle,
  );

  /// Linearly interpolate between this and another [FTimeFieldStyle] using the given factor [t].
  @useResult
  FTimeFieldStyle lerp(FTimeFieldStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    pickerStyle: pickerStyle.lerp(other.pickerStyle, t),
  );
}

mixin _$FTimeFieldStyleFunctions on Diagnosticable {
  FTextFieldStyle get fieldStyle;
  FPopoverStyle get popoverStyle;
  FTimePickerStyle get pickerStyle;

  /// Returns itself.
  ///
  /// Allows [FTimeFieldStyle] to replace functions that accept and return a [FTimeFieldStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTimeFieldStyle Function(FTimeFieldStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTimeFieldStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTimeFieldStyle(...));
  /// ```
  @useResult
  FTimeFieldStyle call(Object? _) => this as FTimeFieldStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: .debug))
      ..add(DiagnosticsProperty('pickerStyle', pickerStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTimeFieldStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          popoverStyle == other.popoverStyle &&
          pickerStyle == other.pickerStyle);

  @override
  int get hashCode => fieldStyle.hashCode ^ popoverStyle.hashCode ^ pickerStyle.hashCode;
}

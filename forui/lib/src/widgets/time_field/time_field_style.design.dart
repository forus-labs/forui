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
  /// * [FTimeFieldStyle.textFieldStyle] - The time field's text field style.
  /// * [FTimeFieldStyle.popoverStyle] - The time field picker's popover style.
  /// * [FTimeFieldStyle.popoverConstraints] - The time field picker's popover constraints.
  /// * [FTimeFieldStyle.pickerStyle] - The time field's picker style.
  /// * [FTimeFieldStyle.iconStyle] - The time field icon's style.
  @useResult
  FTimeFieldStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? textFieldStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FPortalConstraints? popoverConstraints,
    FTimePickerStyle Function(FTimePickerStyle style)? pickerStyle,
    IconThemeData? iconStyle,
  }) => FTimeFieldStyle(
    textFieldStyle: textFieldStyle != null ? textFieldStyle(this.textFieldStyle) : this.textFieldStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    popoverConstraints: popoverConstraints ?? this.popoverConstraints,
    pickerStyle: pickerStyle != null ? pickerStyle(this.pickerStyle) : this.pickerStyle,
    iconStyle: iconStyle ?? this.iconStyle,
  );

  /// Linearly interpolate between this and another [FTimeFieldStyle] using the given factor [t].
  @useResult
  FTimeFieldStyle lerp(FTimeFieldStyle other, double t) => FTimeFieldStyle(
    textFieldStyle: textFieldStyle.lerp(other.textFieldStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    popoverConstraints: t < 0.5 ? popoverConstraints : other.popoverConstraints,
    pickerStyle: pickerStyle.lerp(other.pickerStyle, t),
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
  );
}

mixin _$FTimeFieldStyleFunctions on Diagnosticable {
  FTextFieldStyle get textFieldStyle;
  FPopoverStyle get popoverStyle;
  FPortalConstraints get popoverConstraints;
  FTimePickerStyle get pickerStyle;
  IconThemeData get iconStyle;

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
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverConstraints', popoverConstraints, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('pickerStyle', pickerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTimeFieldStyle &&
          textFieldStyle == other.textFieldStyle &&
          popoverStyle == other.popoverStyle &&
          popoverConstraints == other.popoverConstraints &&
          pickerStyle == other.pickerStyle &&
          iconStyle == other.iconStyle);

  @override
  int get hashCode =>
      textFieldStyle.hashCode ^
      popoverStyle.hashCode ^
      popoverConstraints.hashCode ^
      pickerStyle.hashCode ^
      iconStyle.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'time_field_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FTimeFieldStyleCopyWith on FTimeFieldStyle {
  /// Returns a copy of this [FTimeFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [textFieldStyle]
  /// The time field's text field style.
  ///
  /// # [popoverStyle]
  /// The time field picker's popover style.
  ///
  /// # [popoverConstraints]
  /// The time field picker's popover constraints.
  ///
  /// # [pickerStyle]
  /// The time field's picker style.
  ///
  /// # [iconStyle]
  /// The time field icon's style.
  ///
  @useResult
  FTimeFieldStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle)? textFieldStyle,
    FPopoverStyle Function(FPopoverStyle)? popoverStyle,
    FPortalConstraints? popoverConstraints,
    FTimePickerStyle Function(FTimePickerStyle)? pickerStyle,
    IconThemeData? iconStyle,
  }) => FTimeFieldStyle(
    textFieldStyle: textFieldStyle != null ? textFieldStyle(this.textFieldStyle) : this.textFieldStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    popoverConstraints: popoverConstraints ?? this.popoverConstraints,
    pickerStyle: pickerStyle != null ? pickerStyle(this.pickerStyle) : this.pickerStyle,
    iconStyle: iconStyle ?? this.iconStyle,
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
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle))
      ..add(DiagnosticsProperty('popoverConstraints', popoverConstraints))
      ..add(DiagnosticsProperty('pickerStyle', pickerStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle));
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

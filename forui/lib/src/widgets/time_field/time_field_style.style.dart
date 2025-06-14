// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'time_field_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FTimeFieldStyleFunctions on Diagnosticable implements FTransformable {
  FTextFieldStyle get textFieldStyle;
  FPopoverStyle get popoverStyle;
  FPortalConstraints get popoverConstraints;
  FTimePickerStyle get pickerStyle;
  IconThemeData get iconStyle;

  /// Returns a copy of this [FTimeFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FTimeFieldStyle copyWith({
    FTextFieldStyle? textFieldStyle,
    FPopoverStyle? popoverStyle,
    FPortalConstraints? popoverConstraints,
    FTimePickerStyle? pickerStyle,
    IconThemeData? iconStyle,
  }) => FTimeFieldStyle(
    textFieldStyle: textFieldStyle ?? this.textFieldStyle,
    popoverStyle: popoverStyle ?? this.popoverStyle,
    popoverConstraints: popoverConstraints ?? this.popoverConstraints,
    pickerStyle: pickerStyle ?? this.pickerStyle,
    iconStyle: iconStyle ?? this.iconStyle,
  );
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

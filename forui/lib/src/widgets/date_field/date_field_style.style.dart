// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'date_field_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FDateFieldStyleFunctions on Diagnosticable implements FTransformable {
  FTextFieldStyle get textFieldStyle;
  FPopoverStyle get popoverStyle;
  FCalendarStyle get calendarStyle;
  IconThemeData get iconStyle;

  /// Returns a copy of this [FDateFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FDateFieldStyle copyWith({
    FTextFieldStyle? textFieldStyle,
    FPopoverStyle? popoverStyle,
    FCalendarStyle? calendarStyle,
    IconThemeData? iconStyle,
  }) => FDateFieldStyle(
    textFieldStyle: textFieldStyle ?? this.textFieldStyle,
    popoverStyle: popoverStyle ?? this.popoverStyle,
    calendarStyle: calendarStyle ?? this.calendarStyle,
    iconStyle: iconStyle ?? this.iconStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDateFieldStyle &&
          textFieldStyle == other.textFieldStyle &&
          popoverStyle == other.popoverStyle &&
          calendarStyle == other.calendarStyle &&
          iconStyle == other.iconStyle);
  @override
  int get hashCode => textFieldStyle.hashCode ^ popoverStyle.hashCode ^ calendarStyle.hashCode ^ iconStyle.hashCode;
}

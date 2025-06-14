// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'calendar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FCalendarStyleFunctions on Diagnosticable implements FTransformable {
  FCalendarHeaderStyle get headerStyle;
  FCalendarDayPickerStyle get dayPickerStyle;
  FCalendarEntryStyle get yearMonthPickerStyle;
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  Duration get pageAnimationDuration;

  /// Returns a copy of this [FCalendarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FCalendarStyle copyWith({
    FCalendarHeaderStyle? headerStyle,
    FCalendarDayPickerStyle? dayPickerStyle,
    FCalendarEntryStyle? yearMonthPickerStyle,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    Duration? pageAnimationDuration,
  }) => FCalendarStyle(
    headerStyle: headerStyle ?? this.headerStyle,
    dayPickerStyle: dayPickerStyle ?? this.dayPickerStyle,
    yearMonthPickerStyle: yearMonthPickerStyle ?? this.yearMonthPickerStyle,
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    pageAnimationDuration: pageAnimationDuration ?? this.pageAnimationDuration,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerStyle', headerStyle))
      ..add(DiagnosticsProperty('dayPickerStyle', dayPickerStyle))
      ..add(DiagnosticsProperty('yearMonthPickerStyle', yearMonthPickerStyle))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('pageAnimationDuration', pageAnimationDuration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarStyle &&
          headerStyle == other.headerStyle &&
          dayPickerStyle == other.dayPickerStyle &&
          yearMonthPickerStyle == other.yearMonthPickerStyle &&
          decoration == other.decoration &&
          padding == other.padding &&
          pageAnimationDuration == other.pageAnimationDuration);
  @override
  int get hashCode =>
      headerStyle.hashCode ^
      dayPickerStyle.hashCode ^
      yearMonthPickerStyle.hashCode ^
      decoration.hashCode ^
      padding.hashCode ^
      pageAnimationDuration.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'calendar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FCalendarStyleCopyWith on FCalendarStyle {
  /// Returns a copy of this [FCalendarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [headerStyle]
  /// The header's style.
  ///
  /// # [dayPickerStyle]
  /// The day picker's style.
  ///
  /// # [yearMonthPickerStyle]
  /// The year/month picker's style.
  ///
  /// # [decoration]
  /// The decoration surrounding the header & picker.
  ///
  /// # [padding]
  /// The padding surrounding the header & picker. Defaults to `EdgeInsets.symmetric(horizontal: 12, vertical: 16)`.
  ///
  /// # [pageAnimationDuration]
  /// The duration of the page switch animation. Defaults to 200 milliseconds.
  ///
  @useResult
  FCalendarStyle copyWith({
    FCalendarHeaderStyle Function(FCalendarHeaderStyle)? headerStyle,
    FCalendarDayPickerStyle Function(FCalendarDayPickerStyle)? dayPickerStyle,
    FCalendarEntryStyle Function(FCalendarEntryStyle)? yearMonthPickerStyle,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? padding,
    Duration? pageAnimationDuration,
  }) => FCalendarStyle(
    headerStyle: headerStyle != null ? headerStyle(this.headerStyle) : this.headerStyle,
    dayPickerStyle: dayPickerStyle != null ? dayPickerStyle(this.dayPickerStyle) : this.dayPickerStyle,
    yearMonthPickerStyle: yearMonthPickerStyle != null
        ? yearMonthPickerStyle(this.yearMonthPickerStyle)
        : this.yearMonthPickerStyle,
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    pageAnimationDuration: pageAnimationDuration ?? this.pageAnimationDuration,
  );
}

mixin _$FCalendarStyleFunctions on Diagnosticable {
  FCalendarHeaderStyle get headerStyle;
  FCalendarDayPickerStyle get dayPickerStyle;
  FCalendarEntryStyle get yearMonthPickerStyle;
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  Duration get pageAnimationDuration;

  /// Returns itself.
  ///
  /// Allows [FCalendarStyle] to replace functions that accept and return a [FCalendarStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarStyle Function(FCalendarStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarStyle(...));
  /// ```
  @useResult
  FCalendarStyle call(Object? _) => this as FCalendarStyle;
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

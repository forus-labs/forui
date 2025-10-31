// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'calendar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarStyleTransformations on FCalendarStyle {
  /// Returns a copy of this [FCalendarStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarStyle.headerStyle] - The header's style.
  /// * [FCalendarStyle.dayPickerStyle] - The day picker's style.
  /// * [FCalendarStyle.yearMonthPickerStyle] - The year/month picker's style.
  /// * [FCalendarStyle.decoration] - The decoration surrounding the header & picker.
  /// * [FCalendarStyle.padding] - The padding surrounding the header & picker.
  /// * [FCalendarStyle.pageAnimationDuration] - The duration of the page switch animation.
  @useResult
  FCalendarStyle copyWith({
    FCalendarHeaderStyle Function(FCalendarHeaderStyle style)? headerStyle,
    FCalendarDayPickerStyle Function(FCalendarDayPickerStyle style)? dayPickerStyle,
    FCalendarEntryStyle Function(FCalendarEntryStyle style)? yearMonthPickerStyle,
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

  /// Linearly interpolate between this and another [FCalendarStyle] using the given factor [t].
  @useResult
  FCalendarStyle lerp(FCalendarStyle other, double t) => FCalendarStyle(
    headerStyle: headerStyle.lerp(other.headerStyle, t),
    dayPickerStyle: dayPickerStyle.lerp(other.dayPickerStyle, t),
    yearMonthPickerStyle: yearMonthPickerStyle.lerp(other.yearMonthPickerStyle, t),
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    pageAnimationDuration: t < 0.5 ? pageAnimationDuration : other.pageAnimationDuration,
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
      ..add(DiagnosticsProperty('headerStyle', headerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dayPickerStyle', dayPickerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('yearMonthPickerStyle', yearMonthPickerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('pageAnimationDuration', pageAnimationDuration, level: DiagnosticLevel.debug));
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

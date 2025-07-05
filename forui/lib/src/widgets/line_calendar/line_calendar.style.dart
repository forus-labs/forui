// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'line_calendar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FLineCalendarStyleCopyWith on FLineCalendarStyle {
  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [padding]
  /// The horizontal padding around each calendar item. Defaults to `EdgeInsets.symmetric(horizontal: 6.5)`.
  ///
  /// # [contentEdgeSpacing]
  /// The vertical height between the content and the edges. Defaults to 15.5.
  ///
  /// ## Contract
  /// Throws [AssertionError] if negative.
  ///
  /// # [contentSpacing]
  /// The vertical height between the date and weekday. Defaults to 2.
  ///
  /// ## Contract
  /// Throws [AssertionError] if negative.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// @macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [todayIndicatorColor]
  /// The color of the today indicator.
  ///
  /// @macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [dateTextStyle]
  /// The text style for the date.
  ///
  /// @macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [weekdayTextStyle]
  /// The text style for the day of the week.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [tappableStyle]
  /// The tappable style.
  ///
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsetsGeometry? padding,
    double? contentEdgeSpacing,
    double? contentSpacing,
    FWidgetStateMap<BoxDecoration>? decoration,
    FWidgetStateMap<Color>? todayIndicatorColor,
    FWidgetStateMap<TextStyle>? dateTextStyle,
    FWidgetStateMap<TextStyle>? weekdayTextStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
  }) => FLineCalendarStyle(
    padding: padding ?? this.padding,
    contentEdgeSpacing: contentEdgeSpacing ?? this.contentEdgeSpacing,
    contentSpacing: contentSpacing ?? this.contentSpacing,
    decoration: decoration ?? this.decoration,
    todayIndicatorColor: todayIndicatorColor ?? this.todayIndicatorColor,
    dateTextStyle: dateTextStyle ?? this.dateTextStyle,
    weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );
}

mixin _$FLineCalendarStyleFunctions on Diagnosticable {
  EdgeInsetsGeometry get padding;
  double get contentEdgeSpacing;
  double get contentSpacing;
  FWidgetStateMap<BoxDecoration> get decoration;
  FWidgetStateMap<Color> get todayIndicatorColor;
  FWidgetStateMap<TextStyle> get dateTextStyle;
  FWidgetStateMap<TextStyle> get weekdayTextStyle;
  FTappableStyle get tappableStyle;

  /// Returns itself.
  ///
  /// Allows [FLineCalendarStyle] to replace functions that accept and return a [FLineCalendarStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FLineCalendarStyle Function(FLineCalendarStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FLineCalendarStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FLineCalendarStyle(...));
  /// ```
  @useResult
  FLineCalendarStyle call(Object? _) => this as FLineCalendarStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('contentEdgeSpacing', contentEdgeSpacing))
      ..add(DoubleProperty('contentSpacing', contentSpacing))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('todayIndicatorColor', todayIndicatorColor))
      ..add(DiagnosticsProperty('dateTextStyle', dateTextStyle))
      ..add(DiagnosticsProperty('weekdayTextStyle', weekdayTextStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLineCalendarStyle &&
          padding == other.padding &&
          contentEdgeSpacing == other.contentEdgeSpacing &&
          contentSpacing == other.contentSpacing &&
          decoration == other.decoration &&
          todayIndicatorColor == other.todayIndicatorColor &&
          dateTextStyle == other.dateTextStyle &&
          weekdayTextStyle == other.weekdayTextStyle &&
          tappableStyle == other.tappableStyle);
  @override
  int get hashCode =>
      padding.hashCode ^
      contentEdgeSpacing.hashCode ^
      contentSpacing.hashCode ^
      decoration.hashCode ^
      todayIndicatorColor.hashCode ^
      dateTextStyle.hashCode ^
      weekdayTextStyle.hashCode ^
      tappableStyle.hashCode;
}

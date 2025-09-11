// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'line_calendar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FLineCalendarStyleTransformations on FLineCalendarStyle {
  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FLineCalendarStyle.padding] - The horizontal padding around each calendar item.
  /// * [FLineCalendarStyle.contentEdgeSpacing] - The vertical height between the content and the edges.
  /// * [FLineCalendarStyle.contentSpacing] - The vertical height between the date and weekday.
  /// * [FLineCalendarStyle.decoration] - The decoration.
  /// * [FLineCalendarStyle.todayIndicatorColor] - The color of the today indicator.
  /// * [FLineCalendarStyle.dateTextStyle] - The text style for the date.
  /// * [FLineCalendarStyle.weekdayTextStyle] - The text style for the day of the week.
  /// * [FLineCalendarStyle.tappableStyle] - The tappable style.
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsetsGeometry? padding,
    double? contentEdgeSpacing,
    double? contentSpacing,
    FWidgetStateMap<BoxDecoration>? decoration,
    FWidgetStateMap<Color>? todayIndicatorColor,
    FWidgetStateMap<TextStyle>? dateTextStyle,
    FWidgetStateMap<TextStyle>? weekdayTextStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
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

  /// Linearly interpolate between this and another [FLineCalendarStyle] using the given factor [t].
  @useResult
  FLineCalendarStyle lerp(FLineCalendarStyle other, double t) => FLineCalendarStyle(
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    contentEdgeSpacing: lerpDouble(contentEdgeSpacing, other.contentEdgeSpacing, t) ?? contentEdgeSpacing,
    contentSpacing: lerpDouble(contentSpacing, other.contentSpacing, t) ?? contentSpacing,
    decoration: FWidgetStateMap.lerpBoxDecoration(decoration, other.decoration, t),
    todayIndicatorColor: FWidgetStateMap.lerpColor(todayIndicatorColor, other.todayIndicatorColor, t),
    dateTextStyle: FWidgetStateMap.lerpTextStyle(dateTextStyle, other.dateTextStyle, t),
    weekdayTextStyle: FWidgetStateMap.lerpTextStyle(weekdayTextStyle, other.weekdayTextStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
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
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('contentEdgeSpacing', contentEdgeSpacing, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('contentSpacing', contentSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('todayIndicatorColor', todayIndicatorColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dateTextStyle', dateTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('weekdayTextStyle', weekdayTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug));
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

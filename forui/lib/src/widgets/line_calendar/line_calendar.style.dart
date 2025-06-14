// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'line_calendar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FLineCalendarStyleFunctions on Diagnosticable implements FTransformable {
  EdgeInsetsGeometry get padding;
  double get contentEdgeSpacing;
  double get contentSpacing;
  FWidgetStateMap<BoxDecoration> get decoration;
  FWidgetStateMap<Color> get todayIndicatorColor;
  FWidgetStateMap<TextStyle> get dateTextStyle;
  FWidgetStateMap<TextStyle> get weekdayTextStyle;
  FTappableStyle get tappableStyle;

  /// Returns a copy of this [FLineCalendarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FLineCalendarStyle copyWith({
    EdgeInsetsGeometry? padding,
    double? contentEdgeSpacing,
    double? contentSpacing,
    FWidgetStateMap<BoxDecoration>? decoration,
    FWidgetStateMap<Color>? todayIndicatorColor,
    FWidgetStateMap<TextStyle>? dateTextStyle,
    FWidgetStateMap<TextStyle>? weekdayTextStyle,
    FTappableStyle? tappableStyle,
  }) => FLineCalendarStyle(
    padding: padding ?? this.padding,
    contentEdgeSpacing: contentEdgeSpacing ?? this.contentEdgeSpacing,
    contentSpacing: contentSpacing ?? this.contentSpacing,
    decoration: decoration ?? this.decoration,
    todayIndicatorColor: todayIndicatorColor ?? this.todayIndicatorColor,
    dateTextStyle: dateTextStyle ?? this.dateTextStyle,
    weekdayTextStyle: weekdayTextStyle ?? this.weekdayTextStyle,
    tappableStyle: tappableStyle ?? this.tappableStyle,
  );
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

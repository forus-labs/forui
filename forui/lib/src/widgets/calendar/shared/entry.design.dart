// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'entry.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCalendarEntryStyleTransformations on FCalendarEntryStyle {
  /// Returns a copy of this [FCalendarEntryStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCalendarEntryStyle.backgroundColor] - The day's background color.
  /// * [FCalendarEntryStyle.borderColor] - The border.
  /// * [FCalendarEntryStyle.textStyle] - The day's text style.
  /// * [FCalendarEntryStyle.radius] - The entry border's radius.
  @useResult
  FCalendarEntryStyle copyWith({
    FWidgetStateMap<Color>? backgroundColor,
    FWidgetStateMap<Color?>? borderColor,
    FWidgetStateMap<TextStyle>? textStyle,
    Radius? radius,
  }) => FCalendarEntryStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    borderColor: borderColor ?? this.borderColor,
    textStyle: textStyle ?? this.textStyle,
    radius: radius ?? this.radius,
  );

  /// Linearly interpolate between this and another [FCalendarEntryStyle] using the given factor [t].
  @useResult
  FCalendarEntryStyle lerp(FCalendarEntryStyle other, double t) => FCalendarEntryStyle(
    backgroundColor: FWidgetStateMap.lerpColor(backgroundColor, other.backgroundColor, t),
    borderColor: FWidgetStateMap.lerpWhere(borderColor, other.borderColor, t, Color.lerp),
    textStyle: FWidgetStateMap.lerpTextStyle(textStyle, other.textStyle, t),
    radius: t < 0.5 ? radius : other.radius,
  );
}

mixin _$FCalendarEntryStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color> get backgroundColor;
  FWidgetStateMap<Color?> get borderColor;
  FWidgetStateMap<TextStyle> get textStyle;
  Radius get radius;

  /// Returns itself.
  ///
  /// Allows [FCalendarEntryStyle] to replace functions that accept and return a [FCalendarEntryStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarEntryStyle Function(FCalendarEntryStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarEntryStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarEntryStyle(...));
  /// ```
  @useResult
  FCalendarEntryStyle call(Object? _) => this as FCalendarEntryStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderColor', borderColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('radius', radius, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarEntryStyle &&
          backgroundColor == other.backgroundColor &&
          borderColor == other.borderColor &&
          textStyle == other.textStyle &&
          radius == other.radius);

  @override
  int get hashCode => backgroundColor.hashCode ^ borderColor.hashCode ^ textStyle.hashCode ^ radius.hashCode;
}

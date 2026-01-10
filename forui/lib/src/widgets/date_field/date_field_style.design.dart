// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'date_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDateFieldStyleTransformations on FDateFieldStyle {
  /// Returns a copy of this [FDateFieldStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDateFieldStyle.fieldStyle] - The date field's textfield style.
  /// * [FDateFieldStyle.popoverStyle] - The date field calendar's popover style.
  /// * [FDateFieldStyle.calendarStyle] - The date field's calendar style.
  @useResult
  FDateFieldStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? fieldStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FCalendarStyle Function(FCalendarStyle style)? calendarStyle,
  }) => .new(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    calendarStyle: calendarStyle != null ? calendarStyle(this.calendarStyle) : this.calendarStyle,
  );

  /// Linearly interpolate between this and another [FDateFieldStyle] using the given factor [t].
  @useResult
  FDateFieldStyle lerp(FDateFieldStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    calendarStyle: calendarStyle.lerp(other.calendarStyle, t),
  );
}

mixin _$FDateFieldStyleFunctions on Diagnosticable {
  FTextFieldStyle get fieldStyle;
  FPopoverStyle get popoverStyle;
  FCalendarStyle get calendarStyle;

  /// Returns itself.
  ///
  /// Allows [FDateFieldStyle] to replace functions that accept and return a [FDateFieldStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDateFieldStyle Function(FDateFieldStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDateFieldStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDateFieldStyle(...));
  /// ```
  @useResult
  FDateFieldStyle call(Object? _) => this as FDateFieldStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: .debug))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDateFieldStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          popoverStyle == other.popoverStyle &&
          calendarStyle == other.calendarStyle);

  @override
  int get hashCode => fieldStyle.hashCode ^ popoverStyle.hashCode ^ calendarStyle.hashCode;
}

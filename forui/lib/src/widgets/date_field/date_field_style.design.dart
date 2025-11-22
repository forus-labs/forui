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
  /// * [FDateFieldStyle.textFieldStyle] - The date field's textfield style.
  /// * [FDateFieldStyle.popoverStyle] - The date field calendar's popover style.
  /// * [FDateFieldStyle.calendarStyle] - The date field's calendar style.
  /// * [FDateFieldStyle.iconStyle] - The date field icon's style.
  @useResult
  FDateFieldStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle style)? textFieldStyle,
    FPopoverStyle Function(FPopoverStyle style)? popoverStyle,
    FCalendarStyle Function(FCalendarStyle style)? calendarStyle,
    IconThemeData? iconStyle,
  }) => FDateFieldStyle(
    textFieldStyle: textFieldStyle != null ? textFieldStyle(this.textFieldStyle) : this.textFieldStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    calendarStyle: calendarStyle != null ? calendarStyle(this.calendarStyle) : this.calendarStyle,
    iconStyle: iconStyle ?? this.iconStyle,
  );

  /// Linearly interpolate between this and another [FDateFieldStyle] using the given factor [t].
  @useResult
  FDateFieldStyle lerp(FDateFieldStyle other, double t) => FDateFieldStyle(
    textFieldStyle: textFieldStyle.lerp(other.textFieldStyle, t),
    popoverStyle: popoverStyle.lerp(other.popoverStyle, t),
    calendarStyle: calendarStyle.lerp(other.calendarStyle, t),
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
  );
}

mixin _$FDateFieldStyleFunctions on Diagnosticable {
  FTextFieldStyle get textFieldStyle;
  FPopoverStyle get popoverStyle;
  FCalendarStyle get calendarStyle;
  IconThemeData get iconStyle;

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
      ..add(DiagnosticsProperty('textFieldStyle', textFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('popoverStyle', popoverStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('calendarStyle', calendarStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug));
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

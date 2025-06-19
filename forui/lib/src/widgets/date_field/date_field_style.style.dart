// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'date_field_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FDateFieldStyleCopyWith on FDateFieldStyle {
  /// Returns a copy of this [FDateFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [textFieldStyle]
  /// The date field's textfield style.
  ///
  /// # [popoverStyle]
  /// The date field calendar's popover style.
  ///
  /// # [calendarStyle]
  /// The date field's calendar style.
  ///
  /// # [iconStyle]
  /// The date field icon's style.
  ///
  @useResult
  FDateFieldStyle copyWith({
    FTextFieldStyle Function(FTextFieldStyle)? textFieldStyle,
    FPopoverStyle Function(FPopoverStyle)? popoverStyle,
    FCalendarStyle Function(FCalendarStyle)? calendarStyle,
    IconThemeData? iconStyle,
  }) => FDateFieldStyle(
    textFieldStyle: textFieldStyle != null ? textFieldStyle(this.textFieldStyle) : this.textFieldStyle,
    popoverStyle: popoverStyle != null ? popoverStyle(this.popoverStyle) : this.popoverStyle,
    calendarStyle: calendarStyle != null ? calendarStyle(this.calendarStyle) : this.calendarStyle,
    iconStyle: iconStyle ?? this.iconStyle,
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

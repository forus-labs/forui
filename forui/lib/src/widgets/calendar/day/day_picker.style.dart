// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'day_picker.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FCalendarDayPickerStyleCopyWith on FCalendarDayPickerStyle {
  /// Returns a copy of this [FCalendarDayPickerStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [headerTextStyle]
  /// The text style for the day of th week headers.
  ///
  /// # [current]
  /// The styles of dates in the current month.
  ///
  /// # [enclosing]
  /// The styles of dates in the enclosing months.
  ///
  /// # [startDayOfWeek]
  /// The starting day of the week. Defaults to the current locale's preferred starting day of the week if null.
  ///
  /// Specifying [startDayOfWeek] will override the current locale's preferred starting day of the week.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [startDayOfWeek] < [DateTime.monday]
  /// * [DateTime.sunday] < [startDayOfWeek]
  ///
  /// # [tileSize]
  /// The tile's size. Defaults to 42.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [tileSize] is not positive.
  ///
  @useResult
  FCalendarDayPickerStyle copyWith({
    TextStyle? headerTextStyle,
    FCalendarEntryStyle Function(FCalendarEntryStyle)? current,
    FCalendarEntryStyle Function(FCalendarEntryStyle)? enclosing,
    int? startDayOfWeek,
    double? tileSize,
  }) => FCalendarDayPickerStyle(
    headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    current: current != null ? current(this.current) : this.current,
    enclosing: enclosing != null ? enclosing(this.enclosing) : this.enclosing,
    startDayOfWeek: startDayOfWeek ?? this.startDayOfWeek,
    tileSize: tileSize ?? this.tileSize,
  );
}

mixin _$FCalendarDayPickerStyleFunctions on Diagnosticable {
  TextStyle get headerTextStyle;
  FCalendarEntryStyle get current;
  FCalendarEntryStyle get enclosing;
  int? get startDayOfWeek;
  double get tileSize;

  /// Returns itself.
  ///
  /// Allows [FCalendarDayPickerStyle] to replace functions that accept and return a [FCalendarDayPickerStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCalendarDayPickerStyle Function(FCalendarDayPickerStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCalendarDayPickerStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCalendarDayPickerStyle(...));
  /// ```
  @useResult
  FCalendarDayPickerStyle call(Object? _) => this as FCalendarDayPickerStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle))
      ..add(DiagnosticsProperty('current', current))
      ..add(DiagnosticsProperty('enclosing', enclosing))
      ..add(IntProperty('startDayOfWeek', startDayOfWeek))
      ..add(DoubleProperty('tileSize', tileSize));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarDayPickerStyle &&
          headerTextStyle == other.headerTextStyle &&
          current == other.current &&
          enclosing == other.enclosing &&
          startDayOfWeek == other.startDayOfWeek &&
          tileSize == other.tileSize);
  @override
  int get hashCode =>
      headerTextStyle.hashCode ^ current.hashCode ^ enclosing.hashCode ^ startDayOfWeek.hashCode ^ tileSize.hashCode;
}

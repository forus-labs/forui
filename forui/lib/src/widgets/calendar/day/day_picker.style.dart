// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'day_picker.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FCalendarDayPickerStyleFunctions on Diagnosticable implements FTransformable {
  TextStyle get headerTextStyle;
  FCalendarEntryStyle get current;
  FCalendarEntryStyle get enclosing;
  int? get startDayOfWeek;
  double get tileSize;

  /// Returns a copy of this [FCalendarDayPickerStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FCalendarDayPickerStyle copyWith({
    TextStyle? headerTextStyle,
    FCalendarEntryStyle? current,
    FCalendarEntryStyle? enclosing,
    int? startDayOfWeek,
    double? tileSize,
  }) => FCalendarDayPickerStyle(
    headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    current: current ?? this.current,
    enclosing: enclosing ?? this.enclosing,
    startDayOfWeek: startDayOfWeek ?? this.startDayOfWeek,
    tileSize: tileSize ?? this.tileSize,
  );
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

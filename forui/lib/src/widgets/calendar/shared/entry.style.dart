// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'entry.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FCalendarEntryStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<Color> get backgroundColor;
  FWidgetStateMap<Color?> get borderColor;
  FWidgetStateMap<TextStyle> get textStyle;
  Radius get radius;

  /// Returns a copy of this [FCalendarEntryStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
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
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('borderColor', borderColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('radius', radius));
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

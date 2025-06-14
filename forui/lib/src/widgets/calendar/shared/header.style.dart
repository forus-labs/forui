// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'header.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FCalendarHeaderStyleFunctions on Diagnosticable implements FTransformable {
  FFocusedOutlineStyle get focusedOutlineStyle;
  FButtonStyle get buttonStyle;
  TextStyle get headerTextStyle;
  Duration get animationDuration;

  /// Returns a copy of this [FCalendarHeaderStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FCalendarHeaderStyle copyWith({
    FFocusedOutlineStyle? focusedOutlineStyle,
    FButtonStyle? buttonStyle,
    TextStyle? headerTextStyle,
    Duration? animationDuration,
  }) => FCalendarHeaderStyle(
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
    buttonStyle: buttonStyle ?? this.buttonStyle,
    headerTextStyle: headerTextStyle ?? this.headerTextStyle,
    animationDuration: animationDuration ?? this.animationDuration,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('buttonStyle', buttonStyle))
      ..add(DiagnosticsProperty('headerTextStyle', headerTextStyle))
      ..add(DiagnosticsProperty('animationDuration', animationDuration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCalendarHeaderStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          buttonStyle == other.buttonStyle &&
          headerTextStyle == other.headerTextStyle &&
          animationDuration == other.animationDuration);
  @override
  int get hashCode =>
      focusedOutlineStyle.hashCode ^ buttonStyle.hashCode ^ headerTextStyle.hashCode ^ animationDuration.hashCode;
}

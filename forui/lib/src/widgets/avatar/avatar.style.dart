// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'avatar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FAvatarStyleFunctions on Diagnosticable implements FTransformable {
  Color get backgroundColor;
  Color get foregroundColor;
  TextStyle get textStyle;
  Duration get fadeInDuration;

  /// Returns a copy of this [FAvatarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FAvatarStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? textStyle,
    Duration? fadeInDuration,
  }) => FAvatarStyle(
    backgroundColor: backgroundColor ?? this.backgroundColor,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    textStyle: textStyle ?? this.textStyle,
    fadeInDuration: fadeInDuration ?? this.fadeInDuration,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('fadeInDuration', fadeInDuration));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAvatarStyle &&
          backgroundColor == other.backgroundColor &&
          foregroundColor == other.foregroundColor &&
          textStyle == other.textStyle &&
          fadeInDuration == other.fadeInDuration);
  @override
  int get hashCode =>
      backgroundColor.hashCode ^ foregroundColor.hashCode ^ textStyle.hashCode ^ fadeInDuration.hashCode;
}

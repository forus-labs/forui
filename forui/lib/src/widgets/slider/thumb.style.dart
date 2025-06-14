// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'thumb.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSliderThumbStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<Color> get color;
  FWidgetStateMap<Color> get borderColor;
  double get borderWidth;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns a copy of this [FSliderThumbStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSliderThumbStyle copyWith({
    FWidgetStateMap<Color>? color,
    FWidgetStateMap<Color>? borderColor,
    double? borderWidth,
    FFocusedOutlineStyle? focusedOutlineStyle,
  }) => FSliderThumbStyle(
    color: color ?? this.color,
    borderColor: borderColor ?? this.borderColor,
    borderWidth: borderWidth ?? this.borderWidth,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('borderColor', borderColor))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderThumbStyle &&
          color == other.color &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          focusedOutlineStyle == other.focusedOutlineStyle);
  @override
  int get hashCode => color.hashCode ^ borderColor.hashCode ^ borderWidth.hashCode ^ focusedOutlineStyle.hashCode;
}

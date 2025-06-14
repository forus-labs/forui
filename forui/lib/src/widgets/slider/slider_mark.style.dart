// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_mark.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSliderMarkStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<Color> get tickColor;
  double get tickSize;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  AlignmentGeometry get labelAnchor;
  double get labelOffset;

  /// Returns a copy of this [FSliderMarkStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSliderMarkStyle copyWith({
    FWidgetStateMap<Color>? tickColor,
    double? tickSize,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    AlignmentGeometry? labelAnchor,
    double? labelOffset,
  }) => FSliderMarkStyle(
    tickColor: tickColor ?? this.tickColor,
    tickSize: tickSize ?? this.tickSize,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    labelAnchor: labelAnchor ?? this.labelAnchor,
    labelOffset: labelOffset ?? this.labelOffset,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tickColor', tickColor))
      ..add(DoubleProperty('tickSize', tickSize))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('labelAnchor', labelAnchor))
      ..add(DoubleProperty('labelOffset', labelOffset));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderMarkStyle &&
          tickColor == other.tickColor &&
          tickSize == other.tickSize &&
          labelTextStyle == other.labelTextStyle &&
          labelAnchor == other.labelAnchor &&
          labelOffset == other.labelOffset);
  @override
  int get hashCode =>
      tickColor.hashCode ^ tickSize.hashCode ^ labelTextStyle.hashCode ^ labelAnchor.hashCode ^ labelOffset.hashCode;
}

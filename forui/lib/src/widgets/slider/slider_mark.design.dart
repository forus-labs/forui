// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_mark.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSliderMarkStyleTransformations on FSliderMarkStyle {
  /// Returns a copy of this [FSliderMarkStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSliderMarkStyle.tickColor] - The tick's color.
  /// * [FSliderMarkStyle.tickSize] - The tick's size.
  /// * [FSliderMarkStyle.labelTextStyle] - The label's default text style.
  /// * [FSliderMarkStyle.labelAnchor] - The label's anchor to which the [labelOffset] is applied.
  /// * [FSliderMarkStyle.labelOffset] - The label's offset from the slider, along its cross axis, in logical pixels.
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

  /// Linearly interpolate between this and another [FSliderMarkStyle] using the given factor [t].
  @useResult
  FSliderMarkStyle lerp(FSliderMarkStyle other, double t) => FSliderMarkStyle(
    tickColor: FWidgetStateMap.lerpColor(tickColor, other.tickColor, t),
    tickSize: lerpDouble(tickSize, other.tickSize, t) ?? tickSize,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    labelAnchor: AlignmentGeometry.lerp(labelAnchor, other.labelAnchor, t) ?? labelAnchor,
    labelOffset: lerpDouble(labelOffset, other.labelOffset, t) ?? labelOffset,
  );
}

mixin _$FSliderMarkStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color> get tickColor;
  double get tickSize;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  AlignmentGeometry get labelAnchor;
  double get labelOffset;

  /// Returns itself.
  ///
  /// Allows [FSliderMarkStyle] to replace functions that accept and return a [FSliderMarkStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSliderMarkStyle Function(FSliderMarkStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSliderMarkStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSliderMarkStyle(...));
  /// ```
  @useResult
  FSliderMarkStyle call(Object? _) => this as FSliderMarkStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('tickColor', tickColor, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('tickSize', tickSize, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelAnchor', labelAnchor, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('labelOffset', labelOffset, level: DiagnosticLevel.debug));
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

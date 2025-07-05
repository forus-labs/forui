// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_mark.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSliderMarkStyleCopyWith on FSliderMarkStyle {
  /// Returns a copy of this [FSliderMarkStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [tickColor]
  /// The tick's color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [tickSize]
  /// The tick's size. Defaults to 3.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not positive.
  ///
  /// # [labelTextStyle]
  /// The label's default text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [labelAnchor]
  /// The label's anchor to which the [labelOffset] is applied.
  ///
  /// # [labelOffset]
  /// The label's offset from the slider, along its cross axis, in logical pixels. The top-left corner is always the
  /// origin, regardless of the layout.
  ///
  /// For example, if the layout is [FLayout.ltr] and the cross axis offset is 3, the label will be 3 pixels below the
  /// slider's edge.
  ///
  /// ```diagram
  /// |--------------------------|
  /// |----------[tick]----------|
  /// |__________________________|
  ///              (1)
  ///              (2)
  ///              (3)
  ///            [label]
  /// ```
  ///
  /// Given the same layout, if the cross axis offset is -3, the label will be 3 pixels above the slider's edge.
  ///
  /// ```diagram
  ///            [label]
  ///              (3)
  ///              (2)
  ///              (1)
  /// |--------------------------|
  /// |----------[tick]----------|
  /// |__________________________|
  /// ```
  ///
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

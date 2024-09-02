import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A mark in a [FSlider].
class FSliderMark with Diagnosticable {
  /// The mark's style.
  final FSliderMarkStyle? style;

  /// The percentage in the slider's bar at which to position this mark.
  ///
  /// For example, if the percentage is `0.5`, the mark will be positioned in the middle of the slider's bar.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not between `0` and `1`, inclusive.
  final double percentage;

  /// Whether the mark is visible in the slider's bar. Defaults to true.
  final bool visible;

  /// The mark's label.
  final Widget? label;

  /// Creates a [FSliderMark] at the given percentage in a slider.
  const FSliderMark({
    required this.percentage,
    this.style,
    this.visible = true,
    this.label,
  }) : assert(0 <= percentage && percentage <= 1, 'Percentage must be between 0 and 1, but is $percentage.');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('percentage', percentage))
      ..add(FlagProperty('visible', value: visible, ifTrue: 'visible'));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FSliderMark &&
              runtimeType == other.runtimeType &&
              style == other.style &&
              percentage == other.percentage &&
              visible == other.visible &&
              label == other.label;

  @override
  int get hashCode => style.hashCode ^ percentage.hashCode ^ visible.hashCode ^ label.hashCode;
}

/// The style of a mark in a [FSlider].
final class FSliderMarkStyle with Diagnosticable {
  /// The mark's color.
  final Color color;

  /// The mark's dimension. Defaults to 3.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not positive.
  final double dimension;

  /// The label's anchor to which the [labelCrossAxisOffset] is applied.
  final Alignment labelAnchor;

  /// The label's offset from the slider along the cross axis, in logical pixels. The top-left corner is always the
  /// origin, regardless of the layout.
  ///
  /// For example, if the layout is [Layout.ltr] and the cross axis offset is 3, the label will be 3 pixels below the
  /// slider's edge.
  ///
  /// ```
  /// |--------------------------|
  /// |----------[mark]----------|
  /// |__________________________|
  ///              (1)
  ///              (2)
  ///              (3)
  ///            [label]
  /// ```
  ///
  /// Given the same layout, if the cross axis offset is -3, the label will be 3 pixels above the slider's edge.
  ///
  /// ```
  ///            [label]
  ///              (3)
  ///              (2)
  ///              (1)
  /// |--------------------------|
  /// |----------[mark]----------|
  /// |__________________________|
  /// ```
  final double labelCrossAxisOffset;

  /// Creates a [FSliderMarkStyle].
  const FSliderMarkStyle({
    required this.color,
    required this.labelAnchor,
    required this.labelCrossAxisOffset,
    this.dimension = 3,
  }) : assert(0 < dimension, 'Dimension must be positive, but is $dimension.');

  /// Returns a copy of this [FSliderMarkStyle] but with the given fields replaced with the new values.
  @useResult
  FSliderMarkStyle copyWith({
    Color? color,
    double? dimension,
    Alignment? labelAnchor,
    double? labelCrossAxisOffset,
  }) =>
      FSliderMarkStyle(
        color: color ?? this.color,
        dimension: dimension ?? this.dimension,
        labelAnchor: labelAnchor ?? this.labelAnchor,
        labelCrossAxisOffset: labelCrossAxisOffset ?? this.labelCrossAxisOffset,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('dimension', dimension))
      ..add(DiagnosticsProperty('labelAnchor', labelAnchor))
      ..add(DoubleProperty('labelCrossAxisOffset', labelCrossAxisOffset));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderMarkStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          dimension == other.dimension &&
          labelAnchor == other.labelAnchor &&
          labelCrossAxisOffset == other.labelCrossAxisOffset;

  @override
  int get hashCode => color.hashCode ^ dimension.hashCode ^ labelAnchor.hashCode ^ labelCrossAxisOffset.hashCode;
}
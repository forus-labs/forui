import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A mark in a [FSlider]. It is a combination of a tick - a visual indicator along the track, and a label.
final class FSliderMark with Diagnosticable {
  /// The mark's style.
  final FSliderMarkStyle? style;

  /// The offset in the slider's track at which to position this mark, in percentage.
  ///
  /// For example, if the value is `0.5`, the mark will be positioned in the middle of the slider's bar.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not between `0` and `1`, inclusive.
  final double value;

  /// True if a tick should be shown. Defaults to true.
  final bool tick;

  /// The mark's label.
  final Widget? label;

  /// Creates a [FSliderMark] at the given percentage in a slider.
  const FSliderMark({
    required this.value,
    this.style,
    this.tick = true,
    this.label,
  }) : assert(0 <= value && value <= 1, 'offset must be between 0 and 1, but is $value.');

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('offset', value))
      ..add(FlagProperty('tick', value: tick, ifTrue: 'tick'));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderMark &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          value == other.value &&
          tick == other.tick &&
          label == other.label;

  @override
  int get hashCode => style.hashCode ^ value.hashCode ^ tick.hashCode ^ label.hashCode;
}

/// A [FSlider] mark's style.
final class FSliderMarkStyle with Diagnosticable {
  /// The tick's color.
  final Color tickColor;

  /// The tick's size. Defaults to 3.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not positive.
  final double tickSize;

  /// The label's default text style.
  final TextStyle labelTextStyle;

  /// The label's anchor to which the [labelOffset] is applied.
  final Alignment labelAnchor;

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
  final double labelOffset;

  /// Creates a [FSliderMarkStyle].
  const FSliderMarkStyle({
    required this.tickColor,
    required this.labelTextStyle,
    required this.labelAnchor,
    required this.labelOffset,
    this.tickSize = 3,
  }) : assert(0 < tickSize, 'tickDimension must be positive, but is $tickSize.');

  /// Returns a copy of this [FSliderMarkStyle] but with the given fields replaced with the new values.
  @useResult
  FSliderMarkStyle copyWith({
    Color? tickColor,
    double? tickSize,
    TextStyle? labelTextStyle,
    Alignment? labelAnchor,
    double? labelOffset,
  }) =>
      FSliderMarkStyle(
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
      ..add(ColorProperty('tickColor', tickColor))
      ..add(DoubleProperty('tickSize', tickSize))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('labelAnchor', labelAnchor))
      ..add(DoubleProperty('labelCrossAxisOffset', labelOffset));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderMarkStyle &&
          runtimeType == other.runtimeType &&
          tickColor == other.tickColor &&
          tickSize == other.tickSize &&
          labelTextStyle == other.labelTextStyle &&
          labelAnchor == other.labelAnchor &&
          labelOffset == other.labelOffset;

  @override
  int get hashCode =>
      tickColor.hashCode ^ tickSize.hashCode ^ labelTextStyle.hashCode ^ labelAnchor.hashCode ^ labelOffset.hashCode;
}

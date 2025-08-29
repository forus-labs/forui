import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'slider_mark.design.dart';

/// A mark in a [FSlider]. It is a combination of a tick - a visual indicator along the track, and a label.
class FSliderMark with Diagnosticable {
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
  const FSliderMark({required this.value, this.style, this.tick = true, this.label})
    : assert(0 <= value && value <= 1, 'value ($value) must be between 0.0 and 1.0, inclusive.');

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
class FSliderMarkStyle with Diagnosticable, _$FSliderMarkStyleFunctions {
  /// The tick's color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<Color> tickColor;

  /// The tick's size. Defaults to 3.
  ///
  /// ## Contract
  /// Throws [AssertionError] if it is not positive.
  @override
  final double tickSize;

  /// The label's default text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<TextStyle> labelTextStyle;

  /// The label's anchor to which the [labelOffset] is applied.
  @override
  final AlignmentGeometry labelAnchor;

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
  @override
  final double labelOffset;

  /// Creates a [FSliderMarkStyle].
  const FSliderMarkStyle({
    required this.tickColor,
    required this.labelTextStyle,
    required this.labelAnchor,
    required this.labelOffset,
    this.tickSize = 3,
  }) : assert(0 < tickSize, 'tickSize ($tickSize) must be > 0');
}

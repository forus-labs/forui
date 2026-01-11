import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'slider_styles.design.dart';

/// A slider's styles.
class FSliderStyles with Diagnosticable, _$FSliderStylesFunctions {
  /// The enabled slider's horizontal style.
  @override
  final FSliderStyle horizontalStyle;

  /// The enabled slider's vertical style.
  @override
  final FSliderStyle verticalStyle;

  /// Creates a [FSliderStyles].
  FSliderStyles({required this.horizontalStyle, required this.verticalStyle});

  /// Creates a [FSliderStyles] that inherits its properties.
  FSliderStyles.inherit({required FColors colors, required FTypography typography, required FStyle style})
    : this(
        horizontalStyle: .inherit(
          colors: colors,
          typography: typography,
          style: style,
          labelAnchor: .topCenter,
          labelOffset: 10,
          descriptionPadding: const .only(top: 10),
          childPadding: const .only(top: 10, bottom: 20, left: 10, right: 10),
        ),
        verticalStyle: .inherit(
          colors: colors,
          typography: typography,
          style: style,
          labelAnchor: .centerRight,
          labelOffset: -10,
          tooltipTipAnchor: FTouch.primary ? .bottomCenter : .centerLeft,
          tooltipThumbAnchor: FTouch.primary ? .topCenter : .centerRight,
          descriptionPadding: const .only(top: 5),
          childPadding: const .all(10),
        ),
      );
}

/// A slider's style.
class FSliderStyle extends FLabelStyle with _$FSliderStyleFunctions {
  /// The slider's active track colors.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<Color> activeColor;

  /// The slider's inactive track colors.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  @override
  final FWidgetStateMap<Color> inactiveColor;

  /// The slider's border radius.
  @override
  final BorderRadius borderRadius;

  /// The slider's cross-axis extent. Defaults to 8.
  ///
  /// ## Contract:
  /// Throws [AssertionError] if it is not positive.
  @override
  final double crossAxisExtent;

  /// The thumb's size. Defaults to `25` on touch platforms and `20` on non-touch platforms.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [thumbSize] is not positive.
  ///
  /// ## Implementation details
  /// This unfortunately has to be placed outside of FSliderThumbStyle because [FSliderThumbStyle] is inside
  /// [FSliderStyle]. Putting the thumb size inside [FSliderThumbStyle] will cause a cyclic rebuild to occur
  /// whenever the window is resized due to a bad interaction between an internal LayoutBuilder and SliderFormField.
  @override
  final double thumbSize;

  /// The slider thumb's style.
  @override
  final FSliderThumbStyle thumbStyle;

  /// The slider marks' style.
  @override
  final FSliderMarkStyle markStyle;

  /// The tooltip's style.
  @override
  final FTooltipStyle tooltipStyle;

  /// The tooltip's motion-related properties.
  @override
  final FTooltipMotion tooltipMotion;

  /// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned.
  ///
  /// Defaults to [Alignment.bottomCenter] on primarily touch devices and [Alignment.centerLeft] on non-primarily touch
  /// devices.
  @override
  final AlignmentGeometry tooltipTipAnchor;

  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned.
  ///
  /// Defaults to [Alignment.topCenter] on primarily touch devices and [Alignment.centerRight] on non-primarily touch
  /// devices.
  @override
  final AlignmentGeometry tooltipThumbAnchor;

  /// Creates a [FSliderStyle].
  FSliderStyle({
    required this.activeColor,
    required this.inactiveColor,
    required this.thumbStyle,
    required this.markStyle,
    required this.tooltipStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.errorTextStyle,
    this.borderRadius = const .all(.circular(4)),
    this.crossAxisExtent = 8,
    double? thumbSize,
    this.tooltipMotion = const FTooltipMotion(),
    this.tooltipTipAnchor = .bottomCenter,
    this.tooltipThumbAnchor = .topCenter,
    super.labelPadding = const .only(bottom: 5),
    super.descriptionPadding,
    super.errorPadding = const .only(top: 5),
    super.childPadding,
  }) : assert(thumbSize == null || 0 < thumbSize, 'thumbSize ($thumbSize) must be > 0'),
       thumbSize = thumbSize ?? (FTouch.primary ? 25 : 20);

  /// Creates a [FSliderStyle] that inherits its properties.
  FSliderStyle.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
    required AlignmentGeometry labelAnchor,
    required double labelOffset,
    required EdgeInsetsGeometry descriptionPadding,
    required EdgeInsetsGeometry childPadding,
    AlignmentGeometry tooltipTipAnchor = .bottomCenter,
    AlignmentGeometry tooltipThumbAnchor = .topCenter,
  }) : this(
         activeColor: FWidgetStateMap({
           WidgetState.disabled: colors.disable(colors.primary, colors.secondary),
           WidgetState.any: colors.primary,
         }),
         inactiveColor: .all(colors.secondary),
         thumbStyle: FSliderThumbStyle(
           color: .all(colors.primaryForeground),
           borderColor: FWidgetStateMap({
             WidgetState.disabled: colors.disable(colors.primary),
             WidgetState.any: colors.primary,
           }),
           focusedOutlineStyle: style.focusedOutlineStyle,
         ),
         markStyle: FSliderMarkStyle(
           tickColor: .all(colors.mutedForeground),
           labelTextStyle: .all(typography.xs.copyWith(color: colors.mutedForeground)),
           labelAnchor: labelAnchor,
           labelOffset: labelOffset,
         ),
         tooltipStyle: .inherit(colors: colors, typography: typography, style: style),
         tooltipTipAnchor: tooltipTipAnchor,
         tooltipThumbAnchor: tooltipThumbAnchor,
         labelTextStyle: style.formFieldStyle.labelTextStyle,
         descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
         errorTextStyle: style.formFieldStyle.errorTextStyle,
         descriptionPadding: descriptionPadding,
         childPadding: childPadding,
       );
}

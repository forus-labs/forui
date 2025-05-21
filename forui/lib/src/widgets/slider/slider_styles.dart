import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

part 'slider_styles.style.dart';

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
  FSliderStyles.inherit({
    required FColors colors,
    required FTypography typography,
    required FStyle style,
  }) : this(
         horizontalStyle: FSliderStyle.inherit(
           colors: colors,
           typography: typography,
           style: style,
           labelAnchor: Alignment.topCenter,
           labelOffset: 10,
           descriptionPadding: const EdgeInsets.only(top: 10),
           childPadding: const EdgeInsets.only(
             top: 10,
             bottom: 20,
             left: 10,
             right: 10,
           ),
         ),
         verticalStyle: FSliderStyle.inherit(
           colors: colors,
           typography: typography,
           style: style,
           labelAnchor: Alignment.centerRight,
           labelOffset: -10,
           tooltipTipAnchor:
               FTouch.primary ? Alignment.bottomCenter : Alignment.centerLeft,
           tooltipThumbAnchor:
               FTouch.primary ? Alignment.topCenter : Alignment.centerRight,
           descriptionPadding: const EdgeInsets.only(top: 5),
           childPadding: const EdgeInsets.all(10),
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

  /// The thumb's size, inclusive of . Defaults to `25` on touch platforms and `20` on non-touch platforms.
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

  /// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.bottomCenter] on primarily touch devices and [Alignment.centerLeft] on non-primarily touch
  /// devices.
  @override
  final AlignmentGeometry tooltipTipAnchor;

  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned to.
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
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.crossAxisExtent = 8,
    double? thumbSize,
    this.tooltipTipAnchor = Alignment.bottomCenter,
    this.tooltipThumbAnchor = Alignment.topCenter,
    super.labelPadding = const EdgeInsets.only(bottom: 5),
    super.descriptionPadding,
    super.errorPadding = const EdgeInsets.only(top: 5),
    super.childPadding,
  }) : assert(
         thumbSize == null || 0 < thumbSize,
         'The thumb size must be positive',
       ),
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
    AlignmentGeometry tooltipTipAnchor = Alignment.bottomCenter,
    AlignmentGeometry tooltipThumbAnchor = Alignment.topCenter,
  }) : this(
         activeColor: FWidgetStateMap({
           WidgetState.error: colors.error,
           WidgetState.disabled: colors.disable(
             colors.primary,
             colors.secondary,
           ),
           WidgetState.any: colors.primary,
         }),
         inactiveColor: FWidgetStateMap.all(colors.secondary),
         thumbStyle: FSliderThumbStyle(
           color: FWidgetStateMap({
             WidgetState.error: colors.errorForeground,
             WidgetState.any: colors.primaryForeground,
           }),
           borderColor: FWidgetStateMap({
             WidgetState.error: colors.error,
             WidgetState.disabled: colors.disable(colors.primary),
             WidgetState.any: colors.primary,
           }),
           focusedOutlineStyle: style.focusedOutlineStyle,
         ),
         markStyle: FSliderMarkStyle(
           tickColor: FWidgetStateMap.all(colors.mutedForeground),
           labelTextStyle: FWidgetStateMap({
             WidgetState.error: typography.xs.copyWith(color: colors.error),
             WidgetState.any: typography.xs.copyWith(
               color: colors.mutedForeground,
             ),
           }),
           labelAnchor: labelAnchor,
           labelOffset: labelOffset,
         ),
         tooltipStyle: FTooltipStyle.inherit(
           colors: colors,
           typography: typography,
           style: style,
         ),
         tooltipTipAnchor: tooltipTipAnchor,
         tooltipThumbAnchor: tooltipThumbAnchor,
         labelTextStyle: style.formFieldStyle.labelTextStyle,
         descriptionTextStyle: style.formFieldStyle.descriptionTextStyle,
         errorTextStyle: style.formFieldStyle.errorTextStyle,
         descriptionPadding: descriptionPadding,
         childPadding: childPadding,
       );
}

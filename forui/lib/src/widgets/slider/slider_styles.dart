import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

part 'slider_styles.style.dart';

/// A slider's styles.
final class FSliderStyles with Diagnosticable, _$FSliderStylesFunctions {
  /// The enabled slider's horizontal style.
  @override
  final FSliderStyle horizontalStyle;

  /// The enabled slider's vertical style.
  @override
  final FSliderStyle verticalStyle;

  /// Creates a [FSliderStyles].
  FSliderStyles({required this.horizontalStyle, required this.verticalStyle});

  /// Creates a [FSliderStyles] that inherits its properties from the given [FColorScheme].
  factory FSliderStyles.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
    required FStyle style,
  }) {
    final enabledHorizontalStyle = FSliderStateStyle(
      labelTextStyle: style.enabledFormFieldStyle.labelTextStyle,
      descriptionTextStyle: style.enabledFormFieldStyle.descriptionTextStyle,
      activeColor: colorScheme.primary,
      inactiveColor: colorScheme.secondary,
      markStyle: FSliderMarkStyle(
        tickColor: colorScheme.mutedForeground,
        labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
        labelAnchor: Alignment.topCenter,
        labelOffset: 10,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.primaryForeground,
        borderColor: colorScheme.primary,
        focusedOutlineStyle: style.focusedOutlineStyle,
      ),
    );

    final disabledHorizontalStyle = FSliderStateStyle(
      labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
      descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
      activeColor: colorScheme.disable(colorScheme.primary, colorScheme.secondary),
      inactiveColor: colorScheme.secondary,
      markStyle: FSliderMarkStyle(
        tickColor: colorScheme.mutedForeground,
        labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
        labelAnchor: Alignment.topCenter,
        labelOffset: 10,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.primaryForeground,
        borderColor: colorScheme.disable(colorScheme.primary),
        focusedOutlineStyle: style.focusedOutlineStyle,
      ),
    );

    final errorHorizontalStyle = FSliderErrorStyle(
      labelTextStyle: style.errorFormFieldStyle.labelTextStyle,
      descriptionTextStyle: style.errorFormFieldStyle.descriptionTextStyle,
      errorTextStyle: style.errorFormFieldStyle.errorTextStyle,
      activeColor: colorScheme.error,
      inactiveColor: colorScheme.secondary,
      markStyle: FSliderMarkStyle(
        tickColor: colorScheme.mutedForeground,
        labelTextStyle: typography.xs.copyWith(color: colorScheme.error),
        labelAnchor: Alignment.topCenter,
        labelOffset: 10,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.errorForeground,
        borderColor: colorScheme.error,
        focusedOutlineStyle: style.focusedOutlineStyle,
      ),
    );

    return FSliderStyles(
      horizontalStyle: FSliderStyle(
        labelLayoutStyle: const FLabelLayoutStyle(
          labelPadding: EdgeInsets.only(bottom: 5),
          childPadding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
          descriptionPadding: EdgeInsets.only(top: 10),
          errorPadding: EdgeInsets.only(top: 5),
        ),
        enabledStyle: enabledHorizontalStyle,
        disabledStyle: disabledHorizontalStyle,
        errorStyle: errorHorizontalStyle,
      ),
      verticalStyle: FSliderStyle(
        labelLayoutStyle: const FLabelLayoutStyle(
          labelPadding: EdgeInsets.only(bottom: 5),
          childPadding: EdgeInsets.all(10),
          descriptionPadding: EdgeInsets.only(top: 5),
          errorPadding: EdgeInsets.only(top: 5),
        ),
        enabledStyle: enabledHorizontalStyle.transform(
          (style) =>
              style.copyWith(markStyle: style.markStyle.copyWith(labelAnchor: Alignment.centerRight, labelOffset: -10)),
        ),
        disabledStyle: disabledHorizontalStyle.transform(
          (style) =>
              style.copyWith(markStyle: style.markStyle.copyWith(labelAnchor: Alignment.centerRight, labelOffset: -10)),
        ),
        errorStyle: errorHorizontalStyle.transform(
          (style) =>
              style.copyWith(markStyle: style.markStyle.copyWith(labelAnchor: Alignment.centerRight, labelOffset: -10)),
        ),
        tooltipTipAnchor: Touch.primary ? Alignment.bottomCenter : Alignment.centerLeft,
        tooltipThumbAnchor: Touch.primary ? Alignment.topCenter : Alignment.centerRight,
      ),
    );
  }
}

/// A slider's style.
final class FSliderStyle with Diagnosticable, _$FSliderStyleFunctions {
  /// The label's layout style.
  @override
  final FLabelLayoutStyle labelLayoutStyle;

  /// The enabled slider's style.
  @override
  final FSliderStateStyle enabledStyle;

  /// The disabled slider's style.
  @override
  final FSliderStateStyle disabledStyle;

  /// The error slider's style.
  @override
  final FSliderErrorStyle errorStyle;

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
  /// [FSliderStateStyle]. Putting the thumb size inside [FSliderThumbStyle] will cause a cyclic rebuild to occur
  /// whenever the window is resized due to some bad interaction between an internal LayoutBuilder and SliderFormField.
  @override
  final double thumbSize;

  /// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.bottomCenter] on primarily touch devices and [Alignment.centerLeft] on non-primarily touch
  /// devices.
  @override
  final Alignment tooltipTipAnchor;

  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.topCenter] on primarily touch devices and [Alignment.centerRight] on non-primarily touch
  /// devices.
  @override
  final Alignment tooltipThumbAnchor;

  /// Creates a [FSliderStyle].
  FSliderStyle({
    required this.labelLayoutStyle,
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
    this.crossAxisExtent = 8,
    double? thumbSize,
    this.tooltipTipAnchor = Alignment.bottomCenter,
    this.tooltipThumbAnchor = Alignment.topCenter,
  }) : assert(thumbSize == null || 0 < thumbSize, 'The thumb size must be positive'),
       thumbSize = thumbSize ?? (Touch.primary ? 25 : 20);
}

/// A slider state's style.
// ignore: avoid_implementing_value_types
final class FSliderStateStyle with Diagnosticable, _$FSliderStateStyleFunctions implements FFormFieldStyle {
  /// The label's [TextStyle].
  @override
  final TextStyle labelTextStyle;

  /// The help/error's [TextStyle].
  @override
  final TextStyle descriptionTextStyle;

  /// The slider's active track color.
  @override
  final Color activeColor;

  /// The slider's inactive track color.
  @override
  final Color inactiveColor;

  /// The slider's border radius.
  @override
  final BorderRadius borderRadius;

  /// The slider marks' style.
  @override
  final FSliderMarkStyle markStyle;

  /// The slider thumb's style.
  @override
  final FSliderThumbStyle thumbStyle;

  /// The tooltip's style.
  @override
  final FTooltipStyle tooltipStyle;

  /// Creates a [FSliderStateStyle].
  FSliderStateStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
    required this.activeColor,
    required this.inactiveColor,
    required this.markStyle,
    required this.thumbStyle,
    required this.tooltipStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });
}

/// A slider error's style.
final class FSliderErrorStyle extends FSliderStateStyle
    with _$FSliderErrorStyleFunctions
        // ignore: avoid_implementing_value_types
        implements
        FFormFieldErrorStyle {
  /// The error's [TextStyle].
  @override
  final TextStyle errorTextStyle;

  /// Creates a [FSliderErrorStyle].
  FSliderErrorStyle({
    required this.errorTextStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
    required super.activeColor,
    required super.inactiveColor,
    required super.markStyle,
    required super.thumbStyle,
    required super.tooltipStyle,
    super.borderRadius,
  });
}

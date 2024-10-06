import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/tappable.dart';

/// A slider's styles.
final class FSliderStyles with Diagnosticable {
  /// The enabled slider's horizontal style.
  final FSliderStyle horizontalStyle;

  /// The enabled slider's vertical style.
  final FSliderStyle verticalStyle;

  /// Creates a [FSliderStyles].
  FSliderStyles({
    required this.horizontalStyle,
    required this.verticalStyle,
  });

  /// Creates a [FSliderStyles] that inherits its properties from the given [FStateColorScheme].
  factory FSliderStyles.inherit({
    required FStateColorScheme colorScheme,
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
      ),
    );

    final disabledHorizontalStyle = FSliderStateStyle(
      labelTextStyle: style.disabledFormFieldStyle.labelTextStyle,
      descriptionTextStyle: style.disabledFormFieldStyle.descriptionTextStyle,
      activeColor: colorScheme.disable(colorScheme.primary),
      inactiveColor: colorScheme.secondary,
      markStyle: FSliderMarkStyle(
        tickColor: colorScheme.mutedForeground,
        labelTextStyle: typography.xs.copyWith(color: colorScheme.disable(colorScheme.mutedForeground)),
        labelAnchor: Alignment.topCenter,
        labelOffset: 10,
      ),
      tooltipStyle: FTooltipStyle.inherit(colorScheme: colorScheme, typography: typography, style: style),
      thumbStyle: FSliderThumbStyle(
        color: colorScheme.primaryForeground,
        borderColor: colorScheme.disable(colorScheme.primary),
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
        enabledStyle: enabledHorizontalStyle.copyWith(
          markStyle: FSliderMarkStyle(
            tickColor: colorScheme.mutedForeground,
            labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
            labelAnchor: Alignment.centerRight,
            labelOffset: -10,
          ),
        ),
        disabledStyle: disabledHorizontalStyle.copyWith(
          markStyle: FSliderMarkStyle(
            tickColor: colorScheme.mutedForeground,
            labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground.withOpacity(0.7)),
            labelAnchor: Alignment.centerRight,
            labelOffset: -10,
          ),
        ),
        errorStyle: errorHorizontalStyle.copyWith(
          markStyle: FSliderMarkStyle(
            tickColor: colorScheme.mutedForeground,
            labelTextStyle: typography.xs.copyWith(color: colorScheme.mutedForeground),
            labelAnchor: Alignment.centerRight,
            labelOffset: -10,
          ),
        ),
        tooltipTipAnchor: Touch.primary ? Alignment.bottomCenter : Alignment.centerLeft,
        tooltipThumbAnchor: Touch.primary ? Alignment.topCenter : Alignment.centerRight,
      ),
    );
  }

  /// Returns a copy of this [FSliderStyles] but with the given fields replaced with the new values.
  @useResult
  FSliderStyles copyWith({
    FSliderStyle? horizontalStyle,
    FSliderStyle? verticalStyle,
  }) =>
      FSliderStyles(
        horizontalStyle: horizontalStyle ?? this.horizontalStyle,
        verticalStyle: verticalStyle ?? this.verticalStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderStyles &&
          runtimeType == other.runtimeType &&
          horizontalStyle == other.horizontalStyle &&
          verticalStyle == other.verticalStyle;

  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}

/// A slider's style.
final class FSliderStyle with Diagnosticable {
  /// The label's layout style.
  final FLabelLayoutStyle labelLayoutStyle;

  /// The enabled slider's style.
  final FSliderStateStyle enabledStyle;

  /// The disabled slider's style.
  final FSliderStateStyle disabledStyle;

  /// The error slider's style.
  final FSliderErrorStyle errorStyle;

  /// The slider's cross-axis extent. Defaults to 8.
  ///
  /// ## Contract:
  /// Throws [AssertionError] if it is not positive.
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
  final double thumbSize;

  /// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.bottomCenter] on primarily touch devices and [Alignment.centerLeft] on non-primarily touch
  /// devices.
  final Alignment tooltipTipAnchor;

  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned to.
  ///
  /// Defaults to [Alignment.topCenter] on primarily touch devices and [Alignment.centerRight] on non-primarily touch
  /// devices.
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
  })  : assert(thumbSize == null || 0 < thumbSize, 'The thumb size must be positive'),
        thumbSize = thumbSize ?? (Touch.primary ? 25 : 20);

  /// Returns a copy of this [FSliderStyle] but with the given fields replaced with the new values.
  @useResult
  FSliderStyle copyWith({
    FLabelLayoutStyle? labelLayoutStyle,
    FSliderStateStyle? enabledStyle,
    FSliderStateStyle? disabledStyle,
    FSliderErrorStyle? errorStyle,
    double? thumbSize,
    double? crossAxisExtent,
    Alignment? tooltipTipAnchor,
    Alignment? tooltipThumbAnchor,
  }) =>
      FSliderStyle(
        labelLayoutStyle: labelLayoutStyle ?? this.labelLayoutStyle,
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
        thumbSize: thumbSize ?? this.thumbSize,
        crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
        tooltipTipAnchor: tooltipTipAnchor ?? this.tooltipTipAnchor,
        tooltipThumbAnchor: tooltipThumbAnchor ?? this.tooltipThumbAnchor,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelLayoutStyle', labelLayoutStyle))
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle))
      ..add(DiagnosticsProperty('thumbSize', thumbSize))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DiagnosticsProperty('tooltipTipAnchor', tooltipTipAnchor))
      ..add(DiagnosticsProperty('tooltipThumbAnchor', tooltipThumbAnchor));
  }

  /// The label style.
  // ignore: diagnostic_describe_all_properties
  FLabelStyle get labelStyle => (
        layout: labelLayoutStyle,
        state: FLabelStateStyles(
          enabledStyle: enabledStyle,
          disabledStyle: disabledStyle,
          errorStyle: errorStyle,
        ),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderStyle &&
          runtimeType == other.runtimeType &&
          labelLayoutStyle == other.labelLayoutStyle &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle &&
          crossAxisExtent == other.crossAxisExtent &&
          tooltipTipAnchor == other.tooltipTipAnchor &&
          tooltipThumbAnchor == other.tooltipThumbAnchor;

  @override
  int get hashCode =>
      labelLayoutStyle.hashCode ^
      enabledStyle.hashCode ^
      disabledStyle.hashCode ^
      errorStyle.hashCode ^
      crossAxisExtent.hashCode ^
      tooltipTipAnchor.hashCode ^
      tooltipThumbAnchor.hashCode;
}

/// A slider state's style.
// ignore: avoid_implementing_value_types
final class FSliderStateStyle with Diagnosticable implements FFormFieldStyle {
  /// The label's [TextStyle].
  @override
  final TextStyle labelTextStyle;

  /// The help/error's [TextStyle].
  @override
  final TextStyle descriptionTextStyle;

  /// The slider's active color.
  final Color activeColor;

  /// The slider inactive color.
  final Color inactiveColor;

  /// The slider's border radius.
  final BorderRadius borderRadius;

  /// The slider marks' style.
  final FSliderMarkStyle markStyle;

  /// The slider thumb's style.
  final FSliderThumbStyle thumbStyle;

  /// The tooltip's style.
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

  /// Returns a copy of this [FSliderStateStyle] but with the given fields replaced with the new values.
  @useResult
  @override
  FSliderStateStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    Color? activeColor,
    Color? inactiveColor,
    double? mainAxisPadding,
    BorderRadius? borderRadius,
    FSliderMarkStyle? markStyle,
    FSliderThumbStyle? thumbStyle,
    FTooltipStyle? tooltipStyle,
  }) =>
      FSliderStateStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        borderRadius: borderRadius ?? this.borderRadius,
        markStyle: markStyle ?? this.markStyle,
        thumbStyle: thumbStyle ?? this.thumbStyle,
        tooltipStyle: tooltipStyle ?? this.tooltipStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(ColorProperty('activeColor', activeColor))
      ..add(ColorProperty('inactiveColor', inactiveColor))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('markStyle', markStyle))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle))
      ..add(DiagnosticsProperty('tooltipStyle', tooltipStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSliderStateStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          activeColor == other.activeColor &&
          inactiveColor == other.inactiveColor &&
          borderRadius == other.borderRadius &&
          markStyle == other.markStyle &&
          thumbStyle == other.thumbStyle &&
          tooltipStyle == other.tooltipStyle;

  @override
  int get hashCode =>
      activeColor.hashCode ^
      inactiveColor.hashCode ^
      borderRadius.hashCode ^
      markStyle.hashCode ^
      thumbStyle.hashCode ^
      tooltipStyle.hashCode;
}

/// A slider error's style.
// ignore: avoid_implementing_value_types
final class FSliderErrorStyle extends FSliderStateStyle implements FFormFieldErrorStyle {
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

  /// Returns a copy of this [FSliderStateStyle] but with the given fields replaced with the new values.
  @useResult
  @override
  FSliderErrorStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? errorTextStyle,
    Color? activeColor,
    Color? inactiveColor,
    double? mainAxisPadding,
    BorderRadius? borderRadius,
    FSliderMarkStyle? markStyle,
    FSliderThumbStyle? thumbStyle,
    FTooltipStyle? tooltipStyle,
  }) =>
      FSliderErrorStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
        activeColor: activeColor ?? this.activeColor,
        inactiveColor: inactiveColor ?? this.inactiveColor,
        borderRadius: borderRadius ?? this.borderRadius,
        markStyle: markStyle ?? this.markStyle,
        thumbStyle: thumbStyle ?? this.thumbStyle,
        tooltipStyle: tooltipStyle ?? this.tooltipStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
  }
}

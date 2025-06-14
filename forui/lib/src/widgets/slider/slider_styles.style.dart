// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_styles.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSliderStylesFunctions on Diagnosticable implements FTransformable {
  FSliderStyle get horizontalStyle;
  FSliderStyle get verticalStyle;

  /// Returns a copy of this [FSliderStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSliderStyles copyWith({FSliderStyle? horizontalStyle, FSliderStyle? verticalStyle}) => FSliderStyles(
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
      (other is FSliderStyles && horizontalStyle == other.horizontalStyle && verticalStyle == other.verticalStyle);
  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}
mixin _$FSliderStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<Color> get activeColor;
  FWidgetStateMap<Color> get inactiveColor;
  BorderRadius get borderRadius;
  double get crossAxisExtent;
  double get thumbSize;
  FSliderThumbStyle get thumbStyle;
  FSliderMarkStyle get markStyle;
  FTooltipStyle get tooltipStyle;
  AlignmentGeometry get tooltipTipAnchor;
  AlignmentGeometry get tooltipThumbAnchor;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns a copy of this [FSliderStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FSliderStyle copyWith({
    FWidgetStateMap<Color>? activeColor,
    FWidgetStateMap<Color>? inactiveColor,
    BorderRadius? borderRadius,
    double? crossAxisExtent,
    double? thumbSize,
    FSliderThumbStyle? thumbStyle,
    FSliderMarkStyle? markStyle,
    FTooltipStyle? tooltipStyle,
    AlignmentGeometry? tooltipTipAnchor,
    AlignmentGeometry? tooltipThumbAnchor,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FSliderStyle(
    activeColor: activeColor ?? this.activeColor,
    inactiveColor: inactiveColor ?? this.inactiveColor,
    borderRadius: borderRadius ?? this.borderRadius,
    crossAxisExtent: crossAxisExtent ?? this.crossAxisExtent,
    thumbSize: thumbSize ?? this.thumbSize,
    thumbStyle: thumbStyle ?? this.thumbStyle,
    markStyle: markStyle ?? this.markStyle,
    tooltipStyle: tooltipStyle ?? this.tooltipStyle,
    tooltipTipAnchor: tooltipTipAnchor ?? this.tooltipTipAnchor,
    tooltipThumbAnchor: tooltipThumbAnchor ?? this.tooltipThumbAnchor,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('activeColor', activeColor))
      ..add(DiagnosticsProperty('inactiveColor', inactiveColor))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('thumbSize', thumbSize))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle))
      ..add(DiagnosticsProperty('markStyle', markStyle))
      ..add(DiagnosticsProperty('tooltipStyle', tooltipStyle))
      ..add(DiagnosticsProperty('tooltipTipAnchor', tooltipTipAnchor))
      ..add(DiagnosticsProperty('tooltipThumbAnchor', tooltipThumbAnchor))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding))
      ..add(DiagnosticsProperty('errorPadding', errorPadding))
      ..add(DiagnosticsProperty('childPadding', childPadding))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderStyle &&
          activeColor == other.activeColor &&
          inactiveColor == other.inactiveColor &&
          borderRadius == other.borderRadius &&
          crossAxisExtent == other.crossAxisExtent &&
          thumbSize == other.thumbSize &&
          thumbStyle == other.thumbStyle &&
          markStyle == other.markStyle &&
          tooltipStyle == other.tooltipStyle &&
          tooltipTipAnchor == other.tooltipTipAnchor &&
          tooltipThumbAnchor == other.tooltipThumbAnchor &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);
  @override
  int get hashCode =>
      activeColor.hashCode ^
      inactiveColor.hashCode ^
      borderRadius.hashCode ^
      crossAxisExtent.hashCode ^
      thumbSize.hashCode ^
      thumbStyle.hashCode ^
      markStyle.hashCode ^
      tooltipStyle.hashCode ^
      tooltipTipAnchor.hashCode ^
      tooltipThumbAnchor.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

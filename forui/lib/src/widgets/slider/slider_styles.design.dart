// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_styles.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSliderStylesTransformations on FSliderStyles {
  /// Returns a copy of this [FSliderStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSliderStyles.horizontalStyle] - The enabled slider's horizontal style.
  /// * [FSliderStyles.verticalStyle] - The enabled slider's vertical style.
  @useResult
  FSliderStyles copyWith({
    FSliderStyle Function(FSliderStyle style)? horizontalStyle,
    FSliderStyle Function(FSliderStyle style)? verticalStyle,
  }) => FSliderStyles(
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
  );

  /// Linearly interpolate between this and another [FSliderStyles] using the given factor [t].
  @useResult
  FSliderStyles lerp(FSliderStyles other, double t) => FSliderStyles(
    horizontalStyle: horizontalStyle.lerp(other.horizontalStyle, t),
    verticalStyle: verticalStyle.lerp(other.verticalStyle, t),
  );
}

mixin _$FSliderStylesFunctions on Diagnosticable {
  FSliderStyle get horizontalStyle;
  FSliderStyle get verticalStyle;

  /// Returns itself.
  ///
  /// Allows [FSliderStyles] to replace functions that accept and return a [FSliderStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSliderStyles Function(FSliderStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSliderStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSliderStyles(...));
  /// ```
  @useResult
  FSliderStyles call(Object? _) => this as FSliderStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSliderStyles && horizontalStyle == other.horizontalStyle && verticalStyle == other.verticalStyle);

  @override
  int get hashCode => horizontalStyle.hashCode ^ verticalStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FSliderStyleTransformations on FSliderStyle {
  /// Returns a copy of this [FSliderStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSliderStyle.activeColor] - The slider's active track colors.
  /// * [FSliderStyle.inactiveColor] - The slider's inactive track colors.
  /// * [FSliderStyle.borderRadius] - The slider's border radius.
  /// * [FSliderStyle.crossAxisExtent] - The slider's cross-axis extent.
  /// * [FSliderStyle.thumbSize] - The thumb's size.
  /// * [FSliderStyle.thumbStyle] - The slider thumb's style.
  /// * [FSliderStyle.markStyle] - The slider marks' style.
  /// * [FSliderStyle.tooltipStyle] - The tooltip's style.
  /// * [FSliderStyle.tooltipMotion] - The tooltip's motion-related properties.
  /// * [FSliderStyle.tooltipTipAnchor] - The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned.
  /// * [FSliderStyle.tooltipThumbAnchor] - The anchor of the thumb to which the [tooltipTipAnchor] is aligned.
  /// * [FSliderStyle.labelPadding] - The label's padding.
  /// * [FSliderStyle.descriptionPadding] - The description's padding.
  /// * [FSliderStyle.errorPadding] - The error's padding.
  /// * [FSliderStyle.childPadding] - The child's padding.
  /// * [FSliderStyle.labelTextStyle] - The label's text style.
  /// * [FSliderStyle.descriptionTextStyle] - The description's text style.
  /// * [FSliderStyle.errorTextStyle] - The error's text style.
  @useResult
  FSliderStyle copyWith({
    FWidgetStateMap<Color>? activeColor,
    FWidgetStateMap<Color>? inactiveColor,
    BorderRadius? borderRadius,
    double? crossAxisExtent,
    double? thumbSize,
    FSliderThumbStyle Function(FSliderThumbStyle style)? thumbStyle,
    FSliderMarkStyle Function(FSliderMarkStyle style)? markStyle,
    FTooltipStyle Function(FTooltipStyle style)? tooltipStyle,
    FTooltipMotion Function(FTooltipMotion motion)? tooltipMotion,
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
    thumbStyle: thumbStyle != null ? thumbStyle(this.thumbStyle) : this.thumbStyle,
    markStyle: markStyle != null ? markStyle(this.markStyle) : this.markStyle,
    tooltipStyle: tooltipStyle != null ? tooltipStyle(this.tooltipStyle) : this.tooltipStyle,
    tooltipMotion: tooltipMotion != null ? tooltipMotion(this.tooltipMotion) : this.tooltipMotion,
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

  /// Linearly interpolate between this and another [FSliderStyle] using the given factor [t].
  @useResult
  FSliderStyle lerp(FSliderStyle other, double t) => FSliderStyle(
    activeColor: FWidgetStateMap.lerpColor(activeColor, other.activeColor, t),
    inactiveColor: FWidgetStateMap.lerpColor(inactiveColor, other.inactiveColor, t),
    borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    crossAxisExtent: lerpDouble(crossAxisExtent, other.crossAxisExtent, t) ?? crossAxisExtent,
    thumbSize: lerpDouble(thumbSize, other.thumbSize, t) ?? thumbSize,
    thumbStyle: thumbStyle.lerp(other.thumbStyle, t),
    markStyle: markStyle.lerp(other.markStyle, t),
    tooltipStyle: tooltipStyle.lerp(other.tooltipStyle, t),
    tooltipMotion: tooltipMotion.lerp(other.tooltipMotion, t),
    tooltipTipAnchor: AlignmentGeometry.lerp(tooltipTipAnchor, other.tooltipTipAnchor, t) ?? tooltipTipAnchor,
    tooltipThumbAnchor: AlignmentGeometry.lerp(tooltipThumbAnchor, other.tooltipThumbAnchor, t) ?? tooltipThumbAnchor,
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FSliderStyleFunctions on Diagnosticable {
  FWidgetStateMap<Color> get activeColor;
  FWidgetStateMap<Color> get inactiveColor;
  BorderRadius get borderRadius;
  double get crossAxisExtent;
  double get thumbSize;
  FSliderThumbStyle get thumbStyle;
  FSliderMarkStyle get markStyle;
  FTooltipStyle get tooltipStyle;
  FTooltipMotion get tooltipMotion;
  AlignmentGeometry get tooltipTipAnchor;
  AlignmentGeometry get tooltipThumbAnchor;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FSliderStyle] to replace functions that accept and return a [FSliderStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSliderStyle Function(FSliderStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSliderStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSliderStyle(...));
  /// ```
  @useResult
  FSliderStyle call(Object? _) => this as FSliderStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('activeColor', activeColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('inactiveColor', inactiveColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('thumbSize', thumbSize, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('thumbStyle', thumbStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('markStyle', markStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tooltipStyle', tooltipStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tooltipMotion', tooltipMotion, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tooltipTipAnchor', tooltipTipAnchor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tooltipThumbAnchor', tooltipThumbAnchor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorPadding', errorPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle, level: DiagnosticLevel.debug));
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
          tooltipMotion == other.tooltipMotion &&
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
      tooltipMotion.hashCode ^
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

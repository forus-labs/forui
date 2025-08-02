// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'slider_styles.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSliderStylesCopyWith on FSliderStyles {
  /// Returns a copy of this [FSliderStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [horizontalStyle]
  /// The enabled slider's horizontal style.
  ///
  /// # [verticalStyle]
  /// The enabled slider's vertical style.
  ///
  @useResult
  FSliderStyles copyWith({
    FSliderStyle Function(FSliderStyle)? horizontalStyle,
    FSliderStyle Function(FSliderStyle)? verticalStyle,
  }) => FSliderStyles(
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
  );
}

/// Provides a `copyWith` method.
extension $FSliderStyleCopyWith on FSliderStyle {
  /// Returns a copy of this [FSliderStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [activeColor]
  /// The slider's active track colors.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [inactiveColor]
  /// The slider's inactive track colors.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [borderRadius]
  /// The slider's border radius.
  ///
  /// # [crossAxisExtent]
  /// The slider's cross-axis extent. Defaults to 8.
  ///
  /// ## Contract:
  /// Throws [AssertionError] if it is not positive.
  ///
  /// # [thumbSize]
  /// The thumb's size. Defaults to `25` on touch platforms and `20` on non-touch platforms.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [thumbSize] is not positive.
  ///
  /// ## Implementation details
  /// This unfortunately has to be placed outside of FSliderThumbStyle because [FSliderThumbStyle] is inside
  /// [FSliderStyle]. Putting the thumb size inside [FSliderThumbStyle] will cause a cyclic rebuild to occur
  /// whenever the window is resized due to a bad interaction between an internal LayoutBuilder and SliderFormField.
  ///
  /// # [thumbStyle]
  /// The slider thumb's style.
  ///
  /// # [markStyle]
  /// The slider marks' style.
  ///
  /// # [tooltipStyle]
  /// The tooltip's style.
  ///
  /// # [tooltipTipAnchor]
  /// The anchor of the tooltip to which the [tooltipThumbAnchor] is aligned.
  ///
  /// Defaults to [Alignment.bottomCenter] on primarily touch devices and [Alignment.centerLeft] on non-primarily touch
  /// devices.
  ///
  /// # [tooltipThumbAnchor]
  /// The anchor of the thumb to which the [tooltipTipAnchor] is aligned.
  ///
  /// Defaults to [Alignment.topCenter] on primarily touch devices and [Alignment.centerRight] on non-primarily touch
  /// devices.
  ///
  /// # [labelPadding]
  /// The label's padding.
  ///
  /// # [descriptionPadding]
  /// The description's padding.
  ///
  /// # [errorPadding]
  /// The error's padding.
  ///
  /// # [childPadding]
  /// The child's padding.
  ///
  /// # [labelTextStyle]
  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [descriptionTextStyle]
  /// The description's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [errorTextStyle]
  /// The error's text style.
  ///
  @useResult
  FSliderStyle copyWith({
    FWidgetStateMap<Color>? activeColor,
    FWidgetStateMap<Color>? inactiveColor,
    BorderRadius? borderRadius,
    double? crossAxisExtent,
    double? thumbSize,
    FSliderThumbStyle Function(FSliderThumbStyle)? thumbStyle,
    FSliderMarkStyle Function(FSliderMarkStyle)? markStyle,
    FTooltipStyle Function(FTooltipStyle)? tooltipStyle,
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
mixin _$FSliderStyleFunctions on Diagnosticable {
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

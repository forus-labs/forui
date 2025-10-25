// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'field.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FMultiSelectFieldStyleTransformations on FMultiSelectFieldStyle {
  /// Returns a copy of this [FMultiSelectFieldStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FMultiSelectFieldStyle.decoration] - The multi-select field's decoration.
  /// * [FMultiSelectFieldStyle.contentPadding] - The multi-select field's padding.
  /// * [FMultiSelectFieldStyle.spacing] - The spacing between tags.
  /// * [FMultiSelectFieldStyle.runSpacing] - The spacing between the rows of tags.
  /// * [FMultiSelectFieldStyle.hintTextStyle] - The multi-select field hint's text style.
  /// * [FMultiSelectFieldStyle.hintPadding] - The multi-select field's hint padding.
  /// * [FMultiSelectFieldStyle.iconStyle] - The multi-select field's icon style.
  /// * [FMultiSelectFieldStyle.clearButtonStyle] - The clear button's style when [FMultiSelect.
  /// * [FMultiSelectFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FMultiSelectFieldStyle.tappableStyle] - The multi-select field's tappable style.
  /// * [FMultiSelectFieldStyle.labelPadding] - The label's padding.
  /// * [FMultiSelectFieldStyle.descriptionPadding] - The description's padding.
  /// * [FMultiSelectFieldStyle.errorPadding] - The error's padding.
  /// * [FMultiSelectFieldStyle.childPadding] - The child's padding.
  /// * [FMultiSelectFieldStyle.labelTextStyle] - The label's text style.
  /// * [FMultiSelectFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FMultiSelectFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FMultiSelectFieldStyle copyWith({
    FWidgetStateMap<Decoration>? decoration,
    EdgeInsetsGeometry? contentPadding,
    double? spacing,
    double? runSpacing,
    FWidgetStateMap<TextStyle>? hintTextStyle,
    EdgeInsetsGeometry? hintPadding,
    IconThemeData? iconStyle,
    FButtonStyle Function(FButtonStyle style)? clearButtonStyle,
    EdgeInsetsGeometry? clearButtonPadding,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FMultiSelectFieldStyle(
    decoration: decoration ?? this.decoration,
    contentPadding: contentPadding ?? this.contentPadding,
    spacing: spacing ?? this.spacing,
    runSpacing: runSpacing ?? this.runSpacing,
    hintTextStyle: hintTextStyle ?? this.hintTextStyle,
    hintPadding: hintPadding ?? this.hintPadding,
    iconStyle: iconStyle ?? this.iconStyle,
    clearButtonStyle: clearButtonStyle != null ? clearButtonStyle(this.clearButtonStyle) : this.clearButtonStyle,
    clearButtonPadding: clearButtonPadding ?? this.clearButtonPadding,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FMultiSelectFieldStyle] using the given factor [t].
  @useResult
  FMultiSelectFieldStyle lerp(FMultiSelectFieldStyle other, double t) => FMultiSelectFieldStyle(
    decoration: t < 0.5 ? decoration : other.decoration,
    contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    runSpacing: lerpDouble(runSpacing, other.runSpacing, t) ?? runSpacing,
    hintTextStyle: FWidgetStateMap.lerpTextStyle(hintTextStyle, other.hintTextStyle, t),
    hintPadding: EdgeInsetsGeometry.lerp(hintPadding, other.hintPadding, t) ?? hintPadding,
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    clearButtonStyle: clearButtonStyle.lerp(other.clearButtonStyle, t),
    clearButtonPadding: EdgeInsetsGeometry.lerp(clearButtonPadding, other.clearButtonPadding, t) ?? clearButtonPadding,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FMultiSelectFieldStyleFunctions on Diagnosticable {
  FWidgetStateMap<Decoration> get decoration;
  EdgeInsetsGeometry get contentPadding;
  double get spacing;
  double get runSpacing;
  FWidgetStateMap<TextStyle> get hintTextStyle;
  EdgeInsetsGeometry get hintPadding;
  IconThemeData get iconStyle;
  FButtonStyle get clearButtonStyle;
  EdgeInsetsGeometry get clearButtonPadding;
  FTappableStyle get tappableStyle;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FMultiSelectFieldStyle] to replace functions that accept and return a [FMultiSelectFieldStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FMultiSelectFieldStyle Function(FMultiSelectFieldStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FMultiSelectFieldStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FMultiSelectFieldStyle(...));
  /// ```
  @useResult
  FMultiSelectFieldStyle call(Object? _) => this as FMultiSelectFieldStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('spacing', spacing, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('runSpacing', runSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('hintPadding', hintPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
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
      (other is FMultiSelectFieldStyle &&
          decoration == other.decoration &&
          contentPadding == other.contentPadding &&
          spacing == other.spacing &&
          runSpacing == other.runSpacing &&
          hintTextStyle == other.hintTextStyle &&
          hintPadding == other.hintPadding &&
          iconStyle == other.iconStyle &&
          clearButtonStyle == other.clearButtonStyle &&
          clearButtonPadding == other.clearButtonPadding &&
          tappableStyle == other.tappableStyle &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      decoration.hashCode ^
      contentPadding.hashCode ^
      spacing.hashCode ^
      runSpacing.hashCode ^
      hintTextStyle.hashCode ^
      hintPadding.hashCode ^
      iconStyle.hashCode ^
      clearButtonStyle.hashCode ^
      clearButtonPadding.hashCode ^
      tappableStyle.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

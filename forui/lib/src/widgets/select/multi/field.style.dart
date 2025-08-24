// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'field.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FMultiSelectFieldStyleCopyWith on FMultiSelectFieldStyle {
  /// Returns a copy of this [FMultiSelectFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The multi-select field's decoration.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  ///
  /// # [contentPadding]
  /// The multi-select field's padding. Defaults to `EdgeInsets.only(start: 10, top: 6, bottom: 6, end: 8)`.
  ///
  /// # [spacing]
  /// The spacing between tags. Defaults to 4.
  ///
  /// # [runSpacing]
  /// The spacing between the rows of tags. Defaults to 4.
  ///
  /// # [hintTextStyle]
  /// The multi-select field hint's text style.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  ///
  /// # [hintPadding]
  /// The multi-select field's hint padding. Defaults to `EdgeInsetsDirectional.only(start: 4, top: 4, bottom: 4)`.
  ///
  /// The vertical padding should typically be the same as the [FMultiSelectTagStyle.padding].
  ///
  /// # [iconStyle]
  /// The multi-select field's icon style.
  ///
  /// # [clearButtonStyle]
  /// The clear button's style when [FMultiSelect.clearable] is true.
  ///
  /// # [clearButtonPadding]
  /// The padding surrounding the clear button. Defaults to [EdgeInsets.zero].
  ///
  /// # [tappableStyle]
  /// The multi-select field's tappable style.
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
  FMultiSelectFieldStyle copyWith({
    FWidgetStateMap<Decoration>? decoration,
    EdgeInsetsGeometry? contentPadding,
    double? spacing,
    double? runSpacing,
    FWidgetStateMap<TextStyle>? hintTextStyle,
    EdgeInsetsGeometry? hintPadding,
    IconThemeData? iconStyle,
    FButtonStyle Function(FButtonStyle)? clearButtonStyle,
    EdgeInsetsGeometry? clearButtonPadding,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
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
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DoubleProperty('runSpacing', runSpacing))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle))
      ..add(DiagnosticsProperty('hintPadding', hintPadding))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
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

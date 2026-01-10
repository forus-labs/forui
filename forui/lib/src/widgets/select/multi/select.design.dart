// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FMultiSelectStyleTransformations on FMultiSelectStyle {
  /// Returns a copy of this [FMultiSelectStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FMultiSelectStyle.fieldStyle] - The field's style.
  /// * [FMultiSelectStyle.tagStyle] - The tag's style.
  /// * [FMultiSelectStyle.searchStyle] - The search's style.
  /// * [FMultiSelectStyle.contentStyle] - The content's style.
  /// * [FMultiSelectStyle.emptyTextStyle] - The default text style when there are no results.
  @useResult
  FMultiSelectStyle copyWith({
    FMultiSelectFieldStyle Function(FMultiSelectFieldStyle style)? fieldStyle,
    FMultiSelectTagStyle Function(FMultiSelectTagStyle style)? tagStyle,
    FSelectSearchStyle Function(FSelectSearchStyle style)? searchStyle,
    FSelectContentStyle Function(FSelectContentStyle style)? contentStyle,
    TextStyle? emptyTextStyle,
  }) => .new(
    fieldStyle: fieldStyle != null ? fieldStyle(this.fieldStyle) : this.fieldStyle,
    tagStyle: tagStyle != null ? tagStyle(this.tagStyle) : this.tagStyle,
    searchStyle: searchStyle != null ? searchStyle(this.searchStyle) : this.searchStyle,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
    emptyTextStyle: emptyTextStyle ?? this.emptyTextStyle,
  );

  /// Linearly interpolate between this and another [FMultiSelectStyle] using the given factor [t].
  @useResult
  FMultiSelectStyle lerp(FMultiSelectStyle other, double t) => .new(
    fieldStyle: fieldStyle.lerp(other.fieldStyle, t),
    tagStyle: tagStyle.lerp(other.tagStyle, t),
    searchStyle: searchStyle.lerp(other.searchStyle, t),
    contentStyle: contentStyle.lerp(other.contentStyle, t),
    emptyTextStyle: .lerp(emptyTextStyle, other.emptyTextStyle, t) ?? emptyTextStyle,
  );
}

mixin _$FMultiSelectStyleFunctions on Diagnosticable {
  FMultiSelectFieldStyle get fieldStyle;
  FMultiSelectTagStyle get tagStyle;
  FSelectSearchStyle get searchStyle;
  FSelectContentStyle get contentStyle;
  TextStyle get emptyTextStyle;

  /// Returns itself.
  ///
  /// Allows [FMultiSelectStyle] to replace functions that accept and return a [FMultiSelectStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FMultiSelectStyle Function(FMultiSelectStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FMultiSelectStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FMultiSelectStyle(...));
  /// ```
  @useResult
  FMultiSelectStyle call(Object? _) => this as FMultiSelectStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('fieldStyle', fieldStyle, level: .debug))
      ..add(DiagnosticsProperty('tagStyle', tagStyle, level: .debug))
      ..add(DiagnosticsProperty('searchStyle', searchStyle, level: .debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: .debug))
      ..add(DiagnosticsProperty('emptyTextStyle', emptyTextStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectStyle &&
          runtimeType == other.runtimeType &&
          fieldStyle == other.fieldStyle &&
          tagStyle == other.tagStyle &&
          searchStyle == other.searchStyle &&
          contentStyle == other.contentStyle &&
          emptyTextStyle == other.emptyTextStyle);

  @override
  int get hashCode =>
      fieldStyle.hashCode ^ tagStyle.hashCode ^ searchStyle.hashCode ^ contentStyle.hashCode ^ emptyTextStyle.hashCode;
}

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
  /// * [FMultiSelectFieldStyle.clearButtonStyle] - The clear button's style when [FMultiSelect.clearable] is true.
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
  }) => .new(
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
  FMultiSelectFieldStyle lerp(FMultiSelectFieldStyle other, double t) => .new(
    decoration: t < 0.5 ? decoration : other.decoration,
    contentPadding: .lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    runSpacing: lerpDouble(runSpacing, other.runSpacing, t) ?? runSpacing,
    hintTextStyle: .lerpTextStyle(hintTextStyle, other.hintTextStyle, t),
    hintPadding: .lerp(hintPadding, other.hintPadding, t) ?? hintPadding,
    iconStyle: .lerp(iconStyle, other.iconStyle, t),
    clearButtonStyle: clearButtonStyle.lerp(other.clearButtonStyle, t),
    clearButtonPadding: .lerp(clearButtonPadding, other.clearButtonPadding, t) ?? clearButtonPadding,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
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
      ..add(DiagnosticsProperty('decoration', decoration, level: .debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: .debug))
      ..add(DoubleProperty('spacing', spacing, level: .debug))
      ..add(DoubleProperty('runSpacing', runSpacing, level: .debug))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle, level: .debug))
      ..add(DiagnosticsProperty('hintPadding', hintPadding, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle, level: .debug))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding, level: .debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FMultiSelectFieldStyle &&
          runtimeType == other.runtimeType &&
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

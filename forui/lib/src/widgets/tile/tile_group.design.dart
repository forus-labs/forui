// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tile_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTileGroupStyleTransformations on FTileGroupStyle {
  /// Returns a copy of this [FTileGroupStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FTileGroupStyle.decoration] - The group's decoration.
  /// * [FTileGroupStyle.tileStyle] - The tile's style.
  /// * [FTileGroupStyle.dividerColor] - The divider's style.
  /// * [FTileGroupStyle.dividerWidth] - The divider's width.
  /// * [FTileGroupStyle.labelPadding] - The label's padding.
  /// * [FTileGroupStyle.descriptionPadding] - The description's padding.
  /// * [FTileGroupStyle.errorPadding] - The error's padding.
  /// * [FTileGroupStyle.childPadding] - The child's padding.
  /// * [FTileGroupStyle.labelTextStyle] - The label's text style.
  /// * [FTileGroupStyle.descriptionTextStyle] - The description's text style.
  /// * [FTileGroupStyle.errorTextStyle] - The error's text style.
  @useResult
  FTileGroupStyle copyWith({
    BoxDecoration? decoration,
    FTileStyle Function(FTileStyle style)? tileStyle,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FTileGroupStyle(
    decoration: decoration ?? this.decoration,
    tileStyle: tileStyle != null ? tileStyle(this.tileStyle) : this.tileStyle,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FTileGroupStyle] using the given factor [t].
  @useResult
  FTileGroupStyle lerp(FTileGroupStyle other, double t) => FTileGroupStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    tileStyle: tileStyle.lerp(other.tileStyle, t),
    dividerColor: FWidgetStateMap.lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FTileGroupStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  FTileStyle get tileStyle;
  FWidgetStateMap<Color> get dividerColor;
  double get dividerWidth;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FTileGroupStyle] to replace functions that accept and return a [FTileGroupStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTileGroupStyle Function(FTileGroupStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTileGroupStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTileGroupStyle(...));
  /// ```
  @useResult
  FTileGroupStyle call(Object? _) => this as FTileGroupStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tileStyle', tileStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('dividerWidth', dividerWidth, level: DiagnosticLevel.debug))
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
      (other is FTileGroupStyle &&
          decoration == other.decoration &&
          tileStyle == other.tileStyle &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
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
      tileStyle.hashCode ^
      dividerColor.hashCode ^
      dividerWidth.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

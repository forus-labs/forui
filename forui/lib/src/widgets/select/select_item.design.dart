// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectSectionStyleTransformations on FSelectSectionStyle {
  /// Returns a copy of this [FSelectSectionStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectSectionStyle.labelTextStyle] - The enabled label's text style.
  /// * [FSelectSectionStyle.labelPadding] - The padding around the label.
  /// * [FSelectSectionStyle.dividerColor] - The divider's style.
  /// * [FSelectSectionStyle.dividerWidth] - The divider's width.
  /// * [FSelectSectionStyle.itemStyle] - The section's items' style.
  @useResult
  FSelectSectionStyle copyWith({
    FWidgetStateMap<TextStyle>? labelTextStyle,
    EdgeInsetsGeometry? labelPadding,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    FItemStyle Function(FItemStyle style)? itemStyle,
  }) => FSelectSectionStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
  );

  /// Linearly interpolate between this and another [FSelectSectionStyle] using the given factor [t].
  @useResult
  FSelectSectionStyle lerp(FSelectSectionStyle other, double t) => FSelectSectionStyle(
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    dividerColor: FWidgetStateMap.lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
  );
}

mixin _$FSelectSectionStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get labelTextStyle;
  EdgeInsetsGeometry get labelPadding;
  FWidgetStateMap<Color> get dividerColor;
  double get dividerWidth;
  FItemStyle get itemStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectSectionStyle] to replace functions that accept and return a [FSelectSectionStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectSectionStyle Function(FSelectSectionStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectSectionStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectSectionStyle(...));
  /// ```
  @useResult
  FSelectSectionStyle call(Object? _) => this as FSelectSectionStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dividerColor', dividerColor, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('dividerWidth', dividerWidth, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSectionStyle &&
          labelTextStyle == other.labelTextStyle &&
          labelPadding == other.labelPadding &&
          dividerColor == other.dividerColor &&
          dividerWidth == other.dividerWidth &&
          itemStyle == other.itemStyle);

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      labelPadding.hashCode ^
      dividerColor.hashCode ^
      dividerWidth.hashCode ^
      itemStyle.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAutocompleteSectionStyleTransformations on FAutocompleteSectionStyle {
  /// Returns a copy of this [FAutocompleteSectionStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAutocompleteSectionStyle.labelTextStyle] - The enabled label's text style.
  /// * [FAutocompleteSectionStyle.labelPadding] - The padding around the label.
  /// * [FAutocompleteSectionStyle.dividerColor] - The divider's style.
  /// * [FAutocompleteSectionStyle.dividerWidth] - The divider's width.
  /// * [FAutocompleteSectionStyle.itemStyle] - The section's items' style.
  @useResult
  FAutocompleteSectionStyle copyWith({
    FWidgetStateMap<TextStyle>? labelTextStyle,
    EdgeInsetsGeometry? labelPadding,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    FItemStyle Function(FItemStyle style)? itemStyle,
  }) => FAutocompleteSectionStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
  );

  /// Linearly interpolate between this and another [FAutocompleteSectionStyle] using the given factor [t].
  @useResult
  FAutocompleteSectionStyle lerp(FAutocompleteSectionStyle other, double t) => FAutocompleteSectionStyle(
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    dividerColor: FWidgetStateMap.lerpColor(dividerColor, other.dividerColor, t),
    dividerWidth: lerpDouble(dividerWidth, other.dividerWidth, t) ?? dividerWidth,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
  );
}

mixin _$FAutocompleteSectionStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get labelTextStyle;
  EdgeInsetsGeometry get labelPadding;
  FWidgetStateMap<Color> get dividerColor;
  double get dividerWidth;
  FItemStyle get itemStyle;

  /// Returns itself.
  ///
  /// Allows [FAutocompleteSectionStyle] to replace functions that accept and return a [FAutocompleteSectionStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAutocompleteSectionStyle Function(FAutocompleteSectionStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAutocompleteSectionStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAutocompleteSectionStyle(...));
  /// ```
  @useResult
  FAutocompleteSectionStyle call(Object? _) => this as FAutocompleteSectionStyle;

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
      (other is FAutocompleteSectionStyle &&
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

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'autocomplete_item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FAutocompleteSectionStyleCopyWith on FAutocompleteSectionStyle {
  /// Returns a copy of this [FAutocompleteSectionStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [labelTextStyle]
  /// The enabled label's text style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  ///
  /// # [labelPadding]
  /// The padding around the label. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  ///
  /// # [dividerColor]
  /// The divider's style.
  ///
  /// Supported states:
  /// * [WidgetState.disabled]
  ///
  /// # [dividerWidth]
  /// The divider's width.
  ///
  /// # [itemStyle]
  /// The section's items' style.
  ///
  @useResult
  FAutocompleteSectionStyle copyWith({
    FWidgetStateMap<TextStyle>? labelTextStyle,
    EdgeInsetsGeometry? labelPadding,
    FWidgetStateMap<Color>? dividerColor,
    double? dividerWidth,
    FItemStyle Function(FItemStyle)? itemStyle,
  }) => FAutocompleteSectionStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
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
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('dividerColor', dividerColor))
      ..add(DoubleProperty('dividerWidth', dividerWidth))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
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

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
    FAutocompleteItemStyle Function(FAutocompleteItemStyle)? itemStyle,
  }) => FAutocompleteSectionStyle(
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    dividerColor: dividerColor ?? this.dividerColor,
    dividerWidth: dividerWidth ?? this.dividerWidth,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
  );
}

/// Provides a `copyWith` method.
extension $FAutocompleteItemStyleCopyWith on FAutocompleteItemStyle {
  /// Returns a copy of this [FAutocompleteItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [margin]
  /// The margin around the item. Defaults to `EdgeInsets.symmetric(horizontal: 4, vertical: 2)`.
  ///
  /// # [padding]
  /// The padding around the item. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [prefixIconStyle]
  /// The icon style for an item's prefix.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [titleTextStyle]
  /// The default text style for the title.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [titleSpacing]
  /// The vertical spacing between the title and the subtitle. Defaults to 4.
  ///
  /// # [subtitleTextStyle]
  /// The default text style for the subtitle.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [suffixIconStyle]
  /// The icon style for an item's suffix.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [tappableStyle]
  /// The tappable style for the item.
  ///
  @useResult
  FAutocompleteItemStyle copyWith({
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FWidgetStateMap<IconThemeData>? prefixIconStyle,
    double? prefixIconSpacing,
    FWidgetStateMap<TextStyle>? titleTextStyle,
    double? titleSpacing,
    FWidgetStateMap<TextStyle>? subtitleTextStyle,
    FWidgetStateMap<IconThemeData>? suffixIconStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
  }) => FAutocompleteItemStyle(
    margin: margin ?? this.margin,
    padding: padding ?? this.padding,
    decoration: decoration ?? this.decoration,
    prefixIconStyle: prefixIconStyle ?? this.prefixIconStyle,
    prefixIconSpacing: prefixIconSpacing ?? this.prefixIconSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    suffixIconStyle: suffixIconStyle ?? this.suffixIconStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );
}

mixin _$FAutocompleteSectionStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get labelTextStyle;
  EdgeInsetsGeometry get labelPadding;
  FWidgetStateMap<Color> get dividerColor;
  double get dividerWidth;
  FAutocompleteItemStyle get itemStyle;

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
mixin _$FAutocompleteItemStyleFunctions on Diagnosticable {
  EdgeInsetsGeometry get margin;
  EdgeInsetsGeometry get padding;
  FWidgetStateMap<BoxDecoration?> get decoration;
  FWidgetStateMap<IconThemeData> get prefixIconStyle;
  double get prefixIconSpacing;
  FWidgetStateMap<TextStyle> get titleTextStyle;
  double get titleSpacing;
  FWidgetStateMap<TextStyle> get subtitleTextStyle;
  FWidgetStateMap<IconThemeData> get suffixIconStyle;
  FTappableStyle get tappableStyle;

  /// Returns itself.
  ///
  /// Allows [FAutocompleteItemStyle] to replace functions that accept and return a [FAutocompleteItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAutocompleteItemStyle Function(FAutocompleteItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAutocompleteItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAutocompleteItemStyle(...));
  /// ```
  @useResult
  FAutocompleteItemStyle call(Object? _) => this as FAutocompleteItemStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('margin', margin))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('prefixIconStyle', prefixIconStyle))
      ..add(DoubleProperty('prefixIconSpacing', prefixIconSpacing))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DoubleProperty('titleSpacing', titleSpacing))
      ..add(DiagnosticsProperty('subtitleTextStyle', subtitleTextStyle))
      ..add(DiagnosticsProperty('suffixIconStyle', suffixIconStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAutocompleteItemStyle &&
          margin == other.margin &&
          padding == other.padding &&
          decoration == other.decoration &&
          prefixIconStyle == other.prefixIconStyle &&
          prefixIconSpacing == other.prefixIconSpacing &&
          titleTextStyle == other.titleTextStyle &&
          titleSpacing == other.titleSpacing &&
          subtitleTextStyle == other.subtitleTextStyle &&
          suffixIconStyle == other.suffixIconStyle &&
          tappableStyle == other.tappableStyle);
  @override
  int get hashCode =>
      margin.hashCode ^
      padding.hashCode ^
      decoration.hashCode ^
      prefixIconStyle.hashCode ^
      prefixIconSpacing.hashCode ^
      titleTextStyle.hashCode ^
      titleSpacing.hashCode ^
      subtitleTextStyle.hashCode ^
      suffixIconStyle.hashCode ^
      tappableStyle.hashCode;
}

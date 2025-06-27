// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSelectSectionStyleCopyWith on FSelectSectionStyle {
  /// Returns a copy of this [FSelectSectionStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [enabledLabelTextStyle]
  /// The enabled label's text style.
  ///
  /// # [disabledLabelTextStyle]
  /// The disabled label's text style.
  ///
  /// # [labelPadding]
  /// The padding around the label. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  ///
  /// # [itemStyle]
  /// The section's items' style.
  ///
  @useResult
  FSelectSectionStyle copyWith({
    TextStyle? enabledLabelTextStyle,
    TextStyle? disabledLabelTextStyle,
    EdgeInsetsGeometry? labelPadding,
    FSelectItemStyle Function(FSelectItemStyle)? itemStyle,
  }) => FSelectSectionStyle(
    enabledLabelTextStyle: enabledLabelTextStyle ?? this.enabledLabelTextStyle,
    disabledLabelTextStyle: disabledLabelTextStyle ?? this.disabledLabelTextStyle,
    labelPadding: labelPadding ?? this.labelPadding,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
  );
}

/// Provides a `copyWith` method.
extension $FSelectItemStyleCopyWith on FSelectItemStyle {
  /// Returns a copy of this [FSelectItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [padding]
  /// The padding around the item. Defaults to `EdgeInsetsDirectional.only(start: 15, top: 7.5, bottom: 7.5, end: 10)`.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [textStyle]
  /// The default text style for the child.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [iconStyle]
  /// The icon style for a checked item.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [tappableStyle]
  /// The tappable style for the item.
  ///
  @useResult
  FSelectItemStyle copyWith({
    EdgeInsetsGeometry? padding,
    FWidgetStateMap<BoxDecoration?>? decoration,
    FWidgetStateMap<TextStyle>? textStyle,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
  }) => FSelectItemStyle(
    padding: padding ?? this.padding,
    decoration: decoration ?? this.decoration,
    textStyle: textStyle ?? this.textStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );
}

mixin _$FSelectSectionStyleFunctions on Diagnosticable {
  TextStyle get enabledLabelTextStyle;
  TextStyle get disabledLabelTextStyle;
  EdgeInsetsGeometry get labelPadding;
  FSelectItemStyle get itemStyle;

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
      ..add(DiagnosticsProperty('enabledLabelTextStyle', enabledLabelTextStyle))
      ..add(DiagnosticsProperty('disabledLabelTextStyle', disabledLabelTextStyle))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectSectionStyle &&
          enabledLabelTextStyle == other.enabledLabelTextStyle &&
          disabledLabelTextStyle == other.disabledLabelTextStyle &&
          labelPadding == other.labelPadding &&
          itemStyle == other.itemStyle);
  @override
  int get hashCode =>
      enabledLabelTextStyle.hashCode ^ disabledLabelTextStyle.hashCode ^ labelPadding.hashCode ^ itemStyle.hashCode;
}
mixin _$FSelectItemStyleFunctions on Diagnosticable {
  EdgeInsetsGeometry get padding;
  FWidgetStateMap<BoxDecoration?> get decoration;
  FWidgetStateMap<TextStyle> get textStyle;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FTappableStyle get tappableStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectItemStyle] to replace functions that accept and return a [FSelectItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectItemStyle Function(FSelectItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectItemStyle(...));
  /// ```
  @useResult
  FSelectItemStyle call(Object? _) => this as FSelectItemStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectItemStyle &&
          padding == other.padding &&
          decoration == other.decoration &&
          textStyle == other.textStyle &&
          iconStyle == other.iconStyle &&
          tappableStyle == other.tappableStyle);
  @override
  int get hashCode =>
      padding.hashCode ^ decoration.hashCode ^ textStyle.hashCode ^ iconStyle.hashCode ^ tappableStyle.hashCode;
}

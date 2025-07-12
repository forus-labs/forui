// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_group.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSidebarGroupStyleCopyWith on FSidebarGroupStyle {
  /// Returns a copy of this [FSidebarGroupStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.symmetric(horizontal: 16)`.
  ///
  /// # [headerSpacing]
  /// The spacing between the label and action in the header. Defaults to 8.
  ///
  /// # [headerPadding]
  /// The padding around the header. Defaults to `EdgeInsets.fromLTRB(12, 0, 8, 2)`.
  ///
  /// # [labelStyle]
  /// The label's text style.
  ///
  /// # [actionStyle]
  /// The action's style.
  ///
  /// # [childrenSpacing]
  /// The spacing between children. Defaults to 2.
  ///
  /// # [childrenPadding]
  /// The padding around the children. Defaults to `EdgeInsets.fromLTRB(0, 0, 0, 24)`.
  ///
  /// # [tappableStyle]
  /// The tappable action's style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  /// # [itemStyle]
  /// The item's style.
  ///
  @useResult
  FSidebarGroupStyle copyWith({
    EdgeInsets? padding,
    double? headerSpacing,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? labelStyle,
    FWidgetStateMap<IconThemeData>? actionStyle,
    double? childrenSpacing,
    EdgeInsetsGeometry? childrenPadding,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
    FSidebarItemStyle Function(FSidebarItemStyle)? itemStyle,
  }) => FSidebarGroupStyle(
    padding: padding ?? this.padding,
    headerSpacing: headerSpacing ?? this.headerSpacing,
    headerPadding: headerPadding ?? this.headerPadding,
    labelStyle: labelStyle ?? this.labelStyle,
    actionStyle: actionStyle ?? this.actionStyle,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding ?? this.childrenPadding,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
  );
}

mixin _$FSidebarGroupStyleFunctions on Diagnosticable {
  EdgeInsets get padding;
  double get headerSpacing;
  EdgeInsetsGeometry get headerPadding;
  TextStyle get labelStyle;
  FWidgetStateMap<IconThemeData> get actionStyle;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FSidebarItemStyle get itemStyle;

  /// Returns itself.
  ///
  /// Allows [FSidebarGroupStyle] to replace functions that accept and return a [FSidebarGroupStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSidebarGroupStyle Function(FSidebarGroupStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSidebarGroupStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSidebarGroupStyle(...));
  /// ```
  @useResult
  FSidebarGroupStyle call(Object? _) => this as FSidebarGroupStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DoubleProperty('headerSpacing', headerSpacing))
      ..add(DiagnosticsProperty('headerPadding', headerPadding))
      ..add(DiagnosticsProperty('labelStyle', labelStyle))
      ..add(DiagnosticsProperty('actionStyle', actionStyle))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarGroupStyle &&
          padding == other.padding &&
          headerSpacing == other.headerSpacing &&
          headerPadding == other.headerPadding &&
          labelStyle == other.labelStyle &&
          actionStyle == other.actionStyle &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          itemStyle == other.itemStyle);
  @override
  int get hashCode =>
      padding.hashCode ^
      headerSpacing.hashCode ^
      headerPadding.hashCode ^
      labelStyle.hashCode ^
      actionStyle.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      itemStyle.hashCode;
}

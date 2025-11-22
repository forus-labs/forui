// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarGroupStyleTransformations on FSidebarGroupStyle {
  /// Returns a copy of this [FSidebarGroupStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarGroupStyle.padding] - The padding.
  /// * [FSidebarGroupStyle.headerSpacing] - The spacing between the label and action in the header.
  /// * [FSidebarGroupStyle.headerPadding] - The padding around the header.
  /// * [FSidebarGroupStyle.labelStyle] - The label's text style.
  /// * [FSidebarGroupStyle.actionStyle] - The action's style.
  /// * [FSidebarGroupStyle.childrenSpacing] - The spacing between children.
  /// * [FSidebarGroupStyle.childrenPadding] - The padding around the children.
  /// * [FSidebarGroupStyle.tappableStyle] - The tappable action's style.
  /// * [FSidebarGroupStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarGroupStyle.itemStyle] - The item's style.
  @useResult
  FSidebarGroupStyle copyWith({
    EdgeInsets? padding,
    double? headerSpacing,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? labelStyle,
    FWidgetStateMap<IconThemeData>? actionStyle,
    double? childrenSpacing,
    EdgeInsetsGeometry? childrenPadding,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FSidebarItemStyle Function(FSidebarItemStyle style)? itemStyle,
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

  /// Linearly interpolate between this and another [FSidebarGroupStyle] using the given factor [t].
  @useResult
  FSidebarGroupStyle lerp(FSidebarGroupStyle other, double t) => FSidebarGroupStyle(
    padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
    headerSpacing: lerpDouble(headerSpacing, other.headerSpacing, t) ?? headerSpacing,
    headerPadding: EdgeInsetsGeometry.lerp(headerPadding, other.headerPadding, t) ?? headerPadding,
    labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t) ?? labelStyle,
    actionStyle: FWidgetStateMap.lerpIconThemeData(actionStyle, other.actionStyle, t),
    childrenSpacing: lerpDouble(childrenSpacing, other.childrenSpacing, t) ?? childrenSpacing,
    childrenPadding: EdgeInsetsGeometry.lerp(childrenPadding, other.childrenPadding, t) ?? childrenPadding,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    itemStyle: itemStyle.lerp(other.itemStyle, t),
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
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('headerSpacing', headerSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('headerPadding', headerPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelStyle', labelStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('actionStyle', actionStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: DiagnosticLevel.debug));
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

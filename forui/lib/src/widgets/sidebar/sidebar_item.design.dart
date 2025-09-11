// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarItemStyleTransformations on FSidebarItemStyle {
  /// Returns a copy of this [FSidebarItemStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarItemStyle.textStyle] - The label's text style.
  /// * [FSidebarItemStyle.iconSpacing] - The spacing between the icon and label.
  /// * [FSidebarItemStyle.iconStyle] - The icon's style.
  /// * [FSidebarItemStyle.collapsibleIconSpacing] - The spacing between the label and collapsible widget.
  /// * [FSidebarItemStyle.collapsibleIconStyle] - The collapsible icon's style.
  /// * [FSidebarItemStyle.expandDuration] - The expand animation's duration.
  /// * [FSidebarItemStyle.expandCurve] - The expand animation's curve.
  /// * [FSidebarItemStyle.collapseDuration] - The collapse animation's duration.
  /// * [FSidebarItemStyle.collapseCurve] - The collapse animation's curve.
  /// * [FSidebarItemStyle.childrenSpacing] - The spacing between child items.
  /// * [FSidebarItemStyle.childrenPadding] - The padding around the children container.
  /// * [FSidebarItemStyle.backgroundColor] - The background color.
  /// * [FSidebarItemStyle.padding] - The padding around the content.
  /// * [FSidebarItemStyle.borderRadius] - The item's border radius.
  /// * [FSidebarItemStyle.tappableStyle] - The tappable's style.
  /// * [FSidebarItemStyle.focusedOutlineStyle] - The focused outline style.
  @useResult
  FSidebarItemStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    double? iconSpacing,
    FWidgetStateMap<IconThemeData>? iconStyle,
    double? collapsibleIconSpacing,
    FWidgetStateMap<IconThemeData>? collapsibleIconStyle,
    Duration? expandDuration,
    Curve? expandCurve,
    Duration? collapseDuration,
    Curve? collapseCurve,
    double? childrenSpacing,
    EdgeInsetsGeometry? childrenPadding,
    FWidgetStateMap<Color>? backgroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => FSidebarItemStyle(
    textStyle: textStyle ?? this.textStyle,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    iconStyle: iconStyle ?? this.iconStyle,
    collapsibleIconSpacing: collapsibleIconSpacing ?? this.collapsibleIconSpacing,
    collapsibleIconStyle: collapsibleIconStyle ?? this.collapsibleIconStyle,
    expandDuration: expandDuration ?? this.expandDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding ?? this.childrenPadding,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    padding: padding ?? this.padding,
    borderRadius: borderRadius ?? this.borderRadius,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FSidebarItemStyle] using the given factor [t].
  @useResult
  FSidebarItemStyle lerp(FSidebarItemStyle other, double t) => FSidebarItemStyle(
    textStyle: FWidgetStateMap.lerpTextStyle(textStyle, other.textStyle, t),
    iconSpacing: lerpDouble(iconSpacing, other.iconSpacing, t) ?? iconSpacing,
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    collapsibleIconSpacing:
        lerpDouble(collapsibleIconSpacing, other.collapsibleIconSpacing, t) ?? collapsibleIconSpacing,
    collapsibleIconStyle: FWidgetStateMap.lerpIconThemeData(collapsibleIconStyle, other.collapsibleIconStyle, t),
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    childrenSpacing: lerpDouble(childrenSpacing, other.childrenSpacing, t) ?? childrenSpacing,
    childrenPadding: EdgeInsetsGeometry.lerp(childrenPadding, other.childrenPadding, t) ?? childrenPadding,
    backgroundColor: FWidgetStateMap.lerpColor(backgroundColor, other.backgroundColor, t),
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FSidebarItemStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get textStyle;
  double get iconSpacing;
  FWidgetStateMap<IconThemeData> get iconStyle;
  double get collapsibleIconSpacing;
  FWidgetStateMap<IconThemeData> get collapsibleIconStyle;
  Duration get expandDuration;
  Curve get expandCurve;
  Duration get collapseDuration;
  Curve get collapseCurve;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  FWidgetStateMap<Color> get backgroundColor;
  EdgeInsetsGeometry get padding;
  BorderRadius get borderRadius;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FSidebarItemStyle] to replace functions that accept and return a [FSidebarItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSidebarItemStyle Function(FSidebarItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSidebarItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSidebarItemStyle(...));
  /// ```
  @useResult
  FSidebarItemStyle call(Object? _) => this as FSidebarItemStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('iconSpacing', iconSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('collapsibleIconSpacing', collapsibleIconSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapsibleIconStyle', collapsibleIconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarItemStyle &&
          textStyle == other.textStyle &&
          iconSpacing == other.iconSpacing &&
          iconStyle == other.iconStyle &&
          collapsibleIconSpacing == other.collapsibleIconSpacing &&
          collapsibleIconStyle == other.collapsibleIconStyle &&
          expandDuration == other.expandDuration &&
          expandCurve == other.expandCurve &&
          collapseDuration == other.collapseDuration &&
          collapseCurve == other.collapseCurve &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding &&
          backgroundColor == other.backgroundColor &&
          padding == other.padding &&
          borderRadius == other.borderRadius &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      textStyle.hashCode ^
      iconSpacing.hashCode ^
      iconStyle.hashCode ^
      collapsibleIconSpacing.hashCode ^
      collapsibleIconStyle.hashCode ^
      expandDuration.hashCode ^
      expandCurve.hashCode ^
      collapseDuration.hashCode ^
      collapseCurve.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode ^
      backgroundColor.hashCode ^
      padding.hashCode ^
      borderRadius.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

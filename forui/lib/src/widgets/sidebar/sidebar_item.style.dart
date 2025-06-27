// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_item.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSidebarItemStyleCopyWith on FSidebarItemStyle {
  /// Returns a copy of this [FSidebarItemStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [textStyle]
  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [iconSpacing]
  /// The spacing between the icon and label. Defaults to 8.
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [collapsibleIconSpacing]
  /// The spacing between the label and collapsible widget. Defaults to 8.
  ///
  /// # [collapsibleIconStyle]
  /// The collapsible icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [expandDuration]
  /// The expand animation's duration. Defaults to 200ms.
  ///
  /// # [expandCurve]
  /// The expand animation's curve. Defaults to [Curves.easeOutCubic].
  ///
  /// # [collapseDuration]
  /// The collapse animation's duration. Defaults to 150ms.
  ///
  /// # [collapseCurve]
  /// The collapse animation's curve. Defaults to [Curves.easeInCubic].
  ///
  /// # [childrenSpacing]
  /// The spacing between child items. Defaults to 2.
  ///
  /// # [childrenPadding]
  /// The padding around the children container. Defaults to `EdgeInsets.only(left: 26, top: 2)`.
  ///
  /// # [backgroundColor]
  /// The background color.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.selectable}
  ///
  /// # [padding]
  /// The padding around the content. Defaults to `EdgeInsets.symmetric(horizontal: 12, vertical: 10)`.
  ///
  /// # [borderRadius]
  /// The item's border radius.
  ///
  /// # [tappableStyle]
  /// The tappable's style.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
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
    FTappableStyle Function(FTappableStyle)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
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
      ..add(DiagnosticsProperty('textStyle', textStyle))
      ..add(DoubleProperty('iconSpacing', iconSpacing))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DoubleProperty('collapsibleIconSpacing', collapsibleIconSpacing))
      ..add(DiagnosticsProperty('collapsibleIconStyle', collapsibleIconStyle))
      ..add(DiagnosticsProperty('expandDuration', expandDuration))
      ..add(DiagnosticsProperty('expandCurve', expandCurve))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle));
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

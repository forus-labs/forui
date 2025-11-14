// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'bottom_navigation_bar_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBottomNavigationBarItemStyleTransformations on FBottomNavigationBarItemStyle {
  /// Returns a copy of this [FBottomNavigationBarItemStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FBottomNavigationBarItemStyle.iconStyle] - The icon's style.
  /// * [FBottomNavigationBarItemStyle.textStyle] - The text style.
  /// * [FBottomNavigationBarItemStyle.padding] - The padding.
  /// * [FBottomNavigationBarItemStyle.spacing] - The spacing between the icon and the label.
  /// * [FBottomNavigationBarItemStyle.tappableStyle] - The item's tappable's style.
  /// * [FBottomNavigationBarItemStyle.focusedOutlineStyle] - The item's focused outline style.
  @useResult
  FBottomNavigationBarItemStyle copyWith({
    FWidgetStateMap<IconThemeData>? iconStyle,
    FWidgetStateMap<TextStyle>? textStyle,
    EdgeInsetsGeometry? padding,
    double? spacing,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
  }) => FBottomNavigationBarItemStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    textStyle: textStyle ?? this.textStyle,
    padding: padding ?? this.padding,
    spacing: spacing ?? this.spacing,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
  );

  /// Linearly interpolate between this and another [FBottomNavigationBarItemStyle] using the given factor [t].
  @useResult
  FBottomNavigationBarItemStyle lerp(FBottomNavigationBarItemStyle other, double t) => FBottomNavigationBarItemStyle(
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    textStyle: FWidgetStateMap.lerpTextStyle(textStyle, other.textStyle, t),
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
  );
}

mixin _$FBottomNavigationBarItemStyleFunctions on Diagnosticable {
  FWidgetStateMap<IconThemeData> get iconStyle;
  FWidgetStateMap<TextStyle> get textStyle;
  EdgeInsetsGeometry get padding;
  double get spacing;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;

  /// Returns itself.
  ///
  /// Allows [FBottomNavigationBarItemStyle] to replace functions that accept and return a [FBottomNavigationBarItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBottomNavigationBarItemStyle Function(FBottomNavigationBarItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBottomNavigationBarItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBottomNavigationBarItemStyle(...));
  /// ```
  @useResult
  FBottomNavigationBarItemStyle call(Object? _) => this as FBottomNavigationBarItemStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('spacing', spacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBottomNavigationBarItemStyle &&
          iconStyle == other.iconStyle &&
          textStyle == other.textStyle &&
          padding == other.padding &&
          spacing == other.spacing &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle);

  @override
  int get hashCode =>
      iconStyle.hashCode ^
      textStyle.hashCode ^
      padding.hashCode ^
      spacing.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode;
}

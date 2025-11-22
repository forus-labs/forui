// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'bottom_navigation_bar.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBottomNavigationBarStyleTransformations on FBottomNavigationBarStyle {
  /// Returns a copy of this [FBottomNavigationBarStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FBottomNavigationBarStyle.decoration] - The decoration.
  /// * [FBottomNavigationBarStyle.backgroundFilter] - An optional background filter.
  /// * [FBottomNavigationBarStyle.padding] - The padding.
  /// * [FBottomNavigationBarStyle.itemStyle] - The item's style.
  @useResult
  FBottomNavigationBarStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometry? padding,
    FBottomNavigationBarItemStyle Function(FBottomNavigationBarItemStyle style)? itemStyle,
  }) => FBottomNavigationBarStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
  );

  /// Linearly interpolate between this and another [FBottomNavigationBarStyle] using the given factor [t].
  @useResult
  FBottomNavigationBarStyle lerp(FBottomNavigationBarStyle other, double t) => FBottomNavigationBarStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    itemStyle: itemStyle.lerp(other.itemStyle, t),
  );
}

mixin _$FBottomNavigationBarStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get padding;
  FBottomNavigationBarItemStyle get itemStyle;

  /// Returns itself.
  ///
  /// Allows [FBottomNavigationBarStyle] to replace functions that accept and return a [FBottomNavigationBarStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBottomNavigationBarStyle Function(FBottomNavigationBarStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBottomNavigationBarStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBottomNavigationBarStyle(...));
  /// ```
  @useResult
  FBottomNavigationBarStyle call(Object? _) => this as FBottomNavigationBarStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('itemStyle', itemStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBottomNavigationBarStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          itemStyle == other.itemStyle);

  @override
  int get hashCode => decoration.hashCode ^ backgroundFilter.hashCode ^ padding.hashCode ^ itemStyle.hashCode;
}

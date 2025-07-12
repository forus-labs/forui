// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'bottom_navigation_bar.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FBottomNavigationBarStyleCopyWith on FBottomNavigationBarStyle {
  /// Returns a copy of this [FBottomNavigationBarStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// # [backgroundFilter]
  /// An optional background filter. This only takes effect if the [decoration] has a transparent or translucent
  /// background color.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  ///
  /// // Solid color
  /// ColorFilter.mode(Colors.white, BlendMode.srcOver);
  ///
  /// // Tinted
  /// ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver),
  /// );
  /// ```
  ///
  /// # [padding]
  /// The padding. Defaults to `EdgeInsets.all(5)`.
  ///
  /// # [itemStyle]
  /// The item's style.
  ///
  @useResult
  FBottomNavigationBarStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometry? padding,
    FBottomNavigationBarItemStyle Function(FBottomNavigationBarItemStyle)? itemStyle,
  }) => FBottomNavigationBarStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    itemStyle: itemStyle != null ? itemStyle(this.itemStyle) : this.itemStyle,
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
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('itemStyle', itemStyle));
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

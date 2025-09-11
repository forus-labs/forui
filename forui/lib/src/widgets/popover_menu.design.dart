// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'popover_menu.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPopoverMenuStyleTransformations on FPopoverMenuStyle {
  /// Returns a copy of this [FPopoverMenuStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FPopoverMenuStyle.itemGroupStyle] - The item group's style.
  /// * [FPopoverMenuStyle.tileGroupStyle] - The tile group's style.
  /// * [FPopoverMenuStyle.maxWidth] - The menu's max width.
  /// * [FPopoverMenuStyle.decoration] - The popover's decoration.
  /// * [FPopoverMenuStyle.barrierFilter] - {@template forui.
  /// * [FPopoverMenuStyle.backgroundFilter] - {@template forui.
  /// * [FPopoverMenuStyle.viewInsets] - The additional insets of the view.
  @useResult
  FPopoverMenuStyle copyWith({
    FItemGroupStyle Function(FItemGroupStyle style)? itemGroupStyle,
    FTileGroupStyle Function(FTileGroupStyle style)? tileGroupStyle,
    double? maxWidth,
    BoxDecoration? decoration,
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    EdgeInsetsGeometry? viewInsets,
  }) => FPopoverMenuStyle(
    itemGroupStyle: itemGroupStyle != null ? itemGroupStyle(this.itemGroupStyle) : this.itemGroupStyle,
    tileGroupStyle: tileGroupStyle != null ? tileGroupStyle(this.tileGroupStyle) : this.tileGroupStyle,
    maxWidth: maxWidth ?? this.maxWidth,
    decoration: decoration ?? this.decoration,
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    viewInsets: viewInsets ?? this.viewInsets,
  );

  /// Linearly interpolate between this and another [FPopoverMenuStyle] using the given factor [t].
  @useResult
  FPopoverMenuStyle lerp(FPopoverMenuStyle other, double t) => FPopoverMenuStyle(
    itemGroupStyle: itemGroupStyle.lerp(other.itemGroupStyle, t),
    tileGroupStyle: tileGroupStyle.lerp(other.tileGroupStyle, t),
    maxWidth: lerpDouble(maxWidth, other.maxWidth, t) ?? maxWidth,
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    viewInsets: EdgeInsetsGeometry.lerp(viewInsets, other.viewInsets, t) ?? viewInsets,
  );
}

mixin _$FPopoverMenuStyleFunctions on Diagnosticable {
  FItemGroupStyle get itemGroupStyle;
  FTileGroupStyle get tileGroupStyle;
  double get maxWidth;
  BoxDecoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;

  /// Returns itself.
  ///
  /// Allows [FPopoverMenuStyle] to replace functions that accept and return a [FPopoverMenuStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FPopoverMenuStyle Function(FPopoverMenuStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FPopoverMenuStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FPopoverMenuStyle(...));
  /// ```
  @useResult
  FPopoverMenuStyle call(Object? _) => this as FPopoverMenuStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('itemGroupStyle', itemGroupStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('maxWidth', maxWidth, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('viewInsets', viewInsets, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverMenuStyle &&
          itemGroupStyle == other.itemGroupStyle &&
          tileGroupStyle == other.tileGroupStyle &&
          maxWidth == other.maxWidth &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);

  @override
  int get hashCode =>
      itemGroupStyle.hashCode ^
      tileGroupStyle.hashCode ^
      maxWidth.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      viewInsets.hashCode;
}

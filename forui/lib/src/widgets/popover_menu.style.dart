// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'popover_menu.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FPopoverMenuStyleCopyWith on FPopoverMenuStyle {
  /// Returns a copy of this [FPopoverMenuStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [itemGroupStyle]
  /// The item group's style.
  ///
  /// # [tileGroupStyle]
  /// The tile group's style.
  ///
  /// # [maxWidth]
  /// The menu's max width. Defaults to 250.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the width is not positive.
  ///
  /// # [decoration]
  /// The popover's decoration.
  ///
  /// # [barrierFilter]
  /// {@template forui.widgets.FPopoverStyle.barrierFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the barrier. Defaults to null.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  ///
  /// # [backgroundFilter]
  /// {@template forui.widgets.FPopoverStyle.backgroundFilter}
  /// An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter]
  /// that is used as the background. Defaults to null.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// (animation) => ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5);
  ///
  /// // Solid color
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation), BlendMode.srcOver);
  ///
  /// // Tinted
  /// (animation) => ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// (animation) => ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: animation * 5, sigmaY: animation * 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: animation * 0.5), BlendMode.srcOver),
  /// );
  /// ```
  /// {@endtemplate}
  ///
  /// # [viewInsets]
  /// The additional insets of the view. In other words, the minimum distance between the edges of the view and the
  /// edges of the popover. This applied in addition to the insets provided by [MediaQueryData.viewPadding].
  ///
  /// Defaults to `EdgeInsets.all(5)`.
  ///
  @useResult
  FPopoverMenuStyle copyWith({
    FItemGroupStyle Function(FItemGroupStyle)? itemGroupStyle,
    FTileGroupStyle Function(FTileGroupStyle)? tileGroupStyle,
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
      ..add(DiagnosticsProperty('itemGroupStyle', itemGroupStyle))
      ..add(DiagnosticsProperty('tileGroupStyle', tileGroupStyle))
      ..add(DoubleProperty('maxWidth', maxWidth))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('viewInsets', viewInsets));
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

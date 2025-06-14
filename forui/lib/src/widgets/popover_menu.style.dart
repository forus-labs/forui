// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'popover_menu.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FPopoverMenuStyleFunctions on Diagnosticable implements FTransformable {
  FTileGroupStyle get tileGroupStyle;
  double get maxWidth;
  BoxDecoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;

  /// Returns a copy of this [FPopoverMenuStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FPopoverMenuStyle copyWith({
    FTileGroupStyle? tileGroupStyle,
    double? maxWidth,
    BoxDecoration? decoration,
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    EdgeInsetsGeometry? viewInsets,
  }) => FPopoverMenuStyle(
    tileGroupStyle: tileGroupStyle ?? this.tileGroupStyle,
    maxWidth: maxWidth ?? this.maxWidth,
    decoration: decoration ?? this.decoration,
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    viewInsets: viewInsets ?? this.viewInsets,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
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
          tileGroupStyle == other.tileGroupStyle &&
          maxWidth == other.maxWidth &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);
  @override
  int get hashCode =>
      tileGroupStyle.hashCode ^
      maxWidth.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      viewInsets.hashCode;
}

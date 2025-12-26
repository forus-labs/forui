// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectContentStyleTransformations on FSelectContentStyle {
  /// Returns a copy of this [FSelectContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectContentStyle.sectionStyle] - A section's style.
  /// * [FSelectContentStyle.scrollHandleStyle] - A scroll handle's style.
  /// * [FSelectContentStyle.padding] - The padding surrounding the content.
  /// * [FSelectContentStyle.decoration] - The popover's decoration.
  /// * [FSelectContentStyle.barrierFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the barrier.
  /// * [FSelectContentStyle.backgroundFilter] - An optional callback that takes the current animation transition value (0.0 to 1.0) and returns an [ImageFilter] that is used as the background.
  /// * [FSelectContentStyle.viewInsets] - The additional insets of the view.
  @useResult
  FSelectContentStyle copyWith({
    FSelectSectionStyle Function(FSelectSectionStyle style)? sectionStyle,
    FSelectScrollHandleStyle Function(FSelectScrollHandleStyle style)? scrollHandleStyle,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    EdgeInsetsGeometry? viewInsets,
  }) => .new(
    sectionStyle: sectionStyle != null ? sectionStyle(this.sectionStyle) : this.sectionStyle,
    scrollHandleStyle: scrollHandleStyle != null ? scrollHandleStyle(this.scrollHandleStyle) : this.scrollHandleStyle,
    padding: padding ?? this.padding,
    decoration: decoration ?? this.decoration,
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    viewInsets: viewInsets ?? this.viewInsets,
  );

  /// Linearly interpolate between this and another [FSelectContentStyle] using the given factor [t].
  @useResult
  FSelectContentStyle lerp(FSelectContentStyle other, double t) => .new(
    sectionStyle: sectionStyle.lerp(other.sectionStyle, t),
    scrollHandleStyle: scrollHandleStyle.lerp(other.scrollHandleStyle, t),
    padding: .lerp(padding, other.padding, t) ?? padding,
    decoration: .lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    viewInsets: .lerp(viewInsets, other.viewInsets, t) ?? viewInsets,
  );
}

mixin _$FSelectContentStyleFunctions on Diagnosticable {
  FSelectSectionStyle get sectionStyle;
  FSelectScrollHandleStyle get scrollHandleStyle;
  EdgeInsetsGeometry get padding;
  BoxDecoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;

  /// Returns itself.
  ///
  /// Allows [FSelectContentStyle] to replace functions that accept and return a [FSelectContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectContentStyle Function(FSelectContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectContentStyle(...));
  /// ```
  @useResult
  FSelectContentStyle call(Object? _) => this as FSelectContentStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle, level: .debug))
      ..add(DiagnosticsProperty('scrollHandleStyle', scrollHandleStyle, level: .debug))
      ..add(DiagnosticsProperty('padding', padding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectContentStyle &&
          runtimeType == other.runtimeType &&
          sectionStyle == other.sectionStyle &&
          scrollHandleStyle == other.scrollHandleStyle &&
          padding == other.padding &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);

  @override
  int get hashCode =>
      sectionStyle.hashCode ^
      scrollHandleStyle.hashCode ^
      padding.hashCode ^
      decoration.hashCode ^
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      viewInsets.hashCode;
}

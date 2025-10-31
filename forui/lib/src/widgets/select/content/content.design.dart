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
  @useResult
  FSelectContentStyle copyWith({
    FSelectSectionStyle Function(FSelectSectionStyle style)? sectionStyle,
    FSelectScrollHandleStyle Function(FSelectScrollHandleStyle style)? scrollHandleStyle,
    EdgeInsetsGeometry? padding,
  }) => FSelectContentStyle(
    sectionStyle: sectionStyle != null ? sectionStyle(this.sectionStyle) : this.sectionStyle,
    scrollHandleStyle: scrollHandleStyle != null ? scrollHandleStyle(this.scrollHandleStyle) : this.scrollHandleStyle,
    padding: padding ?? this.padding,
  );

  /// Linearly interpolate between this and another [FSelectContentStyle] using the given factor [t].
  @useResult
  FSelectContentStyle lerp(FSelectContentStyle other, double t) => FSelectContentStyle(
    sectionStyle: sectionStyle.lerp(other.sectionStyle, t),
    scrollHandleStyle: scrollHandleStyle.lerp(other.scrollHandleStyle, t),
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
  );
}

mixin _$FSelectContentStyleFunctions on Diagnosticable {
  FSelectSectionStyle get sectionStyle;
  FSelectScrollHandleStyle get scrollHandleStyle;
  EdgeInsetsGeometry get padding;

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
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scrollHandleStyle', scrollHandleStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectContentStyle &&
          sectionStyle == other.sectionStyle &&
          scrollHandleStyle == other.scrollHandleStyle &&
          padding == other.padding);

  @override
  int get hashCode => sectionStyle.hashCode ^ scrollHandleStyle.hashCode ^ padding.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSelectContentStyleCopyWith on FSelectContentStyle {
  /// Returns a copy of this [FSelectContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [sectionStyle]
  /// A section's style.
  ///
  /// # [scrollHandleStyle]
  /// A scroll handle's style.
  ///
  /// # [padding]
  /// The padding surrounding the content. Defaults to `const EdgeInsets.symmetric(vertical: 5)`.
  ///
  @useResult
  FSelectContentStyle copyWith({
    FSelectSectionStyle Function(FSelectSectionStyle)? sectionStyle,
    FSelectScrollHandleStyle Function(FSelectScrollHandleStyle)? scrollHandleStyle,
    EdgeInsetsGeometry? padding,
  }) => FSelectContentStyle(
    sectionStyle: sectionStyle != null ? sectionStyle(this.sectionStyle) : this.sectionStyle,
    scrollHandleStyle: scrollHandleStyle != null ? scrollHandleStyle(this.scrollHandleStyle) : this.scrollHandleStyle,
    padding: padding ?? this.padding,
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
      ..add(DiagnosticsProperty('sectionStyle', sectionStyle))
      ..add(DiagnosticsProperty('scrollHandleStyle', scrollHandleStyle))
      ..add(DiagnosticsProperty('padding', padding));
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

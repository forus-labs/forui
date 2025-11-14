// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBadgeStyleTransformations on FBadgeStyle {
  /// Returns a copy of this [FBadgeStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FBadgeStyle.decoration] - The decoration.
  /// * [FBadgeStyle.contentStyle] - The content's style.
  @useResult
  FBadgeStyle copyWith({
    BoxDecoration? decoration,
    FBadgeContentStyle Function(FBadgeContentStyle style)? contentStyle,
  }) => FBadgeStyle(
    decoration: decoration ?? this.decoration,
    contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
  );

  /// Linearly interpolate between this and another [FBadgeStyle] using the given factor [t].
  @useResult
  FBadgeStyle lerp(FBadgeStyle other, double t) => FBadgeStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FBadgeStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  FBadgeContentStyle get contentStyle;

  /// Returns itself.
  ///
  /// Allows [FBadgeStyle] to replace functions that accept and return a [FBadgeStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBadgeStyle Function(FBadgeStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBadgeStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBadgeStyle(...));
  /// ```
  @useResult
  FBadgeStyle call(Object? _) => this as FBadgeStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentStyle', contentStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeStyle && decoration == other.decoration && contentStyle == other.contentStyle);

  @override
  int get hashCode => decoration.hashCode ^ contentStyle.hashCode;
}

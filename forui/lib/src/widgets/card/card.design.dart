// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCardStyleTransformations on FCardStyle {
  /// Returns a copy of this [FCardStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCardStyle.decoration] - The decoration.
  /// * [FCardStyle.contentStyle] - The card content's style.
  @useResult
  FCardStyle copyWith({BoxDecoration? decoration, FCardContentStyle Function(FCardContentStyle style)? contentStyle}) =>
      FCardStyle(
        decoration: decoration ?? this.decoration,
        contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
      );

  /// Linearly interpolate between this and another [FCardStyle] using the given factor [t].
  @useResult
  FCardStyle lerp(FCardStyle other, double t) => FCardStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    contentStyle: contentStyle.lerp(other.contentStyle, t),
  );
}

mixin _$FCardStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  FCardContentStyle get contentStyle;

  /// Returns itself.
  ///
  /// Allows [FCardStyle] to replace functions that accept and return a [FCardStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCardStyle Function(FCardStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCardStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCardStyle(...));
  /// ```
  @useResult
  FCardStyle call(Object? _) => this as FCardStyle;

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
      (other is FCardStyle && decoration == other.decoration && contentStyle == other.contentStyle);

  @override
  int get hashCode => decoration.hashCode ^ contentStyle.hashCode;
}

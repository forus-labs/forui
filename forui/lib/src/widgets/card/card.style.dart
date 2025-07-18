// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'card.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FCardStyleCopyWith on FCardStyle {
  /// Returns a copy of this [FCardStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// # [contentStyle]
  /// The card content's style.
  ///
  @useResult
  FCardStyle copyWith({BoxDecoration? decoration, FCardContentStyle Function(FCardContentStyle)? contentStyle}) =>
      FCardStyle(
        decoration: decoration ?? this.decoration,
        contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
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
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('contentStyle', contentStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCardStyle && decoration == other.decoration && contentStyle == other.contentStyle);
  @override
  int get hashCode => decoration.hashCode ^ contentStyle.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FBadgeStyleCopyWith on FBadgeStyle {
  /// Returns a copy of this [FBadgeStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [decoration]
  /// The decoration.
  ///
  /// # [contentStyle]
  /// The content's style.
  ///
  @useResult
  FBadgeStyle copyWith({BoxDecoration? decoration, FBadgeContentStyle Function(FBadgeContentStyle)? contentStyle}) =>
      FBadgeStyle(
        decoration: decoration ?? this.decoration,
        contentStyle: contentStyle != null ? contentStyle(this.contentStyle) : this.contentStyle,
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
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('contentStyle', contentStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeStyle && decoration == other.decoration && contentStyle == other.contentStyle);
  @override
  int get hashCode => decoration.hashCode ^ contentStyle.hashCode;
}

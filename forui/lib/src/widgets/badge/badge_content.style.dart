// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge_content.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FBadgeContentStyleCopyWith on FBadgeContentStyle {
  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [labelTextStyle]
  /// The label's [TextStyle].
  ///
  /// # [padding]
  /// The padding.
  ///
  @useResult
  FBadgeContentStyle copyWith({TextStyle? labelTextStyle, EdgeInsetsGeometry? padding}) =>
      FBadgeContentStyle(labelTextStyle: labelTextStyle ?? this.labelTextStyle, padding: padding ?? this.padding);
}

mixin _$FBadgeContentStyleFunctions on Diagnosticable {
  TextStyle get labelTextStyle;
  EdgeInsetsGeometry get padding;

  /// Returns itself.
  ///
  /// Allows [FBadgeContentStyle] to replace functions that accept and return a [FBadgeContentStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBadgeContentStyle Function(FBadgeContentStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBadgeContentStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBadgeContentStyle(...));
  /// ```
  @useResult
  FBadgeContentStyle call(Object? _) => this as FBadgeContentStyle;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('padding', padding));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeContentStyle && labelTextStyle == other.labelTextStyle && padding == other.padding);
  @override
  int get hashCode => labelTextStyle.hashCode ^ padding.hashCode;
}

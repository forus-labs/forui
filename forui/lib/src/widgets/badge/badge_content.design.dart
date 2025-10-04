// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge_content.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBadgeContentStyleTransformations on FBadgeContentStyle {
  /// Returns a copy of this [FBadgeContentStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FBadgeContentStyle.labelTextStyle] - The label's [TextStyle].
  /// * [FBadgeContentStyle.padding] - The padding.
  @useResult
  FBadgeContentStyle copyWith({TextStyle? labelTextStyle, EdgeInsetsGeometry? padding}) =>
      FBadgeContentStyle(labelTextStyle: labelTextStyle ?? this.labelTextStyle, padding: padding ?? this.padding);

  /// Linearly interpolate between this and another [FBadgeContentStyle] using the given factor [t].
  @useResult
  FBadgeContentStyle lerp(FBadgeContentStyle other, double t) => FBadgeContentStyle(
    labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t) ?? labelTextStyle,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
  );
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
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeContentStyle && labelTextStyle == other.labelTextStyle && padding == other.padding);

  @override
  int get hashCode => labelTextStyle.hashCode ^ padding.hashCode;
}

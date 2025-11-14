// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge_styles.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FBadgeStylesTransformations on FBadgeStyles {
  /// Returns a copy of this [FBadgeStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FBadgeStyles.primary] - The primary badge style.
  /// * [FBadgeStyles.secondary] - The secondary badge style.
  /// * [FBadgeStyles.outline] - The outlined badge style.
  /// * [FBadgeStyles.destructive] - The destructive badge style.
  @useResult
  FBadgeStyles copyWith({
    FBadgeStyle Function(FBadgeStyle style)? primary,
    FBadgeStyle Function(FBadgeStyle style)? secondary,
    FBadgeStyle Function(FBadgeStyle style)? outline,
    FBadgeStyle Function(FBadgeStyle style)? destructive,
  }) => FBadgeStyles(
    primary: primary != null ? primary(this.primary) : this.primary,
    secondary: secondary != null ? secondary(this.secondary) : this.secondary,
    outline: outline != null ? outline(this.outline) : this.outline,
    destructive: destructive != null ? destructive(this.destructive) : this.destructive,
  );

  /// Linearly interpolate between this and another [FBadgeStyles] using the given factor [t].
  @useResult
  FBadgeStyles lerp(FBadgeStyles other, double t) => FBadgeStyles(
    primary: primary.lerp(other.primary, t),
    secondary: secondary.lerp(other.secondary, t),
    outline: outline.lerp(other.outline, t),
    destructive: destructive.lerp(other.destructive, t),
  );
}

mixin _$FBadgeStylesFunctions on Diagnosticable {
  FBadgeStyle get primary;
  FBadgeStyle get secondary;
  FBadgeStyle get outline;
  FBadgeStyle get destructive;

  /// Returns itself.
  ///
  /// Allows [FBadgeStyles] to replace functions that accept and return a [FBadgeStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FBadgeStyles Function(FBadgeStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FBadgeStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FBadgeStyles(...));
  /// ```
  @useResult
  FBadgeStyles call(Object? _) => this as FBadgeStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('secondary', secondary, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('outline', outline, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('destructive', destructive, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FBadgeStyles &&
          primary == other.primary &&
          secondary == other.secondary &&
          outline == other.outline &&
          destructive == other.destructive);

  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode ^ outline.hashCode ^ destructive.hashCode;
}

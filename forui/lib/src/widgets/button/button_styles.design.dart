// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button_styles.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FButtonStylesTransformations on FButtonStyles {
  /// Returns a copy of this [FButtonStyles] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FButtonStyles.primary] - The primary button style.
  /// * [FButtonStyles.secondary] - The secondary  button style.
  /// * [FButtonStyles.destructive] - The destructive button style.
  /// * [FButtonStyles.outline] - The outlined button style.
  /// * [FButtonStyles.ghost] - The ghost button style.
  @useResult
  FButtonStyles copyWith({
    FButtonStyle Function(FButtonStyle style)? primary,
    FButtonStyle Function(FButtonStyle style)? secondary,
    FButtonStyle Function(FButtonStyle style)? destructive,
    FButtonStyle Function(FButtonStyle style)? outline,
    FButtonStyle Function(FButtonStyle style)? ghost,
  }) => FButtonStyles(
    primary: primary != null ? primary(this.primary) : this.primary,
    secondary: secondary != null ? secondary(this.secondary) : this.secondary,
    destructive: destructive != null ? destructive(this.destructive) : this.destructive,
    outline: outline != null ? outline(this.outline) : this.outline,
    ghost: ghost != null ? ghost(this.ghost) : this.ghost,
  );

  /// Linearly interpolate between this and another [FButtonStyles] using the given factor [t].
  @useResult
  FButtonStyles lerp(FButtonStyles other, double t) => FButtonStyles(
    primary: primary.lerp(other.primary, t),
    secondary: secondary.lerp(other.secondary, t),
    destructive: destructive.lerp(other.destructive, t),
    outline: outline.lerp(other.outline, t),
    ghost: ghost.lerp(other.ghost, t),
  );
}

mixin _$FButtonStylesFunctions on Diagnosticable {
  FButtonStyle get primary;
  FButtonStyle get secondary;
  FButtonStyle get destructive;
  FButtonStyle get outline;
  FButtonStyle get ghost;

  /// Returns itself.
  ///
  /// Allows [FButtonStyles] to replace functions that accept and return a [FButtonStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FButtonStyles Function(FButtonStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FButtonStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FButtonStyles(...));
  /// ```
  @useResult
  FButtonStyles call(Object? _) => this as FButtonStyles;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('secondary', secondary, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('destructive', destructive, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('outline', outline, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('ghost', ghost, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FButtonStyles &&
          primary == other.primary &&
          secondary == other.secondary &&
          destructive == other.destructive &&
          outline == other.outline &&
          ghost == other.ghost);

  @override
  int get hashCode => primary.hashCode ^ secondary.hashCode ^ destructive.hashCode ^ outline.hashCode ^ ghost.hashCode;
}

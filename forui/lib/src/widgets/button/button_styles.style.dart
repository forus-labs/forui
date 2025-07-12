// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button_styles.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FButtonStylesCopyWith on FButtonStyles {
  /// Returns a copy of this [FButtonStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [primary]
  /// The primary button style.
  ///
  /// # [secondary]
  /// The secondary  button style.
  ///
  /// # [destructive]
  /// The destructive button style.
  ///
  /// # [outline]
  /// The outlined button style.
  ///
  /// # [ghost]
  /// The ghost button style.
  ///
  @useResult
  FButtonStyles copyWith({
    FButtonStyle Function(FButtonStyle)? primary,
    FButtonStyle Function(FButtonStyle)? secondary,
    FButtonStyle Function(FButtonStyle)? destructive,
    FButtonStyle Function(FButtonStyle)? outline,
    FButtonStyle Function(FButtonStyle)? ghost,
  }) => FButtonStyles(
    primary: primary != null ? primary(this.primary) : this.primary,
    secondary: secondary != null ? secondary(this.secondary) : this.secondary,
    destructive: destructive != null ? destructive(this.destructive) : this.destructive,
    outline: outline != null ? outline(this.outline) : this.outline,
    ghost: ghost != null ? ghost(this.ghost) : this.ghost,
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
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('destructive', destructive))
      ..add(DiagnosticsProperty('outline', outline))
      ..add(DiagnosticsProperty('ghost', ghost));
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

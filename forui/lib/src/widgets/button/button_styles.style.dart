// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'button_styles.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FButtonStylesFunctions on Diagnosticable implements FTransformable {
  FButtonStyle get primary;
  FButtonStyle get secondary;
  FButtonStyle get destructive;
  FButtonStyle get outline;
  FButtonStyle get ghost;

  /// Returns a copy of this [FButtonStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FButtonStyles copyWith({
    FButtonStyle? primary,
    FButtonStyle? secondary,
    FButtonStyle? destructive,
    FButtonStyle? outline,
    FButtonStyle? ghost,
  }) => FButtonStyles(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    destructive: destructive ?? this.destructive,
    outline: outline ?? this.outline,
    ghost: ghost ?? this.ghost,
  );
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

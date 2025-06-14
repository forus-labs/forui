// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'badge_styles.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FBadgeStylesFunctions on Diagnosticable implements FTransformable {
  FBadgeStyle get primary;
  FBadgeStyle get secondary;
  FBadgeStyle get outline;
  FBadgeStyle get destructive;

  /// Returns a copy of this [FBadgeStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FBadgeStyles copyWith({
    FBadgeStyle? primary,
    FBadgeStyle? secondary,
    FBadgeStyle? outline,
    FBadgeStyle? destructive,
  }) => FBadgeStyles(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    outline: outline ?? this.outline,
    destructive: destructive ?? this.destructive,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('outline', outline))
      ..add(DiagnosticsProperty('destructive', destructive));
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

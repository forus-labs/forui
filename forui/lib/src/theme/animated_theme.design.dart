// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'animated_theme.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAnimatedThemeMotionTransformations on FAnimatedThemeMotion {
  /// Returns a copy of this [FAnimatedThemeMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FAnimatedThemeMotion.duration] - The animation's duration.
  /// * [FAnimatedThemeMotion.curve] - The animation's curve.
  @useResult
  FAnimatedThemeMotion copyWith({Duration? duration, Curve? curve}) =>
      FAnimatedThemeMotion(duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FAnimatedThemeMotion] using the given factor [t].
  @useResult
  FAnimatedThemeMotion lerp(FAnimatedThemeMotion other, double t) =>
      FAnimatedThemeMotion(duration: t < 0.5 ? duration : other.duration, curve: t < 0.5 ? curve : other.curve);
}

mixin _$FAnimatedThemeMotionFunctions on Diagnosticable {
  Duration get duration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FAnimatedThemeMotion call(Object? _) => this as FAnimatedThemeMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FAnimatedThemeMotion && duration == other.duration && curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}

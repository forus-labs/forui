// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'theme.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FThemeMotionTransformations on FThemeMotion {
  /// Returns a copy of this [FThemeMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FThemeMotion.duration] - The animation's duration.
  /// * [FThemeMotion.curve] - The animation's curve.
  @useResult
  FThemeMotion copyWith({Duration? duration, Curve? curve}) =>
      .new(duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FThemeMotion] using the given factor [t].
  @useResult
  FThemeMotion lerp(FThemeMotion other, double t) =>
      .new(duration: t < 0.5 ? duration : other.duration, curve: t < 0.5 ? curve : other.curve);
}

mixin _$FThemeMotionFunctions on Diagnosticable {
  Duration get duration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FThemeMotion call(Object? _) => this as FThemeMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FThemeMotion && runtimeType == other.runtimeType && duration == other.duration && curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}

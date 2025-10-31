// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'circular_progress.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FCircularProgressStyleTransformations on FCircularProgressStyle {
  /// Returns a copy of this [FCircularProgressStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FCircularProgressStyle.iconStyle] - The circular progress's style.
  /// * [FCircularProgressStyle.motion] - The motion-related properties.
  @useResult
  FCircularProgressStyle copyWith({
    IconThemeData? iconStyle,
    FCircularProgressMotion Function(FCircularProgressMotion motion)? motion,
  }) => FCircularProgressStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FCircularProgressStyle] using the given factor [t].
  @useResult
  FCircularProgressStyle lerp(FCircularProgressStyle other, double t) => FCircularProgressStyle(
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FCircularProgressStyleFunctions on Diagnosticable {
  IconThemeData get iconStyle;
  FCircularProgressMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FCircularProgressStyle] to replace functions that accept and return a [FCircularProgressStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FCircularProgressStyle Function(FCircularProgressStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FCircularProgressStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FCircularProgressStyle(...));
  /// ```
  @useResult
  FCircularProgressStyle call(Object? _) => this as FCircularProgressStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCircularProgressStyle && iconStyle == other.iconStyle && motion == other.motion);

  @override
  int get hashCode => iconStyle.hashCode ^ motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FCircularProgressMotionTransformations on FCircularProgressMotion {
  /// Returns a copy of this [FCircularProgressMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FCircularProgressMotion.duration] - The duration of one full rotation.
  /// * [FCircularProgressMotion.curve] - The animation curve.
  /// * [FCircularProgressMotion.tween] - The rotation's tween.
  @useResult
  FCircularProgressMotion copyWith({Duration? duration, Curve? curve, Animatable<double>? tween}) =>
      FCircularProgressMotion(
        duration: duration ?? this.duration,
        curve: curve ?? this.curve,
        tween: tween ?? this.tween,
      );

  /// Linearly interpolate between this and another [FCircularProgressMotion] using the given factor [t].
  @useResult
  FCircularProgressMotion lerp(FCircularProgressMotion other, double t) => FCircularProgressMotion(
    duration: t < 0.5 ? duration : other.duration,
    curve: t < 0.5 ? curve : other.curve,
    tween: t < 0.5 ? tween : other.tween,
  );
}

mixin _$FCircularProgressMotionFunctions on Diagnosticable {
  Duration get duration;
  Curve get curve;
  Animatable<double> get tween;

  /// Returns itself.
  @useResult
  FCircularProgressMotion call(Object? _) => this as FCircularProgressMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tween', tween, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FCircularProgressMotion && duration == other.duration && curve == other.curve && tween == other.tween);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode ^ tween.hashCode;
}

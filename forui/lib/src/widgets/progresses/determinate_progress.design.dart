// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'determinate_progress.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDeterminateProgressStyleTransformations on FDeterminateProgressStyle {
  /// Returns a copy of this [FDeterminateProgressStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDeterminateProgressStyle.constraints] - The linear progress's constraints.
  /// * [FDeterminateProgressStyle.trackDecoration] - The track's decoration.
  /// * [FDeterminateProgressStyle.fillDecoration] - The fill's decoration.
  /// * [FDeterminateProgressStyle.motion] - The motion-related properties for an indeterminate [FDeterminateProgress].
  @useResult
  FDeterminateProgressStyle copyWith({
    BoxConstraints? constraints,
    BoxDecoration? trackDecoration,
    BoxDecoration? fillDecoration,
    FDeterminateProgressMotion Function(FDeterminateProgressMotion motion)? motion,
  }) => FDeterminateProgressStyle(
    constraints: constraints ?? this.constraints,
    trackDecoration: trackDecoration ?? this.trackDecoration,
    fillDecoration: fillDecoration ?? this.fillDecoration,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FDeterminateProgressStyle] using the given factor [t].
  @useResult
  FDeterminateProgressStyle lerp(FDeterminateProgressStyle other, double t) => FDeterminateProgressStyle(
    constraints: BoxConstraints.lerp(constraints, other.constraints, t) ?? constraints,
    trackDecoration: BoxDecoration.lerp(trackDecoration, other.trackDecoration, t) ?? trackDecoration,
    fillDecoration: BoxDecoration.lerp(fillDecoration, other.fillDecoration, t) ?? fillDecoration,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FDeterminateProgressStyleFunctions on Diagnosticable {
  BoxConstraints get constraints;
  BoxDecoration get trackDecoration;
  BoxDecoration get fillDecoration;
  FDeterminateProgressMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FDeterminateProgressStyle] to replace functions that accept and return a [FDeterminateProgressStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDeterminateProgressStyle Function(FDeterminateProgressStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDeterminateProgressStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDeterminateProgressStyle(...));
  /// ```
  @useResult
  FDeterminateProgressStyle call(Object? _) => this as FDeterminateProgressStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('constraints', constraints, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('trackDecoration', trackDecoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fillDecoration', fillDecoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDeterminateProgressStyle &&
          constraints == other.constraints &&
          trackDecoration == other.trackDecoration &&
          fillDecoration == other.fillDecoration &&
          motion == other.motion);

  @override
  int get hashCode => constraints.hashCode ^ trackDecoration.hashCode ^ fillDecoration.hashCode ^ motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDeterminateProgressMotionTransformations on FDeterminateProgressMotion {
  /// Returns a copy of this [FDeterminateProgressMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FDeterminateProgressMotion.duration] - The animation's duration for a full progress from 0.
  /// * [FDeterminateProgressMotion.curve] - The animation curve.
  @useResult
  FDeterminateProgressMotion copyWith({Duration? duration, Curve? curve}) =>
      FDeterminateProgressMotion(duration: duration ?? this.duration, curve: curve ?? this.curve);

  /// Linearly interpolate between this and another [FDeterminateProgressMotion] using the given factor [t].
  @useResult
  FDeterminateProgressMotion lerp(FDeterminateProgressMotion other, double t) =>
      FDeterminateProgressMotion(duration: t < 0.5 ? duration : other.duration, curve: t < 0.5 ? curve : other.curve);
}

mixin _$FDeterminateProgressMotionFunctions on Diagnosticable {
  Duration get duration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FDeterminateProgressMotion call(Object? _) => this as FDeterminateProgressMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('duration', duration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDeterminateProgressMotion && duration == other.duration && curve == other.curve);

  @override
  int get hashCode => duration.hashCode ^ curve.hashCode;
}

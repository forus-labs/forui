// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'progress.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FProgressStyleTransformations on FProgressStyle {
  /// Returns a copy of this [FProgressStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FProgressStyle.constraints] - The linear progress's constraints.
  /// * [FProgressStyle.trackDecoration] - The track's decoration.
  /// * [FProgressStyle.fillDecoration] - The fill's decoration.
  /// * [FProgressStyle.motion] - The motion-related properties for an indeterminate [FProgress].
  @useResult
  FProgressStyle copyWith({
    BoxConstraints? constraints,
    BoxDecoration? trackDecoration,
    BoxDecoration? fillDecoration,
    FProgressMotion Function(FProgressMotion motion)? motion,
  }) => FProgressStyle(
    constraints: constraints ?? this.constraints,
    trackDecoration: trackDecoration ?? this.trackDecoration,
    fillDecoration: fillDecoration ?? this.fillDecoration,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FProgressStyle] using the given factor [t].
  @useResult
  FProgressStyle lerp(FProgressStyle other, double t) => FProgressStyle(
    constraints: BoxConstraints.lerp(constraints, other.constraints, t) ?? constraints,
    trackDecoration: BoxDecoration.lerp(trackDecoration, other.trackDecoration, t) ?? trackDecoration,
    fillDecoration: BoxDecoration.lerp(fillDecoration, other.fillDecoration, t) ?? fillDecoration,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FProgressStyleFunctions on Diagnosticable {
  BoxConstraints get constraints;
  BoxDecoration get trackDecoration;
  BoxDecoration get fillDecoration;
  FProgressMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FProgressStyle] to replace functions that accept and return a [FProgressStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FProgressStyle Function(FProgressStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FProgressStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FProgressStyle(...));
  /// ```
  @useResult
  FProgressStyle call(Object? _) => this as FProgressStyle;

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
      (other is FProgressStyle &&
          constraints == other.constraints &&
          trackDecoration == other.trackDecoration &&
          fillDecoration == other.fillDecoration &&
          motion == other.motion);

  @override
  int get hashCode => constraints.hashCode ^ trackDecoration.hashCode ^ fillDecoration.hashCode ^ motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FProgressMotionTransformations on FProgressMotion {
  /// Returns a copy of this [FProgressMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FProgressMotion.period] - The animation's period.
  /// * [FProgressMotion.interval] - The interval between animations.
  /// * [FProgressMotion.curve] - The animation curve.
  /// * [FProgressMotion.value] - The percentage of the filled progress.
  @useResult
  FProgressMotion copyWith({Duration? period, Duration? interval, Curve? curve, double? value}) => FProgressMotion(
    period: period ?? this.period,
    interval: interval ?? this.interval,
    curve: curve ?? this.curve,
    value: value ?? this.value,
  );

  /// Linearly interpolate between this and another [FProgressMotion] using the given factor [t].
  @useResult
  FProgressMotion lerp(FProgressMotion other, double t) => FProgressMotion(
    period: t < 0.5 ? period : other.period,
    interval: t < 0.5 ? interval : other.interval,
    curve: t < 0.5 ? curve : other.curve,
    value: lerpDouble(value, other.value, t) ?? value,
  );
}

mixin _$FProgressMotionFunctions on Diagnosticable {
  Duration get period;
  Duration get interval;
  Curve get curve;
  double get value;

  /// Returns itself.
  @useResult
  FProgressMotion call(Object? _) => this as FProgressMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('period', period, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('interval', interval, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('value', value, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FProgressMotion &&
          period == other.period &&
          interval == other.interval &&
          curve == other.curve &&
          value == other.value);

  @override
  int get hashCode => period.hashCode ^ interval.hashCode ^ curve.hashCode ^ value.hashCode;
}

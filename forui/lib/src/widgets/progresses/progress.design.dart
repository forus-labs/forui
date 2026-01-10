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
  }) => .new(
    constraints: constraints ?? this.constraints,
    trackDecoration: trackDecoration ?? this.trackDecoration,
    fillDecoration: fillDecoration ?? this.fillDecoration,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FProgressStyle] using the given factor [t].
  @useResult
  FProgressStyle lerp(FProgressStyle other, double t) => .new(
    constraints: .lerp(constraints, other.constraints, t) ?? constraints,
    trackDecoration: .lerp(trackDecoration, other.trackDecoration, t) ?? trackDecoration,
    fillDecoration: .lerp(fillDecoration, other.fillDecoration, t) ?? fillDecoration,
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
      ..add(DiagnosticsProperty('constraints', constraints, level: .debug))
      ..add(DiagnosticsProperty('trackDecoration', trackDecoration, level: .debug))
      ..add(DiagnosticsProperty('fillDecoration', fillDecoration, level: .debug))
      ..add(DiagnosticsProperty('motion', motion, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FProgressStyle &&
          runtimeType == other.runtimeType &&
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
  FProgressMotion copyWith({Duration? period, Duration? interval, Curve? curve, double? value}) => .new(
    period: period ?? this.period,
    interval: interval ?? this.interval,
    curve: curve ?? this.curve,
    value: value ?? this.value,
  );

  /// Linearly interpolate between this and another [FProgressMotion] using the given factor [t].
  @useResult
  FProgressMotion lerp(FProgressMotion other, double t) => .new(
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
      ..add(DiagnosticsProperty('period', period, level: .debug))
      ..add(DiagnosticsProperty('interval', interval, level: .debug))
      ..add(DiagnosticsProperty('curve', curve, level: .debug))
      ..add(DoubleProperty('value', value, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FProgressMotion &&
          runtimeType == other.runtimeType &&
          period == other.period &&
          interval == other.interval &&
          curve == other.curve &&
          value == other.value);

  @override
  int get hashCode => period.hashCode ^ interval.hashCode ^ curve.hashCode ^ value.hashCode;
}

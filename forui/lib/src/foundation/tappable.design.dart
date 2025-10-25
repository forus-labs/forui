// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tappable.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTappableStyleTransformations on FTappableStyle {
  /// Returns a copy of this [FTappableStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FTappableStyle.cursor] - The mouse cursor for mouse pointers that are hovering over the region.
  /// * [FTappableStyle.pressedEnterDuration] - The duration to wait before applying the pressed effect after the user presses the tile.
  /// * [FTappableStyle.pressedExitDuration] - The duration to wait before removing the pressed effect after the user stops pressing the tile.
  /// * [FTappableStyle.motion] - Motion-related properties for the tappable.
  @useResult
  FTappableStyle copyWith({
    FWidgetStateMap<MouseCursor>? cursor,
    Duration? pressedEnterDuration,
    Duration? pressedExitDuration,
    FTappableMotion Function(FTappableMotion motion)? motion,
  }) => FTappableStyle(
    cursor: cursor ?? this.cursor,
    pressedEnterDuration: pressedEnterDuration ?? this.pressedEnterDuration,
    pressedExitDuration: pressedExitDuration ?? this.pressedExitDuration,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FTappableStyle] using the given factor [t].
  @useResult
  FTappableStyle lerp(FTappableStyle other, double t) => FTappableStyle(
    cursor: t < 0.5 ? cursor : other.cursor,
    pressedEnterDuration: t < 0.5 ? pressedEnterDuration : other.pressedEnterDuration,
    pressedExitDuration: t < 0.5 ? pressedExitDuration : other.pressedExitDuration,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FTappableStyleFunctions on Diagnosticable {
  FWidgetStateMap<MouseCursor> get cursor;
  Duration get pressedEnterDuration;
  Duration get pressedExitDuration;
  FTappableMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FTappableStyle] to replace functions that accept and return a [FTappableStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTappableStyle Function(FTappableStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTappableStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTappableStyle(...));
  /// ```
  @useResult
  FTappableStyle call(Object? _) => this as FTappableStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('cursor', cursor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('pressedEnterDuration', pressedEnterDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('pressedExitDuration', pressedExitDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTappableStyle &&
          cursor == other.cursor &&
          pressedEnterDuration == other.pressedEnterDuration &&
          pressedExitDuration == other.pressedExitDuration &&
          motion == other.motion);

  @override
  int get hashCode => cursor.hashCode ^ pressedEnterDuration.hashCode ^ pressedExitDuration.hashCode ^ motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FTappableMotionTransformations on FTappableMotion {
  /// Returns a copy of this [FTappableMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FTappableMotion.bounceDownDuration] - The bounce animation's duration when the tappable is pressed down.
  /// * [FTappableMotion.bounceUpDuration] - The bounce animation's duration when the tappable is released (up).
  /// * [FTappableMotion.bounceDownCurve] - The curve used to animate the scale of the tappable when pressed (down).
  /// * [FTappableMotion.bounceUpCurve] - The curve used to animate the scale of the tappable when released (up).
  /// * [FTappableMotion.bounceTween] - The bounce's tween.
  @useResult
  FTappableMotion copyWith({
    Duration? bounceDownDuration,
    Duration? bounceUpDuration,
    Curve? bounceDownCurve,
    Curve? bounceUpCurve,
    Animatable<double>? bounceTween,
  }) => FTappableMotion(
    bounceDownDuration: bounceDownDuration ?? this.bounceDownDuration,
    bounceUpDuration: bounceUpDuration ?? this.bounceUpDuration,
    bounceDownCurve: bounceDownCurve ?? this.bounceDownCurve,
    bounceUpCurve: bounceUpCurve ?? this.bounceUpCurve,
    bounceTween: bounceTween ?? this.bounceTween,
  );

  /// Linearly interpolate between this and another [FTappableMotion] using the given factor [t].
  @useResult
  FTappableMotion lerp(FTappableMotion other, double t) => FTappableMotion(
    bounceDownDuration: t < 0.5 ? bounceDownDuration : other.bounceDownDuration,
    bounceUpDuration: t < 0.5 ? bounceUpDuration : other.bounceUpDuration,
    bounceDownCurve: t < 0.5 ? bounceDownCurve : other.bounceDownCurve,
    bounceUpCurve: t < 0.5 ? bounceUpCurve : other.bounceUpCurve,
    bounceTween: t < 0.5 ? bounceTween : other.bounceTween,
  );
}

mixin _$FTappableMotionFunctions on Diagnosticable {
  Duration get bounceDownDuration;
  Duration get bounceUpDuration;
  Curve get bounceDownCurve;
  Curve get bounceUpCurve;
  Animatable<double> get bounceTween;

  /// Returns itself.
  @useResult
  FTappableMotion call(Object? _) => this as FTappableMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('bounceDownDuration', bounceDownDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bounceUpDuration', bounceUpDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bounceDownCurve', bounceDownCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bounceUpCurve', bounceUpCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('bounceTween', bounceTween, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTappableMotion &&
          bounceDownDuration == other.bounceDownDuration &&
          bounceUpDuration == other.bounceUpDuration &&
          bounceDownCurve == other.bounceDownCurve &&
          bounceUpCurve == other.bounceUpCurve &&
          bounceTween == other.bounceTween);

  @override
  int get hashCode =>
      bounceDownDuration.hashCode ^
      bounceUpDuration.hashCode ^
      bounceDownCurve.hashCode ^
      bounceUpCurve.hashCode ^
      bounceTween.hashCode;
}

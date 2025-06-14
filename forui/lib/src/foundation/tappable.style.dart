// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tappable.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FTappableStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<MouseCursor> get cursor;
  Duration get pressedEnterDuration;
  Duration get pressedExitDuration;
  Duration get bounceDownDuration;
  Duration get bounceUpDuration;
  Curve get bounceDownCurve;
  Curve get bounceUpCurve;
  Tween<double> get bounceTween;

  /// Returns a copy of this [FTappableStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FTappableStyle copyWith({
    FWidgetStateMap<MouseCursor>? cursor,
    Duration? pressedEnterDuration,
    Duration? pressedExitDuration,
    Duration? bounceDownDuration,
    Duration? bounceUpDuration,
    Curve? bounceDownCurve,
    Curve? bounceUpCurve,
    Tween<double>? bounceTween,
  }) => FTappableStyle(
    cursor: cursor ?? this.cursor,
    pressedEnterDuration: pressedEnterDuration ?? this.pressedEnterDuration,
    pressedExitDuration: pressedExitDuration ?? this.pressedExitDuration,
    bounceDownDuration: bounceDownDuration ?? this.bounceDownDuration,
    bounceUpDuration: bounceUpDuration ?? this.bounceUpDuration,
    bounceDownCurve: bounceDownCurve ?? this.bounceDownCurve,
    bounceUpCurve: bounceUpCurve ?? this.bounceUpCurve,
    bounceTween: bounceTween ?? this.bounceTween,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('cursor', cursor))
      ..add(DiagnosticsProperty('pressedEnterDuration', pressedEnterDuration))
      ..add(DiagnosticsProperty('pressedExitDuration', pressedExitDuration))
      ..add(DiagnosticsProperty('bounceDownDuration', bounceDownDuration))
      ..add(DiagnosticsProperty('bounceUpDuration', bounceUpDuration))
      ..add(DiagnosticsProperty('bounceDownCurve', bounceDownCurve))
      ..add(DiagnosticsProperty('bounceUpCurve', bounceUpCurve))
      ..add(DiagnosticsProperty('bounceTween', bounceTween));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTappableStyle &&
          cursor == other.cursor &&
          pressedEnterDuration == other.pressedEnterDuration &&
          pressedExitDuration == other.pressedExitDuration &&
          bounceDownDuration == other.bounceDownDuration &&
          bounceUpDuration == other.bounceUpDuration &&
          bounceDownCurve == other.bounceDownCurve &&
          bounceUpCurve == other.bounceUpCurve &&
          bounceTween == other.bounceTween);
  @override
  int get hashCode =>
      cursor.hashCode ^
      pressedEnterDuration.hashCode ^
      pressedExitDuration.hashCode ^
      bounceDownDuration.hashCode ^
      bounceUpDuration.hashCode ^
      bounceDownCurve.hashCode ^
      bounceUpCurve.hashCode ^
      bounceTween.hashCode;
}

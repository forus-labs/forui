// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tappable.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FTappableStyleCopyWith on FTappableStyle {
  /// Returns a copy of this [FTappableStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [cursor]
  /// The mouse cursor for mouse pointers that are hovering over the region. Defaults to [MouseCursor.defer].
  ///
  /// # [pressedEnterDuration]
  /// The duration to wait before applying the pressed effect after the user presses the tile. Defaults to 200ms.
  ///
  /// # [pressedExitDuration]
  /// The duration to wait before removing the pressed effect after the user stops pressing the tile. Defaults to 0s.
  ///
  /// # [bounceDownDuration]
  /// The bounce's animation duration when the tappable is pressed down. Defaults to 100ms.
  ///
  /// # [bounceUpDuration]
  /// The bounce's animation duration when the tappable is released (up). Defaults to 120ms.
  ///
  /// # [bounceDownCurve]
  /// The curve used to animate the scale of the tappable when pressed (down). Defaults to [Curves.easeOutQuart].
  ///
  /// # [bounceUpCurve]
  /// The curve used to animate the scale of the tappable when released (up). Defaults to [Curves.easeOutCubic].
  ///
  /// # [bounceTween]
  /// The tween used to animate the scale of the tappable. Defaults to [defaultBounceTween].
  ///
  /// Set to [noBounceTween] to disable the bounce effect.
  ///
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
}

mixin _$FTappableStyleFunctions on Diagnosticable {
  FWidgetStateMap<MouseCursor> get cursor;
  Duration get pressedEnterDuration;
  Duration get pressedExitDuration;
  Duration get bounceDownDuration;
  Duration get bounceUpDuration;
  Curve get bounceDownCurve;
  Curve get bounceUpCurve;
  Tween<double> get bounceTween;

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

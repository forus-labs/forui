// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scroll_handle.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectScrollHandleStyleTransformations on FSelectScrollHandleStyle {
  /// Returns a copy of this [FSelectScrollHandleStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectScrollHandleStyle.iconStyle] - The handle icon's style.
  /// * [FSelectScrollHandleStyle.background] - The background color.
  /// * [FSelectScrollHandleStyle.enterDuration] - The duration to wait before scrolling.
  /// * [FSelectScrollHandleStyle.pixelsPerSecond] - The number of pixels to scroll per second.
  @useResult
  FSelectScrollHandleStyle copyWith({
    IconThemeData? iconStyle,
    Color? background,
    Duration? enterDuration,
    double? pixelsPerSecond,
  }) => FSelectScrollHandleStyle(
    iconStyle: iconStyle ?? this.iconStyle,
    background: background ?? this.background,
    enterDuration: enterDuration ?? this.enterDuration,
    pixelsPerSecond: pixelsPerSecond ?? this.pixelsPerSecond,
  );

  /// Linearly interpolate between this and another [FSelectScrollHandleStyle] using the given factor [t].
  @useResult
  FSelectScrollHandleStyle lerp(FSelectScrollHandleStyle other, double t) => FSelectScrollHandleStyle(
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    background: Color.lerp(background, other.background, t) ?? background,
    enterDuration: t < 0.5 ? enterDuration : other.enterDuration,
    pixelsPerSecond: lerpDouble(pixelsPerSecond, other.pixelsPerSecond, t) ?? pixelsPerSecond,
  );
}

mixin _$FSelectScrollHandleStyleFunctions on Diagnosticable {
  IconThemeData get iconStyle;
  Color get background;
  Duration get enterDuration;
  double get pixelsPerSecond;

  /// Returns itself.
  ///
  /// Allows [FSelectScrollHandleStyle] to replace functions that accept and return a [FSelectScrollHandleStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectScrollHandleStyle Function(FSelectScrollHandleStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectScrollHandleStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectScrollHandleStyle(...));
  /// ```
  @useResult
  FSelectScrollHandleStyle call(Object? _) => this as FSelectScrollHandleStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(ColorProperty('background', background, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('enterDuration', enterDuration, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('pixelsPerSecond', pixelsPerSecond, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectScrollHandleStyle &&
          iconStyle == other.iconStyle &&
          background == other.background &&
          enterDuration == other.enterDuration &&
          pixelsPerSecond == other.pixelsPerSecond);

  @override
  int get hashCode => iconStyle.hashCode ^ background.hashCode ^ enterDuration.hashCode ^ pixelsPerSecond.hashCode;
}

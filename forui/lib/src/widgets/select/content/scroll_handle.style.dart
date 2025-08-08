// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scroll_handle.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSelectScrollHandleStyleCopyWith on FSelectScrollHandleStyle {
  /// Returns a copy of this [FSelectScrollHandleStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [iconStyle]
  /// The handle icon's style.
  ///
  /// # [background]
  /// The background color.
  ///
  /// # [enterDuration]
  /// The duration to wait before scrolling. Defaults to 200ms.
  ///
  /// # [pixelsPerSecond]
  /// The number of pixels to scroll per second. Defaults to 200.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the pixels per second <= 0.
  ///
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
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(ColorProperty('background', background))
      ..add(DiagnosticsProperty('enterDuration', enterDuration))
      ..add(DoubleProperty('pixelsPerSecond', pixelsPerSecond));
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

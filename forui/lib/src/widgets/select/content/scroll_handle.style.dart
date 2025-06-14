// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'scroll_handle.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSelectScrollHandleStyleFunctions on Diagnosticable implements FTransformable {
  IconThemeData get iconStyle;
  Color get background;
  Duration get enterDuration;
  double get pixelsPerSecond;

  /// Returns a copy of this [FSelectScrollHandleStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
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

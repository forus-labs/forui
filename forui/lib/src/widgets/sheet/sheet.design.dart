// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sheet.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSheetStyleTransformations on FSheetStyle {
  /// Returns a copy of this [FSheetStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSheetStyle.barrierFilter] - {@macro forui.
  /// * [FSheetStyle.enterDuration] - The entrance duration.
  /// * [FSheetStyle.exitDuration] - The exit duration.
  /// * [FSheetStyle.flingVelocity] - The minimum velocity to initiate a fling.
  /// * [FSheetStyle.closeProgressThreshold] - The threshold for determining whether the sheet is closing.
  @useResult
  FSheetStyle copyWith({
    ImageFilter Function(double)? barrierFilter,
    Duration? enterDuration,
    Duration? exitDuration,
    double? flingVelocity,
    double? closeProgressThreshold,
  }) => FSheetStyle(
    barrierFilter: barrierFilter ?? this.barrierFilter,
    enterDuration: enterDuration ?? this.enterDuration,
    exitDuration: exitDuration ?? this.exitDuration,
    flingVelocity: flingVelocity ?? this.flingVelocity,
    closeProgressThreshold: closeProgressThreshold ?? this.closeProgressThreshold,
  );

  /// Linearly interpolate between this and another [FSheetStyle] using the given factor [t].
  @useResult
  FSheetStyle lerp(FSheetStyle other, double t) => FSheetStyle(
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    enterDuration: t < 0.5 ? enterDuration : other.enterDuration,
    exitDuration: t < 0.5 ? exitDuration : other.exitDuration,
    flingVelocity: lerpDouble(flingVelocity, other.flingVelocity, t) ?? flingVelocity,
    closeProgressThreshold:
        lerpDouble(closeProgressThreshold, other.closeProgressThreshold, t) ?? closeProgressThreshold,
  );
}

mixin _$FSheetStyleFunctions on Diagnosticable {
  ImageFilter Function(double)? get barrierFilter;
  Duration get enterDuration;
  Duration get exitDuration;
  double get flingVelocity;
  double get closeProgressThreshold;

  /// Returns itself.
  ///
  /// Allows [FSheetStyle] to replace functions that accept and return a [FSheetStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSheetStyle Function(FSheetStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSheetStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSheetStyle(...));
  /// ```
  @useResult
  FSheetStyle call(Object? _) => this as FSheetStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('enterDuration', enterDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('exitDuration', exitDuration, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('flingVelocity', flingVelocity, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('closeProgressThreshold', closeProgressThreshold, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSheetStyle &&
          barrierFilter == other.barrierFilter &&
          enterDuration == other.enterDuration &&
          exitDuration == other.exitDuration &&
          flingVelocity == other.flingVelocity &&
          closeProgressThreshold == other.closeProgressThreshold);

  @override
  int get hashCode =>
      barrierFilter.hashCode ^
      enterDuration.hashCode ^
      exitDuration.hashCode ^
      flingVelocity.hashCode ^
      closeProgressThreshold.hashCode;
}

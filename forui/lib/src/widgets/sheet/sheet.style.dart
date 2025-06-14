// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sheet.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FSheetStyleFunctions on Diagnosticable implements FTransformable {
  ImageFilter Function(double)? get barrierFilter;
  Duration get enterDuration;
  Duration get exitDuration;
  double get flingVelocity;
  double get closeProgressThreshold;

  /// Returns a copy of this [FSheetStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
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
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter))
      ..add(DiagnosticsProperty('enterDuration', enterDuration))
      ..add(DiagnosticsProperty('exitDuration', exitDuration))
      ..add(DoubleProperty('flingVelocity', flingVelocity))
      ..add(DoubleProperty('closeProgressThreshold', closeProgressThreshold));
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

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sheet.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSheetStyleCopyWith on FSheetStyle {
  /// Returns a copy of this [FSheetStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [barrierFilter]
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  ///
  /// # [enterDuration]
  /// The entrance duration. Defaults to 200ms.
  ///
  /// # [exitDuration]
  /// The exit duration. Defaults to 200ms.
  ///
  /// # [flingVelocity]
  /// The minimum velocity to initiate a fling. Defaults to 700.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the value is not positive.
  ///
  /// # [closeProgressThreshold]
  /// The threshold for determining whether the sheet is closing. Defaults to 0.5.
  ///
  /// ## Contract
  /// Throws an [AssertionError] if the value is not in the range `[0, 1]`.
  ///
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

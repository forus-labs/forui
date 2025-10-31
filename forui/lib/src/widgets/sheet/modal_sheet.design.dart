// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'modal_sheet.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FModalSheetStyleTransformations on FModalSheetStyle {
  /// Returns a copy of this [FModalSheetStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FModalSheetStyle.barrierFilter] -
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  /// * [FModalSheetStyle.motion] - The motion-related properties for a modal sheet.
  /// * [FModalSheetStyle.flingVelocity] - The minimum velocity to initiate a fling.
  /// * [FModalSheetStyle.closeProgressThreshold] - The threshold for determining whether the sheet is closing.
  @useResult
  FModalSheetStyle copyWith({
    ImageFilter Function(double)? barrierFilter,
    FModalSheetMotion Function(FModalSheetMotion motion)? motion,
    double? flingVelocity,
    double? closeProgressThreshold,
  }) => FModalSheetStyle(
    barrierFilter: barrierFilter ?? this.barrierFilter,
    motion: motion != null ? motion(this.motion) : this.motion,
    flingVelocity: flingVelocity ?? this.flingVelocity,
    closeProgressThreshold: closeProgressThreshold ?? this.closeProgressThreshold,
  );

  /// Linearly interpolate between this and another [FModalSheetStyle] using the given factor [t].
  @useResult
  FModalSheetStyle lerp(FModalSheetStyle other, double t) => FModalSheetStyle(
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    motion: motion.lerp(other.motion, t),
    flingVelocity: lerpDouble(flingVelocity, other.flingVelocity, t) ?? flingVelocity,
    closeProgressThreshold:
        lerpDouble(closeProgressThreshold, other.closeProgressThreshold, t) ?? closeProgressThreshold,
  );
}

mixin _$FModalSheetStyleFunctions on Diagnosticable {
  ImageFilter Function(double)? get barrierFilter;
  FModalSheetMotion get motion;
  double get flingVelocity;
  double get closeProgressThreshold;

  /// Returns itself.
  ///
  /// Allows [FModalSheetStyle] to replace functions that accept and return a [FModalSheetStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FModalSheetStyle Function(FModalSheetStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FModalSheetStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FModalSheetStyle(...));
  /// ```
  @useResult
  FModalSheetStyle call(Object? _) => this as FModalSheetStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('flingVelocity', flingVelocity, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('closeProgressThreshold', closeProgressThreshold, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FModalSheetStyle &&
          barrierFilter == other.barrierFilter &&
          motion == other.motion &&
          flingVelocity == other.flingVelocity &&
          closeProgressThreshold == other.closeProgressThreshold);

  @override
  int get hashCode =>
      barrierFilter.hashCode ^ motion.hashCode ^ flingVelocity.hashCode ^ closeProgressThreshold.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FModalSheetMotionTransformations on FModalSheetMotion {
  /// Returns a copy of this [FModalSheetMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FModalSheetMotion.barrierCurve] - The barrier's curve.
  /// * [FModalSheetMotion.expandDuration] - The duration of the sheet's expansion animation.
  /// * [FModalSheetMotion.collapseDuration] - The duration of the sheet's collapsing animation.
  /// * [FModalSheetMotion.curve] - The curve of the sheet's expansion and collapse.
  @useResult
  FModalSheetMotion copyWith({
    Curve? barrierCurve,
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? curve,
  }) => FModalSheetMotion(
    barrierCurve: barrierCurve ?? this.barrierCurve,
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    curve: curve ?? this.curve,
  );

  /// Linearly interpolate between this and another [FModalSheetMotion] using the given factor [t].
  @useResult
  FModalSheetMotion lerp(FModalSheetMotion other, double t) => FModalSheetMotion(
    barrierCurve: t < 0.5 ? barrierCurve : other.barrierCurve,
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    curve: t < 0.5 ? curve : other.curve,
  );
}

mixin _$FModalSheetMotionFunctions on Diagnosticable {
  Curve get barrierCurve;
  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FModalSheetMotion call(Object? _) => this as FModalSheetMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierCurve', barrierCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FModalSheetMotion &&
          barrierCurve == other.barrierCurve &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          curve == other.curve);

  @override
  int get hashCode => barrierCurve.hashCode ^ expandDuration.hashCode ^ collapseDuration.hashCode ^ curve.hashCode;
}

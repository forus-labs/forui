// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'persistent_sheet.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPersistentSheetStyleTransformations on FPersistentSheetStyle {
  /// Returns a copy of this [FPersistentSheetStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FPersistentSheetStyle.motion] - The motion-related properties for a persistent sheet.
  /// * [FPersistentSheetStyle.flingVelocity] - The minimum velocity to initiate a fling.
  /// * [FPersistentSheetStyle.closeProgressThreshold] - The threshold for determining whether the sheet is closing.
  @useResult
  FPersistentSheetStyle copyWith({
    FPersistentSheetMotion Function(FPersistentSheetMotion motion)? motion,
    double? flingVelocity,
    double? closeProgressThreshold,
  }) => FPersistentSheetStyle(
    motion: motion != null ? motion(this.motion) : this.motion,
    flingVelocity: flingVelocity ?? this.flingVelocity,
    closeProgressThreshold: closeProgressThreshold ?? this.closeProgressThreshold,
  );

  /// Linearly interpolate between this and another [FPersistentSheetStyle] using the given factor [t].
  @useResult
  FPersistentSheetStyle lerp(FPersistentSheetStyle other, double t) => FPersistentSheetStyle(
    motion: motion.lerp(other.motion, t),
    flingVelocity: lerpDouble(flingVelocity, other.flingVelocity, t) ?? flingVelocity,
    closeProgressThreshold:
        lerpDouble(closeProgressThreshold, other.closeProgressThreshold, t) ?? closeProgressThreshold,
  );
}

mixin _$FPersistentSheetStyleFunctions on Diagnosticable {
  FPersistentSheetMotion get motion;
  double get flingVelocity;
  double get closeProgressThreshold;

  /// Returns itself.
  ///
  /// Allows [FPersistentSheetStyle] to replace functions that accept and return a [FPersistentSheetStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FPersistentSheetStyle Function(FPersistentSheetStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FPersistentSheetStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FPersistentSheetStyle(...));
  /// ```
  @useResult
  FPersistentSheetStyle call(Object? _) => this as FPersistentSheetStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('flingVelocity', flingVelocity, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('closeProgressThreshold', closeProgressThreshold, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPersistentSheetStyle &&
          motion == other.motion &&
          flingVelocity == other.flingVelocity &&
          closeProgressThreshold == other.closeProgressThreshold);

  @override
  int get hashCode => motion.hashCode ^ flingVelocity.hashCode ^ closeProgressThreshold.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FPersistentSheetMotionTransformations on FPersistentSheetMotion {
  /// Returns a copy of this [FPersistentSheetMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FPersistentSheetMotion.expandDuration] - The duration of the sheet's expansion animation.
  /// * [FPersistentSheetMotion.collapseDuration] - The duration of the sheet's collapsing animation.
  /// * [FPersistentSheetMotion.curve] - The curve of the sheet's expansion and collapse.
  @useResult
  FPersistentSheetMotion copyWith({Duration? expandDuration, Duration? collapseDuration, Curve? curve}) =>
      FPersistentSheetMotion(
        expandDuration: expandDuration ?? this.expandDuration,
        collapseDuration: collapseDuration ?? this.collapseDuration,
        curve: curve ?? this.curve,
      );

  /// Linearly interpolate between this and another [FPersistentSheetMotion] using the given factor [t].
  @useResult
  FPersistentSheetMotion lerp(FPersistentSheetMotion other, double t) => FPersistentSheetMotion(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    curve: t < 0.5 ? curve : other.curve,
  );
}

mixin _$FPersistentSheetMotionFunctions on Diagnosticable {
  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get curve;

  /// Returns itself.
  @useResult
  FPersistentSheetMotion call(Object? _) => this as FPersistentSheetMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('curve', curve, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPersistentSheetMotion &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          curve == other.curve);

  @override
  int get hashCode => expandDuration.hashCode ^ collapseDuration.hashCode ^ curve.hashCode;
}

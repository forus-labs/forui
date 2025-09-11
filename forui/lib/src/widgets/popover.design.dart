// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'popover.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FPopoverMotionTransformations on FPopoverMotion {
  /// Returns a copy of this [FPopoverMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FPopoverMotion.entranceDuration] - The popover's entrance duration.
  /// * [FPopoverMotion.exitDuration] - The popover's exit duration.
  /// * [FPopoverMotion.expandCurve] - The curve used for the popover's expansion animation when entering.
  /// * [FPopoverMotion.collapseCurve] - The curve used for the popover's collapse animation when exiting.
  /// * [FPopoverMotion.fadeInCurve] - The curve used for the popover's fade-in animation when entering.
  /// * [FPopoverMotion.fadeOutCurve] - The curve used for the popover's fade-out animation when exiting.
  /// * [FPopoverMotion.scaleTween] - The popover's scale tween.
  /// * [FPopoverMotion.fadeTween] - The popover's fade tween.
  @useResult
  FPopoverMotion copyWith({
    Duration? entranceDuration,
    Duration? exitDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
  }) => FPopoverMotion(
    entranceDuration: entranceDuration ?? this.entranceDuration,
    exitDuration: exitDuration ?? this.exitDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
    scaleTween: scaleTween ?? this.scaleTween,
    fadeTween: fadeTween ?? this.fadeTween,
  );

  /// Linearly interpolate between this and another [FPopoverMotion] using the given factor [t].
  @useResult
  FPopoverMotion lerp(FPopoverMotion other, double t) => FPopoverMotion(
    entranceDuration: t < 0.5 ? entranceDuration : other.entranceDuration,
    exitDuration: t < 0.5 ? exitDuration : other.exitDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    fadeInCurve: t < 0.5 ? fadeInCurve : other.fadeInCurve,
    fadeOutCurve: t < 0.5 ? fadeOutCurve : other.fadeOutCurve,
    scaleTween: t < 0.5 ? scaleTween : other.scaleTween,
    fadeTween: t < 0.5 ? fadeTween : other.fadeTween,
  );
}

mixin _$FPopoverMotionFunctions on Diagnosticable {
  Duration get entranceDuration;
  Duration get exitDuration;
  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get fadeInCurve;
  Curve get fadeOutCurve;
  Animatable<double> get scaleTween;
  Animatable<double> get fadeTween;

  /// Returns itself.
  @useResult
  FPopoverMotion call(Object? _) => this as FPopoverMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('entranceDuration', entranceDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('exitDuration', exitDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeInCurve', fadeInCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeOutCurve', fadeOutCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scaleTween', scaleTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeTween', fadeTween, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverMotion &&
          entranceDuration == other.entranceDuration &&
          exitDuration == other.exitDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          fadeInCurve == other.fadeInCurve &&
          fadeOutCurve == other.fadeOutCurve &&
          scaleTween == other.scaleTween &&
          fadeTween == other.fadeTween);

  @override
  int get hashCode =>
      entranceDuration.hashCode ^
      exitDuration.hashCode ^
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      fadeInCurve.hashCode ^
      fadeOutCurve.hashCode ^
      scaleTween.hashCode ^
      fadeTween.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FPopoverStyleTransformations on FPopoverStyle {
  /// Returns a copy of this [FPopoverStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FPopoverStyle.decoration] - The popover's decoration.
  /// * [FPopoverStyle.barrierFilter] - {@template forui.
  /// * [FPopoverStyle.backgroundFilter] - {@template forui.
  /// * [FPopoverStyle.viewInsets] - The additional insets of the view.
  @useResult
  FPopoverStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    EdgeInsetsGeometry? viewInsets,
  }) => FPopoverStyle(
    decoration: decoration ?? this.decoration,
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    viewInsets: viewInsets ?? this.viewInsets,
  );

  /// Linearly interpolate between this and another [FPopoverStyle] using the given factor [t].
  @useResult
  FPopoverStyle lerp(FPopoverStyle other, double t) => FPopoverStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    viewInsets: EdgeInsetsGeometry.lerp(viewInsets, other.viewInsets, t) ?? viewInsets,
  );
}

mixin _$FPopoverStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  EdgeInsetsGeometry get viewInsets;

  /// Returns itself.
  ///
  /// Allows [FPopoverStyle] to replace functions that accept and return a [FPopoverStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FPopoverStyle Function(FPopoverStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FPopoverStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FPopoverStyle(...));
  /// ```
  @useResult
  FPopoverStyle call(Object? _) => this as FPopoverStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('viewInsets', viewInsets, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FPopoverStyle &&
          decoration == other.decoration &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          viewInsets == other.viewInsets);

  @override
  int get hashCode => decoration.hashCode ^ barrierFilter.hashCode ^ backgroundFilter.hashCode ^ viewInsets.hashCode;
}

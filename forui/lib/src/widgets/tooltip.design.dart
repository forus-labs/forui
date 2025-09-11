// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'tooltip.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTooltipMotionTransformations on FTooltipMotion {
  /// Returns a copy of this [FTooltipMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FTooltipMotion.entranceDuration] - The tooltip's entrance duration.
  /// * [FTooltipMotion.exitDuration] - The tooltip's exit duration.
  /// * [FTooltipMotion.expandCurve] - The curve used for the tooltip's expansion animation when entering.
  /// * [FTooltipMotion.collapseCurve] - The curve used for the tooltip's collapse animation when exiting.
  /// * [FTooltipMotion.fadeInCurve] - The curve used for the tooltip's fade-in animation when entering.
  /// * [FTooltipMotion.fadeOutCurve] - The curve used for the tooltip's fade-out animation when exiting.
  /// * [FTooltipMotion.scaleTween] - The tooltip's scale tween.
  /// * [FTooltipMotion.fadeTween] - The tooltip's fade tween.
  @useResult
  FTooltipMotion copyWith({
    Duration? entranceDuration,
    Duration? exitDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
  }) => FTooltipMotion(
    entranceDuration: entranceDuration ?? this.entranceDuration,
    exitDuration: exitDuration ?? this.exitDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
    scaleTween: scaleTween ?? this.scaleTween,
    fadeTween: fadeTween ?? this.fadeTween,
  );

  /// Linearly interpolate between this and another [FTooltipMotion] using the given factor [t].
  @useResult
  FTooltipMotion lerp(FTooltipMotion other, double t) => FTooltipMotion(
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

mixin _$FTooltipMotionFunctions on Diagnosticable {
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
  FTooltipMotion call(Object? _) => this as FTooltipMotion;

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
      (other is FTooltipMotion &&
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
extension $FTooltipStyleTransformations on FTooltipStyle {
  /// Returns a copy of this [FTooltipStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FTooltipStyle.decoration] - The box decoration.
  /// * [FTooltipStyle.backgroundFilter] - An optional background filter applied to the tooltip.
  /// * [FTooltipStyle.padding] - The padding surrounding the tooltip's text.
  /// * [FTooltipStyle.textStyle] - The tooltip's default text style.
  @useResult
  FTooltipStyle copyWith({
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsets? padding,
    TextStyle? textStyle,
  }) => FTooltipStyle(
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    textStyle: textStyle ?? this.textStyle,
  );

  /// Linearly interpolate between this and another [FTooltipStyle] using the given factor [t].
  @useResult
  FTooltipStyle lerp(FTooltipStyle other, double t) => FTooltipStyle(
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
    textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
  );
}

mixin _$FTooltipStyleFunctions on Diagnosticable {
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsets get padding;
  TextStyle get textStyle;

  /// Returns itself.
  ///
  /// Allows [FTooltipStyle] to replace functions that accept and return a [FTooltipStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTooltipStyle Function(FTooltipStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTooltipStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTooltipStyle(...));
  /// ```
  @useResult
  FTooltipStyle call(Object? _) => this as FTooltipStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTooltipStyle &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          textStyle == other.textStyle);

  @override
  int get hashCode => decoration.hashCode ^ backgroundFilter.hashCode ^ padding.hashCode ^ textStyle.hashCode;
}

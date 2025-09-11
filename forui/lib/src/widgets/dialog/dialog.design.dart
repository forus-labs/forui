// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDialogStyleTransformations on FDialogStyle {
  /// Returns a copy of this [FDialogStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDialogStyle.barrierFilter] - {@macro forui.
  /// * [FDialogStyle.backgroundFilter] - {@macro forui.
  /// * [FDialogStyle.entranceExitDuration] - The dialog's entrance/exit animation duration.
  /// * [FDialogStyle.entranceCurve] - The dialog's entrance animation curve.
  /// * [FDialogStyle.exitCurve] - The dialog's entrance animation curve.
  /// * [FDialogStyle.fadeTween] - The tween used to animate the dialog's fade in and out.
  /// * [FDialogStyle.scaleTween] - The tween used to animate the dialog's scale in and out.
  /// * [FDialogStyle.decoration] - The decoration.
  /// * [FDialogStyle.insetAnimationDuration] - The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  /// * [FDialogStyle.insetAnimationCurve] - The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is
  /// placed in.
  /// * [FDialogStyle.insetPadding] - The inset padding.
  /// * [FDialogStyle.horizontalStyle] - The horizontal dialog content's style.
  /// * [FDialogStyle.verticalStyle] - The vertical dialog content's style.
  @useResult
  FDialogStyle copyWith({
    ImageFilter Function(double)? barrierFilter,
    ImageFilter Function(double)? backgroundFilter,
    Duration? entranceExitDuration,
    Curve? entranceCurve,
    Curve? exitCurve,
    Tween<double>? fadeTween,
    Tween<double>? scaleTween,
    BoxDecoration? decoration,
    Duration? insetAnimationDuration,
    Curve? insetAnimationCurve,
    EdgeInsetsGeometry? insetPadding,
    FDialogContentStyle Function(FDialogContentStyle style)? horizontalStyle,
    FDialogContentStyle Function(FDialogContentStyle style)? verticalStyle,
  }) => FDialogStyle(
    barrierFilter: barrierFilter ?? this.barrierFilter,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    entranceExitDuration: entranceExitDuration ?? this.entranceExitDuration,
    entranceCurve: entranceCurve ?? this.entranceCurve,
    exitCurve: exitCurve ?? this.exitCurve,
    fadeTween: fadeTween ?? this.fadeTween,
    scaleTween: scaleTween ?? this.scaleTween,
    decoration: decoration ?? this.decoration,
    insetAnimationDuration: insetAnimationDuration ?? this.insetAnimationDuration,
    insetAnimationCurve: insetAnimationCurve ?? this.insetAnimationCurve,
    insetPadding: insetPadding ?? this.insetPadding,
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
  );

  /// Linearly interpolate between this and another [FDialogStyle] using the given factor [t].
  @useResult
  FDialogStyle lerp(FDialogStyle other, double t) => FDialogStyle(
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    entranceExitDuration: t < 0.5 ? entranceExitDuration : other.entranceExitDuration,
    entranceCurve: t < 0.5 ? entranceCurve : other.entranceCurve,
    exitCurve: t < 0.5 ? exitCurve : other.exitCurve,
    fadeTween: t < 0.5 ? fadeTween : other.fadeTween,
    scaleTween: t < 0.5 ? scaleTween : other.scaleTween,
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    insetAnimationDuration: t < 0.5 ? insetAnimationDuration : other.insetAnimationDuration,
    insetAnimationCurve: t < 0.5 ? insetAnimationCurve : other.insetAnimationCurve,
    insetPadding: EdgeInsetsGeometry.lerp(insetPadding, other.insetPadding, t) ?? insetPadding,
    horizontalStyle: horizontalStyle.lerp(other.horizontalStyle, t),
    verticalStyle: verticalStyle.lerp(other.verticalStyle, t),
  );
}

mixin _$FDialogStyleFunctions on Diagnosticable {
  ImageFilter Function(double)? get barrierFilter;
  ImageFilter Function(double)? get backgroundFilter;
  Duration get entranceExitDuration;
  Curve get entranceCurve;
  Curve get exitCurve;
  Tween<double> get fadeTween;
  Tween<double> get scaleTween;
  BoxDecoration get decoration;
  Duration get insetAnimationDuration;
  Curve get insetAnimationCurve;
  EdgeInsetsGeometry get insetPadding;
  FDialogContentStyle get horizontalStyle;
  FDialogContentStyle get verticalStyle;

  /// Returns itself.
  ///
  /// Allows [FDialogStyle] to replace functions that accept and return a [FDialogStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDialogStyle Function(FDialogStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDialogStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDialogStyle(...));
  /// ```
  @useResult
  FDialogStyle call(Object? _) => this as FDialogStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('entranceExitDuration', entranceExitDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('entranceCurve', entranceCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('exitCurve', exitCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeTween', fadeTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scaleTween', scaleTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('insetAnimationDuration', insetAnimationDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('insetAnimationCurve', insetAnimationCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('insetPadding', insetPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogStyle &&
          barrierFilter == other.barrierFilter &&
          backgroundFilter == other.backgroundFilter &&
          entranceExitDuration == other.entranceExitDuration &&
          entranceCurve == other.entranceCurve &&
          exitCurve == other.exitCurve &&
          fadeTween == other.fadeTween &&
          scaleTween == other.scaleTween &&
          decoration == other.decoration &&
          insetAnimationDuration == other.insetAnimationDuration &&
          insetAnimationCurve == other.insetAnimationCurve &&
          insetPadding == other.insetPadding &&
          horizontalStyle == other.horizontalStyle &&
          verticalStyle == other.verticalStyle);

  @override
  int get hashCode =>
      barrierFilter.hashCode ^
      backgroundFilter.hashCode ^
      entranceExitDuration.hashCode ^
      entranceCurve.hashCode ^
      exitCurve.hashCode ^
      fadeTween.hashCode ^
      scaleTween.hashCode ^
      decoration.hashCode ^
      insetAnimationDuration.hashCode ^
      insetAnimationCurve.hashCode ^
      insetPadding.hashCode ^
      horizontalStyle.hashCode ^
      verticalStyle.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FDialogStyleFunctions on Diagnosticable implements FTransformable {
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

  /// Returns a copy of this [FDialogStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
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
    FDialogContentStyle? horizontalStyle,
    FDialogContentStyle? verticalStyle,
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
    horizontalStyle: horizontalStyle ?? this.horizontalStyle,
    verticalStyle: verticalStyle ?? this.verticalStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('entranceExitDuration', entranceExitDuration))
      ..add(DiagnosticsProperty('entranceCurve', entranceCurve))
      ..add(DiagnosticsProperty('exitCurve', exitCurve))
      ..add(DiagnosticsProperty('fadeTween', fadeTween))
      ..add(DiagnosticsProperty('scaleTween', scaleTween))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('insetAnimationDuration', insetAnimationDuration))
      ..add(DiagnosticsProperty('insetAnimationCurve', insetAnimationCurve))
      ..add(DiagnosticsProperty('insetPadding', insetPadding))
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle));
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

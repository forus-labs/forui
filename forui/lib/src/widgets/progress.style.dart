// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'progress.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FProgressStylesFunctions on Diagnosticable implements FTransformable {
  FLinearProgressStyle get linearProgressStyle;
  IconThemeData get circularIconProgressStyle;

  /// Returns a copy of this [FProgressStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FProgressStyles copyWith({FLinearProgressStyle? linearProgressStyle, IconThemeData? circularIconProgressStyle}) =>
      FProgressStyles(
        linearProgressStyle: linearProgressStyle ?? this.linearProgressStyle,
        circularIconProgressStyle: circularIconProgressStyle ?? this.circularIconProgressStyle,
      );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('linearProgressStyle', linearProgressStyle))
      ..add(DiagnosticsProperty('circularIconProgressStyle', circularIconProgressStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FProgressStyles &&
          linearProgressStyle == other.linearProgressStyle &&
          circularIconProgressStyle == other.circularIconProgressStyle);
  @override
  int get hashCode => linearProgressStyle.hashCode ^ circularIconProgressStyle.hashCode;
}
mixin _$FLinearProgressStyleFunctions on Diagnosticable implements FTransformable {
  BoxConstraints get constraints;
  BoxDecoration get backgroundDecoration;
  BoxDecoration get progressDecoration;
  Curve get curve;

  /// Returns a copy of this [FLinearProgressStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FLinearProgressStyle copyWith({
    BoxConstraints? constraints,
    BoxDecoration? backgroundDecoration,
    BoxDecoration? progressDecoration,
    Curve? curve,
  }) => FLinearProgressStyle(
    constraints: constraints ?? this.constraints,
    backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
    progressDecoration: progressDecoration ?? this.progressDecoration,
    curve: curve ?? this.curve,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('backgroundDecoration', backgroundDecoration))
      ..add(DiagnosticsProperty('progressDecoration', progressDecoration))
      ..add(DiagnosticsProperty('curve', curve));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FLinearProgressStyle &&
          constraints == other.constraints &&
          backgroundDecoration == other.backgroundDecoration &&
          progressDecoration == other.progressDecoration &&
          curve == other.curve);
  @override
  int get hashCode =>
      constraints.hashCode ^ backgroundDecoration.hashCode ^ progressDecoration.hashCode ^ curve.hashCode;
}

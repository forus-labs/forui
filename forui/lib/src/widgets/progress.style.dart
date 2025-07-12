// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'progress.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FProgressStylesCopyWith on FProgressStyles {
  /// Returns a copy of this [FProgressStyles] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [linearProgressStyle]
  /// The linear progress's style.
  ///
  /// # [circularIconProgressStyle]
  /// The circular progress's style.
  ///
  @useResult
  FProgressStyles copyWith({
    FLinearProgressStyle Function(FLinearProgressStyle)? linearProgressStyle,
    IconThemeData? circularIconProgressStyle,
  }) => FProgressStyles(
    linearProgressStyle: linearProgressStyle != null
        ? linearProgressStyle(this.linearProgressStyle)
        : this.linearProgressStyle,
    circularIconProgressStyle: circularIconProgressStyle ?? this.circularIconProgressStyle,
  );
}

/// Provides a `copyWith` method.
extension $FLinearProgressStyleCopyWith on FLinearProgressStyle {
  /// Returns a copy of this [FLinearProgressStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [constraints]
  /// The linear progress's constraints. Defaults to a height of 10.0 and no horizontal constraint.
  ///
  /// # [backgroundDecoration]
  /// The progress's background's decoration.
  ///
  /// # [progressDecoration]
  /// The progress's decoration.
  ///
  /// # [curve]
  /// The animation curve. Defaults to [Curves.ease].
  ///
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
}

mixin _$FProgressStylesFunctions on Diagnosticable {
  FLinearProgressStyle get linearProgressStyle;
  IconThemeData get circularIconProgressStyle;

  /// Returns itself.
  ///
  /// Allows [FProgressStyles] to replace functions that accept and return a [FProgressStyles], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FProgressStyles Function(FProgressStyles) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FProgressStyles(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FProgressStyles(...));
  /// ```
  @useResult
  FProgressStyles call(Object? _) => this as FProgressStyles;
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
mixin _$FLinearProgressStyleFunctions on Diagnosticable {
  BoxConstraints get constraints;
  BoxDecoration get backgroundDecoration;
  BoxDecoration get progressDecoration;
  Curve get curve;

  /// Returns itself.
  ///
  /// Allows [FLinearProgressStyle] to replace functions that accept and return a [FLinearProgressStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FLinearProgressStyle Function(FLinearProgressStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FLinearProgressStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FLinearProgressStyle(...));
  /// ```
  @useResult
  FLinearProgressStyle call(Object? _) => this as FLinearProgressStyle;
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

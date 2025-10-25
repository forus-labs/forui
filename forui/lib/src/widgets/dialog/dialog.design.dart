// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'dialog.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FDialogRouteStyleTransformations on FDialogRouteStyle {
  /// Returns a copy of this [FDialogRouteStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDialogRouteStyle.barrierFilter] -
  /// {@macro forui.widgets.FPopoverStyle.barrierFilter}
  /// * [FDialogRouteStyle.motion] - Motion-related properties.
  @useResult
  FDialogRouteStyle copyWith({
    ImageFilter Function(double)? barrierFilter,
    FDialogRouteMotion Function(FDialogRouteMotion motion)? motion,
  }) => FDialogRouteStyle(
    barrierFilter: barrierFilter ?? this.barrierFilter,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FDialogRouteStyle] using the given factor [t].
  @useResult
  FDialogRouteStyle lerp(FDialogRouteStyle other, double t) => FDialogRouteStyle(
    barrierFilter: t < 0.5 ? barrierFilter : other.barrierFilter,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FDialogRouteStyleFunctions on Diagnosticable {
  ImageFilter Function(double)? get barrierFilter;
  FDialogRouteMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FDialogRouteStyle] to replace functions that accept and return a [FDialogRouteStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FDialogRouteStyle Function(FDialogRouteStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FDialogRouteStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FDialogRouteStyle(...));
  /// ```
  @useResult
  FDialogRouteStyle call(Object? _) => this as FDialogRouteStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('barrierFilter', barrierFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogRouteStyle && barrierFilter == other.barrierFilter && motion == other.motion);

  @override
  int get hashCode => barrierFilter.hashCode ^ motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDialogRouteMotionTransformations on FDialogRouteMotion {
  /// Returns a copy of this [FDialogRouteMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FDialogRouteMotion.entranceDuration] - The amount of time the entrance animation takes.
  /// * [FDialogRouteMotion.exitDuration] - The amount of time the exit animation takes.
  /// * [FDialogRouteMotion.barrierCurve] - The curve used for the barrier's entrance and exit.
  @useResult
  FDialogRouteMotion copyWith({Duration? entranceDuration, Duration? exitDuration, Curve? barrierCurve}) =>
      FDialogRouteMotion(
        entranceDuration: entranceDuration ?? this.entranceDuration,
        exitDuration: exitDuration ?? this.exitDuration,
        barrierCurve: barrierCurve ?? this.barrierCurve,
      );

  /// Linearly interpolate between this and another [FDialogRouteMotion] using the given factor [t].
  @useResult
  FDialogRouteMotion lerp(FDialogRouteMotion other, double t) => FDialogRouteMotion(
    entranceDuration: t < 0.5 ? entranceDuration : other.entranceDuration,
    exitDuration: t < 0.5 ? exitDuration : other.exitDuration,
    barrierCurve: t < 0.5 ? barrierCurve : other.barrierCurve,
  );
}

mixin _$FDialogRouteMotionFunctions on Diagnosticable {
  Duration get entranceDuration;
  Duration get exitDuration;
  Curve get barrierCurve;

  /// Returns itself.
  @useResult
  FDialogRouteMotion call(Object? _) => this as FDialogRouteMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('entranceDuration', entranceDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('exitDuration', exitDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('barrierCurve', barrierCurve, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogRouteMotion &&
          entranceDuration == other.entranceDuration &&
          exitDuration == other.exitDuration &&
          barrierCurve == other.barrierCurve);

  @override
  int get hashCode => entranceDuration.hashCode ^ exitDuration.hashCode ^ barrierCurve.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDialogStyleTransformations on FDialogStyle {
  /// Returns a copy of this [FDialogStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FDialogStyle.backgroundFilter] -
  /// {@macro forui.widgets.FPopoverStyle.backgroundFilter}
  /// * [FDialogStyle.decoration] - The decoration.
  /// * [FDialogStyle.insetPadding] - The inset padding.
  /// * [FDialogStyle.horizontalStyle] - The horizontal dialog content's style.
  /// * [FDialogStyle.verticalStyle] - The vertical dialog content's style.
  /// * [FDialogStyle.motion] - Motion-related properties.
  @useResult
  FDialogStyle copyWith({
    ImageFilter Function(double)? backgroundFilter,
    BoxDecoration? decoration,
    EdgeInsetsGeometry? insetPadding,
    FDialogContentStyle Function(FDialogContentStyle style)? horizontalStyle,
    FDialogContentStyle Function(FDialogContentStyle style)? verticalStyle,
    FDialogMotion Function(FDialogMotion motion)? motion,
  }) => FDialogStyle(
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    decoration: decoration ?? this.decoration,
    insetPadding: insetPadding ?? this.insetPadding,
    horizontalStyle: horizontalStyle != null ? horizontalStyle(this.horizontalStyle) : this.horizontalStyle,
    verticalStyle: verticalStyle != null ? verticalStyle(this.verticalStyle) : this.verticalStyle,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FDialogStyle] using the given factor [t].
  @useResult
  FDialogStyle lerp(FDialogStyle other, double t) => FDialogStyle(
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    insetPadding: EdgeInsetsGeometry.lerp(insetPadding, other.insetPadding, t) ?? insetPadding,
    horizontalStyle: horizontalStyle.lerp(other.horizontalStyle, t),
    verticalStyle: verticalStyle.lerp(other.verticalStyle, t),
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FDialogStyleFunctions on Diagnosticable {
  ImageFilter Function(double)? get backgroundFilter;
  BoxDecoration get decoration;
  EdgeInsetsGeometry get insetPadding;
  FDialogContentStyle get horizontalStyle;
  FDialogContentStyle get verticalStyle;
  FDialogMotion get motion;

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
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('insetPadding', insetPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('horizontalStyle', horizontalStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('verticalStyle', verticalStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogStyle &&
          backgroundFilter == other.backgroundFilter &&
          decoration == other.decoration &&
          insetPadding == other.insetPadding &&
          horizontalStyle == other.horizontalStyle &&
          verticalStyle == other.verticalStyle &&
          motion == other.motion);

  @override
  int get hashCode =>
      backgroundFilter.hashCode ^
      decoration.hashCode ^
      insetPadding.hashCode ^
      horizontalStyle.hashCode ^
      verticalStyle.hashCode ^
      motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FDialogMotionTransformations on FDialogMotion {
  /// Returns a copy of this [FDialogMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FDialogMotion.expandCurve] - The curve used for the dialog's expansion animation when entering.
  /// * [FDialogMotion.collapseCurve] - The curve used for the dialog's collapse animation when exiting.
  /// * [FDialogMotion.fadeInCurve] - The curve used for the dialog's fade-in animation when entering.
  /// * [FDialogMotion.fadeOutCurve] - The curve used for the dialog's fade-out animation when exiting.
  /// * [FDialogMotion.scaleTween] - The tween used to animate the dialog's scale in and out.
  /// * [FDialogMotion.fadeTween] - The tween used to animate the dialog's fade in and out.
  /// * [FDialogMotion.insetDuration] - The duration of the animation to show when the system keyboard intrudes into the space that the dialog is placed in.
  /// * [FDialogMotion.insetCurve] - The curve to use for the animation shown when the system keyboard intrudes into the space that the dialog is
  /// placed in.
  @useResult
  FDialogMotion copyWith({
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Animatable<double>? scaleTween,
    Animatable<double>? fadeTween,
    Duration? insetDuration,
    Curve? insetCurve,
  }) => FDialogMotion(
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
    scaleTween: scaleTween ?? this.scaleTween,
    fadeTween: fadeTween ?? this.fadeTween,
    insetDuration: insetDuration ?? this.insetDuration,
    insetCurve: insetCurve ?? this.insetCurve,
  );

  /// Linearly interpolate between this and another [FDialogMotion] using the given factor [t].
  @useResult
  FDialogMotion lerp(FDialogMotion other, double t) => FDialogMotion(
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    fadeInCurve: t < 0.5 ? fadeInCurve : other.fadeInCurve,
    fadeOutCurve: t < 0.5 ? fadeOutCurve : other.fadeOutCurve,
    scaleTween: t < 0.5 ? scaleTween : other.scaleTween,
    fadeTween: t < 0.5 ? fadeTween : other.fadeTween,
    insetDuration: t < 0.5 ? insetDuration : other.insetDuration,
    insetCurve: t < 0.5 ? insetCurve : other.insetCurve,
  );
}

mixin _$FDialogMotionFunctions on Diagnosticable {
  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get fadeInCurve;
  Curve get fadeOutCurve;
  Animatable<double> get scaleTween;
  Animatable<double> get fadeTween;
  Duration get insetDuration;
  Curve get insetCurve;

  /// Returns itself.
  @useResult
  FDialogMotion call(Object? _) => this as FDialogMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeInCurve', fadeInCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeOutCurve', fadeOutCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scaleTween', scaleTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeTween', fadeTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('insetDuration', insetDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('insetCurve', insetCurve, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FDialogMotion &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          fadeInCurve == other.fadeInCurve &&
          fadeOutCurve == other.fadeOutCurve &&
          scaleTween == other.scaleTween &&
          fadeTween == other.fadeTween &&
          insetDuration == other.insetDuration &&
          insetCurve == other.insetCurve);

  @override
  int get hashCode =>
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      fadeInCurve.hashCode ^
      fadeOutCurve.hashCode ^
      scaleTween.hashCode ^
      fadeTween.hashCode ^
      insetDuration.hashCode ^
      insetCurve.hashCode;
}

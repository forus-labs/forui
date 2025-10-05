// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'toaster_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FToasterStyleTransformations on FToasterStyle {
  /// Returns a copy of this [FToasterStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FToasterStyle.max] - The maximum number of entries shown per [FToastAlignment].
  /// * [FToasterStyle.padding] - The toaster's padding.
  /// * [FToasterStyle.expandBehavior] - The toaster's expansion behavior.
  /// * [FToasterStyle.expandHoverEnterDuration] - The duration to wait after entering the toaster before expanding the toasts.
  /// * [FToasterStyle.expandHoverExitDuration] - The duration to wait after exiting the toaster before collapsing the toasts.
  /// * [FToasterStyle.expandStartSpacing] - The spacing below or above the toasts when they are expanded.
  /// * [FToasterStyle.expandSpacing] - The spacing between the toasts when they are expanded.
  /// * [FToasterStyle.collapsedProtrusion] - The protrusion of the collapsed toasts behind the front toast.
  /// * [FToasterStyle.collapsedScale] - The scaling factor pf the collapsed toasts behind the front toast.
  /// * [FToasterStyle.motion] - The motion-related properties.
  /// * [FToasterStyle.toastAlignment] - The toast's alignment relative to a [FToaster].
  /// * [FToasterStyle.toastStyle] - The contained toasts' style.
  @useResult
  FToasterStyle copyWith({
    double? max,
    EdgeInsetsGeometry? padding,
    FToasterExpandBehavior? expandBehavior,
    Duration? expandHoverEnterDuration,
    Duration? expandHoverExitDuration,
    double? expandStartSpacing,
    double? expandSpacing,
    double? collapsedProtrusion,
    double? collapsedScale,
    FToasterMotion Function(FToasterMotion motion)? motion,
    FToastAlignment? toastAlignment,
    FToastStyle Function(FToastStyle style)? toastStyle,
  }) => FToasterStyle(
    max: max ?? this.max,
    padding: padding ?? this.padding,
    expandBehavior: expandBehavior ?? this.expandBehavior,
    expandHoverEnterDuration: expandHoverEnterDuration ?? this.expandHoverEnterDuration,
    expandHoverExitDuration: expandHoverExitDuration ?? this.expandHoverExitDuration,
    expandStartSpacing: expandStartSpacing ?? this.expandStartSpacing,
    expandSpacing: expandSpacing ?? this.expandSpacing,
    collapsedProtrusion: collapsedProtrusion ?? this.collapsedProtrusion,
    collapsedScale: collapsedScale ?? this.collapsedScale,
    motion: motion != null ? motion(this.motion) : this.motion,
    toastAlignment: toastAlignment ?? this.toastAlignment,
    toastStyle: toastStyle != null ? toastStyle(this.toastStyle) : this.toastStyle,
  );

  /// Linearly interpolate between this and another [FToasterStyle] using the given factor [t].
  @useResult
  FToasterStyle lerp(FToasterStyle other, double t) => FToasterStyle(
    max: lerpDouble(max, other.max, t) ?? max,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    expandBehavior: t < 0.5 ? expandBehavior : other.expandBehavior,
    expandHoverEnterDuration: t < 0.5 ? expandHoverEnterDuration : other.expandHoverEnterDuration,
    expandHoverExitDuration: t < 0.5 ? expandHoverExitDuration : other.expandHoverExitDuration,
    expandStartSpacing: lerpDouble(expandStartSpacing, other.expandStartSpacing, t) ?? expandStartSpacing,
    expandSpacing: lerpDouble(expandSpacing, other.expandSpacing, t) ?? expandSpacing,
    collapsedProtrusion: lerpDouble(collapsedProtrusion, other.collapsedProtrusion, t) ?? collapsedProtrusion,
    collapsedScale: lerpDouble(collapsedScale, other.collapsedScale, t) ?? collapsedScale,
    motion: motion.lerp(other.motion, t),
    toastAlignment: t < 0.5 ? toastAlignment : other.toastAlignment,
    toastStyle: toastStyle.lerp(other.toastStyle, t),
  );
}

mixin _$FToasterStyleFunctions on Diagnosticable {
  double get max;
  EdgeInsetsGeometry get padding;
  FToasterExpandBehavior get expandBehavior;
  Duration get expandHoverEnterDuration;
  Duration get expandHoverExitDuration;
  double get expandStartSpacing;
  double get expandSpacing;
  double get collapsedProtrusion;
  double get collapsedScale;
  FToasterMotion get motion;
  FToastAlignment get toastAlignment;
  FToastStyle get toastStyle;

  /// Returns itself.
  ///
  /// Allows [FToasterStyle] to replace functions that accept and return a [FToasterStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FToasterStyle Function(FToasterStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FToasterStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FToasterStyle(...));
  /// ```
  @useResult
  FToasterStyle call(Object? _) => this as FToasterStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('max', max, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(EnumProperty('expandBehavior', expandBehavior, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandHoverEnterDuration', expandHoverEnterDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandHoverExitDuration', expandHoverExitDuration, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('expandStartSpacing', expandStartSpacing, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('expandSpacing', expandSpacing, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('collapsedProtrusion', collapsedProtrusion, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('collapsedScale', collapsedScale, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug))
      ..add(EnumProperty('toastAlignment', toastAlignment, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('toastStyle', toastStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToasterStyle &&
          max == other.max &&
          padding == other.padding &&
          expandBehavior == other.expandBehavior &&
          expandHoverEnterDuration == other.expandHoverEnterDuration &&
          expandHoverExitDuration == other.expandHoverExitDuration &&
          expandStartSpacing == other.expandStartSpacing &&
          expandSpacing == other.expandSpacing &&
          collapsedProtrusion == other.collapsedProtrusion &&
          collapsedScale == other.collapsedScale &&
          motion == other.motion &&
          toastAlignment == other.toastAlignment &&
          toastStyle == other.toastStyle);

  @override
  int get hashCode =>
      max.hashCode ^
      padding.hashCode ^
      expandBehavior.hashCode ^
      expandHoverEnterDuration.hashCode ^
      expandHoverExitDuration.hashCode ^
      expandStartSpacing.hashCode ^
      expandSpacing.hashCode ^
      collapsedProtrusion.hashCode ^
      collapsedScale.hashCode ^
      motion.hashCode ^
      toastAlignment.hashCode ^
      toastStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FToasterMotionTransformations on FToasterMotion {
  /// Returns a copy of this [FToasterMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FToasterMotion.expandDuration] - The duration of the toasts' expansion.
  /// * [FToasterMotion.collapseDuration] - The duration of the toasts' collapsing.
  /// * [FToasterMotion.expandCurve] - The animation curve for the toasts' expansion and collapsing.
  /// * [FToasterMotion.collapseCurve] - The animation curve for the toasts' collapsing.
  @useResult
  FToasterMotion copyWith({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
  }) => FToasterMotion(
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
  );

  /// Linearly interpolate between this and another [FToasterMotion] using the given factor [t].
  @useResult
  FToasterMotion lerp(FToasterMotion other, double t) => FToasterMotion(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
  );
}

mixin _$FToasterMotionFunctions on Diagnosticable {
  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get expandCurve;
  Curve get collapseCurve;

  /// Returns itself.
  @useResult
  FToasterMotion call(Object? _) => this as FToasterMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToasterMotion &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve);

  @override
  int get hashCode =>
      expandDuration.hashCode ^ collapseDuration.hashCode ^ expandCurve.hashCode ^ collapseCurve.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FToastStyleTransformations on FToastStyle {
  /// Returns a copy of this [FToastStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FToastStyle.constraints] - The toast's constraints.
  /// * [FToastStyle.decoration] - The toast's decoration.
  /// * [FToastStyle.backgroundFilter] - An optional background filter.
  /// * [FToastStyle.padding] - The toast content's padding.
  /// * [FToastStyle.iconStyle] - The style of the toast's prefix icon.
  /// * [FToastStyle.iconSpacing] - The spacing between the icon and the title.
  /// * [FToastStyle.titleTextStyle] - The title's text style.
  /// * [FToastStyle.titleSpacing] - The spacing between the title and description Defaults to 5.
  /// * [FToastStyle.descriptionTextStyle] - The description's text style.
  /// * [FToastStyle.suffixSpacing] - The spacing between the icon and the title.
  /// * [FToastStyle.motion] - The motion-related properties.
  @useResult
  FToastStyle copyWith({
    BoxConstraints? constraints,
    BoxDecoration? decoration,
    ImageFilter? backgroundFilter,
    EdgeInsetsGeometry? padding,
    IconThemeData? iconStyle,
    double? iconSpacing,
    TextStyle? titleTextStyle,
    double? titleSpacing,
    TextStyle? descriptionTextStyle,
    double? suffixSpacing,
    FToastMotion Function(FToastMotion motion)? motion,
  }) => FToastStyle(
    constraints: constraints ?? this.constraints,
    decoration: decoration ?? this.decoration,
    backgroundFilter: backgroundFilter ?? this.backgroundFilter,
    padding: padding ?? this.padding,
    iconStyle: iconStyle ?? this.iconStyle,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    suffixSpacing: suffixSpacing ?? this.suffixSpacing,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FToastStyle] using the given factor [t].
  @useResult
  FToastStyle lerp(FToastStyle other, double t) => FToastStyle(
    constraints: BoxConstraints.lerp(constraints, other.constraints, t) ?? constraints,
    decoration: BoxDecoration.lerp(decoration, other.decoration, t) ?? decoration,
    backgroundFilter: t < 0.5 ? backgroundFilter : other.backgroundFilter,
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    iconSpacing: lerpDouble(iconSpacing, other.iconSpacing, t) ?? iconSpacing,
    titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t) ?? titleTextStyle,
    titleSpacing: lerpDouble(titleSpacing, other.titleSpacing, t) ?? titleSpacing,
    descriptionTextStyle: TextStyle.lerp(descriptionTextStyle, other.descriptionTextStyle, t) ?? descriptionTextStyle,
    suffixSpacing: lerpDouble(suffixSpacing, other.suffixSpacing, t) ?? suffixSpacing,
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FToastStyleFunctions on Diagnosticable {
  BoxConstraints get constraints;
  BoxDecoration get decoration;
  ImageFilter? get backgroundFilter;
  EdgeInsetsGeometry get padding;
  IconThemeData get iconStyle;
  double get iconSpacing;
  TextStyle get titleTextStyle;
  double get titleSpacing;
  TextStyle get descriptionTextStyle;
  double get suffixSpacing;
  FToastMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FToastStyle] to replace functions that accept and return a [FToastStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FToastStyle Function(FToastStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FToastStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FToastStyle(...));
  /// ```
  @useResult
  FToastStyle call(Object? _) => this as FToastStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('constraints', constraints, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('iconSpacing', iconSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('suffixSpacing', suffixSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToastStyle &&
          constraints == other.constraints &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          iconStyle == other.iconStyle &&
          iconSpacing == other.iconSpacing &&
          titleTextStyle == other.titleTextStyle &&
          titleSpacing == other.titleSpacing &&
          descriptionTextStyle == other.descriptionTextStyle &&
          suffixSpacing == other.suffixSpacing &&
          motion == other.motion);

  @override
  int get hashCode =>
      constraints.hashCode ^
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      padding.hashCode ^
      iconStyle.hashCode ^
      iconSpacing.hashCode ^
      titleTextStyle.hashCode ^
      titleSpacing.hashCode ^
      descriptionTextStyle.hashCode ^
      suffixSpacing.hashCode ^
      motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FToastMotionTransformations on FToastMotion {
  /// Returns a copy of this [FToastMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FToastMotion.entranceDuration] - The duration of the toast's entrance when it is initially added to to toaster.
  /// * [FToastMotion.dismissDuration] - The duration of the toast's exit animation when it is dismissed.
  /// * [FToastMotion.transitionDuration] - The duration of the toast's transition between places in the toaster.
  /// * [FToastMotion.reentranceDuration] - The duration of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the
  /// toaster.
  /// * [FToastMotion.exitDuration] - The duration of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed
  /// and this toast is hidden.
  /// * [FToastMotion.swipeCompletionDuration] - The toast's swipe completion animation duration.
  /// * [FToastMotion.entranceCurve] - The toast's initial entrance animation curve.
  /// * [FToastMotion.dismissCurve] - The toast's exit animation curve.
  /// * [FToastMotion.transitionCurve] - The toast's transition animation curve.
  /// * [FToastMotion.reentranceCurve] - The curve of the toast's fade-in animation when another toast has been dismissed and this toast re-enters the
  /// toaster.
  /// * [FToastMotion.exitCurve] - The curve of the toast's fade-out animation when the number of toasts in a toaster exceeds the maximum allowed
  /// and this toast is hidden.
  /// * [FToastMotion.swipeCompletionCurve] - The toast's swipe completion animation curve.
  /// * [FToastMotion.entranceDismissFadeTween] - The toast's initial entrance's opacity and dismiss's fade tween.
  @useResult
  FToastMotion copyWith({
    Duration? entranceDuration,
    Duration? dismissDuration,
    Duration? transitionDuration,
    Duration? reentranceDuration,
    Duration? exitDuration,
    Duration? swipeCompletionDuration,
    Curve? entranceCurve,
    Curve? dismissCurve,
    Curve? transitionCurve,
    Curve? reentranceCurve,
    Curve? exitCurve,
    Curve? swipeCompletionCurve,
    Animatable<double>? entranceDismissFadeTween,
  }) => FToastMotion(
    entranceDuration: entranceDuration ?? this.entranceDuration,
    dismissDuration: dismissDuration ?? this.dismissDuration,
    transitionDuration: transitionDuration ?? this.transitionDuration,
    reentranceDuration: reentranceDuration ?? this.reentranceDuration,
    exitDuration: exitDuration ?? this.exitDuration,
    swipeCompletionDuration: swipeCompletionDuration ?? this.swipeCompletionDuration,
    entranceCurve: entranceCurve ?? this.entranceCurve,
    dismissCurve: dismissCurve ?? this.dismissCurve,
    transitionCurve: transitionCurve ?? this.transitionCurve,
    reentranceCurve: reentranceCurve ?? this.reentranceCurve,
    exitCurve: exitCurve ?? this.exitCurve,
    swipeCompletionCurve: swipeCompletionCurve ?? this.swipeCompletionCurve,
    entranceDismissFadeTween: entranceDismissFadeTween ?? this.entranceDismissFadeTween,
  );

  /// Linearly interpolate between this and another [FToastMotion] using the given factor [t].
  @useResult
  FToastMotion lerp(FToastMotion other, double t) => FToastMotion(
    entranceDuration: t < 0.5 ? entranceDuration : other.entranceDuration,
    dismissDuration: t < 0.5 ? dismissDuration : other.dismissDuration,
    transitionDuration: t < 0.5 ? transitionDuration : other.transitionDuration,
    reentranceDuration: t < 0.5 ? reentranceDuration : other.reentranceDuration,
    exitDuration: t < 0.5 ? exitDuration : other.exitDuration,
    swipeCompletionDuration: t < 0.5 ? swipeCompletionDuration : other.swipeCompletionDuration,
    entranceCurve: t < 0.5 ? entranceCurve : other.entranceCurve,
    dismissCurve: t < 0.5 ? dismissCurve : other.dismissCurve,
    transitionCurve: t < 0.5 ? transitionCurve : other.transitionCurve,
    reentranceCurve: t < 0.5 ? reentranceCurve : other.reentranceCurve,
    exitCurve: t < 0.5 ? exitCurve : other.exitCurve,
    swipeCompletionCurve: t < 0.5 ? swipeCompletionCurve : other.swipeCompletionCurve,
    entranceDismissFadeTween: t < 0.5 ? entranceDismissFadeTween : other.entranceDismissFadeTween,
  );
}

mixin _$FToastMotionFunctions on Diagnosticable {
  Duration get entranceDuration;
  Duration get dismissDuration;
  Duration get transitionDuration;
  Duration get reentranceDuration;
  Duration get exitDuration;
  Duration get swipeCompletionDuration;
  Curve get entranceCurve;
  Curve get dismissCurve;
  Curve get transitionCurve;
  Curve get reentranceCurve;
  Curve get exitCurve;
  Curve get swipeCompletionCurve;
  Animatable<double> get entranceDismissFadeTween;

  /// Returns itself.
  @useResult
  FToastMotion call(Object? _) => this as FToastMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('entranceDuration', entranceDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dismissDuration', dismissDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('transitionDuration', transitionDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('reentranceDuration', reentranceDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('exitDuration', exitDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('swipeCompletionDuration', swipeCompletionDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('entranceCurve', entranceCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dismissCurve', dismissCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('transitionCurve', transitionCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('reentranceCurve', reentranceCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('exitCurve', exitCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('swipeCompletionCurve', swipeCompletionCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('entranceDismissFadeTween', entranceDismissFadeTween, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToastMotion &&
          entranceDuration == other.entranceDuration &&
          dismissDuration == other.dismissDuration &&
          transitionDuration == other.transitionDuration &&
          reentranceDuration == other.reentranceDuration &&
          exitDuration == other.exitDuration &&
          swipeCompletionDuration == other.swipeCompletionDuration &&
          entranceCurve == other.entranceCurve &&
          dismissCurve == other.dismissCurve &&
          transitionCurve == other.transitionCurve &&
          reentranceCurve == other.reentranceCurve &&
          exitCurve == other.exitCurve &&
          swipeCompletionCurve == other.swipeCompletionCurve &&
          entranceDismissFadeTween == other.entranceDismissFadeTween);

  @override
  int get hashCode =>
      entranceDuration.hashCode ^
      dismissDuration.hashCode ^
      transitionDuration.hashCode ^
      reentranceDuration.hashCode ^
      exitDuration.hashCode ^
      swipeCompletionDuration.hashCode ^
      entranceCurve.hashCode ^
      dismissCurve.hashCode ^
      transitionCurve.hashCode ^
      reentranceCurve.hashCode ^
      exitCurve.hashCode ^
      swipeCompletionCurve.hashCode ^
      entranceDismissFadeTween.hashCode;
}

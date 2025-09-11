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
  /// * [FToasterStyle.expandDuration] - The expanding/collapsing animation duration.
  /// * [FToasterStyle.expandCurve] - The expanding/collapsing animation curve.
  /// * [FToasterStyle.collapsedProtrusion] - The protrusion of the collapsed toasts behind the front toast.
  /// * [FToasterStyle.collapsedScale] - The scaling factor pf the collapsed toasts behind the front toast.
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
    Duration? expandDuration,
    Curve? expandCurve,
    double? collapsedProtrusion,
    double? collapsedScale,
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
    expandDuration: expandDuration ?? this.expandDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapsedProtrusion: collapsedProtrusion ?? this.collapsedProtrusion,
    collapsedScale: collapsedScale ?? this.collapsedScale,
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
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapsedProtrusion: lerpDouble(collapsedProtrusion, other.collapsedProtrusion, t) ?? collapsedProtrusion,
    collapsedScale: lerpDouble(collapsedScale, other.collapsedScale, t) ?? collapsedScale,
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
  Duration get expandDuration;
  Curve get expandCurve;
  double get collapsedProtrusion;
  double get collapsedScale;
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
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('collapsedProtrusion', collapsedProtrusion, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('collapsedScale', collapsedScale, level: DiagnosticLevel.debug))
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
          expandDuration == other.expandDuration &&
          expandCurve == other.expandCurve &&
          collapsedProtrusion == other.collapsedProtrusion &&
          collapsedScale == other.collapsedScale &&
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
      expandDuration.hashCode ^
      expandCurve.hashCode ^
      collapsedProtrusion.hashCode ^
      collapsedScale.hashCode ^
      toastAlignment.hashCode ^
      toastStyle.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FToastStyleTransformations on FToastStyle {
  /// Returns a copy of this [FToastStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FToastStyle.enterExitDuration] - The toast's entrance & exit animation duration.
  /// * [FToastStyle.enterCurve] - The toast's entrance animation curve.
  /// * [FToastStyle.exitCurve] - The toast's exit animation curve.
  /// * [FToastStyle.entranceExitOpacity] - The toast's initial opacity when it enters, and the target opacity when it exits.
  /// * [FToastStyle.transitionDuration] - The toast's transition between indexes animation duration.
  /// * [FToastStyle.transitionCurve] - The toast's transition animation curve.
  /// * [FToastStyle.swipeCompletionDuration] - The toast's swipe completion animation duration.
  /// * [FToastStyle.swipeCompletionCurve] - The toast's swipe completion animation curve.
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
  @useResult
  FToastStyle copyWith({
    Duration? enterExitDuration,
    Curve? enterCurve,
    Curve? exitCurve,
    double? entranceExitOpacity,
    Duration? transitionDuration,
    Curve? transitionCurve,
    Duration? swipeCompletionDuration,
    Curve? swipeCompletionCurve,
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
  }) => FToastStyle(
    enterExitDuration: enterExitDuration ?? this.enterExitDuration,
    enterCurve: enterCurve ?? this.enterCurve,
    exitCurve: exitCurve ?? this.exitCurve,
    entranceExitOpacity: entranceExitOpacity ?? this.entranceExitOpacity,
    transitionDuration: transitionDuration ?? this.transitionDuration,
    transitionCurve: transitionCurve ?? this.transitionCurve,
    swipeCompletionDuration: swipeCompletionDuration ?? this.swipeCompletionDuration,
    swipeCompletionCurve: swipeCompletionCurve ?? this.swipeCompletionCurve,
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
  );

  /// Linearly interpolate between this and another [FToastStyle] using the given factor [t].
  @useResult
  FToastStyle lerp(FToastStyle other, double t) => FToastStyle(
    enterExitDuration: t < 0.5 ? enterExitDuration : other.enterExitDuration,
    enterCurve: t < 0.5 ? enterCurve : other.enterCurve,
    exitCurve: t < 0.5 ? exitCurve : other.exitCurve,
    entranceExitOpacity: lerpDouble(entranceExitOpacity, other.entranceExitOpacity, t) ?? entranceExitOpacity,
    transitionDuration: t < 0.5 ? transitionDuration : other.transitionDuration,
    transitionCurve: t < 0.5 ? transitionCurve : other.transitionCurve,
    swipeCompletionDuration: t < 0.5 ? swipeCompletionDuration : other.swipeCompletionDuration,
    swipeCompletionCurve: t < 0.5 ? swipeCompletionCurve : other.swipeCompletionCurve,
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
  );
}

mixin _$FToastStyleFunctions on Diagnosticable {
  Duration get enterExitDuration;
  Curve get enterCurve;
  Curve get exitCurve;
  double get entranceExitOpacity;
  Duration get transitionDuration;
  Curve get transitionCurve;
  Duration get swipeCompletionDuration;
  Curve get swipeCompletionCurve;
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
      ..add(DiagnosticsProperty('enterExitDuration', enterExitDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('enterCurve', enterCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('exitCurve', exitCurve, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('entranceExitOpacity', entranceExitOpacity, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('transitionDuration', transitionDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('transitionCurve', transitionCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('swipeCompletionDuration', swipeCompletionDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('swipeCompletionCurve', swipeCompletionCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('constraints', constraints, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('decoration', decoration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('iconSpacing', iconSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('titleSpacing', titleSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('suffixSpacing', suffixSpacing, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FToastStyle &&
          enterExitDuration == other.enterExitDuration &&
          enterCurve == other.enterCurve &&
          exitCurve == other.exitCurve &&
          entranceExitOpacity == other.entranceExitOpacity &&
          transitionDuration == other.transitionDuration &&
          transitionCurve == other.transitionCurve &&
          swipeCompletionDuration == other.swipeCompletionDuration &&
          swipeCompletionCurve == other.swipeCompletionCurve &&
          constraints == other.constraints &&
          decoration == other.decoration &&
          backgroundFilter == other.backgroundFilter &&
          padding == other.padding &&
          iconStyle == other.iconStyle &&
          iconSpacing == other.iconSpacing &&
          titleTextStyle == other.titleTextStyle &&
          titleSpacing == other.titleSpacing &&
          descriptionTextStyle == other.descriptionTextStyle &&
          suffixSpacing == other.suffixSpacing);

  @override
  int get hashCode =>
      enterExitDuration.hashCode ^
      enterCurve.hashCode ^
      exitCurve.hashCode ^
      entranceExitOpacity.hashCode ^
      transitionDuration.hashCode ^
      transitionCurve.hashCode ^
      swipeCompletionDuration.hashCode ^
      swipeCompletionCurve.hashCode ^
      constraints.hashCode ^
      decoration.hashCode ^
      backgroundFilter.hashCode ^
      padding.hashCode ^
      iconStyle.hashCode ^
      iconSpacing.hashCode ^
      titleTextStyle.hashCode ^
      titleSpacing.hashCode ^
      descriptionTextStyle.hashCode ^
      suffixSpacing.hashCode;
}

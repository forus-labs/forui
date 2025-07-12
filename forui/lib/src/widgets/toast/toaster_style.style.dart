// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'toaster_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FToasterStyleCopyWith on FToasterStyle {
  /// Returns a copy of this [FToasterStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [max]
  /// The maximum number of entries shown per [FToastAlignment]. Defaults to to 3.
  ///
  /// # [padding]
  /// The toaster's padding. Defaults to `EdgeInsets.symmetric(horizontal: 20, vertical: 15)`.
  ///
  /// # [expandBehavior]
  /// The toaster's expansion behavior. Defaults to [FToasterExpandBehavior.hoverOrPress].
  ///
  /// # [expandHoverEnterDuration]
  /// The duration to wait after entering the toaster before expanding the toasts. Defaults to 200ms.
  ///
  /// # [expandHoverExitDuration]
  /// The duration to wait after exiting the toaster before collapsing the toasts. Defaults to 300ms.
  ///
  /// # [expandStartSpacing]
  /// The spacing below or above the toasts when they are expanded. Defaults to 16.0.
  ///
  /// # [expandSpacing]
  /// The spacing between the toasts when they are expanded. Defaults to 10.0.
  ///
  /// # [expandDuration]
  /// The expanding/collapsing animation duration. Defaults to 500ms.
  ///
  /// # [expandCurve]
  /// The expanding/collapsing animation curve. Defaults to [Curves.easeInOutCubic].
  ///
  /// # [collapsedProtrusion]
  /// The protrusion of the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 12.0.
  ///
  /// # [collapsedScale]
  /// The scaling factor pf the collapsed toasts behind the front toast. This is scaled by the number of toasts in
  /// front of the toast.
  ///
  /// Defaults to 0.9.
  ///
  /// # [toastAlignment]
  /// The toast's alignment relative to a [FToaster]. Defaults to [FToastAlignment.bottomEnd].
  ///
  /// # [toastStyle]
  /// The contained toasts' style.
  ///
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
    FToastStyle Function(FToastStyle)? toastStyle,
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
}

/// Provides a `copyWith` method.
extension $FToastStyleCopyWith on FToastStyle {
  /// Returns a copy of this [FToastStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [enterExitDuration]
  /// The toast's entrance & exit animation duration. Defaults to 400ms.
  ///
  /// # [enterCurve]
  /// The toast's entrance animation curve. Defaults to [Curves.easeOutCubic].
  ///
  /// # [exitCurve]
  /// The toast's exit animation curve. Defaults to [Curves.easeOutCubic].
  ///
  /// # [entranceExitOpacity]
  /// The toast's initial opacity when it enters, and the target opacity when it exits.
  ///
  /// Defaults to 0. Set to 1.0 to remove the fade-in/out effect.
  ///
  /// ## Contract
  /// Throws [AssertionError] if the value is not in `[0, 1]`.
  ///
  /// # [transitionDuration]
  /// The toast's transition between indexes animation duration. Defaults to 400ms.
  ///
  /// # [transitionCurve]
  /// The toast's transition animation curve. Defaults to [Curves.easeInOutCubic].
  ///
  /// # [swipeCompletionDuration]
  /// The toast's swipe completion animation duration. Defaults to 150ms.
  ///
  /// # [swipeCompletionCurve]
  /// The toast's swipe completion animation curve. Defaults to [Curves.easeInCubic].
  ///
  /// # [constraints]
  /// The toast's constraints. Defaults to `BoxConstraints(maxHeight: 250, maxWidth: 400)`.
  ///
  /// # [decoration]
  /// The toast's decoration.
  ///
  /// # [backgroundFilter]
  /// An optional background filter. This only takes effect if the [decoration] has a transparent or translucent
  /// background color.
  ///
  /// This is typically combined with a transparent/translucent background to create a glassmorphic effect.
  ///
  /// There will be a flicker after the toast's fade-in entrance when a blur background filter is applied. This is due to
  /// https://github.com/flutter/flutter/issues/31706.
  ///
  /// ## Examples
  /// ```dart
  /// // Blurred
  /// ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  ///
  /// // Solid color
  /// ColorFilter.mode(Colors.white, BlendMode.srcOver);
  ///
  /// // Tinted
  /// ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver);
  ///
  /// // Blurred & tinted
  /// ImageFilter.compose(
  ///   outer: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
  ///   inner: ColorFilter.mode(Colors.white.withValues(alpha: 0.5), BlendMode.srcOver),
  /// );
  /// ```
  ///
  /// # [padding]
  /// The toast content's padding. Defaults to `EdgeInsets.all(16)`.
  ///
  /// # [iconStyle]
  /// The style of the toast's prefix icon.
  ///
  /// # [iconSpacing]
  /// The spacing between the icon and the title. Defaults to 10.0.
  ///
  /// # [titleTextStyle]
  /// The title's text style.
  ///
  /// # [titleSpacing]
  /// The spacing between the title and description Defaults to 5.0.
  ///
  /// # [descriptionTextStyle]
  /// The description's text style.
  ///
  /// # [suffixSpacing]
  /// The spacing between the icon and the title. Defaults to 12.0.
  ///
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
      ..add(DoubleProperty('max', max))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(EnumProperty('expandBehavior', expandBehavior))
      ..add(DiagnosticsProperty('expandHoverEnterDuration', expandHoverEnterDuration))
      ..add(DiagnosticsProperty('expandHoverExitDuration', expandHoverExitDuration))
      ..add(DoubleProperty('expandStartSpacing', expandStartSpacing))
      ..add(DoubleProperty('expandSpacing', expandSpacing))
      ..add(DiagnosticsProperty('expandDuration', expandDuration))
      ..add(DiagnosticsProperty('expandCurve', expandCurve))
      ..add(DoubleProperty('collapsedProtrusion', collapsedProtrusion))
      ..add(DoubleProperty('collapsedScale', collapsedScale))
      ..add(EnumProperty('toastAlignment', toastAlignment))
      ..add(DiagnosticsProperty('toastStyle', toastStyle));
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
      ..add(DiagnosticsProperty('enterExitDuration', enterExitDuration))
      ..add(DiagnosticsProperty('enterCurve', enterCurve))
      ..add(DiagnosticsProperty('exitCurve', exitCurve))
      ..add(DoubleProperty('entranceExitOpacity', entranceExitOpacity))
      ..add(DiagnosticsProperty('transitionDuration', transitionDuration))
      ..add(DiagnosticsProperty('transitionCurve', transitionCurve))
      ..add(DiagnosticsProperty('swipeCompletionDuration', swipeCompletionDuration))
      ..add(DiagnosticsProperty('swipeCompletionCurve', swipeCompletionCurve))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('decoration', decoration))
      ..add(DiagnosticsProperty('backgroundFilter', backgroundFilter))
      ..add(DiagnosticsProperty('padding', padding))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DoubleProperty('iconSpacing', iconSpacing))
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DoubleProperty('titleSpacing', titleSpacing))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DoubleProperty('suffixSpacing', suffixSpacing));
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

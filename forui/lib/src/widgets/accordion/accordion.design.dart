// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'accordion.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FAccordionStyleTransformations on FAccordionStyle {
  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FAccordionStyle.titleTextStyle] - The title's text style.
  /// * [FAccordionStyle.childTextStyle] - The child's default text style.
  /// * [FAccordionStyle.titlePadding] - The padding around the title.
  /// * [FAccordionStyle.childPadding] - The padding around the content.
  /// * [FAccordionStyle.iconStyle] - The icon's style.
  /// * [FAccordionStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FAccordionStyle.dividerStyle] - The divider's color.
  /// * [FAccordionStyle.tappableStyle] - The tappable's style.
  /// * [FAccordionStyle.motion] - The motion-related properties.
  @useResult
  FAccordionStyle copyWith({
    FWidgetStateMap<TextStyle>? titleTextStyle,
    TextStyle? childTextStyle,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<IconThemeData>? iconStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FDividerStyle Function(FDividerStyle style)? dividerStyle,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FAccordionMotion Function(FAccordionMotion motion)? motion,
  }) => FAccordionStyle(
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    childTextStyle: childTextStyle ?? this.childTextStyle,
    titlePadding: titlePadding ?? this.titlePadding,
    childPadding: childPadding ?? this.childPadding,
    iconStyle: iconStyle ?? this.iconStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    dividerStyle: dividerStyle != null ? dividerStyle(this.dividerStyle) : this.dividerStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FAccordionStyle] using the given factor [t].
  @useResult
  FAccordionStyle lerp(FAccordionStyle other, double t) => FAccordionStyle(
    titleTextStyle: FWidgetStateMap.lerpTextStyle(titleTextStyle, other.titleTextStyle, t),
    childTextStyle: TextStyle.lerp(childTextStyle, other.childTextStyle, t) ?? childTextStyle,
    titlePadding: EdgeInsetsGeometry.lerp(titlePadding, other.titlePadding, t) ?? titlePadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    dividerStyle: dividerStyle.lerp(other.dividerStyle, t),
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FAccordionStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get titleTextStyle;
  TextStyle get childTextStyle;
  EdgeInsetsGeometry get titlePadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<IconThemeData> get iconStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FDividerStyle get dividerStyle;
  FTappableStyle get tappableStyle;
  FAccordionMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FAccordionStyle] to replace functions that accept and return a [FAccordionStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FAccordionStyle Function(FAccordionStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FAccordionStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FAccordionStyle(...));
  /// ```
  @useResult
  FAccordionStyle call(Object? _) => this as FAccordionStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('titlePadding', titlePadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAccordionStyle &&
          titleTextStyle == other.titleTextStyle &&
          childTextStyle == other.childTextStyle &&
          titlePadding == other.titlePadding &&
          childPadding == other.childPadding &&
          iconStyle == other.iconStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          dividerStyle == other.dividerStyle &&
          tappableStyle == other.tappableStyle &&
          motion == other.motion);

  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      childTextStyle.hashCode ^
      titlePadding.hashCode ^
      childPadding.hashCode ^
      iconStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      dividerStyle.hashCode ^
      tappableStyle.hashCode ^
      motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FAccordionMotionTransformations on FAccordionMotion {
  /// Returns a copy of this [FAccordionMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FAccordionMotion.expandDuration] - The expand animation's duration.
  /// * [FAccordionMotion.collapseDuration] - The collapse animation's duration.
  /// * [FAccordionMotion.expandCurve] - The expand animation's curve.
  /// * [FAccordionMotion.collapseCurve] - The collapse animation's curve.
  /// * [FAccordionMotion.iconExpandCurve] - The icon's animation curve when expanding.
  /// * [FAccordionMotion.iconCollapseCurve] - The icon's animation curve when collapsing.
  /// * [FAccordionMotion.revealTween] - The reveal animation's tween.
  /// * [FAccordionMotion.iconTween] - The icon animation's tween.
  @useResult
  FAccordionMotion copyWith({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? iconExpandCurve,
    Curve? iconCollapseCurve,
    Animatable<double>? revealTween,
    Animatable<double>? iconTween,
  }) => FAccordionMotion(
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    iconExpandCurve: iconExpandCurve ?? this.iconExpandCurve,
    iconCollapseCurve: iconCollapseCurve ?? this.iconCollapseCurve,
    revealTween: revealTween ?? this.revealTween,
    iconTween: iconTween ?? this.iconTween,
  );

  /// Linearly interpolate between this and another [FAccordionMotion] using the given factor [t].
  @useResult
  FAccordionMotion lerp(FAccordionMotion other, double t) => FAccordionMotion(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    iconExpandCurve: t < 0.5 ? iconExpandCurve : other.iconExpandCurve,
    iconCollapseCurve: t < 0.5 ? iconCollapseCurve : other.iconCollapseCurve,
    revealTween: t < 0.5 ? revealTween : other.revealTween,
    iconTween: t < 0.5 ? iconTween : other.iconTween,
  );
}

mixin _$FAccordionMotionFunctions on Diagnosticable {
  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get iconExpandCurve;
  Curve get iconCollapseCurve;
  Animatable<double> get revealTween;
  Animatable<double> get iconTween;

  /// Returns itself.
  @useResult
  FAccordionMotion call(Object? _) => this as FAccordionMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconExpandCurve', iconExpandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconCollapseCurve', iconCollapseCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('revealTween', revealTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconTween', iconTween, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FAccordionMotion &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          iconExpandCurve == other.iconExpandCurve &&
          iconCollapseCurve == other.iconCollapseCurve &&
          revealTween == other.revealTween &&
          iconTween == other.iconTween);

  @override
  int get hashCode =>
      expandDuration.hashCode ^
      collapseDuration.hashCode ^
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      iconExpandCurve.hashCode ^
      iconCollapseCurve.hashCode ^
      revealTween.hashCode ^
      iconTween.hashCode;
}

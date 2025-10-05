// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'sidebar_item.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarItemStyleTransformations on FSidebarItemStyle {
  /// Returns a copy of this [FSidebarItemStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSidebarItemStyle.textStyle] - The label's text style.
  /// * [FSidebarItemStyle.iconSpacing] - The spacing between the icon and label.
  /// * [FSidebarItemStyle.iconStyle] - The icon's style.
  /// * [FSidebarItemStyle.collapsibleIconSpacing] - The spacing between the label and collapsible widget.
  /// * [FSidebarItemStyle.collapsibleIconStyle] - The collapsible icon's style.
  /// * [FSidebarItemStyle.childrenSpacing] - The spacing between child items.
  /// * [FSidebarItemStyle.childrenPadding] - The padding around the children container.
  /// * [FSidebarItemStyle.backgroundColor] - The background color.
  /// * [FSidebarItemStyle.padding] - The padding around the content.
  /// * [FSidebarItemStyle.borderRadius] - The item's border radius.
  /// * [FSidebarItemStyle.tappableStyle] - The tappable's style.
  /// * [FSidebarItemStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FSidebarItemStyle.motion] - The motion-related properties.
  @useResult
  FSidebarItemStyle copyWith({
    FWidgetStateMap<TextStyle>? textStyle,
    double? iconSpacing,
    FWidgetStateMap<IconThemeData>? iconStyle,
    double? collapsibleIconSpacing,
    FWidgetStateMap<IconThemeData>? collapsibleIconStyle,
    double? childrenSpacing,
    EdgeInsetsGeometry? childrenPadding,
    FWidgetStateMap<Color>? backgroundColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    FSidebarItemMotion Function(FSidebarItemMotion motion)? motion,
  }) => FSidebarItemStyle(
    textStyle: textStyle ?? this.textStyle,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    iconStyle: iconStyle ?? this.iconStyle,
    collapsibleIconSpacing: collapsibleIconSpacing ?? this.collapsibleIconSpacing,
    collapsibleIconStyle: collapsibleIconStyle ?? this.collapsibleIconStyle,
    childrenSpacing: childrenSpacing ?? this.childrenSpacing,
    childrenPadding: childrenPadding ?? this.childrenPadding,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    padding: padding ?? this.padding,
    borderRadius: borderRadius ?? this.borderRadius,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    motion: motion != null ? motion(this.motion) : this.motion,
  );

  /// Linearly interpolate between this and another [FSidebarItemStyle] using the given factor [t].
  @useResult
  FSidebarItemStyle lerp(FSidebarItemStyle other, double t) => FSidebarItemStyle(
    textStyle: FWidgetStateMap.lerpTextStyle(textStyle, other.textStyle, t),
    iconSpacing: lerpDouble(iconSpacing, other.iconSpacing, t) ?? iconSpacing,
    iconStyle: FWidgetStateMap.lerpIconThemeData(iconStyle, other.iconStyle, t),
    collapsibleIconSpacing:
        lerpDouble(collapsibleIconSpacing, other.collapsibleIconSpacing, t) ?? collapsibleIconSpacing,
    collapsibleIconStyle: FWidgetStateMap.lerpIconThemeData(collapsibleIconStyle, other.collapsibleIconStyle, t),
    childrenSpacing: lerpDouble(childrenSpacing, other.childrenSpacing, t) ?? childrenSpacing,
    childrenPadding: EdgeInsetsGeometry.lerp(childrenPadding, other.childrenPadding, t) ?? childrenPadding,
    backgroundColor: FWidgetStateMap.lerpColor(backgroundColor, other.backgroundColor, t),
    padding: EdgeInsetsGeometry.lerp(padding, other.padding, t) ?? padding,
    borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    motion: motion.lerp(other.motion, t),
  );
}

mixin _$FSidebarItemStyleFunctions on Diagnosticable {
  FWidgetStateMap<TextStyle> get textStyle;
  double get iconSpacing;
  FWidgetStateMap<IconThemeData> get iconStyle;
  double get collapsibleIconSpacing;
  FWidgetStateMap<IconThemeData> get collapsibleIconStyle;
  double get childrenSpacing;
  EdgeInsetsGeometry get childrenPadding;
  FWidgetStateMap<Color> get backgroundColor;
  EdgeInsetsGeometry get padding;
  BorderRadius get borderRadius;
  FTappableStyle get tappableStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FSidebarItemMotion get motion;

  /// Returns itself.
  ///
  /// Allows [FSidebarItemStyle] to replace functions that accept and return a [FSidebarItemStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSidebarItemStyle Function(FSidebarItemStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSidebarItemStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSidebarItemStyle(...));
  /// ```
  @useResult
  FSidebarItemStyle call(Object? _) => this as FSidebarItemStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('textStyle', textStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('iconSpacing', iconSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('collapsibleIconSpacing', collapsibleIconSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapsibleIconStyle', collapsibleIconStyle, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('childrenSpacing', childrenSpacing, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childrenPadding', childrenPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('padding', padding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('motion', motion, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarItemStyle &&
          textStyle == other.textStyle &&
          iconSpacing == other.iconSpacing &&
          iconStyle == other.iconStyle &&
          collapsibleIconSpacing == other.collapsibleIconSpacing &&
          collapsibleIconStyle == other.collapsibleIconStyle &&
          childrenSpacing == other.childrenSpacing &&
          childrenPadding == other.childrenPadding &&
          backgroundColor == other.backgroundColor &&
          padding == other.padding &&
          borderRadius == other.borderRadius &&
          tappableStyle == other.tappableStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          motion == other.motion);

  @override
  int get hashCode =>
      textStyle.hashCode ^
      iconSpacing.hashCode ^
      iconStyle.hashCode ^
      collapsibleIconSpacing.hashCode ^
      collapsibleIconStyle.hashCode ^
      childrenSpacing.hashCode ^
      childrenPadding.hashCode ^
      backgroundColor.hashCode ^
      padding.hashCode ^
      borderRadius.hashCode ^
      tappableStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      motion.hashCode;
}

/// Provides [copyWith] and [lerp] methods.
extension $FSidebarItemMotionTransformations on FSidebarItemMotion {
  /// Returns a copy of this [FSidebarItemMotion] with the given properties replaced.
  ///
  /// ## Parameters
  /// * [FSidebarItemMotion.expandDuration] - The expand animation's duration.
  /// * [FSidebarItemMotion.collapseDuration] - The collapse animation's duration.
  /// * [FSidebarItemMotion.expandCurve] - The expand animation's curve.
  /// * [FSidebarItemMotion.collapseCurve] - The collapse animation's curve.
  /// * [FSidebarItemMotion.fadeInCurve] - The fade-in animation's curve.
  /// * [FSidebarItemMotion.fadeOutCurve] - The fade-out animation's curve.
  /// * [FSidebarItemMotion.iconExpandCurve] - The icon's animation curve when expanding.
  /// * [FSidebarItemMotion.iconCollapseCurve] - The icon's animation curve when collapsing.
  /// * [FSidebarItemMotion.revealTween] - The reveal animation's tween.
  /// * [FSidebarItemMotion.fadeTween] - The fade animation's tween.
  /// * [FSidebarItemMotion.iconTween] - The icon animation's tween.
  @useResult
  FSidebarItemMotion copyWith({
    Duration? expandDuration,
    Duration? collapseDuration,
    Curve? expandCurve,
    Curve? collapseCurve,
    Curve? fadeInCurve,
    Curve? fadeOutCurve,
    Curve? iconExpandCurve,
    Curve? iconCollapseCurve,
    Animatable<double>? revealTween,
    Animatable<double>? fadeTween,
    Animatable<double>? iconTween,
  }) => FSidebarItemMotion(
    expandDuration: expandDuration ?? this.expandDuration,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    fadeInCurve: fadeInCurve ?? this.fadeInCurve,
    fadeOutCurve: fadeOutCurve ?? this.fadeOutCurve,
    iconExpandCurve: iconExpandCurve ?? this.iconExpandCurve,
    iconCollapseCurve: iconCollapseCurve ?? this.iconCollapseCurve,
    revealTween: revealTween ?? this.revealTween,
    fadeTween: fadeTween ?? this.fadeTween,
    iconTween: iconTween ?? this.iconTween,
  );

  /// Linearly interpolate between this and another [FSidebarItemMotion] using the given factor [t].
  @useResult
  FSidebarItemMotion lerp(FSidebarItemMotion other, double t) => FSidebarItemMotion(
    expandDuration: t < 0.5 ? expandDuration : other.expandDuration,
    collapseDuration: t < 0.5 ? collapseDuration : other.collapseDuration,
    expandCurve: t < 0.5 ? expandCurve : other.expandCurve,
    collapseCurve: t < 0.5 ? collapseCurve : other.collapseCurve,
    fadeInCurve: t < 0.5 ? fadeInCurve : other.fadeInCurve,
    fadeOutCurve: t < 0.5 ? fadeOutCurve : other.fadeOutCurve,
    iconExpandCurve: t < 0.5 ? iconExpandCurve : other.iconExpandCurve,
    iconCollapseCurve: t < 0.5 ? iconCollapseCurve : other.iconCollapseCurve,
    revealTween: t < 0.5 ? revealTween : other.revealTween,
    fadeTween: t < 0.5 ? fadeTween : other.fadeTween,
    iconTween: t < 0.5 ? iconTween : other.iconTween,
  );
}

mixin _$FSidebarItemMotionFunctions on Diagnosticable {
  Duration get expandDuration;
  Duration get collapseDuration;
  Curve get expandCurve;
  Curve get collapseCurve;
  Curve get fadeInCurve;
  Curve get fadeOutCurve;
  Curve get iconExpandCurve;
  Curve get iconCollapseCurve;
  Animatable<double> get revealTween;
  Animatable<double> get fadeTween;
  Animatable<double> get iconTween;

  /// Returns itself.
  @useResult
  FSidebarItemMotion call(Object? _) => this as FSidebarItemMotion;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('expandDuration', expandDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('expandCurve', expandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeInCurve', fadeInCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeOutCurve', fadeOutCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconExpandCurve', iconExpandCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconCollapseCurve', iconCollapseCurve, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('revealTween', revealTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('fadeTween', fadeTween, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconTween', iconTween, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSidebarItemMotion &&
          expandDuration == other.expandDuration &&
          collapseDuration == other.collapseDuration &&
          expandCurve == other.expandCurve &&
          collapseCurve == other.collapseCurve &&
          fadeInCurve == other.fadeInCurve &&
          fadeOutCurve == other.fadeOutCurve &&
          iconExpandCurve == other.iconExpandCurve &&
          iconCollapseCurve == other.iconCollapseCurve &&
          revealTween == other.revealTween &&
          fadeTween == other.fadeTween &&
          iconTween == other.iconTween);

  @override
  int get hashCode =>
      expandDuration.hashCode ^
      collapseDuration.hashCode ^
      expandCurve.hashCode ^
      collapseCurve.hashCode ^
      fadeInCurve.hashCode ^
      fadeOutCurve.hashCode ^
      iconExpandCurve.hashCode ^
      iconCollapseCurve.hashCode ^
      revealTween.hashCode ^
      fadeTween.hashCode ^
      iconTween.hashCode;
}

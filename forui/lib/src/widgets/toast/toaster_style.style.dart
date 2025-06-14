// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'toaster_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FToasterStyleFunctions on Diagnosticable implements FTransformable {
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
  FToastStyle get toastStyle;

  /// Returns a copy of this [FToasterStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
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
    FToastStyle? toastStyle,
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
    toastStyle: toastStyle ?? this.toastStyle,
  );
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
      toastStyle.hashCode;
}
mixin _$FToastStyleFunctions on Diagnosticable implements FTransformable {
  Duration get enterExitDuration;
  Curve get enterCurve;
  Curve get exitCurve;
  double get entranceExitOpacity;
  Duration get transitionDuration;
  Curve get transitionCurve;
  BoxConstraints get constraints;
  BoxDecoration get decoration;
  EdgeInsetsGeometry get padding;
  IconThemeData get iconStyle;
  double get iconSpacing;
  TextStyle get titleTextStyle;
  double get titleSpacing;
  TextStyle get descriptionTextStyle;
  double get suffixSpacing;

  /// Returns a copy of this [FToastStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FToastStyle copyWith({
    Duration? enterExitDuration,
    Curve? enterCurve,
    Curve? exitCurve,
    double? entranceExitOpacity,
    Duration? transitionDuration,
    Curve? transitionCurve,
    BoxConstraints? constraints,
    BoxDecoration? decoration,
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
    constraints: constraints ?? this.constraints,
    decoration: decoration ?? this.decoration,
    padding: padding ?? this.padding,
    iconStyle: iconStyle ?? this.iconStyle,
    iconSpacing: iconSpacing ?? this.iconSpacing,
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    titleSpacing: titleSpacing ?? this.titleSpacing,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    suffixSpacing: suffixSpacing ?? this.suffixSpacing,
  );
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
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('decoration', decoration))
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
          constraints == other.constraints &&
          decoration == other.decoration &&
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
      constraints.hashCode ^
      decoration.hashCode ^
      padding.hashCode ^
      iconStyle.hashCode ^
      iconSpacing.hashCode ^
      titleTextStyle.hashCode ^
      titleSpacing.hashCode ^
      descriptionTextStyle.hashCode ^
      suffixSpacing.hashCode;
}

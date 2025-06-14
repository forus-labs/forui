// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'accordion.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FAccordionStyleFunctions on Diagnosticable implements FTransformable {
  FWidgetStateMap<TextStyle> get titleTextStyle;
  TextStyle get childTextStyle;
  EdgeInsetsGeometry get titlePadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<IconThemeData> get iconStyle;
  Duration get expandDuration;
  Curve get expandCurve;
  Duration get collapseDuration;
  Curve get collapseCurve;
  FFocusedOutlineStyle get focusedOutlineStyle;
  FDividerStyle get dividerStyle;
  FTappableStyle get tappableStyle;

  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FAccordionStyle copyWith({
    FWidgetStateMap<TextStyle>? titleTextStyle,
    TextStyle? childTextStyle,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<IconThemeData>? iconStyle,
    Duration? expandDuration,
    Curve? expandCurve,
    Duration? collapseDuration,
    Curve? collapseCurve,
    FFocusedOutlineStyle? focusedOutlineStyle,
    FDividerStyle? dividerStyle,
    FTappableStyle? tappableStyle,
  }) => FAccordionStyle(
    titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    childTextStyle: childTextStyle ?? this.childTextStyle,
    titlePadding: titlePadding ?? this.titlePadding,
    childPadding: childPadding ?? this.childPadding,
    iconStyle: iconStyle ?? this.iconStyle,
    expandDuration: expandDuration ?? this.expandDuration,
    expandCurve: expandCurve ?? this.expandCurve,
    collapseDuration: collapseDuration ?? this.collapseDuration,
    collapseCurve: collapseCurve ?? this.collapseCurve,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
    dividerStyle: dividerStyle ?? this.dividerStyle,
    tappableStyle: tappableStyle ?? this.tappableStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('titleTextStyle', titleTextStyle))
      ..add(DiagnosticsProperty('childTextStyle', childTextStyle))
      ..add(DiagnosticsProperty('titlePadding', titlePadding))
      ..add(DiagnosticsProperty('childPadding', childPadding))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('expandDuration', expandDuration))
      ..add(DiagnosticsProperty('expandCurve', expandCurve))
      ..add(DiagnosticsProperty('collapseDuration', collapseDuration))
      ..add(DiagnosticsProperty('collapseCurve', collapseCurve))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('dividerStyle', dividerStyle))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
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
          expandDuration == other.expandDuration &&
          expandCurve == other.expandCurve &&
          collapseDuration == other.collapseDuration &&
          collapseCurve == other.collapseCurve &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          dividerStyle == other.dividerStyle &&
          tappableStyle == other.tappableStyle);
  @override
  int get hashCode =>
      titleTextStyle.hashCode ^
      childTextStyle.hashCode ^
      titlePadding.hashCode ^
      childPadding.hashCode ^
      iconStyle.hashCode ^
      expandDuration.hashCode ^
      expandCurve.hashCode ^
      collapseDuration.hashCode ^
      collapseCurve.hashCode ^
      focusedOutlineStyle.hashCode ^
      dividerStyle.hashCode ^
      tappableStyle.hashCode;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'accordion.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FAccordionStyleCopyWith on FAccordionStyle {
  /// Returns a copy of this [FAccordionStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [titleTextStyle]
  /// The title's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  ///
  /// # [childTextStyle]
  /// The child's default text style.
  ///
  /// # [titlePadding]
  /// The padding around the title. Defaults to `EdgeInsets.symmetric(vertical: 15)`.
  ///
  /// # [childPadding]
  /// The padding around the content. Defaults to `EdgeInsets.only(bottom: 15)`.
  ///
  /// # [iconStyle]
  /// The icon's style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.tappable}
  ///
  /// # [expandDuration]
  /// The expand animation's duration. Defaults to 200ms.
  ///
  /// # [expandCurve]
  /// The expand animation's curve. Defaults to [Curves.easeOutCubic].
  ///
  /// # [collapseDuration]
  /// The collapse animation's duration. Defaults to 150ms.
  ///
  /// # [collapseCurve]
  /// The collapse animation's curve. Defaults to [Curves.easeInCubic].
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  /// # [dividerStyle]
  /// The divider's color.
  ///
  /// # [tappableStyle]
  /// The tappable's style.
  ///
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
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
    FDividerStyle Function(FDividerStyle)? dividerStyle,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
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
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    dividerStyle: dividerStyle != null ? dividerStyle(this.dividerStyle) : this.dividerStyle,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );
}

mixin _$FAccordionStyleFunctions on Diagnosticable {
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

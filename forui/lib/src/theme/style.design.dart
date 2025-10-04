// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FStyleTransformations on FStyle {
  /// Returns a copy of this [FStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FStyle.formFieldStyle] - The style for the form field.
  /// * [FStyle.focusedOutlineStyle] - The focused outline style.
  /// * [FStyle.iconStyle] - The icon style.
  /// * [FStyle.borderRadius] - The border radius.
  /// * [FStyle.borderWidth] - The border width.
  /// * [FStyle.pagePadding] - The page's padding.
  /// * [FStyle.shadow] - The shadow used for elevated widgets.
  /// * [FStyle.tappableStyle] - The tappable style.
  @useResult
  FStyle copyWith({
    FFormFieldStyle Function(FFormFieldStyle style)? formFieldStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle style)? focusedOutlineStyle,
    IconThemeData? iconStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
    List<BoxShadow>? shadow,
    FTappableStyle Function(FTappableStyle style)? tappableStyle,
  }) => FStyle(
    formFieldStyle: formFieldStyle != null ? formFieldStyle(this.formFieldStyle) : this.formFieldStyle,
    focusedOutlineStyle: focusedOutlineStyle != null
        ? focusedOutlineStyle(this.focusedOutlineStyle)
        : this.focusedOutlineStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    borderRadius: borderRadius ?? this.borderRadius,
    borderWidth: borderWidth ?? this.borderWidth,
    pagePadding: pagePadding ?? this.pagePadding,
    shadow: shadow ?? this.shadow,
    tappableStyle: tappableStyle != null ? tappableStyle(this.tappableStyle) : this.tappableStyle,
  );

  /// Linearly interpolate between this and another [FStyle] using the given factor [t].
  @useResult
  FStyle lerp(FStyle other, double t) => FStyle(
    formFieldStyle: formFieldStyle.lerp(other.formFieldStyle, t),
    focusedOutlineStyle: focusedOutlineStyle.lerp(other.focusedOutlineStyle, t),
    iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ?? borderRadius,
    borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
    pagePadding: EdgeInsets.lerp(pagePadding, other.pagePadding, t) ?? pagePadding,
    shadow: BoxShadow.lerpList(shadow, other.shadow, t) ?? shadow,
    tappableStyle: tappableStyle.lerp(other.tappableStyle, t),
  );
}

mixin _$FStyleFunctions on Diagnosticable {
  FFormFieldStyle get formFieldStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  IconThemeData get iconStyle;
  BorderRadius get borderRadius;
  double get borderWidth;
  EdgeInsets get pagePadding;
  List<BoxShadow> get shadow;
  FTappableStyle get tappableStyle;

  /// Returns itself.
  ///
  /// Allows [FStyle] to replace functions that accept and return a [FStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FStyle Function(FStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FStyle(...));
  /// ```
  @useResult
  FStyle call(Object? _) => this as FStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('formFieldStyle', formFieldStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, level: DiagnosticLevel.debug))
      ..add(DoubleProperty('borderWidth', borderWidth, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('pagePadding', pagePadding, level: DiagnosticLevel.debug))
      ..add(IterableProperty('shadow', shadow, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle, level: DiagnosticLevel.debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FStyle &&
          formFieldStyle == other.formFieldStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          iconStyle == other.iconStyle &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          pagePadding == other.pagePadding &&
          listEquals(shadow, other.shadow) &&
          tappableStyle == other.tappableStyle);

  @override
  int get hashCode =>
      formFieldStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      iconStyle.hashCode ^
      borderRadius.hashCode ^
      borderWidth.hashCode ^
      pagePadding.hashCode ^
      const ListEquality().hash(shadow) ^
      tappableStyle.hashCode;
}

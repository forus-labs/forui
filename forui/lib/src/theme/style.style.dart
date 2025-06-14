// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FStyleFunctions on Diagnosticable implements FTransformable {
  FFormFieldStyle get formFieldStyle;
  FFocusedOutlineStyle get focusedOutlineStyle;
  IconThemeData get iconStyle;
  BorderRadius get borderRadius;
  double get borderWidth;
  EdgeInsets get pagePadding;
  List<BoxShadow> get shadow;
  FTappableStyle get tappableStyle;

  /// Returns a copy of this [FStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FStyle copyWith({
    FFormFieldStyle? formFieldStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
    IconThemeData? iconStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
    List<BoxShadow>? shadow,
    FTappableStyle? tappableStyle,
  }) => FStyle(
    formFieldStyle: formFieldStyle ?? this.formFieldStyle,
    focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
    iconStyle: iconStyle ?? this.iconStyle,
    borderRadius: borderRadius ?? this.borderRadius,
    borderWidth: borderWidth ?? this.borderWidth,
    pagePadding: pagePadding ?? this.pagePadding,
    shadow: shadow ?? this.shadow,
    tappableStyle: tappableStyle ?? this.tappableStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('formFieldStyle', formFieldStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty('pagePadding', pagePadding))
      ..add(IterableProperty('shadow', shadow))
      ..add(DiagnosticsProperty('tappableStyle', tappableStyle));
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

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FStyleCopyWith on FStyle {
  /// Returns a copy of this [FStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [formFieldStyle]
  /// The style for the form field.
  ///
  /// # [focusedOutlineStyle]
  /// The focused outline style.
  ///
  /// # [iconStyle]
  /// The icon style.
  ///
  /// # [borderRadius]
  /// The border radius. Defaults to `FLerpBorderRadius.circular(8)`.
  ///
  /// # [borderWidth]
  /// The border width. Defaults to 1.
  ///
  /// # [pagePadding]
  /// The page's padding. Defaults to `EdgeInsets.symmetric(vertical: 8, horizontal: 12)`.
  ///
  /// # [shadow]
  /// The shadow used for elevated widgets.
  ///
  /// # [tappableStyle]
  /// The tappable style.
  ///
  @useResult
  FStyle copyWith({
    FFormFieldStyle Function(FFormFieldStyle)? formFieldStyle,
    FFocusedOutlineStyle Function(FFocusedOutlineStyle)? focusedOutlineStyle,
    IconThemeData? iconStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
    List<BoxShadow>? shadow,
    FTappableStyle Function(FTappableStyle)? tappableStyle,
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

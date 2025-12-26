// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_group.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FSelectGroupStyleTransformations on FSelectGroupStyle {
  /// Returns a copy of this [FSelectGroupStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FSelectGroupStyle.checkboxStyle] - The [FCheckbox]'s style.
  /// * [FSelectGroupStyle.radioStyle] - The [FRadio]'s style.
  /// * [FSelectGroupStyle.itemPadding] - The padding surrounding an item.
  /// * [FSelectGroupStyle.labelPadding] - The label's padding.
  /// * [FSelectGroupStyle.descriptionPadding] - The description's padding.
  /// * [FSelectGroupStyle.errorPadding] - The error's padding.
  /// * [FSelectGroupStyle.childPadding] - The child's padding.
  /// * [FSelectGroupStyle.labelTextStyle] - The label's text style.
  /// * [FSelectGroupStyle.descriptionTextStyle] - The description's text style.
  /// * [FSelectGroupStyle.errorTextStyle] - The error's text style.
  @useResult
  FSelectGroupStyle copyWith({
    FCheckboxStyle Function(FCheckboxStyle style)? checkboxStyle,
    FRadioStyle Function(FRadioStyle style)? radioStyle,
    EdgeInsetsGeometry? itemPadding,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => .new(
    checkboxStyle: checkboxStyle != null ? checkboxStyle(this.checkboxStyle) : this.checkboxStyle,
    radioStyle: radioStyle != null ? radioStyle(this.radioStyle) : this.radioStyle,
    itemPadding: itemPadding ?? this.itemPadding,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );

  /// Linearly interpolate between this and another [FSelectGroupStyle] using the given factor [t].
  @useResult
  FSelectGroupStyle lerp(FSelectGroupStyle other, double t) => .new(
    checkboxStyle: checkboxStyle.lerp(other.checkboxStyle, t),
    radioStyle: radioStyle.lerp(other.radioStyle, t),
    itemPadding: .lerp(itemPadding, other.itemPadding, t) ?? itemPadding,
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FSelectGroupStyleFunctions on Diagnosticable {
  FCheckboxStyle get checkboxStyle;
  FRadioStyle get radioStyle;
  EdgeInsetsGeometry get itemPadding;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns itself.
  ///
  /// Allows [FSelectGroupStyle] to replace functions that accept and return a [FSelectGroupStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FSelectGroupStyle Function(FSelectGroupStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FSelectGroupStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FSelectGroupStyle(...));
  /// ```
  @useResult
  FSelectGroupStyle call(Object? _) => this as FSelectGroupStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle, level: .debug))
      ..add(DiagnosticsProperty('radioStyle', radioStyle, level: .debug))
      ..add(DiagnosticsProperty('itemPadding', itemPadding, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectGroupStyle &&
          runtimeType == other.runtimeType &&
          checkboxStyle == other.checkboxStyle &&
          radioStyle == other.radioStyle &&
          itemPadding == other.itemPadding &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);

  @override
  int get hashCode =>
      checkboxStyle.hashCode ^
      radioStyle.hashCode ^
      itemPadding.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

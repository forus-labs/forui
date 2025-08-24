// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'select_group.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FSelectGroupStyleCopyWith on FSelectGroupStyle {
  /// Returns a copy of this [FSelectGroupStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [checkboxStyle]
  /// The [FCheckbox]'s style.
  ///
  /// # [radioStyle]
  /// The [FRadio]'s style.
  ///
  /// # [itemPadding]
  /// The padding surrounding an item. Defaults to `EdgeInsets.symmetric(vertical: 2)`.
  ///
  /// # [labelPadding]
  /// The label's padding.
  ///
  /// # [descriptionPadding]
  /// The description's padding.
  ///
  /// # [errorPadding]
  /// The error's padding.
  ///
  /// # [childPadding]
  /// The child's padding.
  ///
  /// # [labelTextStyle]
  /// The label's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [descriptionTextStyle]
  /// The description's text style.
  ///
  /// {@macro forui.foundation.doc_templates.WidgetStates.form}
  ///
  /// # [errorTextStyle]
  /// The error's text style.
  ///
  @useResult
  FSelectGroupStyle copyWith({
    FCheckboxStyle Function(FCheckboxStyle)? checkboxStyle,
    FRadioStyle Function(FRadioStyle)? radioStyle,
    EdgeInsetsGeometry? itemPadding,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FSelectGroupStyle(
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
      ..add(DiagnosticsProperty('checkboxStyle', checkboxStyle))
      ..add(DiagnosticsProperty('radioStyle', radioStyle))
      ..add(DiagnosticsProperty('itemPadding', itemPadding))
      ..add(DiagnosticsProperty('labelPadding', labelPadding))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding))
      ..add(DiagnosticsProperty('errorPadding', errorPadding))
      ..add(DiagnosticsProperty('childPadding', childPadding))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FSelectGroupStyle &&
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

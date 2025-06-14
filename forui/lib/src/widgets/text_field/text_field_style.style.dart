// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'text_field_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

mixin _$FTextFieldStyleFunctions on Diagnosticable implements FTransformable {
  Brightness get keyboardAppearance;
  Color get cursorColor;
  Color? get fillColor;
  bool get filled;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get clearButtonPadding;
  EdgeInsets get scrollPadding;
  FButtonStyle get clearButtonStyle;
  FWidgetStateMap<TextStyle> get contentTextStyle;
  FWidgetStateMap<TextStyle> get hintTextStyle;
  FWidgetStateMap<TextStyle> get counterTextStyle;
  FWidgetStateMap<InputBorder> get border;
  EdgeInsetsGeometry get labelPadding;
  EdgeInsetsGeometry get descriptionPadding;
  EdgeInsetsGeometry get errorPadding;
  EdgeInsetsGeometry get childPadding;
  FWidgetStateMap<TextStyle> get labelTextStyle;
  FWidgetStateMap<TextStyle> get descriptionTextStyle;
  TextStyle get errorTextStyle;

  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  @useResult
  FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    Color? fillColor,
    bool? filled,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? clearButtonPadding,
    EdgeInsets? scrollPadding,
    FButtonStyle? clearButtonStyle,
    FWidgetStateMap<TextStyle>? contentTextStyle,
    FWidgetStateMap<TextStyle>? hintTextStyle,
    FWidgetStateMap<TextStyle>? counterTextStyle,
    FWidgetStateMap<InputBorder>? border,
    EdgeInsetsGeometry? labelPadding,
    EdgeInsetsGeometry? descriptionPadding,
    EdgeInsetsGeometry? errorPadding,
    EdgeInsetsGeometry? childPadding,
    FWidgetStateMap<TextStyle>? labelTextStyle,
    FWidgetStateMap<TextStyle>? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) => FTextFieldStyle(
    keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
    cursorColor: cursorColor ?? this.cursorColor,
    fillColor: fillColor ?? this.fillColor,
    filled: filled ?? this.filled,
    contentPadding: contentPadding ?? this.contentPadding,
    clearButtonPadding: clearButtonPadding ?? this.clearButtonPadding,
    scrollPadding: scrollPadding ?? this.scrollPadding,
    clearButtonStyle: clearButtonStyle ?? this.clearButtonStyle,
    contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    hintTextStyle: hintTextStyle ?? this.hintTextStyle,
    counterTextStyle: counterTextStyle ?? this.counterTextStyle,
    border: border ?? this.border,
    labelPadding: labelPadding ?? this.labelPadding,
    descriptionPadding: descriptionPadding ?? this.descriptionPadding,
    errorPadding: errorPadding ?? this.errorPadding,
    childPadding: childPadding ?? this.childPadding,
    labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
    errorTextStyle: errorTextStyle ?? this.errorTextStyle,
  );
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance))
      ..add(ColorProperty('cursorColor', cursorColor))
      ..add(ColorProperty('fillColor', fillColor))
      ..add(FlagProperty('filled', value: filled, ifTrue: 'filled'))
      ..add(DiagnosticsProperty('contentPadding', contentPadding))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle))
      ..add(DiagnosticsProperty('counterTextStyle', counterTextStyle))
      ..add(DiagnosticsProperty('border', border))
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
      (other is FTextFieldStyle &&
          keyboardAppearance == other.keyboardAppearance &&
          cursorColor == other.cursorColor &&
          fillColor == other.fillColor &&
          filled == other.filled &&
          contentPadding == other.contentPadding &&
          clearButtonPadding == other.clearButtonPadding &&
          scrollPadding == other.scrollPadding &&
          clearButtonStyle == other.clearButtonStyle &&
          contentTextStyle == other.contentTextStyle &&
          hintTextStyle == other.hintTextStyle &&
          counterTextStyle == other.counterTextStyle &&
          border == other.border &&
          labelPadding == other.labelPadding &&
          descriptionPadding == other.descriptionPadding &&
          errorPadding == other.errorPadding &&
          childPadding == other.childPadding &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle);
  @override
  int get hashCode =>
      keyboardAppearance.hashCode ^
      cursorColor.hashCode ^
      fillColor.hashCode ^
      filled.hashCode ^
      contentPadding.hashCode ^
      clearButtonPadding.hashCode ^
      scrollPadding.hashCode ^
      clearButtonStyle.hashCode ^
      contentTextStyle.hashCode ^
      hintTextStyle.hashCode ^
      counterTextStyle.hashCode ^
      border.hashCode ^
      labelPadding.hashCode ^
      descriptionPadding.hashCode ^
      errorPadding.hashCode ^
      childPadding.hashCode ^
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      errorTextStyle.hashCode;
}

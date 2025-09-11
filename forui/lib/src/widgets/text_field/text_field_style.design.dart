// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'text_field_style.dart';

// **************************************************************************
// DesignGenerator
// **************************************************************************

/// Provides [copyWith] and [lerp] methods.
extension $FTextFieldStyleTransformations on FTextFieldStyle {
  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  ///
  /// Consider [using the CLI to generate a style](https://forui.dev/docs/themes#individual-widget-styles).
  ///
  /// ## Parameters
  /// * [FTextFieldStyle.keyboardAppearance] - The appearance of the keyboard.
  /// * [FTextFieldStyle.cursorColor] - The color of the cursor.
  /// * [FTextFieldStyle.fillColor] - The base fill color of the decoration's container colors.
  /// * [FTextFieldStyle.filled] - If true the decoration's container is filled with [fillColor].
  /// * [FTextFieldStyle.contentPadding] - The padding surrounding this text field's content.
  /// * [FTextFieldStyle.clearButtonPadding] - The padding surrounding the clear button.
  /// * [FTextFieldStyle.obscureButtonPadding] - The padding surrounding the obscured text toggle.
  /// * [FTextFieldStyle.scrollPadding] - Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  /// * [FTextFieldStyle.clearButtonStyle] - The clear button's style when [FTextField.
  /// * [FTextFieldStyle.obscureButtonStyle] - The obscured text toggle's style when enabled in [FTextField.
  /// * [FTextFieldStyle.contentTextStyle] - The content's [TextStyle].
  /// * [FTextFieldStyle.hintTextStyle] - The hint's [TextStyle].
  /// * [FTextFieldStyle.counterTextStyle] - The counter's [TextStyle].
  /// * [FTextFieldStyle.border] - The border.
  /// * [FTextFieldStyle.labelPadding] - The label's padding.
  /// * [FTextFieldStyle.descriptionPadding] - The description's padding.
  /// * [FTextFieldStyle.errorPadding] - The error's padding.
  /// * [FTextFieldStyle.childPadding] - The child's padding.
  /// * [FTextFieldStyle.labelTextStyle] - The label's text style.
  /// * [FTextFieldStyle.descriptionTextStyle] - The description's text style.
  /// * [FTextFieldStyle.errorTextStyle] - The error's text style.
  @useResult
  FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    Color? fillColor,
    bool? filled,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? clearButtonPadding,
    EdgeInsetsGeometry? obscureButtonPadding,
    EdgeInsets? scrollPadding,
    FButtonStyle Function(FButtonStyle style)? clearButtonStyle,
    FButtonStyle Function(FButtonStyle style)? obscureButtonStyle,
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
    obscureButtonPadding: obscureButtonPadding ?? this.obscureButtonPadding,
    scrollPadding: scrollPadding ?? this.scrollPadding,
    clearButtonStyle: clearButtonStyle != null ? clearButtonStyle(this.clearButtonStyle) : this.clearButtonStyle,
    obscureButtonStyle: obscureButtonStyle != null
        ? obscureButtonStyle(this.obscureButtonStyle)
        : this.obscureButtonStyle,
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

  /// Linearly interpolate between this and another [FTextFieldStyle] using the given factor [t].
  @useResult
  FTextFieldStyle lerp(FTextFieldStyle other, double t) => FTextFieldStyle(
    keyboardAppearance: t < 0.5 ? keyboardAppearance : other.keyboardAppearance,
    cursorColor: Color.lerp(cursorColor, other.cursorColor, t) ?? cursorColor,
    fillColor: Color.lerp(fillColor, other.fillColor, t) ?? fillColor,
    filled: t < 0.5 ? filled : other.filled,
    contentPadding: EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    clearButtonPadding: EdgeInsetsGeometry.lerp(clearButtonPadding, other.clearButtonPadding, t) ?? clearButtonPadding,
    obscureButtonPadding:
        EdgeInsetsGeometry.lerp(obscureButtonPadding, other.obscureButtonPadding, t) ?? obscureButtonPadding,
    scrollPadding: EdgeInsets.lerp(scrollPadding, other.scrollPadding, t) ?? scrollPadding,
    clearButtonStyle: clearButtonStyle.lerp(other.clearButtonStyle, t),
    obscureButtonStyle: obscureButtonStyle.lerp(other.obscureButtonStyle, t),
    contentTextStyle: FWidgetStateMap.lerpTextStyle(contentTextStyle, other.contentTextStyle, t),
    hintTextStyle: FWidgetStateMap.lerpTextStyle(hintTextStyle, other.hintTextStyle, t),
    counterTextStyle: FWidgetStateMap.lerpTextStyle(counterTextStyle, other.counterTextStyle, t),
    border: t < 0.5 ? border : other.border,
    labelPadding: EdgeInsetsGeometry.lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: EdgeInsetsGeometry.lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: EdgeInsetsGeometry.lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: EdgeInsetsGeometry.lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: FWidgetStateMap.lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: FWidgetStateMap.lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
  );
}

mixin _$FTextFieldStyleFunctions on Diagnosticable {
  Brightness get keyboardAppearance;
  Color get cursorColor;
  Color? get fillColor;
  bool get filled;
  EdgeInsetsGeometry get contentPadding;
  EdgeInsetsGeometry get clearButtonPadding;
  EdgeInsetsGeometry get obscureButtonPadding;
  EdgeInsets get scrollPadding;
  FButtonStyle get clearButtonStyle;
  FButtonStyle get obscureButtonStyle;
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

  /// Returns itself.
  ///
  /// Allows [FTextFieldStyle] to replace functions that accept and return a [FTextFieldStyle], such as a style's
  /// `copyWith(...)` function.
  ///
  /// ## Example
  ///
  /// Given:
  /// ```dart
  /// void copyWith(FTextFieldStyle Function(FTextFieldStyle) nestedStyle) {}
  /// ```
  ///
  /// The following:
  /// ```dart
  /// copyWith((style) => FTextFieldStyle(...));
  /// ```
  ///
  /// Can be replaced with:
  /// ```dart
  /// copyWith(FTextFieldStyle(...));
  /// ```
  @useResult
  FTextFieldStyle call(Object? _) => this as FTextFieldStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance, level: DiagnosticLevel.debug))
      ..add(ColorProperty('cursorColor', cursorColor, level: DiagnosticLevel.debug))
      ..add(ColorProperty('fillColor', fillColor, level: DiagnosticLevel.debug))
      ..add(FlagProperty('filled', value: filled, ifTrue: 'filled', level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('obscureButtonPadding', obscureButtonPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('obscureButtonStyle', obscureButtonStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('counterTextStyle', counterTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('border', border, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelPadding', labelPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionPadding', descriptionPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorPadding', errorPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('childPadding', childPadding, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty('errorTextStyle', errorTextStyle, level: DiagnosticLevel.debug));
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
          obscureButtonPadding == other.obscureButtonPadding &&
          scrollPadding == other.scrollPadding &&
          clearButtonStyle == other.clearButtonStyle &&
          obscureButtonStyle == other.obscureButtonStyle &&
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
      obscureButtonPadding.hashCode ^
      scrollPadding.hashCode ^
      clearButtonStyle.hashCode ^
      obscureButtonStyle.hashCode ^
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

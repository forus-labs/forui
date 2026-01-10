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
  /// * [FTextFieldStyle.iconStyle] - The prefix & suffix icon styles.
  /// * [FTextFieldStyle.clearButtonStyle] - The clear button's style when [FTextField.clearable] is true.
  /// * [FTextFieldStyle.obscureButtonStyle] - The obscured text toggle's style when enabled in [FTextField.password].
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
    FWidgetStateMap<IconThemeData>? iconStyle,
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
  }) => .new(
    keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
    cursorColor: cursorColor ?? this.cursorColor,
    fillColor: fillColor ?? this.fillColor,
    filled: filled ?? this.filled,
    contentPadding: contentPadding ?? this.contentPadding,
    clearButtonPadding: clearButtonPadding ?? this.clearButtonPadding,
    obscureButtonPadding: obscureButtonPadding ?? this.obscureButtonPadding,
    scrollPadding: scrollPadding ?? this.scrollPadding,
    iconStyle: iconStyle ?? this.iconStyle,
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
  FTextFieldStyle lerp(FTextFieldStyle other, double t) => .new(
    keyboardAppearance: t < 0.5 ? keyboardAppearance : other.keyboardAppearance,
    cursorColor: .lerp(cursorColor, other.cursorColor, t) ?? cursorColor,
    fillColor: .lerp(fillColor, other.fillColor, t) ?? fillColor,
    filled: t < 0.5 ? filled : other.filled,
    contentPadding: .lerp(contentPadding, other.contentPadding, t) ?? contentPadding,
    clearButtonPadding: .lerp(clearButtonPadding, other.clearButtonPadding, t) ?? clearButtonPadding,
    obscureButtonPadding: .lerp(obscureButtonPadding, other.obscureButtonPadding, t) ?? obscureButtonPadding,
    scrollPadding: .lerp(scrollPadding, other.scrollPadding, t) ?? scrollPadding,
    iconStyle: .lerpIconThemeData(iconStyle, other.iconStyle, t),
    clearButtonStyle: clearButtonStyle.lerp(other.clearButtonStyle, t),
    obscureButtonStyle: obscureButtonStyle.lerp(other.obscureButtonStyle, t),
    contentTextStyle: .lerpTextStyle(contentTextStyle, other.contentTextStyle, t),
    hintTextStyle: .lerpTextStyle(hintTextStyle, other.hintTextStyle, t),
    counterTextStyle: .lerpTextStyle(counterTextStyle, other.counterTextStyle, t),
    border: t < 0.5 ? border : other.border,
    labelPadding: .lerp(labelPadding, other.labelPadding, t) ?? labelPadding,
    descriptionPadding: .lerp(descriptionPadding, other.descriptionPadding, t) ?? descriptionPadding,
    errorPadding: .lerp(errorPadding, other.errorPadding, t) ?? errorPadding,
    childPadding: .lerp(childPadding, other.childPadding, t) ?? childPadding,
    labelTextStyle: .lerpTextStyle(labelTextStyle, other.labelTextStyle, t),
    descriptionTextStyle: .lerpTextStyle(descriptionTextStyle, other.descriptionTextStyle, t),
    errorTextStyle: .lerp(errorTextStyle, other.errorTextStyle, t) ?? errorTextStyle,
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
  FWidgetStateMap<IconThemeData> get iconStyle;
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
      ..add(EnumProperty('keyboardAppearance', keyboardAppearance, level: .debug))
      ..add(ColorProperty('cursorColor', cursorColor, level: .debug))
      ..add(ColorProperty('fillColor', fillColor, level: .debug))
      ..add(FlagProperty('filled', value: filled, ifTrue: 'filled', level: .debug))
      ..add(DiagnosticsProperty('contentPadding', contentPadding, level: .debug))
      ..add(DiagnosticsProperty('clearButtonPadding', clearButtonPadding, level: .debug))
      ..add(DiagnosticsProperty('obscureButtonPadding', obscureButtonPadding, level: .debug))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding, level: .debug))
      ..add(DiagnosticsProperty('iconStyle', iconStyle, level: .debug))
      ..add(DiagnosticsProperty('clearButtonStyle', clearButtonStyle, level: .debug))
      ..add(DiagnosticsProperty('obscureButtonStyle', obscureButtonStyle, level: .debug))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle, level: .debug))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle, level: .debug))
      ..add(DiagnosticsProperty('counterTextStyle', counterTextStyle, level: .debug))
      ..add(DiagnosticsProperty('border', border, level: .debug));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FTextFieldStyle &&
          runtimeType == other.runtimeType &&
          keyboardAppearance == other.keyboardAppearance &&
          cursorColor == other.cursorColor &&
          fillColor == other.fillColor &&
          filled == other.filled &&
          contentPadding == other.contentPadding &&
          clearButtonPadding == other.clearButtonPadding &&
          obscureButtonPadding == other.obscureButtonPadding &&
          scrollPadding == other.scrollPadding &&
          iconStyle == other.iconStyle &&
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
      iconStyle.hashCode ^
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

// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format width=120
// coverage:ignore-file

part of 'text_field_style.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

/// Provides a `copyWith` method.
extension $FTextFieldStyleCopyWith on FTextFieldStyle {
  /// Returns a copy of this [FTextFieldStyle] with the given properties replaced.
  ///
  /// Where possible, it is **strongly** recommended to [use the CLI to generate a style](https://forui.dev/themes#customization)
  /// and directly modify the style.
  ///
  /// # [keyboardAppearance]
  /// The appearance of the keyboard. Defaults to [FColors.brightness].
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// # [cursorColor]
  /// The color of the cursor. Defaults to [CupertinoColors.activeBlue].
  ///
  /// The cursor indicates the current location of text insertion point in the field.
  ///
  /// # [fillColor]
  /// The base fill color of the decoration's container colors.
  ///
  /// # [filled]
  /// If true the decoration's container is filled with [fillColor]. Defaults to false.
  ///
  /// # [contentPadding]
  /// The padding surrounding this text field's content.
  ///
  /// Defaults to `const EdgeInsets.symmetric(horizontal: 14, vertical: 14)`.
  ///
  /// # [clearButtonPadding]
  /// The padding surrounding the clear button. Defaults to `EdgeInsetsDirectional.only(end: 2)`.
  ///
  /// # [scrollPadding]
  /// Configures padding to edges surrounding a [Scrollable] when this text field scrolls into view.
  ///
  /// Defaults to `EdgeInsets.all(20)`.
  ///
  /// When this widget receives focus and is not completely visible (for example scrolled partially off the screen or
  /// overlapped by the keyboard) then it will attempt to make itself visible by scrolling a surrounding [Scrollable],
  /// if one is present. This value controls how far from the edges of a [Scrollable] the TextField will be positioned
  /// after the scroll.
  ///
  /// # [clearButtonStyle]
  /// The clear button's style when [FTextField.clearable] is true.
  ///
  /// # [contentTextStyle]
  /// The content's [TextStyle].
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  ///
  /// # [hintTextStyle]
  /// The hint's [TextStyle].
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  ///
  /// # [counterTextStyle]
  /// The counter's [TextStyle].
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
  ///
  /// # [border]
  /// The border.
  ///
  /// The supported states are:
  /// * [WidgetState.disabled]
  /// * [WidgetState.error]
  /// * [WidgetState.focused]
  /// * [WidgetState.hovered]
  /// * [WidgetState.pressed]
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
  FTextFieldStyle copyWith({
    Brightness? keyboardAppearance,
    Color? cursorColor,
    Color? fillColor,
    bool? filled,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? clearButtonPadding,
    EdgeInsets? scrollPadding,
    FButtonStyle Function(FButtonStyle)? clearButtonStyle,
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
    clearButtonStyle: clearButtonStyle != null ? clearButtonStyle(this.clearButtonStyle) : this.clearButtonStyle,
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
}

mixin _$FTextFieldStyleFunctions on Diagnosticable {
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

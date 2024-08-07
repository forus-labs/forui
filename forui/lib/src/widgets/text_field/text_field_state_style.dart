part of 'text_field.dart';

/// A [FTextField] state's style.
sealed class FTextFieldStateStyle with Diagnosticable {
  /// The label's [TextStyle].
  final TextStyle labelTextStyle;

  /// The content's [TextStyle].
  final TextStyle contentTextStyle;

  /// The hint's [TextStyle].
  final TextStyle hintTextStyle;

  /// The help/error's [TextStyle].
  final TextStyle descriptionTextStyle;

  /// The border's color when focused.
  final FTextFieldBorderStyle focusedStyle;

  /// The border's style when unfocused.
  final FTextFieldBorderStyle unfocusedStyle;

  /// Creates a [FTextFieldStateStyle].
  FTextFieldStateStyle({
    required this.labelTextStyle,
    required this.contentTextStyle,
    required this.hintTextStyle,
    required this.descriptionTextStyle,
    required this.focusedStyle,
    required this.unfocusedStyle,
  });

  /// Creates a [FTextFieldStateStyle] that inherits its properties.
  FTextFieldStateStyle.inherit({
    required Color contentColor,
    required Color hintColor,
    required Color focusedBorderColor,
    required Color unfocusedBorderColor,
    required FFormFieldStateStyle formFieldStateStyle,
    required FTypography typography,
    required FStyle style,
  })  : labelTextStyle = formFieldStateStyle.labelTextStyle,
        contentTextStyle = typography.sm.copyWith(
          fontFamily: typography.defaultFontFamily,
          color: contentColor,
        ),
        hintTextStyle = typography.sm.copyWith(
          fontFamily: typography.defaultFontFamily,
          color: hintColor,
        ),
        descriptionTextStyle = formFieldStateStyle.descriptionTextStyle,
        focusedStyle = FTextFieldBorderStyle.inherit(color: focusedBorderColor, style: style),
        unfocusedStyle = FTextFieldBorderStyle.inherit(color: unfocusedBorderColor, style: style);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('focusedStyle', focusedStyle))
      ..add(DiagnosticsProperty('unfocusedStyle', unfocusedStyle));
  }
}

/// A [FTextField] normal state's style.
final class FTextFieldNormalStyle extends FTextFieldStateStyle {
  /// Creates a [FTextFieldNormalStyle].
  FTextFieldNormalStyle({
    required super.labelTextStyle,
    required super.contentTextStyle,
    required super.hintTextStyle,
    required super.descriptionTextStyle,
    required super.focusedStyle,
    required super.unfocusedStyle,
  });

  /// Creates a [FTextFieldNormalStyle] that inherits its properties.
  FTextFieldNormalStyle.inherit({
    required FFormFieldNormalStyle formFieldNormaStyle,
    required super.contentColor,
    required super.hintColor,
    required super.focusedBorderColor,
    required super.unfocusedBorderColor,
    required super.typography,
    required super.style,
  }) : super.inherit(formFieldStateStyle: formFieldNormaStyle);

  /// Returns a copy of this [FTextFieldStateStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FTextFieldNormalStyle(
  ///   labelTextStyle: ...,
  ///   contentTextStyle: ...,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   contentTextStyle: ...,
  /// );
  ///
  /// print(style.labelTextStyle == copy.labelTextStyle); // true
  /// print(style.contentTextStyle == copy.contentTextStyle); // false
  /// ```
  @useResult
  FTextFieldNormalStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? descriptionTextStyle,
    FTextFieldBorderStyle? focusedStyle,
    FTextFieldBorderStyle? unfocusedStyle,
  }) =>
      FTextFieldNormalStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
        hintTextStyle: hintTextStyle ?? this.hintTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        focusedStyle: focusedStyle ?? this.focusedStyle,
        unfocusedStyle: unfocusedStyle ?? this.unfocusedStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldNormalStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          contentTextStyle == other.contentTextStyle &&
          hintTextStyle == other.hintTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          focusedStyle == other.focusedStyle &&
          unfocusedStyle == other.unfocusedStyle;

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      contentTextStyle.hashCode ^
      hintTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      focusedStyle.hashCode ^
      unfocusedStyle.hashCode;
}

/// A [FTextField] error state's style.
final class FTextFieldErrorStyle extends FTextFieldStateStyle {
  /// The error's [TextStyle].
  final TextStyle errorTextStyle;

  /// Creates a [FTextFieldErrorStyle].
  FTextFieldErrorStyle({
    required this.errorTextStyle,
    required super.labelTextStyle,
    required super.contentTextStyle,
    required super.hintTextStyle,
    required super.descriptionTextStyle,
    required super.focusedStyle,
    required super.unfocusedStyle,
  });

  /// Creates a [FTextFieldErrorStyle] that inherits its properties.
  FTextFieldErrorStyle.inherit({
    required FFormFieldErrorStyle formFieldErrorStyle,
    required super.contentColor,
    required super.hintColor,
    required super.focusedBorderColor,
    required super.unfocusedBorderColor,
    required super.typography,
    required super.style,
  })  : errorTextStyle = formFieldErrorStyle.errorTextStyle,
        super.inherit(formFieldStateStyle: formFieldErrorStyle);

  /// Returns a copy of this [FTextFieldStateStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FTextFieldErrorStyle(
  ///   labelTextStyle: ...,
  ///   contentTextStyle: ...,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(
  ///   contentTextStyle: ...,
  /// );
  ///
  /// print(style.labelTextStyle == copy.labelTextStyle); // true
  /// print(style.contentTextStyle == copy.contentTextStyle); // false
  /// ```
  @useResult
  FTextFieldErrorStyle copyWith({
    TextStyle? errorTextStyle,
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? descriptionTextStyle,
    FTextFieldBorderStyle? focusedStyle,
    FTextFieldBorderStyle? unfocusedStyle,
  }) =>
      FTextFieldErrorStyle(
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        contentTextStyle: contentTextStyle ?? this.contentTextStyle,
        hintTextStyle: hintTextStyle ?? this.hintTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        focusedStyle: focusedStyle ?? this.focusedStyle,
        unfocusedStyle: unfocusedStyle ?? this.unfocusedStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldErrorStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          contentTextStyle == other.contentTextStyle &&
          hintTextStyle == other.hintTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          focusedStyle == other.focusedStyle &&
          unfocusedStyle == other.unfocusedStyle &&
          errorTextStyle == other.errorTextStyle;

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      contentTextStyle.hashCode ^
      hintTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      focusedStyle.hashCode ^
      unfocusedStyle.hashCode ^
      errorTextStyle.hashCode;
}

/// A [FTextField] border's style.
final class FTextFieldBorderStyle with Diagnosticable {
  /// The border's color.
  final Color color;

  /// The border's width. Defaults to [FStyle.borderWidth].
  final double width;

  /// The border's width. Defaults to [FStyle.borderRadius].
  final BorderRadius radius;

  /// Creates a [FTextFieldBorderStyle].
  FTextFieldBorderStyle({
    required this.color,
    required this.width,
    required this.radius,
  });

  /// Creates a [FTextFieldBorderStyle] that inherits its properties from [style].
  FTextFieldBorderStyle.inherit({
    required this.color,
    required FStyle style,
  })  : width = style.borderWidth,
        radius = style.borderRadius;

  /// Returns a copy of this border style but with the given fields replaced with the new values.
  ///
  /// ```dart
  /// final style = FTextFieldBorderStyle(
  ///   color: Colors.black,
  ///   width: 1,
  /// );
  ///
  /// final copy = style.copyWith(
  ///   width: 2,
  /// );
  ///
  /// print(copy.color); // black
  /// print(copy.width); // 2
  /// ```
  @useResult
  FTextFieldBorderStyle copyWith({
    Color? color,
    double? width,
    BorderRadius? radius,
  }) =>
      FTextFieldBorderStyle(
        color: color ?? this.color,
        width: width ?? this.width,
        radius: radius ?? this.radius,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty('radius', radius));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldBorderStyle &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          width == other.width &&
          radius == other.radius;

  @override
  int get hashCode => color.hashCode ^ width.hashCode ^ radius.hashCode;
}

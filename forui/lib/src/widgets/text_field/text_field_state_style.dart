import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A [FTextField] state's style.
// ignore: avoid_implementing_value_types
class FTextFieldStateStyle with Diagnosticable implements FFormFieldStyle {
  /// The label's [TextStyle].
  @override
  final TextStyle labelTextStyle;

  /// The help/error's [TextStyle].
  @override
  final TextStyle descriptionTextStyle;

  /// The content's [TextStyle].
  final TextStyle contentTextStyle;

  /// The hint's [TextStyle].
  final TextStyle hintTextStyle;

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
    required FFormFieldStyle formFieldStyle,
    required FTypography typography,
    required FStyle style,
  }) : this(
          labelTextStyle: formFieldStyle.labelTextStyle,
          contentTextStyle: typography.sm.copyWith(
            fontFamily: typography.defaultFontFamily,
            color: contentColor,
          ),
          hintTextStyle: typography.sm.copyWith(
            fontFamily: typography.defaultFontFamily,
            color: hintColor,
          ),
          descriptionTextStyle: formFieldStyle.descriptionTextStyle,
          focusedStyle: FTextFieldBorderStyle.inherit(color: focusedBorderColor, style: style),
          unfocusedStyle: FTextFieldBorderStyle.inherit(color: unfocusedBorderColor, style: style),
        );

  /// Returns a copy of this [FTextFieldStateStyle] with the given properties replaced.
  @override
  @useResult
  FTextFieldStateStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? contentTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? descriptionTextStyle,
    FTextFieldBorderStyle? focusedStyle,
    FTextFieldBorderStyle? unfocusedStyle,
  }) =>
      FTextFieldStateStyle(
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
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('contentTextStyle', contentTextStyle))
      ..add(DiagnosticsProperty('hintTextStyle', hintTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle))
      ..add(DiagnosticsProperty('focusedStyle', focusedStyle))
      ..add(DiagnosticsProperty('unfocusedStyle', unfocusedStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTextFieldStateStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          contentTextStyle == other.contentTextStyle &&
          hintTextStyle == other.hintTextStyle &&
          focusedStyle == other.focusedStyle &&
          unfocusedStyle == other.unfocusedStyle;

  @override
  int get hashCode =>
      labelTextStyle.hashCode ^
      descriptionTextStyle.hashCode ^
      contentTextStyle.hashCode ^
      hintTextStyle.hashCode ^
      focusedStyle.hashCode ^
      unfocusedStyle.hashCode;
}

/// A [FTextField] error state's style.
// ignore: avoid_implementing_value_types
final class FTextFieldErrorStyle extends FTextFieldStateStyle implements FFormFieldErrorStyle {
  /// The error's [TextStyle].
  @override
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
        super.inherit(formFieldStyle: formFieldErrorStyle);

  /// Returns a copy of this [FTextFieldStateStyle] with the given properties replaced.
  @override
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
    required Color color,
    required FStyle style,
  }) : this(
          color: color,
          width: style.borderWidth,
          radius: style.borderRadius,
        );

  /// Returns a copy of this border style but with the given fields replaced with the new values.
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

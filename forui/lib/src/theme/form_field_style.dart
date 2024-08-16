import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A form field's style.
final class FFormFieldStyle with Diagnosticable {
  /// The style for the form field when it is enabled.
  final FFormFieldNormalStyle enabledStyle;

  /// The style for the form field when it is disabled.
  final FFormFieldNormalStyle disabledStyle;

  /// The style for the form field when it has an error.
  final FFormFieldErrorStyle errorStyle;

  /// Creates a [FFormFieldStyle].
  FFormFieldStyle({
    required this.enabledStyle,
    required this.disabledStyle,
    required this.errorStyle,
  });

  /// Creates a [FFormFieldStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FFormFieldStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
  })  : enabledStyle = FFormFieldNormalStyle.inherit(
          labelColor: colorScheme.primary,
          descriptionColor: colorScheme.mutedForeground,
          typography: typography,
        ),
        disabledStyle = FFormFieldNormalStyle.inherit(
          labelColor: colorScheme.primary.withOpacity(0.7),
          descriptionColor: colorScheme.mutedForeground.withOpacity(0.7),
          typography: typography,
        ),
        errorStyle = FFormFieldErrorStyle.inherit(
          labelColor: colorScheme.error,
          descriptionColor: colorScheme.mutedForeground,
          errorColor: colorScheme.error,
          typography: typography,
        );

  /// Returns a copy of this [FFormFieldStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FFormFieldStyle(
  ///   enabledStyle: ...,
  ///   disabledStyle: ...,
  /// );
  ///
  /// final copy = style.copyWith(disabledStyle: ...);
  ///
  /// print(style.enabledStyle == copy.enabledStyle); // true
  /// print(style.disabledStyle == copy.disabledStyle); // false
  /// ```
  @useResult
  FFormFieldStyle copyWith({
    FFormFieldNormalStyle? enabledStyle,
    FFormFieldNormalStyle? disabledStyle,
    FFormFieldErrorStyle? errorStyle,
  }) =>
      FFormFieldStyle(
        enabledStyle: enabledStyle ?? this.enabledStyle,
        disabledStyle: disabledStyle ?? this.disabledStyle,
        errorStyle: errorStyle ?? this.errorStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledStyle', enabledStyle))
      ..add(DiagnosticsProperty('disabledStyle', disabledStyle))
      ..add(DiagnosticsProperty('errorStyle', errorStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FFormFieldStyle &&
          runtimeType == other.runtimeType &&
          enabledStyle == other.enabledStyle &&
          disabledStyle == other.disabledStyle &&
          errorStyle == other.errorStyle;

  @override
  int get hashCode => enabledStyle.hashCode ^ disabledStyle.hashCode ^ errorStyle.hashCode;
}

/// A form field state's style.
sealed class FFormFieldStateStyle with Diagnosticable {
  /// The label's text style.
  final TextStyle labelTextStyle;

  /// The description's text style.
  final TextStyle descriptionTextStyle;

  /// Creates a [FFormFieldStateStyle].
  const FFormFieldStateStyle({
    required this.labelTextStyle,
    required this.descriptionTextStyle,
  });

  /// Creates a [FFormFieldStateStyle] that inherits its properties from the given [FTypography].
  FFormFieldStateStyle.inherit({
    required Color labelColor,
    required Color descriptionColor,
    required FTypography typography,
  })  : labelTextStyle = typography.sm.copyWith(
          color: labelColor,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle = typography.sm.copyWith(color: descriptionColor);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle));
  }
}

/// A form field's normal style.
final class FFormFieldNormalStyle extends FFormFieldStateStyle {
  /// Creates a [FFormFieldNormalStyle].
  FFormFieldNormalStyle({required super.labelTextStyle, required super.descriptionTextStyle});

  /// Creates a [FFormFieldNormalStyle] that inherits its properties from the given arguments.
  FFormFieldNormalStyle.inherit({
    required super.labelColor,
    required super.descriptionColor,
    required super.typography,
  }) : super.inherit();

  /// Returns a copy of this [FFormFieldNormalStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FFormFieldNormalStyle(
  ///   labelTextStyle: TextStyle(fontSize: 16),
  ///   descriptionTextStyle: TextStyle(fontSize: 14),
  /// );
  ///
  /// final copy = style.copyWith(descriptionTextStyle: TextStyle(fontSize: 18));
  ///
  /// print(copy.labelTextStyle.fontSize); // 16
  /// print(copy.descriptionTextStyle.fontSize); // 18
  /// ```
  @useResult
  FFormFieldNormalStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
  }) =>
      FFormFieldNormalStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FFormFieldNormalStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode;
}

/// A form field's error style.
final class FFormFieldErrorStyle extends FFormFieldStateStyle {
  /// The error's text style.
  final TextStyle errorTextStyle;

  /// Creates a [FFormFieldErrorStyle].
  FFormFieldErrorStyle({
    required this.errorTextStyle,
    required super.labelTextStyle,
    required super.descriptionTextStyle,
  });

  /// Creates a [FFormFieldErrorStyle] that inherits its properties from the given arguments.
  FFormFieldErrorStyle.inherit({
    required Color errorColor,
    required super.labelColor,
    required super.descriptionColor,
    required super.typography,
  })  : errorTextStyle = typography.sm.copyWith(
          color: errorColor,
          fontWeight: FontWeight.w600,
        ),
        super.inherit();

  /// Returns a copy of this [FFormFieldErrorStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FFormFieldErrorStyle(
  ///   labelTextStyle: TextStyle(fontSize: 16),
  ///   descriptionTextStyle: TextStyle(fontSize: 14),
  ///   ...,
  /// );
  ///
  /// final copy = style.copyWith(descriptionTextStyle: TextStyle(fontSize: 18));
  ///
  /// print(copy.labelTextStyle.fontSize); // 16
  /// print(copy.descriptionTextStyle.fontSize); // 18
  /// ```
  @useResult
  FFormFieldErrorStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? errorTextStyle,
  }) =>
      FFormFieldErrorStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
        errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('errorTextStyle', errorTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FFormFieldErrorStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle &&
          errorTextStyle == other.errorTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode ^ errorTextStyle.hashCode;
}

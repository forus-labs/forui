import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/theme.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A set of miscellaneous properties that is part of a [FThemeData].
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding
/// properties of widget styles configured via `inherit(...)` constructors.
final class FStyle with Diagnosticable {
  /// The form field's style.
  final FFormFieldStyle formFieldStyle;

  /// The border radius. Defaults to `BorderRadius.circular(8)`.
  final BorderRadius borderRadius;

  /// The border width. Defaults to 1.
  final double borderWidth;

  /// The page's padding. Defaults to `EdgeInsets.symmetric(vertical: 8, horizontal: 12)`.
  final EdgeInsets pagePadding;

  /// Creates an [FStyle].
  ///
  /// **Note:**
  /// Unless you are creating a completely new style, modifying [FThemes]' predefined styles should be preferred.
  FStyle({
    required this.formFieldStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
    this.pagePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  });

  /// Creates an [FStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
  }) : this(
    formFieldStyle: FFormFieldStyle.inherit(
      colorScheme: colorScheme,
      typography: typography,
    ),
  );


  /// Returns a copy of this [FStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FStyle(
  ///   borderRadius: BorderRadius.circular(1),
  ///   borderWidth: 2,
  /// );
  ///
  /// final copy = style.copyWith(borderWidth: 3);
  ///
  /// print(copy.borderRadius); // BorderRadius.circular(1)
  /// print(copy.borderWidth); // 3
  /// ```
  @useResult
  FStyle copyWith({
    FFormFieldStyle? formFieldStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
  }) =>
      FStyle(
        formFieldStyle: formFieldStyle ?? this.formFieldStyle,
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        pagePadding: pagePadding ?? this.pagePadding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('formFieldStyle', formFieldStyle))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, defaultValue: BorderRadius.circular(8)))
      ..add(DoubleProperty('borderWidth', borderWidth, defaultValue: 1))
      ..add(DiagnosticsProperty('pagePadding', pagePadding, defaultValue: const EdgeInsets.all(4)));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FStyle &&
          runtimeType == other.runtimeType &&
          formFieldStyle == other.formFieldStyle &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          pagePadding == other.pagePadding;

  @override
  int get hashCode => formFieldStyle.hashCode ^ borderRadius.hashCode ^ borderWidth.hashCode ^ pagePadding.hashCode;
}

/// A form field's style.
final class FFormFieldStyle with Diagnosticable {
  /// The style for the form field when it is enabled.
  final FFormFieldStateStyle enabledStyle;

  /// The style for the form field when it is disabled.
  final FFormFieldStateStyle disabledStyle;

  /// The style for the form field when it has an error.
  final FFormFieldStateStyle errorStyle;

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
  })  : enabledStyle = FFormFieldStateStyle.inherit(
          labelColor: colorScheme.primary,
          descriptionColor: colorScheme.mutedForeground,
          typography: typography,
        ),
        disabledStyle = FFormFieldStateStyle.inherit(
          labelColor: colorScheme.primary.withOpacity(0.7),
          descriptionColor: colorScheme.border.withOpacity(0.7),
          typography: typography,
        ),
        errorStyle = FFormFieldStateStyle.inherit(
          labelColor: colorScheme.primary,
          descriptionColor: colorScheme.error,
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
    FFormFieldStateStyle? enabledStyle,
    FFormFieldStateStyle? disabledStyle,
    FFormFieldStateStyle? errorStyle,
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
final class FFormFieldStateStyle with Diagnosticable {
  /// The label's text style.
  final TextStyle labelTextStyle;

  /// The description's text style.
  final TextStyle descriptionTextStyle;

  /// Creates a [FFormFieldStateStyle].
  const FFormFieldStateStyle({
    this.labelTextStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    this.descriptionTextStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  });

  /// Creates a [FFormFieldStateStyle] that inherits its properties from the given [FTypography].
  FFormFieldStateStyle.inherit({
    required Color labelColor,
    required Color descriptionColor,
    required FTypography typography,
  })  : labelTextStyle = typography.sm.copyWith(
          color: labelColor,
          fontFamily: typography.defaultFontFamily,
          fontWeight: FontWeight.w600,
        ),
        descriptionTextStyle = typography.sm.copyWith(
          color: descriptionColor,
          fontFamily: typography.defaultFontFamily,
        );

  /// Returns a copy of this [FFormFieldStateStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FFormFieldStateStyle(
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
  FFormFieldStateStyle copyWith({
    TextStyle? labelTextStyle,
    TextStyle? descriptionTextStyle,
  }) =>
      FFormFieldStateStyle(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('labelTextStyle', labelTextStyle))
      ..add(DiagnosticsProperty('descriptionTextStyle', descriptionTextStyle));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FFormFieldStateStyle &&
          runtimeType == other.runtimeType &&
          labelTextStyle == other.labelTextStyle &&
          descriptionTextStyle == other.descriptionTextStyle;

  @override
  int get hashCode => labelTextStyle.hashCode ^ descriptionTextStyle.hashCode;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/theme.dart';

/// A set of miscellaneous properties that is part of a [FThemeData].
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding
/// properties of widget styles configured via `inherit(...)` constructors.
final class FStyle with Diagnosticable {
  /// The style for the form field when it is enabled.
  final FFormFieldStyle enabledFormFieldStyle;

  /// The style for the form field when it is disabled.
  final FFormFieldStyle disabledFormFieldStyle;

  /// The style for the form field when it has an error.
  final FFormFieldErrorStyle errorFormFieldStyle;

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
    required this.enabledFormFieldStyle,
    required this.disabledFormFieldStyle,
    required this.errorFormFieldStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
    this.pagePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  });

  /// Creates an [FStyle] that inherits its properties from the given [FColorScheme] and [FTypography].
  FStyle.inherit({
    required FColorScheme colorScheme,
    required FTypography typography,
  }) : this(
          enabledFormFieldStyle: FFormFieldStyle.inherit(
            labelColor: colorScheme.primary,
            descriptionColor: colorScheme.mutedForeground,
            typography: typography,
          ),
          disabledFormFieldStyle: FFormFieldStyle.inherit(
            labelColor: colorScheme.primary.withOpacity(0.7),
            descriptionColor: colorScheme.mutedForeground.withOpacity(0.7),
            typography: typography,
          ),
          errorFormFieldStyle: FFormFieldErrorStyle.inherit(
            labelColor: colorScheme.error,
            descriptionColor: colorScheme.mutedForeground,
            errorColor: colorScheme.error,
            typography: typography,
          ),
        );

  /// Returns a copy of this [FStyle] with the given properties replaced.
  @useResult
  FStyle copyWith({
    FFormFieldStyle? enabledFormFieldStyle,
    FFormFieldStyle? disabledFormFieldStyle,
    FFormFieldErrorStyle? errorFormFieldStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
  }) =>
      FStyle(
        enabledFormFieldStyle: enabledFormFieldStyle ?? this.enabledFormFieldStyle,
        disabledFormFieldStyle: disabledFormFieldStyle ?? this.disabledFormFieldStyle,
        errorFormFieldStyle: errorFormFieldStyle ?? this.errorFormFieldStyle,
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        pagePadding: pagePadding ?? this.pagePadding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledFormFieldStyle', enabledFormFieldStyle))
      ..add(DiagnosticsProperty('disabledFormFieldStyle', disabledFormFieldStyle))
      ..add(DiagnosticsProperty('errorFormFieldStyle', errorFormFieldStyle))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, defaultValue: BorderRadius.circular(8)))
      ..add(DoubleProperty('borderWidth', borderWidth, defaultValue: 1))
      ..add(DiagnosticsProperty('pagePadding', pagePadding, defaultValue: const EdgeInsets.all(4)));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FStyle &&
          runtimeType == other.runtimeType &&
          enabledFormFieldStyle == other.enabledFormFieldStyle &&
          disabledFormFieldStyle == other.disabledFormFieldStyle &&
          errorFormFieldStyle == other.errorFormFieldStyle &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          pagePadding == other.pagePadding;

  @override
  int get hashCode =>
      enabledFormFieldStyle.hashCode ^
      disabledFormFieldStyle.hashCode ^
      errorFormFieldStyle.hashCode ^
      borderRadius.hashCode ^
      borderWidth.hashCode ^
      pagePadding.hashCode;
}

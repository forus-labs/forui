import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

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

  /// The focused outline style.
  final FFocusedOutlineStyle focusedOutlineStyle;

  /// The icon style.
  final FIconStyle iconStyle;

  /// The border radius. Defaults to `BorderRadius.circular(8)`.
  final BorderRadius borderRadius;

  /// The border width. Defaults to 1.
  final double borderWidth;

  /// The page's padding. Defaults to `EdgeInsets.symmetric(vertical: 8, horizontal: 12)`.
  final EdgeInsets pagePadding;

  /// The shadow used for elevated widgets.
  final List<BoxShadow> shadow;

  /// Creates an [FStyle].
  ///
  /// **Note:**
  /// Unless you are creating a completely new style, modifying [FThemes]' predefined styles should be preferred.
  FStyle({
    required this.enabledFormFieldStyle,
    required this.disabledFormFieldStyle,
    required this.errorFormFieldStyle,
    required this.iconStyle,
    required this.focusedOutlineStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
    this.pagePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    this.shadow = const [
      BoxShadow(
        color: Color(0x0d000000),
        offset: Offset(0, 1),
        blurRadius: 2,
      ),
    ],
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
            labelColor: colorScheme.disable(colorScheme.primary),
            descriptionColor: colorScheme.disable(colorScheme.mutedForeground),
            typography: typography,
          ),
          errorFormFieldStyle: FFormFieldErrorStyle.inherit(
            labelColor: colorScheme.error,
            descriptionColor: colorScheme.mutedForeground,
            errorColor: colorScheme.error,
            typography: typography,
          ),
          focusedOutlineStyle: FFocusedOutlineStyle(
            color: colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          iconStyle: FIconStyle(
            color: colorScheme.primary,
            size: 20,
          ),
        );

  /// Returns a copy of this [FStyle] with the given properties replaced.
  @useResult
  FStyle copyWith({
    FFormFieldStyle? enabledFormFieldStyle,
    FFormFieldStyle? disabledFormFieldStyle,
    FFormFieldErrorStyle? errorFormFieldStyle,
    FFocusedOutlineStyle? focusedOutlineStyle,
    FIconStyle? iconStyle,
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
    List<BoxShadow>? shadow,
  }) =>
      FStyle(
        enabledFormFieldStyle: enabledFormFieldStyle ?? this.enabledFormFieldStyle,
        disabledFormFieldStyle: disabledFormFieldStyle ?? this.disabledFormFieldStyle,
        errorFormFieldStyle: errorFormFieldStyle ?? this.errorFormFieldStyle,
        focusedOutlineStyle: focusedOutlineStyle ?? this.focusedOutlineStyle,
        iconStyle: iconStyle ?? this.iconStyle,
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        pagePadding: pagePadding ?? this.pagePadding,
        shadow: shadow ?? this.shadow,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('enabledFormFieldStyle', enabledFormFieldStyle))
      ..add(DiagnosticsProperty('disabledFormFieldStyle', disabledFormFieldStyle))
      ..add(DiagnosticsProperty('errorFormFieldStyle', errorFormFieldStyle))
      ..add(DiagnosticsProperty('focusedOutlineStyle', focusedOutlineStyle))
      ..add(DiagnosticsProperty('iconStyle', iconStyle))
      ..add(DiagnosticsProperty('borderRadius', borderRadius, defaultValue: BorderRadius.circular(8)))
      ..add(DoubleProperty('borderWidth', borderWidth, defaultValue: 1))
      ..add(DiagnosticsProperty('pagePadding', pagePadding, defaultValue: const EdgeInsets.all(4)))
      ..add(IterableProperty('shadow', shadow));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FStyle &&
          runtimeType == other.runtimeType &&
          enabledFormFieldStyle == other.enabledFormFieldStyle &&
          disabledFormFieldStyle == other.disabledFormFieldStyle &&
          errorFormFieldStyle == other.errorFormFieldStyle &&
          focusedOutlineStyle == other.focusedOutlineStyle &&
          iconStyle == other.iconStyle &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          pagePadding == other.pagePadding &&
          shadow == other.shadow;

  @override
  int get hashCode =>
      enabledFormFieldStyle.hashCode ^
      disabledFormFieldStyle.hashCode ^
      errorFormFieldStyle.hashCode ^
      focusedOutlineStyle.hashCode ^
      iconStyle.hashCode ^
      borderRadius.hashCode ^
      borderWidth.hashCode ^
      pagePadding.hashCode ^
      shadow.hashCode;
}

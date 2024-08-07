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

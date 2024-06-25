import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A set of miscellaneous properties that is part of a [FThemeData].
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding
/// properties of widget styles configured via `inherit(...)` constructors.
final class FStyle with Diagnosticable {
  /// The border radius. Defaults to `BorderRadius.circular(8)`.
  final BorderRadius borderRadius;

  /// The border width. Defaults to 1.
  final double borderWidth;

  /// The page's padding. Defaults to `EdgeInsets.all(4)`.
  final EdgeInsets pagePadding;

  /// Creates an [FStyle].
  ///
  /// **Note:**
  /// Unless you are creating a completely new style, modifying [FThemes]' predefined styles should be preferred.
  const FStyle({
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
    this.pagePadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  });

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
    BorderRadius? borderRadius,
    double? borderWidth,
    EdgeInsets? pagePadding,
  }) =>
      FStyle(
        borderRadius: borderRadius ?? this.borderRadius,
        borderWidth: borderWidth ?? this.borderWidth,
        pagePadding: pagePadding ?? this.pagePadding,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('borderRadius', borderRadius, defaultValue: BorderRadius.circular(8)))
      ..add(DoubleProperty('borderWidth', borderWidth, defaultValue: 1))
      ..add(DiagnosticsProperty('pagePadding', pagePadding, defaultValue: const EdgeInsets.all(4)));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FStyle &&
          runtimeType == other.runtimeType &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth &&
          pagePadding == other.pagePadding;

  @override
  int get hashCode => borderRadius.hashCode ^ borderWidth.hashCode ^ pagePadding.hashCode;
}

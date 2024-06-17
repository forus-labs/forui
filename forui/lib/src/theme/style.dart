import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A set of miscellaneous properties that is part of a [FThemeData].
///
/// These properties are not used directly by Forui widgets. Instead, they are the defaults for the corresponding
/// properties of widget styles configured via `inherit(...)` constructors.
final class FStyle with Diagnosticable {
  /// The border radius. Defaults to `BorderRadius.circular(8)`.
  final BorderRadius borderRadius;

  /// The border width. Defaults to 1.
  final double borderWidth;

  /// Creates an [FStyle].
  ///
  /// **Note:**
  /// Unless you are creating a completely new style, modifying [FThemes]' predefined styles should be preferred.
  const FStyle({
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.borderWidth = 1,
  });

  /// Creates a copy of this [FStyle] with the given properties replaced.
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
  @useResult FStyle copyWith({
    BorderRadius? borderRadius,
    double? borderWidth,
  }) => FStyle(
    borderRadius: borderRadius ?? this.borderRadius,
    borderWidth: borderWidth ?? this.borderWidth,
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('borderRadius', borderRadius, defaultValue: BorderRadius.circular(8)))
      ..add(DoubleProperty('borderWidth', borderWidth, defaultValue: 1));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FStyle &&
          runtimeType == other.runtimeType &&
          borderRadius == other.borderRadius &&
          borderWidth == other.borderWidth;

  @override
  int get hashCode => borderRadius.hashCode ^ borderWidth.hashCode;
}

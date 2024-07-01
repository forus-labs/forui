import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A widget that shows progress.
abstract class FProgress extends StatelessWidget {
  /// The style. Defaults to [FThemeData.progressStyle].
  final FProgressStyle? style;

  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range 0.0-1.0.
  ///
  /// If null, this progress indicator is indeterminate, which means the
  /// indicator displays a predetermined animation that does not indicate how
  /// much actual progress is being made.
  final double? value;

  /// Creates a [FProgress].
  const FProgress({
    this.style,
    this.value,
    super.key,
  });

  /// A widget that shows progress along a line.
  factory FProgress.bar({
    FProgressStyle? style,
    double? value,
  }) =>
      _Linear(style: style, value: value);

  /// A widget that shows progress along a circle.
  factory FProgress.circular({FProgressStyle? style, double? value}) => _Circular(
        style: style,
        value: value,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('value', value));
  }
}

class _Linear extends FProgress {
  const _Linear({
    super.style,
    super.value,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.progressStyle;
    return LinearProgressIndicator(
      borderRadius: style.borderRadius,
      minHeight: style.minHeight,
      semanticsLabel: 'Linear FProgress',
      semanticsValue: '${value ?? 'Indeterminate'}',
      backgroundColor: style.backgroundColor,
      valueColor: AlwaysStoppedAnimation<Color>(style.progressColor),
      value: value,
    );
  }
}

class _Circular extends FProgress {
  const _Circular({
    super.style,
    super.value,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.progressStyle;
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: CircularProgressIndicator(
        strokeWidth: style.strokeWidth,
        strokeCap: StrokeCap.round,
        semanticsLabel: 'Circular FProgress',
        semanticsValue: '${value ?? 'Indeterminate'}',
        backgroundColor: style.backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(style.progressColor),
        value: value,
      ),
    );
  }
}

/// [FProgress]'s style.
final class FProgressStyle with Diagnosticable {
  /// The background's color.
  final Color backgroundColor;

  /// The progress's color.
  final Color progressColor;

  /// The border radius.
  final BorderRadiusGeometry borderRadius;

  /// The minimum height of the progress bar.
  final double minHeight;

  /// The width of the circular progress.
  final double strokeWidth;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.backgroundColor,
    required this.progressColor,
    required this.borderRadius,
    required this.minHeight,
    required this.strokeWidth,
  });

  /// Creates a [FSwitchStyle] that inherits its properties from [colorScheme].
  FProgressStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : backgroundColor = colorScheme.secondary,
        progressColor = colorScheme.primary,
        borderRadius = style.borderRadius,
        minHeight = 15.0,
        strokeWidth = 8;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('progressColor', progressColor))
      ..add(DiagnosticsProperty('borderRadius', borderRadius))
      ..add(DoubleProperty('minHeight', minHeight))
      ..add(DoubleProperty('strokeWidth', strokeWidth));
  }

  /// Returns a copy of this [FProgressStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FProgressStyle(
  ///   backgroundColor: ...,
  ///   progressColor: ...,
  /// );
  ///
  /// final copy = style.copyWith(backgroundColor: ...);
  ///
  /// print(style.backgroundColor == copy.backgroundColor); // true
  /// print(style.progressColor == copy.progressColor); // false
  /// ```
  @useResult
  FProgressStyle copyWith({
    Color? backgroundColor,
    Color? progressColor,
    BorderRadiusGeometry? borderRadius,
    double? minHeight,
    double? strokeWidth,
  }) =>
      FProgressStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        progressColor: progressColor ?? this.progressColor,
        borderRadius: borderRadius ?? this.borderRadius,
        minHeight: minHeight ?? this.minHeight,
        strokeWidth: strokeWidth ?? this.strokeWidth,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FProgressStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          progressColor == other.progressColor &&
          borderRadius == other.borderRadius &&
          minHeight == other.minHeight &&
          strokeWidth == other.strokeWidth;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      progressColor.hashCode ^
      borderRadius.hashCode ^
      minHeight.hashCode ^
      strokeWidth.hashCode;
}

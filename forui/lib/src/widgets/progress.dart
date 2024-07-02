import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A widget that shows progress on a line.
class FProgress extends StatelessWidget {
  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range 0.0-1.0.
  final double value;

  /// The style. Defaults to [FThemeData.progressStyle].
  final FProgressStyle? style;

  /// Creates a [FProgress].
  const FProgress({
    required this.value,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.progressStyle;
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Container(
            height: style.minHeight,
            decoration: style.backgroundDecoration,
            width: constraints.maxWidth,
          ),
          AnimatedContainer(
            height: style.minHeight,
            duration: const Duration(milliseconds: 500),
            decoration: style.progressDecoration,
            width: value.abs() * constraints.maxWidth,
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('value', value));
  }
}

/// [FProgress]'s style.
final class FProgressStyle with Diagnosticable {
  /// The background's color.
  final BoxDecoration backgroundDecoration;

  /// The progress's color.
  final BoxDecoration progressDecoration;

  /// The minimum height of the progress bar.
  final double minHeight;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.backgroundDecoration,
    required this.progressDecoration,
    required this.minHeight,
  });

  /// Creates a [FProgressStyle] that inherits its properties from [colorScheme] and [style].
  FProgressStyle.inherit({required FColorScheme colorScheme, required FStyle style})
      : backgroundDecoration = BoxDecoration(
          borderRadius: style.borderRadius,
          color: colorScheme.secondary,
        ),
        progressDecoration = BoxDecoration(
          borderRadius: style.borderRadius,
          color: colorScheme.primary,
        ),
        minHeight = 15.0;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('progressDecoration', progressDecoration))
      ..add(DiagnosticsProperty('backgroundDecoration', backgroundDecoration))
      ..add(DoubleProperty('minHeight', minHeight));
  }

  /// Returns a copy of this [FProgressStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FProgressStyle(
  ///   backgroundDecoration: ...,
  ///   progressDecoration: ...,
  /// );
  ///
  /// final copy = style.copyWith(progressDecoration: ...);
  ///
  /// print(style.backgroundDecoration == copy.backgroundDecoration); // true
  /// print(style.progressDecoration == copy.progressDecoration); // false
  /// ```
  @useResult
  FProgressStyle copyWith({
    BoxDecoration? backgroundDecoration,
    BoxDecoration? progressDecoration,
    double? minHeight,
  }) =>
      FProgressStyle(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        progressDecoration: progressDecoration ?? this.progressDecoration,
        minHeight: minHeight ?? this.minHeight,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FProgressStyle &&
          runtimeType == other.runtimeType &&
          backgroundDecoration == other.backgroundDecoration &&
          progressDecoration == other.progressDecoration &&
          minHeight == other.minHeight;

  @override
  int get hashCode => backgroundDecoration.hashCode ^ progressDecoration.hashCode ^ minHeight.hashCode;
}

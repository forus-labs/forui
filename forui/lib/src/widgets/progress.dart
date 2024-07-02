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
  ///
  /// ## Contract:
  /// Throws [AssertionError] if:
  /// * [value] is NaN
  FProgress({
    required this.value,
    this.style,
    super.key,
  }) : assert(!value.isNaN, 'Cannot provide a NaN value');

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.progressStyle;
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: style.constraints,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              decoration: style.backgroundDecoration,
              width: constraints.maxWidth,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: style.progressDecoration,
              width: value.abs() * constraints.maxWidth,
            ),
          ],
        ),
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
  final BoxConstraints constraints;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.backgroundDecoration,
    required this.progressDecoration,
    required this.constraints,
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
        constraints = const BoxConstraints(minHeight: 15.0, maxHeight: 15.0);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('progressDecoration', progressDecoration))
      ..add(DiagnosticsProperty('backgroundDecoration', backgroundDecoration))
      ..add(DiagnosticsProperty('constraints', constraints));
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
    BoxConstraints? constraints,
  }) =>
      FProgressStyle(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        progressDecoration: progressDecoration ?? this.progressDecoration,
        constraints: constraints ?? this.constraints,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FProgressStyle &&
          runtimeType == other.runtimeType &&
          backgroundDecoration == other.backgroundDecoration &&
          progressDecoration == other.progressDecoration &&
          constraints == other.constraints;

  @override
  int get hashCode => backgroundDecoration.hashCode ^ progressDecoration.hashCode ^ constraints.hashCode;
}

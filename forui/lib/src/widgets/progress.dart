import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A widget that shows progress on a line.
class FProgress extends StatelessWidget {
  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range 0.0-1.0.
  ///
  /// ## Contract:
  /// Throws [AssertionError] if:
  /// * [value] is NaN
  final double value;

  /// The style. Defaults to [FThemeData.progressStyle].
  final FProgressStyle? style;

  /// Creates a [FProgress].
  FProgress({
    required this.value,
    this.style,
    super.key,
  }) : assert(!value.isNaN, 'Cannot provide a NaN value');

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.progressStyle;
    final value = switch (this.value) {
      < 0.0 => 0.0,
      > 1.0 => 1.0,
      _ => this.value,
    };

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
              curve: style.curve,
              duration: style.animationDuration,
              decoration: style.progressDecoration,
              width: value * constraints.maxWidth,
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
      ..add(DoubleProperty('value', value))
      ..add(DiagnosticsProperty('style', style));
  }
}

/// [FProgress]'s style.
final class FProgressStyle with Diagnosticable {
  /// The background's color.
  final BoxDecoration backgroundDecoration;

  /// The progress's color.
  final BoxDecoration progressDecoration;

  /// The constraints for the progress bar.
  final BoxConstraints constraints;

  /// The animation duration.
  final Duration animationDuration;

  /// The animation curve.
  final Curve curve;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.backgroundDecoration,
    required this.progressDecoration,
    required this.constraints,
    required this.animationDuration,
    required this.curve,
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
        constraints = const BoxConstraints(minHeight: 15.0, maxHeight: 15.0),
        animationDuration = const Duration(milliseconds: 500),
        curve = Curves.ease;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('progressDecoration', progressDecoration))
      ..add(DiagnosticsProperty('backgroundDecoration', backgroundDecoration))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('animationDuration', animationDuration))
      ..add(DiagnosticsProperty<Curve>('curve', curve));
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
    Duration? animationDuration,
    Curve? curve,
  }) =>
      FProgressStyle(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        progressDecoration: progressDecoration ?? this.progressDecoration,
        constraints: constraints ?? this.constraints,
        animationDuration: animationDuration ?? this.animationDuration,
        curve: curve ?? this.curve,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FProgressStyle &&
          runtimeType == other.runtimeType &&
          backgroundDecoration == other.backgroundDecoration &&
          progressDecoration == other.progressDecoration &&
          constraints == other.constraints &&
          animationDuration == other.animationDuration &&
          curve == other.curve;

  @override
  int get hashCode =>
      backgroundDecoration.hashCode ^
      progressDecoration.hashCode ^
      constraints.hashCode ^
      animationDuration.hashCode ^
      curve.hashCode;
}

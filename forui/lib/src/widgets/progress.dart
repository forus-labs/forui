import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A progress bar.
///
/// Displays an indicator showing the completion progress of a task, typically displayed as a progress bar.
///
/// See:
/// * https://forui.dev/docs/progress for working examples.
/// * [FProgressStyle] for customizing a progress's appearance.
class FProgress extends StatelessWidget {
  /// The style. Defaults to [FThemeData.progressStyle].
  final FProgressStyle? style;

  /// If non-null, the value of this progress indicator.
  ///
  /// A value of 0.0 means no progress and 1.0 means that progress is complete.
  /// The value will be clamped to be in the range, `[0.0, 1.0]`.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [value] is NaN
  final double value;

  /// Creates a [FProgress].
  FProgress({
    required this.value,
    this.style,
    super.key,
  }) : assert(!value.isNaN, 'Cannot provide a NaN value.');

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

  /// The constraints for the progress bar. Defaults to a height of 15.0.
  final BoxConstraints constraints;

  /// The animation duration. Defaults to 500ms.
  final Duration animationDuration;

  /// The animation curve. Defaults to [Curves.ease].
  final Curve curve;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.backgroundDecoration,
    required this.progressDecoration,
    this.constraints = const BoxConstraints(minHeight: 15.0, maxHeight: 15.0),
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.ease,
  });

  /// Creates a [FProgressStyle] that inherits its properties from [colorScheme] and [style].
  FProgressStyle.inherit({required FColorScheme colorScheme, required FStyle style}): this(
      backgroundDecoration: BoxDecoration(
        borderRadius: style.borderRadius,
        color: colorScheme.secondary,
      ),
      progressDecoration: BoxDecoration(
        borderRadius: style.borderRadius,
        color: colorScheme.primary,
      ),
  );

  /// Returns a copy of this [FProgressStyle] with the given properties replaced.
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
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('progressDecoration', progressDecoration))
      ..add(DiagnosticsProperty('backgroundDecoration', backgroundDecoration))
      ..add(DiagnosticsProperty('constraints', constraints))
      ..add(DiagnosticsProperty('animationDuration', animationDuration))
      ..add(DiagnosticsProperty('curve', curve));
  }

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

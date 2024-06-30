import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A widget that shows progress along a line.
class FProgress extends StatelessWidget {
  /// The style. Defaults to [FThemeData.progressStyle].
  final FProgressStyle? style;

  /// duration of the animation in milliseconds.
  final double? value;

  /// Creates a [FProgress].
  const FProgress({
    this.style,
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? context.theme.progressStyle;
    return LinearProgressIndicator(
      semanticsLabel: 'Linear FProgress',
      semanticsValue: '$value',
      backgroundColor: style.backgroundColor,
      valueColor: AlwaysStoppedAnimation<Color>(style.progressColor),
      value: value,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('style', style))
    ..add(DoubleProperty('value', value));
  }
}

/// [FSwitch]'s style.
final class FProgressStyle with Diagnosticable {
  /// The background's color.
  final Color backgroundColor;

  /// The progress's color.
  final Color progressColor;

  /// Creates a [FProgressStyle].
  const FProgressStyle({
    required this.backgroundColor,
    required this.progressColor,
  });

  /// Creates a [FSwitchStyle] that inherits its properties from [colorScheme].
  FProgressStyle.inherit({required FColorScheme colorScheme})
      : backgroundColor = colorScheme.secondary,
        progressColor = colorScheme.primary;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('progressColor', progressColor));
  }

  /// Returns a copy of this [FSwitchStyle] with the given properties replaced.
  ///
  /// ```dart
  /// final style = FSwitch(
  ///   checkedColor: Colors.black,
  ///   uncheckedColor: Colors.white,
  ///   // Other arguments omitted for brevity
  /// );
  ///
  /// final copy = style.copyWith(uncheckedColor: Colors.blue);
  ///
  /// print(copy.checkedColor); // black
  /// print(copy.uncheckedColor); // blue
  /// ```
  @useResult
  FProgressStyle copyWith({
    Color? backgroundColor,
    Color? progressColor,
  }) =>
      FProgressStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        progressColor: progressColor ?? this.progressColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FProgressStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          progressColor == other.progressColor;

  @override
  int get hashCode => backgroundColor.hashCode ^ progressColor.hashCode;
}

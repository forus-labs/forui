import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The overarching style that is used to configure the properties of widget-specific styles if they are not provided.
final class FStyle with Diagnosticable {

  /// The text style.
  final TextStyle textStyle;

  /// The border radius.
  final BorderRadius borderRadius;

  /// The border width.
  final double borderWidth;

  /// Creates an [FStyle].
  FStyle({BorderRadius? borderRadius, double? borderWidth}):
    borderRadius = borderRadius ?? BorderRadius.circular(8),
    borderWidth = borderWidth ?? 1;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius, defaultValue: BorderRadius.circular(8)))
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

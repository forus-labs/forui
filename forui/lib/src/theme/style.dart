import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The overarching style that is used to configure the properties of widget-specific styles if they are not provided.
final class FStyle with Diagnosticable {

  /// The text style.
  final TextStyle textStyle;

  /// The border radius.
  final BorderRadius borderRadius;

  /// Creates an [FStyle].
  FStyle({required this.textStyle, BorderRadius? borderRadius}):
    borderRadius = borderRadius ?? BorderRadius.circular(8);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextStyle>('textStyle', textStyle))
      ..add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FStyle &&
          runtimeType == other.runtimeType &&
          textStyle == other.textStyle &&
          borderRadius == other.borderRadius;

  @override
  int get hashCode => textStyle.hashCode ^ borderRadius.hashCode;

}

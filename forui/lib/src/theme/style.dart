import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The overarching style that is used to configure the properties of widget-specific styles if they are not provided.
final class FStyle with Diagnosticable {

  /// The border radius.
  final BorderRadius borderRadius;

  /// Creates an [FStyle].
  const FStyle({required this.borderRadius});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<BorderRadius>('borderRadius', borderRadius));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is FStyle && borderRadius == other.borderRadius;

  @override
  int get hashCode => borderRadius.hashCode;

}

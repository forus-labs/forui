import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// An interface for computing the spacing between a widget and its portal.
///
/// See:
/// * [Visualization](http://forui.dev/docs/foundation/portal#visualization) for a visual demonstration of how the
///   spacing works.
abstract interface class FPortalSpacing {
  /// A [FPortalSpacing] that does not apply any spacing.
  static const zero = FPortalSpacing(0);

  /// Creates a [FPortalSpacing] that adds spacing between the anchors of the portal and widget when they do not overlap.
  ///
  /// [spacing] determines the amount of space to apply between the anchors.
  ///
  /// [diagonal] determines whether spacing applies to opposite diagonal corners:
  /// * When `false` (default), opposite diagonal corners have no spacing.
  /// * When `true`, spacing applies to opposite diagonal corners.
  const factory FPortalSpacing(double spacing, {bool diagonal}) = _FPortalSpacing;

  /// Returns the spacing offset for the portal.
  Offset call(Alignment child, Alignment portal);
}

class _FPortalSpacing with Diagnosticable implements FPortalSpacing {
  final double spacing;
  final bool diagonal;

  const _FPortalSpacing(this.spacing, {this.diagonal = false});

  @override
  Offset call(Alignment child, Alignment portal) {
    // ignore corners that are diagonal.
    if (!diagonal && (child.x != 0 && child.y != 0) && (child.x == -portal.x && child.y == -portal.y)) {
      return Offset.zero;
    }

    return Offset(
      switch (child.x) {
        -1 when portal.x == 1 => -spacing,
        1 when portal.x == -1 => spacing,
        _ => 0,
      },
      switch (child.y) {
        -1 when portal.y == 1 => -spacing,
        1 when portal.y == -1 => spacing,
        _ => 0,
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('spacing', spacing))
      ..add(FlagProperty('diagonal', value: diagonal, ifFalse: 'spacing not applied to two diagonal corners'));
  }
}

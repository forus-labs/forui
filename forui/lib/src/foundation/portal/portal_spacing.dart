import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// An interface for computing the spacing between a child and its portal.
abstract interface class FPortalSpacing {
  /// A [FPortalSpacing] that does not apply any spacing.
  static const zero = FPortalSpacing(0);

  /// Creates a [FPortalSpacing] that applies a fixed spacing between the child and its portal when they do not overlap.
  ///
  /// The [spacing] parameter determines the amount of space to apply between the anchors.
  ///
  /// The [diagonal] parameter controls how spacing is applied when both anchors are at corners:
  /// * When [diagonal] is `false` (default), spacing is **not** applied if both anchors are at corners.
  /// * When [diagonal] is `true`, spacing is applied regardless of anchor positions.
  const factory FPortalSpacing(double spacing, {bool diagonal}) = _FPortalSpacing;

  /// Computes spacing between the [child]'s anchor and the [portal]'s anchor, returning an offset by which to shift
  /// the portal.
  Offset resolve(Alignment child, Alignment portal);
}

class _FPortalSpacing with Diagnosticable implements FPortalSpacing {
  final double spacing;
  final bool diagonal;

  const _FPortalSpacing(this.spacing, {this.diagonal = false});

  @override
  Offset resolve(Alignment child, Alignment portal) {
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

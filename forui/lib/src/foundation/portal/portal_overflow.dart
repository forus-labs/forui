import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/foundation/rendering.dart';

/// A portal child's rectangle.
typedef FPortalChildRect = ({Offset offset, Size size, Alignment anchor});

/// A portal's rectangle.
typedef FPortalRect = ({Offset offset, Size size, Alignment anchor});

/// Provides various functions for shifting a portal when it overflows out of the viewport.
///
/// The returned offset should be in the local coordinate system relative to the child's top left corner (0, 0).
///
/// See:
/// * [Visualization](http://forui.dev/docs/foundation/portal#visualization) for a visual demonstration of how the
///   overflow strategies work.
extension FPortalOverflow on Never {
  /// Flips the portal to the opposite side to avoid overflow, falling back to sliding along the edge if needed.
  static Offset flip(Size view, FPortalChildRect child, FPortalRect portal) {
    var anchor = allow(view, child, portal).translate(child.offset.dx, child.offset.dy);

    final viewRect = Offset.zero & view;
    final portalRect = anchor & portal.size;

    switch ((viewRect, portalRect)) {
      case _ when portalRect.left < viewRect.left:
        final flipped = _flip(child, portal, x: true);
        if ((flipped & portal.size).right <= viewRect.right) {
          anchor = flipped;
        }

      case _ when viewRect.right < portalRect.right:
        final flipped = _flip(child, portal, x: true);
        if (viewRect.left <= (flipped & portal.size).left) {
          anchor = flipped;
        }
    }

    switch ((viewRect, portalRect)) {
      case _ when portalRect.top < viewRect.top:
        final flipped = _flip(child, portal, x: false);
        if ((flipped & portal.size).bottom <= viewRect.bottom) {
          anchor = flipped;
        }

      case _ when viewRect.bottom < portalRect.bottom:
        final flipped = _flip(child, portal, x: false);
        if (viewRect.top <= (flipped & portal.size).top) {
          anchor = flipped;
        }
    }

    final adjustedAnchor = _slide(anchor, viewRect, anchor & portal.size);
    return adjustedAnchor.translate(-child.offset.dx, -child.offset.dy);
  }

  static Offset _flip(FPortalChildRect child, FPortalRect portal, {required bool x}) {
    final (childAnchor, portalAnchor, portalOffset) = x
        ? (child.anchor.flipX(), portal.anchor.flipX(), portal.offset.scale(1, -1))
        : (child.anchor.flipY(), portal.anchor.flipY(), portal.offset.scale(-1, 1));

    // This is fucked if we don't want to flip one axis.
    final anchor = childAnchor.relative(to: child.size) - portalAnchor.relative(to: portal.size, origin: portalOffset);

    return anchor.translate(child.offset.dx, child.offset.dy);
  }

  /// Slides the [portal] along the [child]'s edge until the portal does not overflow.
  static Offset slide(Size view, FPortalChildRect child, FPortalRect portal) {
    final anchor = allow(view, child, portal).translate(child.offset.dx, child.offset.dy);

    final viewRect = Offset.zero & view;
    final portalRect = anchor & portal.size;

    return _slide(anchor, viewRect, portalRect).translate(-child.offset.dx, -child.offset.dy);
  }

  static Offset _slide(Offset anchor, Rect viewRect, Rect portalRect) {
    anchor = switch ((viewRect, portalRect)) {
      _ when portalRect.left < viewRect.left => Offset(anchor.dx + (viewRect.left - portalRect.left), anchor.dy),
      _ when viewRect.right < portalRect.right => Offset(anchor.dx - portalRect.right + viewRect.right, anchor.dy),
      _ => anchor,
    };

    anchor = switch ((viewRect, portalRect)) {
      _ when portalRect.top < viewRect.top => Offset(anchor.dx, anchor.dy + (viewRect.top - portalRect.top)),
      _ when viewRect.bottom < portalRect.bottom => Offset(anchor.dx, anchor.dy - portalRect.bottom + viewRect.bottom),
      _ => anchor,
    };

    return anchor;
  }

  /// Allows the portal to overflow.
  static Offset allow(Size _, FPortalChildRect child, FPortalRect portal) {
    final childAnchor = child.anchor.relative(to: child.size);
    final portalAnchor = portal.anchor.relative(to: portal.size, origin: -portal.offset);
    return childAnchor - portalAnchor;
  }
}

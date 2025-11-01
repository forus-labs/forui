import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/foundation/rendering.dart';

/// A portal child's rectangle.
typedef FPortalChildRect = ({Offset offset, Size size, Alignment anchor});

/// A portal's rectangle.
typedef FPortalRect = ({Offset offset, Size size, Alignment anchor});

/// An interface for computing how to shift a portal when it overflows out of the viewport.
///
/// See:
/// * [Visualization](http://forui.dev/docs/foundation/portal#visualization) for a visual demonstration of how the
///   overflow strategies work.
abstract interface class FPortalOverflow {
  /// Flips the portal to the opposite side to avoid overflow, falling back to sliding along the edge if needed.
  static const flip = _Flip();

  /// Slides the portal along the child's edge until the portal does not overflow.
  static const slide = _Slide();

  /// Allows the portal to overflow.
  static const allow = _Allow();

  /// Returns the spacing offset for the portal.
  ///
  /// The returned offset should be in the local coordinate system relative to the child's top left corner (0, 0).
  Offset call(Size view, FPortalChildRect child, FPortalRect portal);
}

class _Flip implements FPortalOverflow {
  const _Flip();

  @override
  Offset call(Size view, FPortalChildRect child, FPortalRect portal) {
    var anchor = _allow(view, child, portal).translate(child.offset.dx, child.offset.dy);

    final viewRect = Offset.zero & view;
    var portalRect = anchor & portal.size;

    switch ((viewRect, portalRect)) {
      case _ when portalRect.left < viewRect.left:
        final flipped = _flip(child, portal, x: true);
        if ((flipped & portal.size).right <= viewRect.right) {
          anchor = flipped;
          portalRect = anchor & portal.size;
        }

      case _ when viewRect.right < portalRect.right:
        final flipped = _flip(child, portal, x: true);
        if (viewRect.left <= (flipped & portal.size).left) {
          anchor = flipped;
          portalRect = anchor & portal.size;
        }
    }

    switch ((viewRect, portalRect)) {
      case _ when portalRect.top < viewRect.top:
        final flipped = _flip(child, portal, x: false);
        if ((flipped & portal.size).bottom <= viewRect.bottom) {
          anchor = flipped;
          portalRect = anchor & portal.size;
        }

      case _ when viewRect.bottom < portalRect.bottom:
        final flipped = _flip(child, portal, x: false);
        if (viewRect.top <= (flipped & portal.size).top) {
          anchor = flipped;
          portalRect = anchor & portal.size;
        }
    }

    final adjustedAnchor = _slide(anchor, viewRect, portalRect);
    return adjustedAnchor.translate(-child.offset.dx, -child.offset.dy);
  }
}

Offset _flip(FPortalChildRect child, FPortalRect portal, {required bool x}) {
  final (childAnchor, portalAnchor, portalOffset) = x
      ? (child.anchor.flipX(), portal.anchor.flipX(), portal.offset.scale(1, -1))
      : (child.anchor.flipY(), portal.anchor.flipY(), portal.offset.scale(-1, 1));

  // This is fucked if we don't want to flip one axis.
  final anchor = childAnchor.relative(to: child.size) - portalAnchor.relative(to: portal.size, origin: portalOffset);

  return anchor.translate(child.offset.dx, child.offset.dy);
}

class _Slide implements FPortalOverflow {
  const _Slide();

  @override
  Offset call(Size view, FPortalChildRect child, FPortalRect portal) {
    final anchor = _allow(view, child, portal).translate(child.offset.dx, child.offset.dy);

    final viewRect = Offset.zero & view;
    final portalRect = anchor & portal.size;

    return _slide(anchor, viewRect, portalRect).translate(-child.offset.dx, -child.offset.dy);
  }
}

Offset _slide(Offset anchor, Rect viewRect, Rect portalRect) {
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

class _Allow implements FPortalOverflow {
  const _Allow();

  @override
  Offset call(Size view, FPortalChildRect child, FPortalRect portal) => _allow(view, child, portal);
}

Offset _allow(Size view, FPortalChildRect child, FPortalRect portal) {
  final childAnchor = child.anchor.relative(to: child.size);
  final portalAnchor = portal.anchor.relative(to: portal.size, origin: -portal.offset);
  return childAnchor - portalAnchor;
}

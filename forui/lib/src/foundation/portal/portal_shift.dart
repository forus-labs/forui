import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/src/foundation/rendering.dart';

/// A portal child's rectangle.
typedef FPortalChildBox = ({Offset offset, Size size, Alignment anchor});

/// A portal's rectangle.
typedef FPortalBox = ({Size size, Alignment anchor});

/// Provides various portal shifting strategies for when a portal overflows out of the viewport.
extension FPortalShift on Never {
  /// Flips the portal to the opposite side of the [child] if it does not cause the [portal] to overflow out of the
  /// viewport. Otherwise shifts the portal along the [child]'s edge.
  static Offset flip(Size view, FPortalChildBox child, FPortalBox portal) {
    var anchor = none(view, child, portal).translate(child.offset.dx, child.offset.dy);

    final viewBox = Offset.zero & view;
    final portalBox = anchor & portal.size;

    switch ((viewBox, portalBox)) {
      case _ when portalBox.left < viewBox.left:
        final flipped = _flip(child, portal, x: true);
        if ((flipped & portal.size).right <= viewBox.right) {
          anchor = flipped;
        }

      case _ when viewBox.right < portalBox.right:
        final flipped = _flip(child, portal, x: true);
        if (viewBox.left <= (flipped & portal.size).left) {
          anchor = flipped;
        }
    }

    switch ((viewBox, portalBox)) {
      case _ when portalBox.top < viewBox.top:
        final flipped = _flip(child, portal, x: false);
        if ((flipped & portal.size).bottom <= viewBox.bottom) {
          anchor = flipped;
        }

      case _ when viewBox.bottom < portalBox.bottom:
        final flipped = _flip(child, portal, x: false);
        if (viewBox.top <= (flipped & portal.size).top) {
          anchor = flipped;
        }
    }

    final adjustedAnchor = _along(anchor, viewBox, anchor & portal.size);
    return adjustedAnchor.translate(-child.offset.dx, -child.offset.dy);
  }

  static Offset _flip(FPortalChildBox child, FPortalBox portal, {required bool x}) {
    final childAnchor = x ? child.anchor.flipX() : child.anchor.flipY();
    final portalAnchor = x ? portal.anchor.flipX() : portal.anchor.flipY();

    final anchor = childAnchor.relative(to: child.size) - portalAnchor.relative(to: portal.size);

    return anchor.translate(child.offset.dx, child.offset.dy);
  }

  /// Shifts the [portal] along the [child]'s edge if the portal overflows out of the viewport.
  static Offset along(Size view, FPortalChildBox child, FPortalBox portal) {
    final anchor = none(view, child, portal).translate(child.offset.dx, child.offset.dy);

    final viewBox = Offset.zero & view;
    final portalBox = anchor & portal.size;

    return _along(anchor, viewBox, portalBox).translate(-child.offset.dx, -child.offset.dy);
  }

  static Offset _along(Offset anchor, Rect viewBox, Rect portalBox) {
    anchor = switch ((viewBox, portalBox)) {
      _ when portalBox.left < viewBox.left => Offset(anchor.dx + (viewBox.left - portalBox.left), anchor.dy),
      _ when viewBox.right < portalBox.right => Offset(anchor.dx - portalBox.right + viewBox.right, anchor.dy),
      _ => anchor,
    };

    anchor = switch ((viewBox, portalBox)) {
      _ when portalBox.top < viewBox.top => Offset(anchor.dx, anchor.dy + (viewBox.top - portalBox.top)),
      _ when viewBox.bottom < portalBox.bottom => Offset(anchor.dx, anchor.dy - portalBox.bottom + viewBox.bottom),
      _ => anchor,
    };

    return anchor;
  }

  /// Does not perform any shifting if the [portal] overflows out of the viewport.
  static Offset none(Size _, FPortalChildBox child, FPortalBox portal) {
    final childAnchor = child.anchor.relative(to: child.size);
    final portalAnchor = portal.anchor.relative(to: portal.size);
    return childAnchor - portalAnchor;
  }
}

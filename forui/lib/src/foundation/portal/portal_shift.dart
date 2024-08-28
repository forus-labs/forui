import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

/// A portal's target.
typedef FPortalTarget = ({Offset offset, Size size, Alignment anchor});

/// A portal's follower.
typedef FPortalFollower = ({Size size, Alignment anchor});

/// Provides various follower shifting strategies for when a follower overflows out of the viewport.
extension FPortalFollowerShift on Never {
  /// Flips the follower to the opposite side of the target if it does not cause the follower to overflow out of the
  /// viewport. Otherwise shifts the follower along the target's edge.
  static Offset flip(Size view, FPortalTarget target, FPortalFollower follower) {
    var anchor = none(view, target, follower).translate(target.offset.dx, target.offset.dy);

    final viewBox = Offset.zero & view;
    final followerBox = anchor & follower.size;

    switch ((viewBox, followerBox)) {
      case _ when followerBox.left < viewBox.left:
        final flipped = _flip(target, follower, x: true);
        if ((flipped & follower.size).right <= viewBox.right) {
          anchor = flipped;
        }

      case _ when viewBox.right < followerBox.right:
        final flipped = _flip(target, follower, x: true);
        if (viewBox.left <= (flipped & follower.size).left) {
          anchor = flipped;
        }
    }

    switch ((viewBox, followerBox)) {
      case _ when followerBox.top < viewBox.top:
        final flipped = _flip(target, follower, x: false);
        if ((flipped & follower.size).bottom <= viewBox.bottom) {
          anchor = flipped;
        }

      case _ when viewBox.bottom < followerBox.bottom:
        final flipped = _flip(target, follower, x: false);
        if (viewBox.top <= (flipped & follower.size).top) {
          anchor = flipped;
        }
    }

    final foo = _along(anchor, viewBox, anchor & follower.size);
    return foo.translate(-target.offset.dx, -target.offset.dy);
  }

  static Offset _flip(FPortalTarget target, FPortalFollower follower, {required bool x}) {
    final targetAnchor = x ? target.anchor.flipX() : target.anchor.flipY();
    final followerAnchor = x ? follower.anchor.flipX() : follower.anchor.flipY();

    final anchor = targetAnchor.relative(to: target.size) - followerAnchor.relative(to: follower.size);

    return anchor.translate(target.offset.dx, target.offset.dy);
  }

  /// Shifts the follower along the target's edge if the follower overflows out of the viewport.
  static Offset along(Size view, FPortalTarget target, FPortalFollower follower) {
    final anchor = none(view, target, follower).translate(target.offset.dx, target.offset.dy);

    final viewBox = Offset.zero & view;
    final followerBox = anchor & follower.size;

    return _along(anchor, viewBox, followerBox).translate(-target.offset.dx, -target.offset.dy);
  }

  static Offset _along(Offset anchor, Rect viewBox, Rect followerBox) {
    anchor = switch ((viewBox, followerBox)) {
      _ when followerBox.left < viewBox.left => Offset(anchor.dx + (viewBox.left - followerBox.left), anchor.dy),
      _ when viewBox.right < followerBox.right => Offset(anchor.dx - followerBox.right + viewBox.right, anchor.dy),
      _ => anchor,
    };

    anchor = switch ((viewBox, followerBox)) {
      _ when followerBox.top < viewBox.top => Offset(anchor.dx, anchor.dy + (viewBox.top - followerBox.top)),
      _ when viewBox.bottom < followerBox.bottom => Offset(anchor.dx, anchor.dy - followerBox.bottom + viewBox.bottom),
      _ => anchor,
    };

    return anchor;
  }

  /// Does not perform any shifting if the follower overflows out of the viewport.
  static Offset none(Size view, FPortalTarget target, FPortalFollower follower) {
    final targetAnchor = target.anchor.relative(to: target.size);
    final followerAnchor = follower.anchor.relative(to: follower.size);
    return targetAnchor - followerAnchor;
  }
}

@internal
extension Alignments on Alignment {
  Alignment flipX() => switch (this) {
        Alignment.topLeft => Alignment.topRight,
        Alignment.topRight => Alignment.topLeft,
        Alignment.centerLeft => Alignment.centerRight,
        Alignment.centerRight => Alignment.centerLeft,
        Alignment.bottomLeft => Alignment.bottomRight,
        Alignment.bottomRight => Alignment.bottomLeft,
        _ => this,
      };

  Alignment flipY() => switch (this) {
        Alignment.topLeft => Alignment.bottomLeft,
        Alignment.topCenter => Alignment.bottomCenter,
        Alignment.topRight => Alignment.bottomRight,
        Alignment.bottomLeft => Alignment.topLeft,
        Alignment.bottomCenter => Alignment.topCenter,
        Alignment.bottomRight => Alignment.topRight,
        _ => this,
      };

  Offset relative({required Size to, Offset origin = Offset.zero}) => switch (this) {
        Alignment.topCenter => to.topCenter(origin),
        Alignment.topRight => to.topRight(origin),
        Alignment.centerLeft => to.centerLeft(origin),
        Alignment.center => to.center(origin),
        Alignment.centerRight => to.centerRight(origin),
        Alignment.bottomLeft => to.bottomLeft(origin),
        Alignment.bottomCenter => to.bottomCenter(origin),
        Alignment.bottomRight => to.bottomRight(origin),
        _ => to.topLeft(origin),
      };
}

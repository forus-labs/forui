import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

typedef FPortalShiftTarget = ({Offset offset, Size size, Alignment anchor});

typedef FPortalShiftFollower = ({RenderBox box, Alignment anchor});

extension FPortalShift on Never {
  static Offset flip(Size view, FPortalShiftTarget target, FPortalShiftFollower follower) {
    var anchor = none(view, target, follower).translate(target.offset.dx, target.offset.dy);

    final viewBox = Offset.zero & view;
    final followerBox = anchor & follower.box.size;

    switch ((viewBox, followerBox)) {
      case _ when followerBox.left < viewBox.left:
        final flipped = _flip(target, follower, x: true);
        if ((flipped & follower.box.size).right <= viewBox.right) {
          anchor = flipped;
        }

      case _ when viewBox.right < followerBox.right:
        final flipped = _flip(target, follower, x: true);
        if (viewBox.left <= (flipped & follower.box.size).left) {
          print('flip');
          anchor = flipped;
        }
    }

    switch ((viewBox, followerBox)) {
      case _ when followerBox.top < viewBox.top:
        final flipped = _flip(target, follower, x: false);
        if ((flipped & follower.box.size).bottom <= viewBox.bottom) {
          anchor = flipped;
        }

      case _ when viewBox.bottom < followerBox.bottom:
        final flipped = _flip(target, follower, x: false);
        if (viewBox.top <= (flipped & follower.box.size).top) {
          anchor = flipped;
        }
    }

    final foo = _along(anchor, viewBox, anchor & follower.box.size);
    return foo.translate(-target.offset.dx, -target.offset.dy);
  }

  static Offset _flip(FPortalShiftTarget target, FPortalShiftFollower follower, {required bool x}) {
    final targetAnchor = x ? target.anchor.flipX() : target.anchor.flipY();
    final followerAnchor = x ? follower.anchor.flipX() : follower.anchor.flipY();

    final anchor = targetAnchor.relative(to: target.size) - followerAnchor.relative(to: follower.box.size);

    return anchor.translate(target.offset.dx, target.offset.dy);
  }

  static Offset along(Size view, FPortalShiftTarget target, FPortalShiftFollower follower) {
    final anchor = none(view, target, follower).translate(target.offset.dx, target.offset.dy);

    final viewBox = Offset.zero & view;
    final followerBox = anchor & follower.box.size;

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

  static Offset none(Size view, FPortalShiftTarget target, FPortalShiftFollower follower) {
    final targetAnchor = target.anchor.relative(to: target.size);
    final followerAnchor = follower.anchor.relative(to: follower.box.size);
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

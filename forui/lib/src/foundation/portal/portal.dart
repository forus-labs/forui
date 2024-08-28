import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A portal renders a follower widget that "floats" on top of a target widget.
///
/// Similar to an [OverlayPortal], it requires an [Overlay] ancestor. Unlike an [OverlayPortal], the follower is aligned
/// relative to the target.
///
/// See:
/// * [FPortalFollowerShift] for the various follower shifting strategies.
/// * [OverlayPortalController] for controlling the follower's visibility.
/// * [OverlayPortal] for the underlying widget.
class FPortal extends StatefulWidget {
  /// The controller that shows and hides the follower. It initially hides the follower.
  final OverlayPortalController controller;

  /// The anchor of the follower to which the [targetAnchor] is aligned to. Defaults to [Alignment.topCenter].
  final Alignment followerAnchor;

  /// The anchor of the target to which the [followerAnchor] is aligned to. Defaults to [Alignment.bottomCenter].
  final Alignment targetAnchor;

  /// The shifting strategy used to shift a follower when it overflows out of the viewport. Defaults to
  /// [FPortalFollowerShift.flip].
  final Offset Function(Size, FPortalTarget, FPortalFollower) shift;

  /// The follower.
  final WidgetBuilder followerBuilder;

  /// The target.
  final Widget child;

  /// Creates a portal.
  const FPortal({
    required this.controller,
    required this.followerBuilder,
    required this.child,
    this.followerAnchor = Alignment.topCenter,
    this.targetAnchor = Alignment.bottomCenter,
    this.shift = FPortalFollowerShift.flip,
    super.key,
  });

  @override
  State<FPortal> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('followerAnchor', followerAnchor))
      ..add(DiagnosticsProperty('childAnchor', targetAnchor))
      ..add(DiagnosticsProperty('shift', shift))
      ..add(DiagnosticsProperty('follower', followerBuilder))
      ..add(DiagnosticsProperty('child', child));
  }
}

class _State extends State<FPortal> {
  late LayerLink _link;

  @override
  void initState() {
    super.initState();
    _link = LayerLink();
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: _link,
        child: OverlayPortal(
          controller: widget.controller,
          overlayChildBuilder: (context) => CompositedTransformFollower(
            link: _link,
            child: _Alignment(
              link: _link,
              followerAnchor: widget.followerAnchor,
              targetAnchor: widget.targetAnchor,
              shift: widget.shift,
              child: widget.followerBuilder(context),
            ),
          ),
          child: widget.child,
        ),
      );
}

class _Alignment extends SingleChildRenderObjectWidget {
  final LayerLink _link;
  final Alignment _targetAnchor;
  final Alignment _followerAnchor;
  final Offset Function(Size, FPortalTarget, FPortalFollower) _shift;

  const _Alignment({
    required Widget child,
    required LayerLink link,
    required Alignment targetAnchor,
    required Alignment followerAnchor,
    required Offset Function(Size, FPortalTarget, FPortalFollower) shift,
  })  : _link = link,
        _targetAnchor = targetAnchor,
        _followerAnchor = followerAnchor,
        _shift = shift,
        super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderBox(
        link: _link,
        targetAnchor: _targetAnchor,
        followerAnchor: _followerAnchor,
        shift: _shift,
      );

  @override
  void updateRenderObject(BuildContext context, _RenderBox renderObject) {
    renderObject
      ..link = _link
      ..targetAnchor = _targetAnchor
      ..followerAnchor = _followerAnchor
      ..shift = _shift;
  }
}

class _RenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  LayerLink _link;
  Alignment _targetAnchor;
  Alignment _followerAnchor;
  Offset Function(Size, FPortalTarget, FPortalFollower) _shift;

  _RenderBox({
    required LayerLink link,
    required Alignment targetAnchor,
    required Alignment followerAnchor,
    required Offset Function(Size, FPortalTarget, FPortalFollower) shift,
  })  : _link = link,
        _targetAnchor = targetAnchor,
        _followerAnchor = followerAnchor,
        _shift = shift;

  @override
  void performLayout() {
    if (child case final child?) {
      child.layout(constraints.loosen(), parentUsesSize: true);
    }

    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final tuple = (child, child?.parentData, link.leader?.offset, link.leaderSize);
    if (tuple case (final child?, final BoxParentData data?, final offset?, final leaderSize?)) {
      data.offset = _shift(
        size,
        (offset: offset, size: leaderSize, anchor: targetAnchor),
        (size: child.size, anchor: followerAnchor),
      );
      context.paintChild(child, data.offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if ((child, child?.parentData) case (final child?, final BoxParentData data?)) {
      if (result.addWithPaintOffset(
        offset: data.offset,
        position: position,
        hitTest: (result, transformed) => child.hitTest(result, position: transformed),
      )) {
        result.add(BoxHitTestEntry(this, position));
        return true;
      }
    }

    return false;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('targetAnchor', targetAnchor))
      ..add(DiagnosticsProperty('followerAnchor', followerAnchor))
      ..add(DiagnosticsProperty('shift', shift));
  }

  LayerLink get link => _link;

  set link(LayerLink value) {
    if (_link != value) {
      _link = value;
      markNeedsPaint();
    }
  }

  Alignment get targetAnchor => _targetAnchor;

  set targetAnchor(Alignment value) {
    if (_targetAnchor != value) {
      _targetAnchor = value;
      markNeedsPaint();
    }
  }

  Alignment get followerAnchor => _followerAnchor;

  set followerAnchor(Alignment value) {
    if (_followerAnchor != value) {
      _followerAnchor = value;
      markNeedsPaint();
    }
  }

  Offset Function(Size, FPortalTarget, FPortalFollower) get shift => _shift;

  set shift(Offset Function(Size, FPortalTarget, FPortalFollower) value) {
    if (_shift != value) {
      _shift = value;
      markNeedsPaint();
    }
  }
}

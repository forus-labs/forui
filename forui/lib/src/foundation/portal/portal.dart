import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class FPortal extends StatefulWidget {
  final OverlayPortalController controller;
  final Alignment childAnchor;
  final Alignment followerAnchor;
  final Offset Function(Size, FPortalShiftTarget, FPortalShiftFollower) shift;
  final WidgetBuilder follower;
  final Widget child;

  FPortal({
    required this.controller,
    required this.follower,
    required this.child,
    this.followerAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalShift.flip,
    super.key,
  });

  @override
  State<FPortal> createState() => _State();
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
              targetAnchor: widget.childAnchor,
              shift: widget.shift,
              child: widget.follower(context),
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
  final Offset Function(Size, FPortalShiftTarget, FPortalShiftFollower) _shift;

  const _Alignment({
    required Widget child,
    required LayerLink link,
    required Alignment targetAnchor,
    required Alignment followerAnchor,
    required Offset Function(Size, FPortalShiftTarget, FPortalShiftFollower) shift,
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
  Offset Function(Size, FPortalShiftTarget, FPortalShiftFollower) _shift;

  _RenderBox({
    required LayerLink link,
    required Alignment targetAnchor,
    required Alignment followerAnchor,
    required Offset Function(Size, FPortalShiftTarget, FPortalShiftFollower) shift,
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
    if ((child, link.leader?.offset, link.leaderSize) case (final child?, final offset?, final leaderSize?)) {
      context.paintChild(
        child,
        _shift(size, (offset: offset, size: leaderSize, anchor: targetAnchor), (box: child, anchor: followerAnchor)),
      );
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if ((child, link.leader?.offset, link.leaderSize) case (final child?, final offset?, final leaderSize?)) {
      return result.addWithPaintOffset(
        offset: _shift(
          size,
          (offset: offset, size: leaderSize, anchor: targetAnchor),
          (box: child, anchor: followerAnchor),
        ),
        position: position,
        hitTest: (result, transformed) => child.hitTest(result, position: transformed),
      );
    }
    return false;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('targetAnchor', targetAnchor))
      ..add(DiagnosticsProperty('followerAnchor', followerAnchor));
  }

  LayerLink get link => _link;

  set link(LayerLink value) {
    _link = value;
    markNeedsPaint();
  }

  Alignment get targetAnchor => _targetAnchor;

  set targetAnchor(Alignment value) {
    _targetAnchor = value;
    markNeedsPaint();
  }

  Alignment get followerAnchor => _followerAnchor;

  set followerAnchor(Alignment value) {
    _followerAnchor = value;
    markNeedsPaint();
  }

  Offset Function(Size, FPortalShiftTarget, FPortalShiftFollower) get shift => _shift;

  set shift(Offset Function(Size, FPortalShiftTarget, FPortalShiftFollower) value) {
    _shift = value;
    markNeedsPaint();
  }
}

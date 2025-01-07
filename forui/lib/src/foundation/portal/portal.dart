import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

/// A portal renders a portal widget that "floats" on top of a child widget.
///
/// Similar to an [OverlayPortal], it requires an [Overlay] ancestor. Unlike an [OverlayPortal], the Portal is aligned
/// relative to the child.
///
/// See:
/// * [FPortalShift] for shifting strategies when a portal overflows outside of the viewport.
/// * [OverlayPortalController] for controlling the portal's visibility.
/// * [OverlayPortal] for the underlying widget.
class FPortal extends StatefulWidget {
  /// The controller that shows and hides the portal. It initially hides the portal.
  final OverlayPortalController controller;

  /// The point on the portal (floating content) that connects with the child, at the child's anchor.
  ///
  /// For example, [Alignment.topCenter] means the top-center point of the portal will connect with the child.
  /// See [childAnchor] for changing the child's anchor.
  ///
  /// Defaults to [Alignment.topCenter].
  final Alignment portalAnchor;

  /// The point on the child widget that connections with the portal (floating content), at the portal's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the portal.
  /// See [childAnchor] for changing the child's anchor.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final Alignment childAnchor;

  /// The shifting strategy used to shift a portal when it overflows out of the viewport. Defaults to
  /// [FPortalShift.flip].
  ///
  /// See [FPortalShift] for the different shifting strategies.
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  /// The offset to adjust the [shift]ed portal by. Defaults to [Offset.zero].
  final Offset offset;

  /// The portal builder which returns the floating content.
  final WidgetBuilder portalBuilder;

  /// The child which the portal is aligned to.
  final Widget child;

  /// Creates a portal.
  const FPortal({
    required this.controller,
    required this.portalBuilder,
    required this.child,
    this.portalAnchor = Alignment.topCenter,
    this.childAnchor = Alignment.bottomCenter,
    this.shift = FPortalShift.flip,
    this.offset = Offset.zero,
    super.key,
  });

  @override
  State<FPortal> createState() => _State();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(ObjectFlagProperty.has('portalBuilder', portalBuilder));
  }
}

class _State extends State<FPortal> {
  final LayerLink _link = LayerLink();

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
        link: _link,
        child: OverlayPortal(
          controller: widget.controller,
          overlayChildBuilder: (context) => CompositedTransformFollower(
            link: _link,
            child: _Alignment(
              link: _link,
              portalAnchor: widget.portalAnchor,
              childAnchor: widget.childAnchor,
              shift: widget.shift,
              offset: widget.offset,
              child: widget.portalBuilder(context),
            ),
          ),
          child: widget.child,
        ),
      );
}

class _Alignment extends SingleChildRenderObjectWidget {
  final LayerLink _link;
  final Alignment _childAnchor;
  final Alignment _portalAnchor;
  final Offset Function(Size, FPortalChildBox, FPortalBox) _shift;
  final Offset _offset;

  const _Alignment({
    required Widget child,
    required LayerLink link,
    required Alignment childAnchor,
    required Alignment portalAnchor,
    required Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    required Offset offset,
  })  : _link = link,
        _childAnchor = childAnchor,
        _portalAnchor = portalAnchor,
        _shift = shift,
        _offset = offset,
        super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderBox(
        link: _link,
        childAnchor: _childAnchor,
        portalAnchor: _portalAnchor,
        shift: _shift,
        offset: _offset,
      );

  @override
  void updateRenderObject(BuildContext context, _RenderBox renderObject) {
    renderObject
      ..link = _link
      ..childAnchor = _childAnchor
      ..portalAnchor = _portalAnchor
      ..shift = _shift
      ..offset = _offset;
  }
}

class _RenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  LayerLink _link;
  Alignment _childAnchor;
  Alignment _portalAnchor;
  Offset Function(Size, FPortalChildBox, FPortalBox) _shift;
  Offset _offset;

  _RenderBox({
    required LayerLink link,
    required Alignment childAnchor,
    required Alignment portalAnchor,
    required Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    required Offset offset,
  })  : _link = link,
        _childAnchor = childAnchor,
        _portalAnchor = portalAnchor,
        _shift = shift,
        _offset = offset;

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
            (offset: offset, size: leaderSize, anchor: childAnchor),
            (size: child.size, anchor: portalAnchor),
          ) +
          _offset;
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
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('offset', offset));
  }

  LayerLink get link => _link;

  set link(LayerLink value) {
    if (_link == value) {
      return;
    }

    _link = value;
    markNeedsPaint();
  }

  Alignment get childAnchor => _childAnchor;

  set childAnchor(Alignment value) {
    if (_childAnchor == value) {
      return;
    }

    _childAnchor = value;
    markNeedsPaint();
  }

  Alignment get portalAnchor => _portalAnchor;

  set portalAnchor(Alignment value) {
    if (_portalAnchor == value) {
      return;
    }

    _portalAnchor = value;
    markNeedsPaint();
  }

  Offset Function(Size, FPortalChildBox, FPortalBox) get shift => _shift;

  set shift(Offset Function(Size, FPortalChildBox, FPortalBox) value) {
    if (_shift == value) {
      return;
    }

    _shift = value;
    markNeedsPaint();
  }

  Offset get offset => _offset;

  set offset(Offset value) {
    if (_offset == value) {
      return;
    }

    _offset = value;
    markNeedsPaint();
  }
}

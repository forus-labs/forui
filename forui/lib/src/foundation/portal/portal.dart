import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/portal/composited_child.dart';
import 'package:forui/src/foundation/portal/composited_portal.dart';
import 'package:forui/src/foundation/portal/layer.dart';

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
  final AlignmentGeometry portalAnchor;

  /// The point on the child widget that connects with the portal (floating content), at the portal's anchor.
  ///
  /// For example, [Alignment.bottomCenter] means the bottom-center point of the child will connect with the portal.
  /// See [portalAnchor] for changing the portal's anchor.
  ///
  /// Defaults to [Alignment.bottomCenter].
  final AlignmentGeometry childAnchor;

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
  final _link = ChildLayerLink();

  @override
  Widget build(BuildContext _) => RepaintBoundary(
    child: CompositedChild(
      link: _link,
      child: OverlayPortal(
        controller: widget.controller,
        overlayChildBuilder:
            (context) => CompositedPortal(
              link: _link,
              showWhenUnlinked: true,
              offset: Offset.zero,
              portalAnchor: Alignment.topLeft,
              childAnchor: Alignment.topLeft,
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
    ),
  );
}

class _Alignment extends SingleChildRenderObjectWidget {
  final ChildLayerLink _link;
  final AlignmentGeometry _childAnchor;
  final AlignmentGeometry _portalAnchor;
  final Offset Function(Size, FPortalChildBox, FPortalBox) _shift;
  final Offset _offset;

  const _Alignment({
    required Widget child,
    required ChildLayerLink link,
    required AlignmentGeometry childAnchor,
    required AlignmentGeometry portalAnchor,
    required Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    required Offset offset,
  }) : _link = link,
       _childAnchor = childAnchor,
       _portalAnchor = portalAnchor,
       _shift = shift,
       _offset = offset,
       super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
    return _RenderBox(
      link: _link,
      childAnchor: _childAnchor.resolve(direction),
      portalAnchor: _portalAnchor.resolve(direction),
      shift: _shift,
      offset: _offset,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderBox box) {
    final direction = Directionality.maybeOf(context) ?? TextDirection.ltr;
    box
      ..link = _link
      ..childAnchor = _childAnchor.resolve(direction)
      ..portalAnchor = _portalAnchor.resolve(direction)
      ..shift = _shift
      ..offset = _offset;
  }
}

class _RenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  ChildLayerLink _link;
  // TODO: shift alignment logic to this.
  Alignment _childAnchor;
  Alignment _portalAnchor;
  Offset Function(Size, FPortalChildBox, FPortalBox) _shift;
  Offset _offset;

  _RenderBox({
    required ChildLayerLink link,
    required Alignment childAnchor,
    required Alignment portalAnchor,
    required Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    required Offset offset,
  }) : _link = link,
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
  void paint(PaintingContext context, Offset _) {
    final tuple = (child, child?.parentData, link.childLayer?.globalOffset, link.childSize);

    if (tuple case (final child?, final BoxParentData data?, final offset?, final leaderSize?)) {
      data.offset =
          _shift(
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

  ChildLayerLink get link => _link;

  set link(ChildLayerLink value) {
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

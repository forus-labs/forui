// ignore_for_file: prefer_asserts_with_message

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/portal/composited_child.dart';
import 'package:forui/src/foundation/portal/layer.dart';
import 'package:meta/meta.dart';

/// A [CompositedPortal] positions itself relative to a [CompositedChild].
///
/// ## Implementation details:
/// This class is a copy of [CompositedTransformFollower] with the following enhancements:
/// * Receives the global position of a linked [CompositedChild].
@internal
class CompositedPortal extends SingleChildRenderObjectWidget {
  /// The link object that connects this [CompositedPortal] with a [CompositedChild]s.
  final ChildLayerLink link;

  /// Whether to show the widget's contents when there is no corresponding [CompositedChild] with the same [link].
  ///
  /// When the widget is linked, the child is positioned such that it has the same global position as the linked
  /// [CompositedChild].
  ///
  /// When the widget is not linked, then: if [showWhenUnlinked] is true, the child is visible and not repositioned; if
  /// it is false, then child is hidden.
  final bool showWhenUnlinked;

  /// The additional offset to apply to the [childAnchor] of the linked [CompositedChild] to obtain this widget's
  /// [portalAnchor] position.
  final Offset offset;

  /// The anchor point on this widget that will line up with [childAnchor] on the linked [CompositedChild].
  final Alignment portalAnchor;

  /// The anchor point on the linked [CompositedChild] that [portalAnchor] will line up with.
  final Alignment childAnchor;

  const CompositedPortal({
    required this.link,
    required this.showWhenUnlinked,
    required this.offset,
    required this.portalAnchor,
    required this.childAnchor,
    super.key,
    super.child,
  });

  @override
  RenderPortalLayer createRenderObject(BuildContext context) => RenderPortalLayer(link: link);

  @override
  void updateRenderObject(BuildContext context, RenderPortalLayer renderObject) => renderObject.link = link;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('showWhenUnlinked', showWhenUnlinked))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor));
  }
}

/// ## Implementation details:
/// This class is a copy of [RenderFollowerLayer] with the following differences:
/// * Contains a [ChildLayerLink] instead of a [LayerLink].
@internal
class RenderPortalLayer extends RenderProxyBox {
  ChildLayerLink _link;
  bool _showWhenUnlinked;
  Offset _offset;
  Alignment _portalAnchor;
  Alignment _childAnchor;

  RenderPortalLayer({
    required ChildLayerLink link,
    bool showWhenUnlinked = true,
    Offset offset = Offset.zero,
    Alignment portalAnchor = Alignment.topLeft,
    Alignment childAnchor = Alignment.topLeft,
    RenderBox? child,
  }) : _link = link,
       _showWhenUnlinked = showWhenUnlinked,
       _offset = offset,
       _childAnchor = childAnchor,
       _portalAnchor = portalAnchor,
       super(child);

  @override
  void paint(PaintingContext context, Offset offset) {
    final childSize = link.childSize;
    assert(
      link.childSize != null || link.childLayer == null || childAnchor == Alignment.topLeft,
      '$link: layer is linked to ${link.childLayer} but a valid childSize is not set. '
      'childSize is required when childAnchor is not Alignment.topLeft '
      '(current value is $childAnchor).',
    );
    final effectiveLinkedOffset =
        childSize == null ? this.offset : childAnchor.alongSize(childSize) - portalAnchor.alongSize(size) + this.offset;

    if (layer == null) {
      layer = PortalLayer(
        link: link,
        showWhenUnlinked: showWhenUnlinked,
        linkedOffset: effectiveLinkedOffset,
        unlinkedOffset: offset,
      );
    } else {
      layer
        ?..link = link
        ..showWhenUnlinked = showWhenUnlinked
        ..linkedOffset = effectiveLinkedOffset
        ..unlinkedOffset = offset;
    }

    context.pushLayer(
      layer!,
      super.paint,
      Offset.zero,
      childPaintBounds: const Rect.fromLTRB(
        // We don't know where we'll end up, so we have no idea what our cull rect should be.
        double.negativeInfinity,
        double.negativeInfinity,
        double.infinity,
        double.infinity,
      ),
    );

    assert(() {
      layer!.debugCreator = debugCreator;
      return true;
    }());
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // Disables the hit testing if this render object is hidden.
    if (link.childLayer == null && !showWhenUnlinked) {
      return false;
    }
    // RenderPortalLayer objects don't check if they are themselves hit, because it's confusing to think about how the
    // untransformed size and the child's transformed position interact.
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) => result.addWithPaintTransform(
    transform: _currentTransform,
    position: position,
    hitTest: (result, position) => super.hitTestChildren(result, position: position),
  );

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    transform.multiply(_currentTransform);
  }

  /// Return the transform that was used in the last composition phase, if any.
  ///
  /// If the [PortalLayer] has not yet been created, was never composited, or was unable to determine the transform (see
  /// [PortalLayer.getLastTransform]), this returns the identity matrix (see [Matrix4.identity]).
  Matrix4 get _currentTransform => layer?.getLastTransform() ?? Matrix4.identity();

  @override
  void detach() {
    layer = null;
    super.detach();
  }

  @override
  bool get alwaysNeedsCompositing => true;

  /// The layer we created when we were last painted.
  @override
  PortalLayer? get layer => super.layer as PortalLayer?;

  ChildLayerLink get link => _link;

  set link(ChildLayerLink value) {
    if (_link == value) {
      return;
    }
    _link = value;
    markNeedsPaint();
  }

  /// Whether to show the render object's contents when there is no corresponding [RenderChildLayer] with the same [link].
  ///
  /// When the render object is linked, the child is positioned such that it has the same global position as the linked
  /// [RenderChildLayer].
  ///
  /// When the render object is not linked, then: if [showWhenUnlinked] is true, the child is visible and not
  /// repositioned; if it is false, then child is hidden, and its hit testing is also disabled.
  bool get showWhenUnlinked => _showWhenUnlinked;

  set showWhenUnlinked(bool value) {
    if (_showWhenUnlinked == value) {
      return;
    }
    _showWhenUnlinked = value;
    markNeedsPaint();
  }

  /// The offset to apply to the origin of the linked [RenderChildLayer] to obtain this render object's origin.
  Offset get offset => _offset;

  set offset(Offset value) {
    if (_offset == value) {
      return;
    }
    _offset = value;
    markNeedsPaint();
  }

  /// The anchor point on this [RenderPortalLayer] that will line up with [portalAnchor] on the linked [RenderChildLayer].
  ///
  /// Defaults to [Alignment.topLeft].
  Alignment get portalAnchor => _portalAnchor;

  set portalAnchor(Alignment value) {
    if (_portalAnchor == value) {
      return;
    }
    _portalAnchor = value;
    markNeedsPaint();
  }

  /// The anchor point on the linked [RenderChildLayer] that [portalAnchor] will line up with.
  ///
  /// Defaults to [Alignment.topLeft].
  Alignment get childAnchor => _childAnchor;

  set childAnchor(Alignment value) {
    if (_childAnchor == value) {
      return;
    }
    _childAnchor = value;
    markNeedsPaint();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('showWhenUnlinked', showWhenUnlinked))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(TransformProperty('current transform matrix', _currentTransform));
  }
}

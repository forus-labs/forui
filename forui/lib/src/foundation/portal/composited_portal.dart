// ignore_for_file: prefer_asserts_with_message

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/portal/composited_child.dart';
import 'package:forui/src/foundation/portal/layer.dart';

/// A [CompositedPortal] positions itself relative to a [CompositedChild].
///
/// ## Implementation details:
/// This class is a copy of [CompositedTransformFollower] with the following enhancements:
/// * Receives the global position of a linked [CompositedChild].
@internal
class CompositedPortal extends SingleChildRenderObjectWidget {
  /// The notifier that is updated whenever the linked [CompositedChild] changes its global position.
  final FChangeNotifier notifier;

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

  /// The padding to avoid system intrusions.
  final EdgeInsets viewPadding;

  /// The shifting strategy used to shift a portal when it overflows out of the viewport.
  ///
  /// See [FPortalShift] for the different shifting strategies.
  final Offset Function(Size, FPortalChildBox, FPortalBox) shift;

  const CompositedPortal({
    required this.notifier,
    required this.link,
    required this.offset,
    required this.portalAnchor,
    required this.childAnchor,
    required this.viewPadding,
    required this.shift,
    this.showWhenUnlinked = false,
    super.key,
    super.child,
  });

  @override
  RenderPortalLayer createRenderObject(BuildContext context) => RenderPortalLayer(
    notifier: notifier,
    link: link,
    viewSize: MediaQuery.sizeOf(context),
    showWhenUnlinked: showWhenUnlinked,
    offset: offset,
    portalAnchor: portalAnchor,
    childAnchor: childAnchor,
    viewPadding: viewPadding,
    shift: FPortalShift.flip,
  );

  @override
  void updateRenderObject(BuildContext context, RenderPortalLayer renderObject) =>
      renderObject
        ..notifier = notifier
        ..link = link
        ..viewSize = MediaQuery.sizeOf(context)
        ..showWhenUnlinked = showWhenUnlinked
        ..offset = offset
        ..portalAnchor = portalAnchor
        ..childAnchor = childAnchor
        ..viewPadding = viewPadding
        ..shift = shift;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('notifier', notifier))
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('showWhenUnlinked', showWhenUnlinked))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(DiagnosticsProperty('viewPadding', viewPadding))
      ..add(ObjectFlagProperty.has('shift', shift));
  }
}

/// ## Implementation details:
/// This class is a copy of [RenderFollowerLayer] with the following differences/enhancements:
/// * Repaints whenever the linked [CompositedChild]'s globalOffset changes.
/// * Contains a [ChildLayerLink] instead of a [LayerLink].
/// * Changes the [paintBounds] to be the entire viewport.
/// * Shifts the portal if it overflows out of the viewport.
@internal
class RenderPortalLayer extends RenderProxyBox {
  FChangeNotifier _notifier;
  ChildLayerLink _link;
  Size _viewSize;
  bool _showWhenUnlinked;
  Offset _offset;
  Alignment _portalAnchor;
  Alignment _childAnchor;
  EdgeInsets _viewPadding;
  Offset Function(Size, FPortalChildBox, FPortalBox) _shift;

  RenderPortalLayer({
    required FChangeNotifier notifier,
    required ChildLayerLink link,
    required Size viewSize,
    required bool showWhenUnlinked,
    required Offset offset,
    required Alignment portalAnchor,
    required Alignment childAnchor,
    required EdgeInsets viewPadding,
    required Offset Function(Size, FPortalChildBox, FPortalBox) shift,
    RenderBox? child,
  }) : _notifier = notifier,
       _link = link,
       _viewSize = viewSize,
       _showWhenUnlinked = showWhenUnlinked,
       _offset = offset,
       _childAnchor = childAnchor,
       _portalAnchor = portalAnchor,
       _viewPadding = viewPadding,
       _shift = shift,
       super(child);

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    notifier.addListener(_schedule);
  }

  /// Marks for repaint between frames so that calculations are performed using consistent state.
  /// This was inspired by visibility_detector's implementation:
  /// https://github.com/google/flutter.widgets/blob/494c6abd3de44a92d34c5cbc424db2eefe3915cf/packages/visibility_detector/lib/src/render_visibility_detector.dart#L46
  void _schedule() => SchedulerBinding.instance.scheduleTask(markNeedsPaint, Priority.touch);

  @override
  void performLayout() {
    if (child case final child?) {
      child.layout(constraints.loosen(), parentUsesSize: true);
    }

    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(
      link.childSize != null || link.childLayer == null || childAnchor == Alignment.topLeft,
      '$link: layer is linked to ${link.childLayer} but a valid childSize is not set. '
      'childSize is required when childAnchor is not Alignment.topLeft '
      '(current value is $childAnchor).',
    );

    final linkedOffset =
        this.offset +
        switch ((link.childLayer?.globalOffset, link.childSize, child)) {
          (final childOffset?, final childSize?, final portal?) => _shift(
            // There is NO guarantee that this render box's size is the window's size. Always use viewSize.
            // It's okay to use viewSize even though it's larger than the render box's size as we override paintBounds.
            Size(
              viewSize.width - (viewPadding.left + viewPadding.right),
              viewSize.height - (viewPadding.top + viewPadding.bottom),
            ),
            (
              offset: Offset(childOffset.dx - viewPadding.left, childOffset.dy - viewPadding.top),
              size: childSize,
              anchor: childAnchor,
            ),
            (size: portal.size, anchor: portalAnchor),
          ),
          _ => Offset.zero,
        };

    if (layer == null) {
      layer = PortalLayer(
        link: link,
        showWhenUnlinked: showWhenUnlinked,
        linkedOffset: linkedOffset,
        unlinkedOffset: offset,
      );
    } else {
      layer
        ?..link = link
        ..showWhenUnlinked = showWhenUnlinked
        ..linkedOffset = linkedOffset
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
  Rect get paintBounds => globalToLocal(Offset.zero) & viewSize;

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
  void applyPaintTransform(RenderBox child, Matrix4 transform) => transform.multiply(_currentTransform);

  /// Return the transform that was used in the last composition phase, if any.
  ///
  /// If the [PortalLayer] has not yet been created, was never composited, or was unable to determine the transform (see
  /// [PortalLayer.getLastTransform]), this returns the identity matrix (see [Matrix4.identity]).
  Matrix4 get _currentTransform => layer?.getLastTransform() ?? Matrix4.identity();

  @override
  void detach() {
    notifier.removeListener(_schedule);
    layer = null;
    super.detach();
  }

  @override
  bool get alwaysNeedsCompositing => true;

  /// The layer we created when we were last painted.
  @override
  PortalLayer? get layer => super.layer as PortalLayer?;

  FChangeNotifier get notifier => _notifier;

  set notifier(FChangeNotifier value) {
    if (_notifier == value) {
      return;
    }

    _notifier.removeListener(_schedule);
    _notifier = value;
    _notifier.addListener(_schedule);
  }

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

  EdgeInsets get viewPadding => _viewPadding;

  set viewPadding(EdgeInsets value) {
    if (_viewPadding == value) {
      return;
    }

    _viewPadding = value;
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

  Size get viewSize => _viewSize;

  set viewSize(Size value) {
    if (_viewSize == value) {
      return;
    }

    _viewSize = value;
    markNeedsPaint();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('notifier', notifier))
      ..add(DiagnosticsProperty('link', link))
      ..add(DiagnosticsProperty('showWhenUnlinked', showWhenUnlinked))
      ..add(DiagnosticsProperty('offset', offset))
      ..add(DiagnosticsProperty('childAnchor', childAnchor))
      ..add(DiagnosticsProperty('portalAnchor', portalAnchor))
      ..add(ObjectFlagProperty.has('shift', shift))
      ..add(DiagnosticsProperty('viewPadding', viewPadding))
      ..add(DiagnosticsProperty('viewSize', viewSize))
      ..add(TransformProperty('current transform matrix', _currentTransform));
  }
}

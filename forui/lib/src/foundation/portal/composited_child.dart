// ignore_for_file: prefer_asserts_with_message

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/portal/composited_portal.dart';
import 'package:forui/src/foundation/portal/layer.dart';

/// A [CompositedChild] allows [CompositedPortal]s to position themselves relative to it.
///
/// The [link] property is used to connect the [CompositedChild] with one or more [CompositedPortal]s.
///
/// ## Implementation details:
/// This class is a copy of [CompositedTransformTarget] with the following enhancements:
/// * Passes its global position to the [CompositedPortal]s.
@internal
class CompositedChild extends SingleChildRenderObjectWidget {
  /// The notifier used to signal to the linked [CompositedPortal]s that they need to repaint.
  final FChangeNotifier notifier;

  /// The link object that connects this [CompositedChild] with one or more [CompositedPortal]s.
  final ChildLayerLink link;

  const CompositedChild({required this.notifier, required this.link, super.key, super.child});

  @override
  RenderChildLayer createRenderObject(BuildContext context) =>
      RenderChildLayer(notifier: notifier, link: link, viewSize: MediaQuery.sizeOf(context));

  @override
  void updateRenderObject(BuildContext context, RenderChildLayer renderObject) =>
      renderObject
        ..notifier = notifier
        ..link = link
        ..viewSize = MediaQuery.sizeOf(context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('notifier', notifier))
      ..add(DiagnosticsProperty('link', link));
  }
}

/// ## Implementation details:
/// This class is a copy of [RenderLeaderLayer] with the following enhancements:
/// * Passes its global position to the [CompositedPortal]s.
@internal
class RenderChildLayer extends RenderProxyBox {
  /// The notifier used to signal to the linked [CompositedPortal]s that they need to repaint.
  FChangeNotifier _notifier;

  // The latest size of this [RenderBox], computed during the previous layout pass. It should always be equal to [size],
  // but can be accessed even when [debugDoingThisResize] and [debugDoingThisLayout] are false.
  Size? _previousLayoutSize;
  ChildLayerLink _link;

  /// The size is not used directly. Instead, it's used to mark this render box for repainting whenever the window size
  /// changes.
  Size _viewSize;
  Offset? _previousGlobalOffset;

  RenderChildLayer({
    required FChangeNotifier notifier,
    required ChildLayerLink link,
    required Size viewSize,
    RenderBox? child,
  }) : _notifier = notifier,
       _link = link,
       _viewSize = viewSize,
       super(child);

  @override
  void performLayout() {
    super.performLayout();
    _previousLayoutSize = size;
    link.childSize = size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var globalOffset = offset;
    if (parent case final RenderBox parent) {
      globalOffset = parent.localToGlobal(offset);
    }

    if (layer == null) {
      layer = ChildLayer(link: link, globalOffset: globalOffset, localOffset: offset);
    } else {
      layer! as ChildLayer
        ..link = link
        ..globalOffset = globalOffset
        ..localOffset = offset;
    }

    context.pushLayer(layer!, super.paint, Offset.zero);
    assert(() {
      layer!.debugCreator = debugCreator;
      return true;
    }());

    if (globalOffset != _previousGlobalOffset) {
      _previousGlobalOffset = globalOffset;
      // Signals to the linked [CompositedPortal]s that they need to repaint. This is requires as the child & portal
      // are painted in separate layers and the portal might not re-paint otherwise, i.e. if the child expands in size.
      //
      // We can create a custom notifier that wraps this, but that seems like overkill.
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      notifier.notifyListeners();
    }
  }

  @override
  bool get alwaysNeedsCompositing => true;

  FChangeNotifier get notifier => _notifier;

  set notifier(FChangeNotifier value) {
    if (_notifier == value) {
      return;
    }

    _notifier = value;
  }

  /// The link object that connects this [RenderChildLayer] with one or more
  /// [RenderFollowerLayer]s.
  ///
  /// The object must not be associated with another [RenderChildLayer] that is
  /// also being painted.
  ChildLayerLink get link => _link;

  set link(ChildLayerLink value) {
    if (_link == value) {
      return;
    }

    _link.childSize = null;
    _link = value;
    if (_previousLayoutSize != null) {
      _link.childSize = _previousLayoutSize;
    }

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
      ..add(DiagnosticsProperty('viewSize', viewSize));
  }
}

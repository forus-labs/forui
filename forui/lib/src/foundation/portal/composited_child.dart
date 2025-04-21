// ignore_for_file: prefer_asserts_with_message

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/portal/composited_portal.dart';
import 'package:forui/src/foundation/portal/layer.dart';
import 'package:meta/meta.dart';

/// A [CompositedChild] allows [CompositedPortal]s to position themselves relative to it.
///
/// The [link] property is used to connect the [CompositedChild] with one or more [CompositedPortal]s.
///
/// ## Implementation details:
/// This class is a copy of [CompositedTransformTarget] with the following enhancements:
/// * Passes its global position to the [CompositedPortal]s.
@internal
class CompositedChild extends SingleChildRenderObjectWidget {
  /// The link object that connects this [CompositedChild] with one or more [CompositedPortal]s.
  final ChildLayerLink link;

  const CompositedChild({required this.link, super.key, super.child});

  @override
  RenderChildLayer createRenderObject(BuildContext context) =>
      RenderChildLayer(viewSize: MediaQuery.sizeOf(context), link: link);

  @override
  void updateRenderObject(BuildContext context, RenderChildLayer renderObject) =>
      renderObject
        ..viewSize = MediaQuery.sizeOf(context)
        ..link = link;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('link', link));
  }
}

/// ## Implementation details:
/// This class is a copy of [RenderLeaderLayer] with the following enhancements:
/// * Passes its global position to the [CompositedPortal]s.
@internal
class RenderChildLayer extends RenderProxyBox {
  // The latest size of this [RenderBox], computed during the previous layout pass. It should always be equal to [size],
  // but can be accessed even when [debugDoingThisResize] and [debugDoingThisLayout] are false.
  Size? _previousLayoutSize;
  Size _viewSize;
  ChildLayerLink _link;

  RenderChildLayer({required Size viewSize, required ChildLayerLink link, RenderBox? child})
    : _viewSize = viewSize,
      _link = link,
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
  }

  Size get viewSize => _viewSize;

  set viewSize(Size value) {
    if (_viewSize == value) {
      return;
    }

    _viewSize = value;
    markNeedsPaint();
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

  @override
  bool get alwaysNeedsCompositing => true;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('viewSize', viewSize))
      ..add(DiagnosticsProperty('link', link));
  }
}

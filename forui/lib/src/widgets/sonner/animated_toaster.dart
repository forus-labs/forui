import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/sonner/animated_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class AnimatedToaster extends MultiChildRenderObjectWidget {
  final Offset shiftTransform;
  final double expand;

  const AnimatedToaster({required this.shiftTransform, required this.expand, super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderAnimatedToaster(shiftTransform: shiftTransform, expand: expand);

  @override
  void updateRenderObject(BuildContext context, covariant RenderAnimatedToaster renderObject) =>
      renderObject
        ..shiftTransform = shiftTransform
        ..expand = expand;
}

@internal
class RenderAnimatedToaster extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, AnimatedToasterParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, AnimatedToasterParentData> {
  Offset _shiftTransform;
  double _expand;

  /// Creates a [RenderAnimatedToaster].
  RenderAnimatedToaster({required Offset shiftTransform, required double expand})
    : _shiftTransform = shiftTransform,
      _expand = expand;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! AnimatedToasterParentData) {
      child.parentData = AnimatedToasterParentData();
    }
  }

  static const collapsedOffset = 16;

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    _shift();


    size = constraints.tighten(height: 400).biggest;
  }

  /// Determines how much to shift the toasts when collapsed, and one is added or removed.
  void _shift() {
    assert(lastChild != null, 'No children to shift');

    // First toast in the stack is always rendered at (0, 0);
    lastChild?.layout(constraints, parentUsesSize: true);

    var previous = lastChild;
    var current = childBefore(lastChild!);
    var accumulated = 0.0;

    while (previous != null && current != null) {
      final data = current.parentData! as AnimatedToasterParentData;
      current.layout(constraints, parentUsesSize: true);

      // We don't accumulate if the current height is more than the previous height
      final difference = current.size.height - previous.size.height;

      if (difference <= collapsedOffset) {
        accumulated += collapsedOffset - difference;
      }

      final end = shiftTransform.scale(0, accumulated);
      data.offset = Offset.lerp(data.shiftOrigin, end, data.shift)!;

      previous = current;
      current = data.previousSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);


  Offset get shiftTransform => _shiftTransform;

  set shiftTransform(Offset value) {
    if (_shiftTransform == value) {
      return;
    }

    _shiftTransform = value;
    markNeedsLayout();
  }

  double get expand => _expand;

  set expand(double value) {
    if (_expand == value) {
      return;
    }

    _expand = value;
    markNeedsLayout();
  }
}

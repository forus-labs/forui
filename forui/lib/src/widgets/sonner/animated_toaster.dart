import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/sonner/animated_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class AnimatedToaster extends MultiChildRenderObjectWidget {
  final Offset behindTransform;
  final double expand;

  const AnimatedToaster({required this.behindTransform, required this.expand, super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderAnimatedToaster(shiftTransform: behindTransform, expand: expand);

  @override
  void updateRenderObject(BuildContext context, covariant RenderAnimatedToaster renderObject) =>
      renderObject
        ..behindTransform = behindTransform
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

  @override
  void performLayout() {
    var current = firstChild;
    while (current != null) {
      final data = current.parentData! as AnimatedToasterParentData;
      current.layout(constraints, parentUsesSize: true);
      current = data.nextSibling;
    }

    size = constraints.tighten(height: 400).biggest;
  }

  // TODO: Fetch from style.
  static const behindScale = 0.9;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (childCount == 0) {
      return;
    }

    // We assume the toast's size at the forefront is the target.
    final target = lastChild!.size;

    var current = firstChild;
    var distanceFromFront = childCount - 1;

    while (current != lastChild && current != null) {
      final data = current.parentData! as AnimatedToasterParentData;

      // Each consecutive toast should be slightly smaller.
      //
      // Calculate target sizes explicitly for each toast based on its distance from front rather than iteratively,
      // since toasts need to be painted in reverse order of their size reduction.
      final targetWidth = target.width * pow(behindScale, distanceFromFront);
      final targetHeight = target.height * pow(behindScale, distanceFromFront);
      distanceFromFront--;

      // Calculate base scaling factors from current size to target size.
      final baseWidth = lerpDouble(current.size.width, targetWidth, data.shift)!;
      final baseHeight = lerpDouble(current.size.height, targetHeight, data.shift)!;

      final baseScaleX = baseWidth / current.size.width;
      final baseScaleY = baseHeight / current.size.height;

      // Interpolate between the base scale and 1.0 based on expand
      // When expand is 1.0, we use a scale of 1.0 (no scaling)
      // When expand is 0.0, we use the base scale calculation
      final scaleX = lerpDouble(baseScaleX, 1.0, expand)!;
      final scaleY = lerpDouble(baseScaleY, 1.0, expand)!;

      context.pushTransform(
        needsCompositing,
        data.offset + offset,
        Matrix4.diagonal3Values(scaleX, scaleY, 1.0),
        (context, offset) => context.paintChild(current!, offset),
      );

      current = data.nextSibling;
    }

    context.paintChild(lastChild!, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  Offset get behindTransform => _shiftTransform;

  set behindTransform(Offset value) {
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

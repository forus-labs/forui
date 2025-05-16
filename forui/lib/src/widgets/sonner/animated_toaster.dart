import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/sonner/animated_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class AnimatedToaster extends MultiChildRenderObjectWidget {
  /// A unit vector indicating how a toast should be aligned to the toast in front of it.
  ///
  /// For example, `Offset(0, -1)` indicates that the top-center of this toast should be aligned to the top-center of
  /// the toast in front of it.
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

  // TODO: Fetch from style.
  static const behindSpacing = 12;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (childCount == 0) {
      return;
    }

    // We assume the toast's size at the front is the target. The current front toast's size may be different from
    // the previous front toast's size. We need to transition from
    final front = lastChild!.size;
    final previousFront = childCount >= 2 ? childBefore(lastChild!)!.size : front;

    var current = firstChild;
    var distanceFromFront = childCount - 1;

    while (current != lastChild && current != null) {
      final data = current.parentData! as AnimatedToasterParentData;

      // Each consecutive toast should be slightly smaller.
      //
      // Calculate target sizes explicitly for each toast based on its distance from front rather than iteratively,
      // since toasts need to be painted in reverse order of their size reduction.
      final targetWidth = front.width * pow(behindScale, distanceFromFront);
      final targetHeight = front.height * pow(behindScale, distanceFromFront);
      distanceFromFront--;

      // Calculate base scaling factors from current size to target size.
      final previousScale = pow(behindScale, data.previousIndex);
      final baseWidth = lerpDouble(previousFront.width * previousScale, targetWidth, data.indexTransition)!;
      final baseHeight = lerpDouble(previousFront.height * previousScale, targetHeight, data.indexTransition)!;

      final baseScaleX = baseWidth / current.size.width;
      final baseScaleY = baseHeight / current.size.height;

      // Interpolate between the base scale and 1.0 based on expand
      // When expand is 1.0, we use a scale of 1.0 (no scaling)
      // When expand is 0.0, we use the base scale calculation
      final scaleX = lerpDouble(baseScaleX, 1.0, expand)!;
      final scaleY = lerpDouble(baseScaleY, 1.0, expand)!;

      // The following section is responsible for translating the toast to the correct position.

      // Calculate the reference points (point of alignment).
      // This is a simplified implementation that assumes toasts are vertically stacked either on top or below another
      // toast and never purely horizontal.
      final frontReferenceX = front.width * (0.5 + behindTransform.dx * 0.5);
      final frontReferenceY = behindTransform.dy < 0 ? 0.0 : front.height;
      final thisReferenceX = (current.size.width * scaleX) * (0.5 + behindTransform.dx * 0.5);
      final thisReferenceY = behindTransform.dy < 0 ? 0.0 : (current.size.height * scaleY);

      final alignment = Offset(frontReferenceX - thisReferenceX, frontReferenceY - thisReferenceY);

      // Calculate the amount to shift the toast such that it protrudes slightly above the toast in front.
      final protrudeStart = behindSpacing * (log(data.previousIndex + 1) / log(2));
      final protrudeEnd = behindSpacing * (log(data.previousIndex + 2) / log(2));
      final protrude = behindTransform * lerpDouble(protrudeStart, protrudeEnd, data.indexTransition)! * (1 - expand);

      context.pushTransform(
        needsCompositing,
        data.offset + offset + alignment + protrude,
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

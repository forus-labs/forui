import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/rendering.dart';
import 'package:forui/src/widgets/sonner/animated_parent_data.dart';
import 'package:meta/meta.dart';

@internal
class AnimatedToaster extends MultiChildRenderObjectWidget {
  /// A unit vector indicating how a toast's protrusion should be aligned to the toast in front of it.
  ///
  /// For example, `Offset(0, -1)` indicates that the top-center of this toast's protrusion should be aligned to the
  /// top-center of the toast in front of it.
  final Offset alignmentTransform;

  /// The expansion's animation value between `[0, 1]`.
  final double expand;

  const AnimatedToaster({required this.alignmentTransform, required this.expand, super.children, super.key});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderAnimatedToaster(alignmentTransform: alignmentTransform, expand: expand);

  @override
  void updateRenderObject(BuildContext context, covariant RenderAnimatedToaster renderObject) =>
      renderObject
        ..alignmentTransform = alignmentTransform
        ..expand = expand;
}

@internal
class RenderAnimatedToaster extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, AnimatedToasterParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, AnimatedToasterParentData> {
  Offset _alignmentTransform;
  double _expand;

  /// Creates a [RenderAnimatedToaster].
  RenderAnimatedToaster({required Offset alignmentTransform, required double expand})
    : _alignmentTransform = alignmentTransform,
      _expand = expand;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! AnimatedToasterParentData) {
      child.parentData = AnimatedToasterParentData();
    }
  }

  // TODO: Fetch from style.
  static const style = (behindScale: 0.9, expansionStartSpacing: 16.0, expansionSpacing: 10.0, protrusion: 12.0);

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    var current = lastChild;
    var previousHeight = 0.0;
    var accumulated = alignmentTransform.dy * style.expansionStartSpacing;

    // First pass: calculate the offset to move the toasts when expanded, relative to (0, 0).
    //
    // This is a simplified implementation that assumes toasts can only be vertically stacked.
    // I'm not fucking doing this for every possible alignment. You're welcome to open a PR if you want it. >:(
    while (current != null) {
      final data = current.parentData! as AnimatedToasterParentData;
      current.layout(constraints, parentUsesSize: true);

      if (_alignmentTransform.dy < 0) {
        // Calculate the additional offset to move the current toast when expanded.
        // Top aligned toasts use the current height as the offset.
        final iterationHeight = current == lastChild ? 0.0 : -current.size.height;
        accumulated += iterationHeight;

        // Top aligned toasts' origins are affected by the previous front toast and not the current front toast. This is
        // because the front toast's content is rendered after (0, 0) in the 1st quadrant.
        final affectingHeight = switch (current) {
          _ when current == lastChild! => 0.0,
          _ when current == childBefore(lastChild!) => current.size.height, // TODO: do we need this case?
          _ => childBefore(lastChild!)!.size.height,
        };

        current.data.offset = Offset(
          current.data.offset.dx,
          lerpDouble(accumulated + affectingHeight, accumulated, data.shift)! * expand,
        );
      } else {
        // Calculate the additional offset to move the current toast when expanded.
        // Bottom aligned toasts use the height of the toast in front as the offset.
        final iterationHeight = previousHeight;
        accumulated += iterationHeight;

        final front = current == lastChild ? Size.zero : lastChild!.size;
        final previous = accumulated - alignmentTransform.dy * style.expansionSpacing - front.height;

        current.data.offset = Offset(current.data.offset.dx, lerpDouble(previous, accumulated, data.shift)! * expand);
      }

      accumulated += alignmentTransform.dy * style.expansionSpacing;

      previousHeight = current.size.height;
      current = data.previousSibling;
    }

    // Transition between previous front and front toast if their sizes are different.
    final front = lastChild!;
    final data = front.parentData! as AnimatedToasterParentData;
    final previousFront = childCount >= 2 ? childBefore(lastChild!)! : front;

    // Transition between collapsed and expanded sizes.
    final frontSize = Size.lerp(previousFront.size, front.size, data.transition)!;
    final expandedSize = Size(front.size.width, front.size.height + accumulated.abs());
    size = constraints.constrain(Size.lerp(frontSize, expandedSize, expand * data.transition)!);

    // Second pass: Shifts offsets if the [alignmentTransform] is negative (toaster expands leftwards/upwards).
    if (!alignmentTransform.dx.isNegative && !alignmentTransform.dy.isNegative) {
      return;
    }

    // Calculate the shift needed for each dimension
    final translateY = accumulated.isNegative ? -accumulated * data.shift * expand : 0.0;

    var child = firstChild;
    while (child != null) {
      final data = child.parentData! as AnimatedToasterParentData;
      data.offset = data.offset.translate(0, translateY);

      child = data.nextSibling;
    }
  }

  /// Scales and aligns toasts before painting them.
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
      // The following section is responsible for scaling the toast to match the size of the frontmost toast.

      // Each consecutive toast should be slightly smaller.
      //
      // Calculate target sizes explicitly for each toast based on its distance from front rather than iteratively,
      // since toasts need to be painted in reverse order of their size reduction.
      final targetWidth = front.width * pow(style.behindScale, distanceFromFront);
      final targetHeight = front.height * pow(style.behindScale, distanceFromFront);
      distanceFromFront--;

      // Calculate base scaling factors from current size to target size.
      final previousScale = pow(style.behindScale, data.previousIndex);
      final baseWidth = lerpDouble(previousFront.width * previousScale, targetWidth, data.scale)!;
      final baseHeight = lerpDouble(previousFront.height * previousScale, targetHeight, data.scale)!;

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
      final frontReferenceX = front.width * (0.5 + alignmentTransform.dx * 0.5);
      final frontReferenceY = alignmentTransform.dy < 0 ? 0.0 : front.height;
      final thisReferenceX = (current.size.width * scaleX) * (0.5 + alignmentTransform.dx * 0.5);
      final thisReferenceY = alignmentTransform.dy < 0 ? 0.0 : (current.size.height * scaleY);

      final alignment = Offset(frontReferenceX - thisReferenceX, frontReferenceY - thisReferenceY);

      // Calculate the amount to shift the toast such that it protrudes slightly above the toast in front.
      final start = style.protrusion * (log(data.previousIndex + 1) / log(2));
      final end = style.protrusion * (log(data.index + 1) / log(2));
      final protrusion = alignmentTransform * lerpDouble(start, end, data.scale)! * (1 - expand);

      // Remove translation when expanded
      final translation = (alignment + protrusion) * (1 - expand);

      context.pushTransform(
        needsCompositing,
        data.offset + offset + translation,
        Matrix4.diagonal3Values(scaleX, scaleY, 1.0),
        (context, offset) => context.paintChild(current!, offset),
      );

      current = data.nextSibling;
    }

    context.paintChild(lastChild!, lastChild!.data.offset + offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  Offset get alignmentTransform => _alignmentTransform;

  set alignmentTransform(Offset value) {
    if (_alignmentTransform == value) {
      return;
    }

    _alignmentTransform = value;
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('expand', expand))
      ..add(DiagnosticsProperty('alignmentTransform', alignmentTransform));
  }
}

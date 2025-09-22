import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/toast/animated_toaster_parent_data.dart';

/// The [AnimatedToaster] that is responsible for coordinating the animation, layout and painting of toasts.
@internal
class AnimatedToaster extends MultiChildRenderObjectWidget {
  /// The toaster's style.
  final FToasterStyle style;

  /// A unit vector indicating how a toasts should be aligned to the front-most toast when expanded
  ///
  /// For example, `Offset(1, 0)` indicates that all toasts ahould be aligned to the right edge.
  final Offset expandedAlignTransform;

  /// A unit vector indicating how a toast's protrusion should be aligned to the toast in front of it.
  ///
  /// For example, `Offset(0, -1)` indicates that the top-center of this toast's protrusion should be aligned to the
  /// top-center of the toast in front of it.
  final Offset collapsedAlignTransform;

  /// The expansion's animation value between `[0, 1]`.
  final double expand;

  const AnimatedToaster({
    required this.style,
    required this.expandedAlignTransform,
    required this.collapsedAlignTransform,
    required this.expand,
    super.children,
    super.key,
  });

  @override
  RenderObject createRenderObject(BuildContext context) => RenderAnimatedToaster(
    style: style,
    expandedAlignTransform: expandedAlignTransform,
    collapsedAlignTransform: collapsedAlignTransform,
    expand: expand,
  );

  @override
  void updateRenderObject(BuildContext context, covariant RenderAnimatedToaster renderObject) => renderObject
    ..style = style
    ..expandedAlignTransform = expandedAlignTransform
    ..collapsedAlignTransform = collapsedAlignTransform
    ..expand = expand;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('style', style))
      ..add(DiagnosticsProperty('expandedAlignTransform', expandedAlignTransform))
      ..add(DiagnosticsProperty('collapsedAlignTransform', collapsedAlignTransform))
      ..add(PercentProperty('expand', expand));
  }
}

@internal
class RenderAnimatedToaster extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, AnimatedToasterParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, AnimatedToasterParentData> {
  FToasterStyle _style;
  Offset _expandedAlignTransform;
  Offset _collapsedAlignTransform;
  double _expand;

  /// Creates a [RenderAnimatedToaster].
  RenderAnimatedToaster({
    required FToasterStyle style,
    required Offset expandedAlignTransform,
    required Offset collapsedAlignTransform,
    required double expand,
  }) : _style = style,
       _expandedAlignTransform = expandedAlignTransform,
       _collapsedAlignTransform = collapsedAlignTransform,
       _expand = expand;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! AnimatedToasterParentData) {
      child.parentData = AnimatedToasterParentData();
    }
  }

  /// Performs the layout of all toast children, handling both collapsed and expanded states.
  ///
  /// Terminology:
  /// * "Previous front toast" - The toast that was at the front before the current front toast.
  ///
  /// This method orchestrates a complex two-phase layout process:
  ///
  /// **Phase 1: Calculate vertical positioning and spacing**
  /// - Iterates through toasts from back to front (lastChild to firstChild)
  /// - Calculates accumulated heights for proper vertical stacking
  /// - Handles different alignment modes (top-aligned vs bottom-aligned toasts)
  /// - Computes smooth transitions between collapsed and expanded positions
  /// - Maintains separate tracking for visible vs all toasts to handle proper spacing
  ///
  /// **Phase 2: Calculate final positions and container size**
  /// - Transitions between previous front toast and current front toast sizes
  /// - Interpolates between collapsed size (based on front toast) and expanded size (includes all visible toast heights)
  /// - Applies horizontal alignment transformations (left/center/right positioning)
  /// - Sets final offsets for each toast child
  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    var current = lastChild;
    var previousHeight = 0.0;

    // We track the accumulated & visible accumulated heights separately so that the toaster will be displayed correctly
    // when expanded & the toasts will not occupy more space than available.
    var accumulated = collapsedAlignTransform.dy * style.expandStartSpacing;
    var visibleAccumulated = collapsedAlignTransform.dy * style.expandStartSpacing;

    // Phase 1: calculate the offset to move the toasts when expanded, relative to (0, 0).
    //
    // This is a simplified implementation that assumes toasts can only be vertically stacked.
    // I'm not doing this for every possible alignment. You're welcome to open a PR if you want it. >:(
    while (current != null) {
      final data = current.parentData! as AnimatedToasterParentData;
      current.layout(constraints, parentUsesSize: true);

      if (_collapsedAlignTransform.dy < 0) {
        // Calculate the additional offset to move the current toast when expanded.
        // Top aligned toasts use the current height as the offset.
        final iterationHeight = current == lastChild ? 0.0 : -current.size.height;
        accumulated += iterationHeight;
        if (data.visible) {
          visibleAccumulated += iterationHeight;
        }

        // Top aligned toasts' origins are affected by the previous front toast and not the current front toast. This is
        // because toasts stack downward from the origin, so each toast's position depends on the height of the toast
        // above it.
        final affectingHeight = current == lastChild ? 0.0 : childBefore(lastChild!)!.size.height;
        final begin = data.shift.begin ??= accumulated + affectingHeight;
        final end = data.shift.end ??= accumulated;
        final value = data.shift.value = lerpDouble(begin, end, data.transition)! * expand;

        data.offset = Offset(data.offset.dx, value);
      } else {
        // Calculate the additional offset to move the current toast when expanded.
        // Bottom aligned toasts use the height of the toast in front as the offset.
        final iterationHeight = previousHeight;
        accumulated += iterationHeight;
        if (data.visible) {
          visibleAccumulated += iterationHeight;
        }

        final front = current == lastChild ? Size.zero : lastChild!.size;
        final begin = data.shift.begin ??=
            accumulated - collapsedAlignTransform.dy * style.expandSpacing - front.height;
        final end = data.shift.end ??= accumulated;
        final value = data.shift.value = lerpDouble(begin, end, data.transition)! * expand;

        data.offset = Offset(data.offset.dx, value);
      }

      accumulated += collapsedAlignTransform.dy * style.expandSpacing;
      if (data.visible) {
        visibleAccumulated += collapsedAlignTransform.dy * style.expandSpacing;
      }

      previousHeight = current.size.height;
      current = data.previousSibling;
    }

    // Phase 2:
    // Transition between previous front and front toast if their sizes are different.
    final front = lastChild!;
    final data = front.parentData! as AnimatedToasterParentData;

    final Size previousFrontSize;
    if (childCount >= 2) {
      // Save the front toast's size as the previous front toast.
      // Allows us to properly transition when there is only 1 remaining toast after the front toast is removed.
      final previous = childBefore(lastChild!)!;
      previousFrontSize = previous.size;
      (previous.parentData! as AnimatedToasterParentData).collapsedUntransformedSize = front.size;
    } else {
      previousFrontSize = data.collapsedUntransformedSize ?? front.size;
    }

    // Transition between collapsed and expanded sizes.
    final collapsedSize = Size.lerp(previousFrontSize, front.size, data.transition)!;

    final baseHeight = collapsedAlignTransform.dy.isNegative ? front.size.height : firstChild!.size.height;
    final expandedSize = Size(front.size.width, baseHeight + visibleAccumulated.abs());

    size = constraints.constrain(Size.lerp(collapsedSize, expandedSize, expand * data.transition)!);

    final translateY = visibleAccumulated.isNegative ? -visibleAccumulated * data.transition * expand : 0.0;
    var child = firstChild;
    while (child != null) {
      final data = child.parentData! as AnimatedToasterParentData;
      // Horizontally aligns the toast to the left, center or right based on [expandedAlignTransform].
      final translateX =
          data.transition *
          expand *
          switch (expandedAlignTransform.dx) {
            -1 => 0,
            0 => (size.width - child.size.width) / 2,
            _ => size.width - child.size.width,
          };

      data.offset = Offset(translateX, data.offset.dy + translateY);

      child = data.nextSibling;
    }
  }

  /// Scales and aligns toasts before painting them.
  @override
  void paint(PaintingContext context, Offset offset) {
    if (childCount == 0) {
      return;
    }

    // We assume the toast's size at the front is the target.
    final front = lastChild!.size;

    var current = firstChild;
    while (current != null) {
      final data = current.parentData! as AnimatedToasterParentData;
      if (current.size.isEmpty) {
        current = data.nextSibling;
        continue;
      }

      // The following section is responsible for scaling the toast to match the size of the frontmost toast.

      // Each consecutive toast should be slightly smaller.
      final target = data.scale.end ??= front * pow(style.collapsedScale, data.index.current).toDouble();

      // Calculate base scaling factors from current size to target size.
      final currentSize = data.scale.begin ??= current.size;

      final baseWidth = lerpDouble(currentSize.width, target.width, data.transition)!;
      final baseHeight = lerpDouble(currentSize.height, target.height, data.transition)!;
      data.scale.value = Size(baseWidth, baseHeight);

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
      final frontX = front.width * (0.5 + collapsedAlignTransform.dx * 0.5);
      final frontY = collapsedAlignTransform.dy < 0 ? 0.0 : front.height;
      final thisX = (current.size.width * scaleX) * (0.5 + collapsedAlignTransform.dx * 0.5);
      final thisY = collapsedAlignTransform.dy < 0 ? 0.0 : (current.size.height * scaleY);

      final alignmentBegin = data.alignment.begin ??= Offset.zero;
      // We don't set data.alignment.end as this constantly changes.
      final alignmentEnd = Offset(frontX - thisX, frontY - thisY);
      final alignment = data.alignment.value = Offset.lerp(alignmentBegin, alignmentEnd, data.transition)!;

      // Calculate the amount to shift the toast such that it protrudes slightly above the toast in front.
      final begin = data.protrusion.begin ??= style.collapsedProtrusion * (log(data.index.previous + 1) / log(2));
      final end = data.protrusion.end ??= style.collapsedProtrusion * (log(data.index.current + 1) / log(2));
      final protrusion = data.protrusion.value = lerpDouble(begin, end, data.transition)!;

      context.pushTransform(
        needsCompositing,
        data.offset + offset + (alignment + collapsedAlignTransform * protrusion) * (1 - expand),
        Matrix4.diagonal3Values(scaleX, scaleY, 1.0),
        (context, offset) => context.paintChild(current!, offset),
      );

      current = data.nextSibling;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);

  FToasterStyle get style => _style;

  set style(FToasterStyle value) {
    if (_style == value) {
      return;
    }

    _style = value;
    markNeedsLayout();
  }

  Offset get expandedAlignTransform => _expandedAlignTransform;

  set expandedAlignTransform(Offset value) {
    if (_expandedAlignTransform == value) {
      return;
    }

    _expandedAlignTransform = value;
    markNeedsLayout();
  }

  Offset get collapsedAlignTransform => _collapsedAlignTransform;

  set collapsedAlignTransform(Offset value) {
    if (_collapsedAlignTransform == value) {
      return;
    }

    _collapsedAlignTransform = value;
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
      ..add(DiagnosticsProperty('style', style))
      ..add(DoubleProperty('expand', expand))
      ..add(DiagnosticsProperty('expandedAlignTransform', expandedAlignTransform))
      ..add(DiagnosticsProperty('collapsedAlignTransform', collapsedAlignTransform));
  }
}

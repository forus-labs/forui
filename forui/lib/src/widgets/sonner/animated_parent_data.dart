import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:forui/src/widgets/sonner/animated_toaster.dart';
import 'package:meta/meta.dart';

@internal
class Animated extends ParentDataWidget<AnimatedToasterParentData> {
  final double transition;

  /// The animation progress for shifting a toast whenever another toast is inserted or removed.
  final double indexTransition;

  /// The current index of the toast in the toaster.
  final double index;

  /// The previous index of the toast in the toaster.
  final double previousIndex;

  const Animated({
    required this.transition,
    required this.indexTransition,
    required this.index,
    required this.previousIndex,
    required super.child,
    super.key,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    assert(
      renderObject.parentData is AnimatedToasterParentData,
      'Parent data must be of type AnimatedToasterParentData',
    );

    final data = renderObject.parentData! as AnimatedToasterParentData;
    var needsLayout = false;

    if (data.transition != transition) {
      data.transition = transition;
      needsLayout = true;
    }

    if (data.indexTransition != indexTransition) {
      data.indexTransition = indexTransition;
      needsLayout = true;
    }

    if (data.index != index) {
      data.index = index;
      needsLayout = true;
    }

    if (data.previousIndex != previousIndex) {
      data.previousIndex = previousIndex;
      needsLayout = true;
    }

    if (needsLayout) {
      renderObject.parent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => AnimatedToaster;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('shift', indexTransition));
  }
}

/// Parent data for use with [RenderAnimatedToaster].
@internal
class AnimatedToasterParentData extends ContainerBoxParentData<RenderBox> {
  /// The animation progress for shifting a toast whenever another toast is inserted or removed.
  double transition = 0;

  /// The animation progress for transitioning from one index to another.
  double indexTransition = 0;

  /// The current index of the toast in the toaster.
  double index = 0;

  /// The previous index of the toast in the toaster.
  double previousIndex = 0;
}

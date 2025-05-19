import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:forui/src/widgets/sonner/animated_toaster.dart';
import 'package:meta/meta.dart';

@internal
class Animated extends ParentDataWidget<AnimatedToasterParentData> {
  /// The current index of the toast in the toaster.
  final double index;

  /// The previous index of the toast in the toaster.
  final double previousIndex;

  /// The animation progress for entrance & exit animations.
  final double transition;

  /// The animation progress for scaling a toast whenever another toast is inserted or removed.
  final double scale;

  final double shift;

  final int m;

  const Animated({
    required this.index,
    required this.previousIndex,
    required this.transition,
    required this.scale,
    required this.shift,
    required this.m,
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

    if (data.index != index) {
      data.index = index;
      needsLayout = true;
    }

    if (data.previousIndex != previousIndex) {
      data.previousIndex = previousIndex;
      needsLayout = true;
    }

    if (data.transition != transition) {
      data.transition = transition;
      needsLayout = true;
    }

    if (data.scale != scale) {
      data.scale = scale;
      needsLayout = true;
    }

    if (data.shift != shift) {
      data.shift = shift;
      needsLayout = true;
    }

    if (data.m != m) {
      data.m = m;
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
    properties.add(DoubleProperty('shift', scale));
  }
}

/// Parent data for use with [RenderAnimatedToaster].
@internal
class AnimatedToasterParentData extends ContainerBoxParentData<RenderBox> {
  /// The current index of the toast in the toaster.
  double index = 0;

  /// The previous index of the toast in the toaster.
  double previousIndex = 0;

  /// The animation progress for entrance & exit animations.
  double transition = 0;

  /// The animation progress for transitioning from one index to another.
  double scale = 0;

  double shift = 0;

  int _monotonic = 0;

  double help = 0;

  int get m => _monotonic;

  set m(int value) {
    if (_monotonic == value) {
      return;
    }

    _monotonic = value;
    print('set m');
    print(help);
  }
}

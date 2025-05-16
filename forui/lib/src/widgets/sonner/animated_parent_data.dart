import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:forui/src/widgets/sonner/animated_toaster.dart';
import 'package:meta/meta.dart';

@internal
class Animated extends ParentDataWidget<AnimatedToasterParentData> {
  /// The animation progress for shifting a toast whenever another toast is inserted or removed.
  final double index;

  final double previous;

  const Animated({required this.index, required this.previous, required super.child, super.key});

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

    if (data.previous != previous) {
      data.previous = previous;
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
    properties.add(DoubleProperty('shift', index));
  }
}

/// Parent data for use with [RenderAnimatedToaster].
@internal
class AnimatedToasterParentData extends ContainerBoxParentData<RenderBox> {
  /// The origin.
  Offset shiftOrigin = Offset.zero;

  double previous = 0;

  /// The animation progress for shifting a toast whenever another toast is inserted or removed.
  double index = 0;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/resizable_box/resizable_box.dart';
import 'package:forui/src/widgets/resizable_box/resizable_box_controller.dart';
import 'package:forui/src/widgets/resizable_box/slider.dart';
import 'package:sugar/sugar.dart';

/// A resizable that can be resized along an axis. It should always be in a [FResizableBox].
class FResizable extends StatelessWidget {
  static double _platform(double? slider) =>
      slider ??
      switch (const Runtime().type) {
        PlatformType.android || PlatformType.ios => 50,
        _ => 5,
      };

  /// The initial height or width of this region.
  ///
  /// ## Contract
  /// Throws a [AssertionError] if [initialSize] is not positive.
  final double initialSize;

  /// The minimum height/width along the resizable axis.
  ///
  /// The minimum size is either the given minimum size or 2 * [sliderSize], whichever is larger. Defaults to
  /// 2 * [sliderSize] if not given. A larger [sliderSize] may increase the minimum region size.
  final double minSize;

  /// The sliders' height/width along the resizable axis.
  ///
  /// Defaults to `50` on Android and iOS, and `5` on other platforms.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [sliderSize] is not positive.
  final double sliderSize;

  /// The builder used to create a child to display in this region.
  final ValueWidgetBuilder<FResizableData> builder;

  /// A height/width-independent widget which is passed back to the [builder].
  ///
  /// This argument is optional and can be null if the entire widget subtree the [builder] builds depends on the size of
  /// the region.
  final Widget? child;

  /// Creates a [FResizable].
  FResizable.raw({
    required this.initialSize,
    required this.builder,
    double? minSize,
    double? sliderSize,
    this.child,
    super.key,
  })  : assert(0 < initialSize, 'The initial size should be positive, but it is $initialSize.'),
        minSize = max(minSize ?? 0, 2 * (sliderSize ?? _platform(sliderSize))),
        sliderSize = sliderSize ?? _platform(sliderSize) {
    assert(
      2 * this.sliderSize <= initialSize,
      'The initial size, $initialSize is less than the required minimum size, ${2 * this.sliderSize}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final InheritedData(:controller, :data) = InheritedData.of(context);
    return Semantics(
      container: true,
      enabled: controller.interaction is Resize || data.selected,
      selected: data.selected,
      child: MouseRegion(
        cursor: controller.interaction is Resize || data.selected ? MouseCursor.defer : SystemMouseCursors.click,
        child: GestureDetector(
          onTap: switch (controller.interaction) {
            SelectAndResize _ => () {
                if (controller.select(data.index) && controller.hapticFeedbackVelocity != null) {
                  // TODO: haptic feedback
                }
              },
            Resize _ => null,
          },
          child: switch (controller.axis) {
            Axis.horizontal => SizedBox(
                width: data.size,
                child: Stack(
                  children: [
                    builder(context, data, child),
                    if (data.index > 0) HorizontalSlider.left(controller: controller, index: data.index, size: sliderSize),
                    if (data.index < controller.resizables.length - 1)
                      HorizontalSlider.right(controller: controller, index: data.index, size: sliderSize),
                  ],
                ),
              ),
            Axis.vertical => SizedBox(
                height: data.size,
                child: Stack(
                  children: [
                    builder(context, data, child),
                    if (data.index > 0) VerticalSlider.up(controller: controller, index: data.index, size: sliderSize),
                    if (data.index < controller.resizables.length - 1)
                      VerticalSlider.down(controller: controller, index: data.index, size: sliderSize),
                  ],
                ),
              ),
          },
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('initialSize', initialSize))
      ..add(DoubleProperty('minSize', minSize))
      ..add(DoubleProperty('sliderSize', sliderSize))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(DiagnosticsProperty('child', child));
  }
}

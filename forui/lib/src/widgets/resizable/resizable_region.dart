import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/resizable/resizable.dart';
import 'package:forui/src/widgets/resizable/resizable_controller.dart';
import 'package:forui/src/widgets/resizable/slider.dart';
import 'package:sugar/sugar.dart';

/// A resizable region that can be resized along the parent [FResizable]'s axis. It should always be in a [FResizable].
///
/// See:
/// * https://forui.dev/docs/resizable for working examples.
class FResizableRegion extends StatelessWidget {
  static double _platform(double? slider) =>
      slider ??
      switch (const Runtime().type) {
        PlatformType.android || PlatformType.ios => 50,
        _ => 5,
      };

  /// The initial height/width, in logical pixels.
  ///
  /// ## Contract
  /// Throws a [AssertionError] if:
  /// * [initialSize] is not positive
  /// * [initialSize] < [minSize]
  final double initialSize;

  /// The minimum height/width along the resizable axis, in logical pixels.
  ///
  /// The minimum size is either the given minimum size or 2 * [sliderSize], whichever is larger. Defaults to
  /// 2 * [sliderSize] if not given.
  final double minSize;

  /// The sliders' height/width along the resizable axis. A larger [sliderSize] may increase [minSize] if it is not
  /// given.
  ///
  /// Defaults to `50` on Android and iOS, and `5` on other platforms.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [sliderSize] is not positive.
  final double sliderSize;

  /// The builder used to create a child to display in this region.
  final ValueWidgetBuilder<FResizableRegionData> builder;

  /// A height/width-independent widget which is passed back to the [builder].
  ///
  /// This argument is optional and can be null if the entire widget subtree the [builder] builds depends on the size of
  /// the region.
  final Widget? child;

  /// Creates a [FResizableRegion].
  FResizableRegion.raw({
    required this.initialSize,
    required this.builder,
    double? minSize,
    double? sliderSize,
    this.child,
    super.key,
  })  : assert(
          0 < initialSize,
          'The initial size should be positive, but it is $initialSize.',
        ),
        assert(
          minSize == null || 0 < minSize,
          'The min size should be positive, but it is $minSize.',
        ),
        assert(
          sliderSize == null || 0 < sliderSize,
          'The slider size should be positive, but it is $sliderSize.',
        ),
        minSize = max(minSize ?? 0, 2 * (sliderSize ?? _platform(sliderSize))),
        sliderSize = sliderSize ?? _platform(sliderSize) {
    assert(
      this.minSize <= initialSize,
      'The initial size, $initialSize is less than the required minimum size, ${this.minSize}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final InheritedData(:controller, :data) = InheritedData.of(context);
    final enabled = controller.interaction is Resize || data.selected;
    return Semantics(
      container: true,
      enabled: enabled,
      selected: data.selected,
      child: MouseRegion(
        cursor: enabled ? MouseCursor.defer : SystemMouseCursors.click,
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
                width: data.size.current,
                child: Stack(
                  children: [
                    builder(context, data, child),
                    if (data.index > 0)
                      HorizontalSlider.left(
                        controller: controller,
                        index: data.index,
                        size: sliderSize,
                      ),
                    if (data.index < controller.regions.length - 1)
                      HorizontalSlider.right(
                        controller: controller,
                        index: data.index,
                        size: sliderSize,
                      ),
                  ],
                ),
              ),
            Axis.vertical => SizedBox(
                height: data.size.current,
                child: Stack(
                  children: [
                    builder(context, data, child),
                    if (data.index > 0)
                      VerticalSlider.up(
                        controller: controller,
                        index: data.index,
                        size: sliderSize,
                      ),
                    if (data.index < controller.regions.length - 1)
                      VerticalSlider.down(
                        controller: controller,
                        index: data.index,
                        size: sliderSize,
                      ),
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

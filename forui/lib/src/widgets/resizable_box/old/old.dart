import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/resizable_box/resized.dart';
import 'package:sugar/sugar.dart';

/// A [FResizable] is a region in a [FResizableBox].
///
/// Each region has a minimum size determined by `2 * [sliderSize]`.
class FResizable {
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

  /// The sliders' height/width along the resizable axis.
  ///
  /// Defaults to `50` on Android and iOS, and `5` on other platforms.
  ///
  /// A [FResizable] always has 2 sliders. The minimum size of a region is determined by the sum of the sliders' size.
  /// A larger [sliderSize] will increase the minimum region size.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [sliderSize] is not positive.
  final double sliderSize;

  /// The builder used to create a child to display in this region.
  final ValueWidgetBuilder<Resized> builder;

  /// A height/width-independent widget which is passed back to the [builder].
  ///
  /// This argument is optional and can be null if the entire widget subtree the [builder] builds depends on the size of
  /// the region.
  final Widget? child;

  /// Creates a [FResizable].
  FResizable({required this.initialSize, required this.builder, double? sliderSize, this.child})
      : sliderSize = _platform(sliderSize),
        assert(0 < initialSize, 'The initial size should be positive, but it is $initialSize.') {
    assert(0 < this.sliderSize, 'The slider size should be positive, but it is $sliderSize.');
    assert(
      2 * this.sliderSize <= initialSize,
      'The initial size, $initialSize is less than the required minimum size, ${2 * this.sliderSize}.',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FResizable &&
          runtimeType == other.runtimeType &&
          initialSize == other.initialSize &&
          sliderSize == other.sliderSize &&
          builder == other.builder &&
          child == other.child;

  @override
  int get hashCode => initialSize.hashCode ^ sliderSize.hashCode ^ builder.hashCode ^ child.hashCode;
}

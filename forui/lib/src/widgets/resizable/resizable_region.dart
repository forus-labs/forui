import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/doubles.dart';
import 'package:forui/src/widgets/resizable/resizable.dart';

/// A resizable region that can be resized along the parent [FResizable]'s axis. It should always be in a [FResizable].
///
/// See https://forui.dev/docs/layout/resizable for working examples.
class FResizableRegion extends StatelessWidget {
  /// The initial extent along the resizable axis, in logical pixels.
  ///
  /// ## Contract
  /// Throws a [AssertionError] if:
  /// * [initialExtent] is not positive
  /// * [initialExtent] < [minExtent]
  final double initialExtent;

  /// The minimum extent along the resizable axis, in logical pixels.
  ///
  /// The effective minimum extent is either the given minimum extent or [FResizable.hitRegionExtent], whichever is
  /// larger. Defaults to [FResizable.hitRegionExtent] if not given.
  final double? minExtent;

  /// The builder used to create a child to display in this region.
  final ValueWidgetBuilder<FResizableRegionData> builder;

  /// A height/width-independent widget which is passed back to the [builder].
  ///
  /// This argument is optional and can be null if the entire widget subtree the [builder] builds depends on the size of
  /// the region.
  final Widget? child;

  /// Creates a [FResizableRegion].
  FResizableRegion({required this.initialExtent, required this.builder, this.minExtent, this.child, super.key})
    : assert(0 < initialExtent, 'initialExtent ($initialExtent) must be > 0'),
      assert(minExtent == null || 0 < minExtent, 'minExtent ($minExtent) must be > 0'),
      assert(
        minExtent == null || minExtent.lessOrAround(initialExtent),
        'minExtent ($minExtent) must be < initialExtent ($initialExtent)',
      );

  /// Creates a [FResizableRegion].
  ///
  /// This is identical to [FResizableRegion.new], allowing dot-shorthand construction.
  factory FResizableRegion.region({
    required double initialExtent,
    required ValueWidgetBuilder<FResizableRegionData> builder,
    double? minExtent,
    Widget? child,
    Key? key,
  }) = FResizableRegion;

  @override
  Widget build(BuildContext context) {
    final InheritedData(:axis, :data) = InheritedData.of(context);
    return Semantics(
      container: true,
      child: GestureDetector(
        child: switch (axis) {
          .horizontal => SizedBox(width: data.extent.current, child: builder(context, data, child)),
          .vertical => SizedBox(height: data.extent.current, child: builder(context, data, child)),
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('initialExtent', initialExtent))
      ..add(DoubleProperty('minExtent', minExtent))
      ..add(ObjectFlagProperty.has('builder', builder));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';

export '/src/widgets/resizable/resizable_region.dart';
export 'resizable_controller.dart';
export '/src/widgets/resizable/resizable_region_data.dart' hide UpdatableResizableRegionData;

/// A resizable which children can be resized along either the horizontal or vertical main axis.
///
/// Each child is a [FResizableRegion] has a initial size and minimum size. Setting an initial size less than the
/// minimum size will result in undefined behaviour. The children are arranged from top to bottom, or left to right,
/// depending on the main [axis].
///
/// Although not required, it is recommended that a [FResizable] contains at least 2 [FResizable] regions.
///
/// See:
/// * https://forui.dev/docs/resizable for working examples.
class FResizable extends StatefulWidget {
  /// The controller that manages the resizing of regions in this resizable. Defaults to [FResizableController.new].
  final FResizableController controller;

  /// The main axis along which the [children] can be resized.
  final Axis axis;

  /// The number of pixels in the non-resizable axis.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [crossAxisExtent] is not positive.
  final double? crossAxisExtent;

  /// The children that may be resized.
  final List<FResizableRegion> children;

  /// Creates a [FResizable].
  FResizable({
    required this.axis,
    required this.children,
    this.crossAxisExtent,
    FResizableController? controller,
    super.key,
  })  : assert(
          crossAxisExtent == null || 0 < crossAxisExtent,
          'The crossAxisExtent should be positive, but it is $crossAxisExtent.',
        ),
        controller = controller ?? FResizableController();

  @override
  State<StatefulWidget> createState() => _FResizableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(EnumProperty('axis', axis))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(IterableProperty('children', children));
  }
}

class _FResizableState extends State<FResizable> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update();
  }

  @override
  void didUpdateWidget(FResizable old) {
    super.didUpdateWidget(old);
    if (widget.axis != old.axis ||
        widget.crossAxisExtent != old.crossAxisExtent ||
        widget.controller != old.controller ||
        !widget.children.equals(old.children)) {
      _update();
    }
  }

  void _update() {
    var minOffset = 0.0;
    final allRegionsMin = widget.children.sum((child) => child.minSize, initial: 0.0);
    final allRegions = widget.children.sum((child) => child.initialSize, initial: 0.0);
    final regions = [
      for (final (index, region) in widget.children.indexed)
        FResizableRegionData(
          index: index,
          size: (min: region.minSize, max: allRegions - allRegionsMin + region.minSize, allRegions: allRegions),
          offset: (min: minOffset, max: minOffset += region.initialSize),
        ),
    ];

    widget.controller.regions.clear();
    widget.controller.regions.addAll(regions);
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.controller.regions.length == widget.children.length,
      'The number of FResizableData should be equal to the number of children. Please file a bug report.',
    );

    if (widget.axis == Axis.horizontal) {
      return SizedBox(
        height: widget.crossAxisExtent,
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.children.length; i++)
                InheritedData(
                  axis: widget.axis,
                  controller: widget.controller,
                  data: widget.controller.regions[i],
                  child: widget.children[i],
                ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox(
        width: widget.crossAxisExtent,
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.children.length; i++)
                InheritedData(
                  axis: widget.axis,
                  controller: widget.controller,
                  data: widget.controller.regions[i],
                  child: widget.children[i],
                ),
            ],
          ),
        ),
      );
    }
  }
}

@internal
class InheritedData extends InheritedWidget {
  static InheritedData of(BuildContext context) {
    final InheritedData? result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context. Is there a parent FResizableBox?');
    return result!;
  }

  final Axis axis;
  final FResizableController controller;
  final FResizableRegionData data;

  const InheritedData({
    required this.axis,
    required this.controller,
    required this.data,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(InheritedData old) => axis != old.axis || controller != old.controller || data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('axis', axis))
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('data', data));
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';
import 'package:sugar/sugar.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/resizable_controller.dart';

export '/src/widgets/resizable/resizable_region.dart';
export '/src/widgets/resizable/resizable_controller.dart' hide ResizableController, Resize, SelectAndResize;
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
  /// The main axis along which the [children] can be resized.
  final Axis axis;

  /// The allowed way for the user to interact with this resizable box. Defaults to [FResizableInteraction.resize].
  final FResizableInteraction interaction;

  /// The number of pixels in the non-resizable axis.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [crossAxisExtent] is not positive.
  final double? crossAxisExtent;

  /// The minimum velocity, inclusive, of a drag gesture for haptic feedback to be performed
  /// on collision between two regions, defaults to 6.5.
  ///
  /// Setting it to `null` disables haptic feedback while setting it to 0 will cause
  /// haptic feedback to always be performed.
  ///
  /// ## Contract
  /// [_hapticFeedbackVelocity] should be a positive, finite number. It will otherwise
  /// result in undefined behaviour.
  final double _hapticFeedbackVelocity = 6.5; // TODO: haptic feedback

  /// The children that may be resized.
  final List<FResizableRegion> children;

  /// A function that is called when a resizable region is selected. This will only be called if [interaction] is
  /// [FResizableInteraction.selectAndResize].
  final void Function(int index)? onPress;

  /// A function that is called when a resizable region and its neighbour are being resized.
  ///
  /// This function is called *while* the regions are being resized. Most users should prefer [onResizeEnd], which is
  /// called only when the regions have finished resizing.
  final void Function(
    FResizableRegionData resized,
    FResizableRegionData neighbour,
  )? onResizeUpdate;

  /// A function that is called after a resizable region and its neighbour have been resized.
  final void Function(
    FResizableRegionData resized,
    FResizableRegionData neighbour,
  )? onResizeEnd;

  /// Creates a [FResizable].
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * [interaction] is a [FResizableInteraction.selectAndResize] and index is index < 0 or `children.length` <= index.
  FResizable({
    required this.axis,
    required this.children,
    this.interaction = const FResizableInteraction.resize(),
    this.crossAxisExtent,
    this.onPress,
    this.onResizeUpdate,
    this.onResizeEnd,
    super.key,
  }) : assert(
          crossAxisExtent == null || 0 < crossAxisExtent,
          'The crossAxisExtent should be positive, but it is $crossAxisExtent.',
        ) {
    if (interaction case SelectAndResize(:final index)) {
      assert(
        0 <= index && index < children.length,
        'The initial index should be in 0 <= initialIndex < ${children.length}, but it is $index.',
      );
    }
  }

  @override
  State<StatefulWidget> createState() => _FResizableState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('axis', axis))
      ..add(DiagnosticsProperty('interaction', interaction))
      ..add(DoubleProperty('crossAxisExtent', crossAxisExtent))
      ..add(DoubleProperty('_hapticFeedbackVelocity', _hapticFeedbackVelocity))
      ..add(IterableProperty('children', children))
      ..add(ObjectFlagProperty('onPress', onPress))
      ..add(ObjectFlagProperty('onResizeUpdate', onResizeUpdate))
      ..add(ObjectFlagProperty('onResizeEnd', onResizeEnd));
  }
}

class _FResizableState extends State<FResizable> {
  late ResizableController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _update(widget.interaction);
  }

  @override
  void didUpdateWidget(FResizable old) {
    super.didUpdateWidget(old);
    if (widget.axis != old.axis ||
        widget.interaction != old.interaction ||
        widget.crossAxisExtent != old.crossAxisExtent ||
        widget._hapticFeedbackVelocity != old._hapticFeedbackVelocity ||
        widget.onPress != widget.onPress ||
        widget.onResizeUpdate != widget.onResizeUpdate ||
        widget.onResizeEnd != widget.onResizeEnd ||
        !widget.children.equals(old.children)) {
      _update(controller.interaction);
    }
  }

  void _update(FResizableInteraction interaction) {
    final selected = switch (interaction) {
      SelectAndResize(:final index) => index,
      Resize _ => null,
    };

    var minoffset = 0.0;
    final allRegionsMin = widget.children.sum((child) => child.minSize, initial: 0.0);
    final allRegions = widget.children.sum((child) => child.initialSize, initial: 0.0);
    final regions = [
      for (final (index, region) in widget.children.indexed)
        FResizableRegionData(
          index: index,
          selected: selected == index,
          size: (min: region.minSize, max: allRegions - allRegionsMin + region.minSize, allRegions: allRegions),
          offset: (min: minoffset, max: minoffset += region.initialSize),
        ),
    ];

    controller = ResizableController(
      regions: regions,
      axis: widget.axis,
      hapticFeedbackVelocity: widget._hapticFeedbackVelocity,
      onPress: widget.onPress,
      onResizeUpdate: widget.onResizeUpdate,
      onResizeEnd: widget.onResizeEnd,
      interaction: interaction,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(
      controller.regions.length == widget.children.length,
      'The number of FResizableData should be equal to the number of children. Please file a bug report.',
    );

    if (widget.axis == Axis.horizontal) {
      return SizedBox(
        height: widget.crossAxisExtent,
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.children.length; i++)
                InheritedData(
                  controller: controller,
                  data: controller.regions[i],
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
          listenable: controller,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < widget.children.length; i++)
                InheritedData(
                  controller: controller,
                  data: controller.regions[i],
                  child: widget.children[i],
                ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('controller', controller));
  }
}

@internal
class InheritedData extends InheritedWidget {
  final ResizableController controller;
  final FResizableRegionData data;

  const InheritedData({
    required this.controller,
    required this.data,
    required super.child,
    super.key,
  });

  static InheritedData of(BuildContext context) {
    final InheritedData? result = context.dependOnInheritedWidgetOfExactType<InheritedData>();
    assert(result != null, 'No InheritedData found in context. Is there a parent FResizableBox?');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedData old) => controller != old.controller || data != old.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('controller', controller))
      ..add(DiagnosticsProperty('data', data));
  }
}

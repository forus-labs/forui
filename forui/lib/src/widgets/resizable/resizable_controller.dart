import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/resizable.dart';

import 'package:forui/src/widgets/resizable/resizable_region_data.dart';

/// A controller that manages the resizing of regions in a [FResizable].
abstract class FResizableController extends ChangeNotifier {
  /// The resizable regions.
  ///
  /// The regions are ordered from top to bottom, or left to right, depending on the resizable axis. They should **not**
  /// be modified outside of a [FResizableController].
  final List<FResizableRegionData> regions = [];

  /// The minimum velocity, inclusive, of a drag gesture for haptic feedback to be performed
  /// on collision between two regions, defaults to 6.5.
  ///
  /// Setting it to `null` disables haptic feedback while setting it to 0 will cause
  /// haptic feedback to always be performed.
  ///
  /// ## Contract
  /// [_hapticFeedbackVelocity] should be a positive, finite number. It will otherwise
  /// result in undefined behaviour.
  // ignore: avoid_field_initializers_in_const_classes
  final double _hapticFeedbackVelocity = 6.5; // TODO: haptic feedback

  factory FResizableController({
    ValueChanged<List<FResizableRegionData>>? onResizeUpdate,
    ValueChanged<List<FResizableRegionData>>? onResizeEnd,
  }) = _CascadingController;

  FResizableController._();

  /// Updates the resizable and its neighbours' sizes at the given index. Returns true if haptic feedback should be
  /// performed.
  bool update(int index, AxisDirection direction, Offset delta);

  /// Notifies the region at the [index] and its neighbours that they has been resized.
  void end(int index, AxisDirection direction);
}

class _CascadingController extends FResizableController {
  /// A function that is called when a resizable region and its neighbours are being resized.
  ///
  /// This function is called *while* the regions are being resized. Most users should prefer [onResizeEnd], which is
  /// called only when the regions have finished resizing.
  final ValueChanged<List<FResizableRegionData>>? onResizeUpdate;

  /// A function that is called after a resizable region and its neighbours have been resized.
  final ValueChanged<List<FResizableRegionData>>? onResizeEnd;

  bool _haptic = false;

  _CascadingController({
    this.onResizeUpdate,
    this.onResizeEnd,
  }): super._();

  @override
  bool update(int index, AxisDirection direction, Offset delta) {
    final (selected, neighbour) = _find(index, direction);

    // We always want to resize the shrunken region first. This allows us to remove any overlaps caused by shrinking
    // a region beyond the minimum size.
    final Offset(:dx, :dy) = delta;
    final opposite = switch (direction) {
      AxisDirection.left => AxisDirection.right,
      AxisDirection.up => AxisDirection.down,
      AxisDirection.right => AxisDirection.left,
      AxisDirection.down => AxisDirection.up,
    };

    final (shrink, shrinkDirection, expand, expandDirection) = switch (direction) {
      AxisDirection.left when 0 < dx => (selected, direction, neighbour, opposite),
      AxisDirection.up when 0 < dy => (selected, direction, neighbour, opposite),
      AxisDirection.right when dx < 0 => (selected, direction, neighbour, opposite),
      AxisDirection.down when dy < 0 => (selected, direction, neighbour, opposite),
      _ => (neighbour, opposite, selected, direction),
    };

    final (shrunk, adjusted) = shrink.update(shrinkDirection, delta);
    // print(delta.dy);
    // print(adjusted.dy);
    if (shrink.offset != shrunk.offset) {
      final (expanded, _) = expand.update(expandDirection, adjusted);
      regions[shrunk.index] = shrunk;
      regions[expanded.index] = expanded;

      onResizeUpdate?.call([selected, neighbour]);
      _haptic = true;
      notifyListeners();

      return false;
    }

    if (_haptic) {
      _haptic = false;
      return true;
    } else {
      return false;
    }
  }

  @override
  void end(int index, AxisDirection direction) {
    final (resized, neighbour) = _find(index, direction);
    onResizeEnd?.call([resized, neighbour]);
    notifyListeners();
  }

  (FResizableRegionData resized, FResizableRegionData neighbour) _find(int index, AxisDirection direction) {
    final resized = regions[index];
    final neighbour = switch (direction) {
      AxisDirection.left || AxisDirection.up => regions[index - 1],
      AxisDirection.right || AxisDirection.down => regions[index + 1],
    };

    return (resized, neighbour);
  }
}

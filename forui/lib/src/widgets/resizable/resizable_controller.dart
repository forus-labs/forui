import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/resizable.dart';

import 'package:forui/src/widgets/resizable/resizable_region_data.dart';
import 'package:sugar/collection_aggregate.dart';

/// A controller that manages the resizing of regions in a [FResizable].
///
/// Users that want to create a custom resizable controller should implement this class.
abstract interface class FResizableController extends ChangeNotifier {
  /// The resizable regions. The regions are ordered from top to bottom, or left to right, depending on the resizable
  /// axis.
  ///
  /// ## Contract
  /// Modifying the regions outside of [update] and [end] will result in undefined behaviour.
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

  bool _haptic = false;

  /// Creates a [FResizableController].
  factory FResizableController({
    void Function(FResizableRegionData resized, FResizableRegionData neighbour)? onResizeUpdate,
    void Function(FResizableRegionData resized, FResizableRegionData neighbour)? onResizeEnd,
  }) = _ResizableController;

  /// Creates a [FResizableController] that cascades shrinking of a region below their minimum sizes to its neighbours.
  ///
  /// [onResizeUpdate] is called **while** a resizable region and its neighbours are being resized. Most users should
  /// prefer [onResizeEnd], which is called only after the regions have bee resized.
  ///
  /// [onResizeEnd] is called after a resizable region and its neighbours have been resized.
  ///
  /// See https://forui.dev/docs/resizable#cascading for a working example.
  factory FResizableController.cascade({
    ValueChanged<List<FResizableRegionData>>? onResizeUpdate,
    ValueChanged<List<FResizableRegionData>>? onResizeEnd,
  }) = _CascadingController;

  FResizableController._();

  /// Updates the resizable and its neighbours' sizes at the given [index]. Returns true if haptic feedback should be
  /// performed.
  ///
  /// [side] indicates the side of the region at the given [index] that is being resized. It should not be confused with
  /// the direction in which the region is expanded/shrunk.
  bool update(int index, AxisDirection side, Offset delta);

  /// Notifies the region at the [index] and its neighbours that they has been resized.
  void end(int index, AxisDirection side);
}

final class _ResizableController extends FResizableController {
  final void Function(FResizableRegionData resized, FResizableRegionData neighbour)? onResizeUpdate;
  final void Function(FResizableRegionData resized, FResizableRegionData neighbour)? onResizeEnd;

  _ResizableController({
    this.onResizeUpdate,
    this.onResizeEnd,
  }) : super._();

  @override
  bool update(int index, AxisDirection side, Offset delta) {
    final (resized, neighbour) = _find(index, side);

    // We always want to resize the shrunken region first. This allows us to remove any overlaps caused by shrinking
    // a region beyond the minimum size.
    final Offset(:dx, :dy) = delta;
    final opposite = switch (side) {
      AxisDirection.left => AxisDirection.right,
      AxisDirection.up => AxisDirection.down,
      AxisDirection.right => AxisDirection.left,
      AxisDirection.down => AxisDirection.up,
    };

    final (shrink, shrinkDirection, expand, expandDirection) = switch (side) {
      AxisDirection.left when 0 < dx => (resized, side, neighbour, opposite),
      AxisDirection.up when 0 < dy => (resized, side, neighbour, opposite),
      AxisDirection.right when dx < 0 => (resized, side, neighbour, opposite),
      AxisDirection.down when dy < 0 => (resized, side, neighbour, opposite),
      _ => (neighbour, opposite, resized, side),
    };

    final (shrunk, adjusted) = shrink.update(shrinkDirection, delta);
    if (shrink.offset != shrunk.offset) {
      final (expanded, _) = expand.update(expandDirection, adjusted);
      regions[shrunk.index] = shrunk;
      regions[expanded.index] = expanded;

      assert(
        regions.sum((r) => r.size.current, initial: 0.0) == regions[0].size.allRegions,
        'current total size: ${regions.sum((r) => r.size.current, initial: 0.0)} != initial total size: ${regions[0].size.allRegions}',
      );

      onResizeUpdate?.call(resized, neighbour);
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
  void end(int index, AxisDirection side) {
    final (resized, neighbour) = _find(index, side);
    onResizeEnd?.call(resized, neighbour);
    notifyListeners();
  }

  (FResizableRegionData resized, FResizableRegionData neighbour) _find(int index, AxisDirection side) {
    final resized = regions[index];
    final neighbour = switch (side) {
      AxisDirection.left || AxisDirection.up => regions[index - 1],
      AxisDirection.right || AxisDirection.down => regions[index + 1],
    };

    return (resized, neighbour);
  }
}

final class _CascadingController extends FResizableController {
  final ValueChanged<List<FResizableRegionData>>? onResizeUpdate;
  final ValueChanged<List<FResizableRegionData>>? onResizeEnd;

  _CascadingController({
    this.onResizeUpdate,
    this.onResizeEnd,
  }) : super._();

  @override
  bool update(int index, AxisDirection side, Offset delta) {
    final (selected, neighbour) = _find(index, side);

    // We always want to resize the shrunken region first. This allows us to remove any overlaps caused by shrinking
    // a region beyond the minimum size.
    final Offset(:dx, :dy) = delta;
    final opposite = switch (side) {
      AxisDirection.left => AxisDirection.right,
      AxisDirection.up => AxisDirection.down,
      AxisDirection.right => AxisDirection.left,
      AxisDirection.down => AxisDirection.up,
    };

    final (shrink, shrinkDirection, expand, expandDirection) = switch (side) {
      AxisDirection.left when 0 < dx => (selected, side, neighbour, opposite),
      AxisDirection.up when 0 < dy => (selected, side, neighbour, opposite),
      AxisDirection.right when dx < 0 => (selected, side, neighbour, opposite),
      AxisDirection.down when dy < 0 => (selected, side, neighbour, opposite),
      _ => (neighbour, opposite, selected, side),
    };

    final shrinks = switch (expandDirection) {
      AxisDirection.left || AxisDirection.up => regions.sublist(0, shrink.index + 1).reversed,
      AxisDirection.right || AxisDirection.down => regions.sublist(shrink.index),
    };

    final updates = <FResizableRegionData>[];
    late FResizableRegionData lastShrunk;
    var translated = delta;
    for (final foo in shrinks) {
      var (shrunk, nextTranslated) = foo.update(shrinkDirection, delta);
      lastShrunk = shrunk;
      translated = nextTranslated;
      if (nextTranslated.dy != 0.0) {
        // This means that the currently shrunk region is not at minimum size. No need to continue cascade.
        break;
      }

      updates.add(shrunk);
    }

    final (expanded, _) = expand.update(expandDirection, translated);
    var offset = expanded.offset;
    final moved = <FResizableRegionData>[];
    switch (expandDirection) {
      case AxisDirection.left || AxisDirection.up:
        for (final foo in updates) {
          final a = foo.copyWith(minOffset: offset.min - foo.size.current, maxOffset: offset.min);
          offset = a.offset;
          moved.add(a);
        }

      case AxisDirection.right || AxisDirection.down:
        for (final foo in updates) {
          final a = foo.copyWith(minOffset: offset.max, maxOffset: offset.max + foo.size.current);
          offset = a.offset;
          moved.add(a);
        }
    }

    for (final region in [
      expanded,
      lastShrunk,
      ...moved,
    ]) {
      regions[region.index] = region;
    }

    assert(
      regions.sum((r) => r.size.current, initial: 0.0) == regions[0].size.allRegions,
      'current total size: ${regions.sum((r) => r.size.current, initial: 0.0)} != initial total size: ${regions[0].size.allRegions}',
    );

    notifyListeners();

    // if (shrink.offset != shrunk.offset) {
    //   final (expanded, _) = expand.update(expandDirection, translated);
    //   regions[shrunk.index] = shrunk;
    //   regions[expanded.index] = expanded;
    //
    //   onResizeUpdate?.call([selected, neighbour]);
    //   _haptic = true;
    //   notifyListeners();
    //
    assert(
      regions.sum((r) => r.size.current, initial: 0.0) == regions[0].size.allRegions,
      'current total size: ${regions.sum((r) => r.size.current, initial: 0.0)} != initial total size: ${regions[0].size.allRegions}',
    );
    //
    //   return false;
    // }

    if (_haptic) {
      _haptic = false;
      return true;
    } else {
      return false;
    }
  }

  @override
  void end(int index, AxisDirection side) {
    final (resized, neighbour) = _find(index, side);
    onResizeEnd?.call([resized, neighbour]);
    notifyListeners();
  }

  (FResizableRegionData resized, FResizableRegionData neighbour) _find(int index, AxisDirection side) {
    final resized = regions[index];
    final neighbour = switch (side) {
      AxisDirection.left || AxisDirection.up => regions[index - 1],
      AxisDirection.right || AxisDirection.down => regions[index + 1],
    };

    return (resized, neighbour);
  }
}

import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/resizable.dart';

import 'package:forui/src/widgets/resizable/resizable_region_data.dart';
import 'package:sugar/collection_aggregate.dart';

/// A controller that manages the resizing of regions in a [FResizable].
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
  final double _hapticFeedbackVelocity = 6.5; // ignore: unused_field, TODO: haptic feedback

  bool _haptic = false;

  /// Creates a [FResizableController].
  ///
  /// [onResizeUpdate] is called **while** a resizable region and its neighbours are being resized. Most users should
  /// prefer [onResizeEnd], which is called only after the regions have bee resized.
  ///
  /// [onResizeEnd] is called after a resizable region and its neighbours have been resized.
  factory FResizableController({
    void Function(List<FResizableRegionData> resized)? onResizeUpdate,
    void Function(List<FResizableRegionData> resized)? onResizeEnd,
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
    void Function(List<FResizableRegionData> resized)? onResizeUpdate,
    void Function(UnmodifiableListView<FResizableRegionData> all)? onResizeEnd,
  }) = _CascadeController;

  FResizableController._();

  /// Updates the resizable and its neighbours' sizes at the given [index]. Returns true if haptic feedback should be
  /// performed.
  ///
  /// [side] indicates the side of the region at the given [index] that is being resized. It should not be confused with
  /// the direction in which the region is expanded/shrunk.
  bool update(int index, AxisDirection side, Offset delta);

  /// Notifies the region at the [index] and its neighbours that they has been resized.
  void end(int index, AxisDirection side);

  AxisDirection _opposite(AxisDirection side) => switch (side) {
        AxisDirection.left => AxisDirection.right,
        AxisDirection.up => AxisDirection.down,
        AxisDirection.right => AxisDirection.left,
        AxisDirection.down => AxisDirection.up,
      };
}

/// A non-cascading [FResizableController].
final class _ResizableController extends FResizableController {
  final void Function(List<FResizableRegionData> resized)? onResizeUpdate;
  final void Function(List<FResizableRegionData> resized)? onResizeEnd;

  _ResizableController({
    this.onResizeUpdate,
    this.onResizeEnd,
  }) : super._();

  @override
  bool update(int index, AxisDirection side, Offset delta) {
    final Offset(:dx, :dy) = delta;
    final (shrink, shrinkSide, expand, expandSide) = switch (side) {
      AxisDirection.left when 0 < dx => (regions[index], side, _neighbour(index, side), _opposite(side)),
      AxisDirection.up when 0 < dy => (regions[index], side, _neighbour(index, side), _opposite(side)),
      AxisDirection.right when dx < 0 => (regions[index], side, _neighbour(index, side), _opposite(side)),
      AxisDirection.down when dy < 0 => (regions[index], side, _neighbour(index, side), _opposite(side)),
      _ => (_neighbour(index, side), _opposite(side), regions[index], side),
    };

    // We always want to resize the shrunken region first. This allows us to remove any overlaps caused by shrinking a
    // region beyond the minimum size.
    final (shrunk, adjusted) = shrink.update(shrinkSide, delta);
    if (shrink.offset != shrunk.offset) {
      final (expanded, _) = expand.update(expandSide, adjusted);
      regions[shrunk.index] = shrunk;
      regions[expanded.index] = expanded;

      assert(
        regions.sum((r) => r.size.current, initial: 0.0) == regions[0].size.allRegions,
        'Current total size: ${regions.sum((r) => r.size.current, initial: 0.0)} != initial total size: ${regions[0].size.allRegions}. '
        'This is likely a bug in Forui. Please file a bug report: https://github.com/forus-labs/forui/issues/new?template=bug_report.md',
      );

      if (onResizeUpdate case final onResizeUpdate?) {
        onResizeUpdate([shrunk, expanded]);
      }
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
    if (onResizeEnd case final onResizeEnd?) {
      onResizeEnd([regions[index], _neighbour(index, side)]);
    }
  }

  FResizableRegionData _neighbour(int index, AxisDirection side) => switch (side) {
        AxisDirection.left || AxisDirection.up => regions[index - 1],
        AxisDirection.right || AxisDirection.down => regions[index + 1],
      };
}

/// A cascading [FResizableController].
final class _CascadeController extends FResizableController {
  final void Function(List<FResizableRegionData> resized)? onResizeUpdate;
  final void Function(UnmodifiableListView<FResizableRegionData> all)? onResizeEnd;

  _CascadeController({
    this.onResizeUpdate,
    this.onResizeEnd,
  }) : super._();

  @override
  bool update(int index, AxisDirection side, Offset delta) {
    List<FResizableRegionData> before(int index) => regions.sublist(0, index + 1).reversed.toList();

    List<FResizableRegionData> after(int index) => regions.sublist(index);

    final Offset(:dx, :dy) = delta;
    final (shrinks, shrinkSide, expand, expandSide) = switch (side) {
      AxisDirection.left when 0 < dx => (after(index), side, regions[index - 1], _opposite(side)),
      AxisDirection.up when 0 < dy => (after(index), side, regions[index - 1], _opposite(side)),
      AxisDirection.right when dx < 0 => (before(index), side, regions[index + 1], _opposite(side)),
      AxisDirection.down when dy < 0 => (before(index), side, regions[index + 1], _opposite(side)),
      AxisDirection.left || AxisDirection.up => (before(index - 1), _opposite(side), regions[index], side),
      AxisDirection.right || AxisDirection.down => (after(index + 1), _opposite(side), regions[index], side),
    };

    // We always want to resize the shrunken region first. This allows us to remove any overlaps caused by shrinking a
    // region beyond the minimum size.

    late FResizableRegionData shrunk;
    late Offset translated;

    // Shrink affected regions without updating offsets.
    final shrunks = <FResizableRegionData>[];
    for (final shrink in shrinks) {
      (shrunk, translated) = shrink.update(shrinkSide, delta);
      shrunks.add(shrunk);

      // Currently shrunk region is not at minimum size. No need to continue cascade.
      if (translated != Offset.zero) {
        break;
      }
    }

    // All shrunk regions are already at minimum size. No need to rebuild.
    if (translated == Offset.zero) {
      final haptic = _haptic;
      _haptic = false;
      return haptic;
    }

    // Update all affected regions' offsets.
    final (expanded, _) = expand.update(expandSide, translated);
    var (:min, :max) = expanded.offset;

    regions[expanded.index] = expanded;
    final moved = onResizeUpdate == null ? null : [expanded];

    switch (expandSide) {
      case AxisDirection.left || AxisDirection.up:
        for (final region in shrunks) {
          final updated = region.copyWith(minOffset: min - region.size.current, maxOffset: min);
          (:min, :max) = updated.offset;

          regions[updated.index] = updated;
          moved?.add(updated);
        }

      case AxisDirection.right || AxisDirection.down:
        for (final region in shrunks) {
          final updated = region.copyWith(minOffset: max, maxOffset: max + region.size.current);
          (:min, :max) = updated.offset;

          regions[updated.index] = updated;
          moved?.add(updated);
        }
    }

    assert(
      regions.sum((r) => r.size.current, initial: 0.0) == regions[0].size.allRegions,
      'Current total size: ${regions.sum((r) => r.size.current, initial: 0.0)} != initial total size: ${regions[0].size.allRegions}. '
      'This is likely a bug in Forui. Please file a bug report: https://github.com/forus-labs/forui/issues/new?template=bug_report.md',
    );

    onResizeUpdate?.call(moved!);
    _haptic = true;
    notifyListeners();

    return false;
  }

  @override
  void end(int index, AxisDirection side) {
    if (onResizeEnd case final onResizeEnd?) {
      onResizeEnd(UnmodifiableListView(regions));
    }
  }
}

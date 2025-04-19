import 'dart:collection';

import 'package:sugar/collection_aggregate.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/doubles.dart';
import 'package:forui/src/widgets/resizable/resizable_region_data.dart';

/// A controller that manages the resizing of regions in a [FResizable].
abstract interface class FResizableController extends FChangeNotifier {
  /// The resizable regions. The regions are ordered from top to bottom, or left to right, depending on the resizable
  /// axis.
  ///
  /// ## Contract
  /// Modifying the regions outside of [update] and [end] will result in undefined behaviour.
  final List<FResizableRegionData> regions = [];

  /// The minimum velocity, inclusive, of a drag gesture for haptic feedback to be performed on collision between two
  /// regions, defaults to 6.5.
  ///
  /// Setting it to `null` disables haptic feedback while setting it to 0 will cause haptic feedback to always be
  /// performed.
  ///
  /// ## Contract
  /// [_hapticFeedbackVelocity] should be a positive, finite number. It will otherwise
  /// result in undefined behaviour.
  // ignore: avoid_field_initializers_in_const_classes
  final double _hapticFeedbackVelocity = 6.5; // ignore: unused_field, TODO: haptic feedback

  bool _haptic = false;

  FResizableController._();

  /// Creates a [FResizableController].
  ///
  /// [onResizeUpdate] is called **while** a resizable region and its neighbours are being resized. Most users should
  /// prefer [onResizeEnd], which is called only after the regions have bee resized.
  ///
  /// [onResizeEnd] is called after a resizable region and its neighbours have been resized.
  ///
  /// See https://forui.dev/docs/layout/resizable#no-cascading for a working example.
  factory FResizableController({
    void Function(List<FResizableRegionData> resized)? onResizeUpdate,
    void Function(List<FResizableRegionData> resized)? onResizeEnd,
  }) = _ResizableController;

  /// Creates a [FResizableController] that cascades shrinking of a region below their minimum extents to its neighbours.
  ///
  /// [onResizeUpdate] is called **while** a resizable region and its neighbours are being resized. Most users should
  /// prefer [onResizeEnd], which is called only after the regions have bee resized.
  ///
  /// [onResizeEnd] is called after a resizable region and its neighbours have been resized.
  ///
  /// See https://forui.dev/docs/layout/resizable for a working example.
  factory FResizableController.cascade({
    void Function(List<FResizableRegionData> resized)? onResizeUpdate,
    void Function(UnmodifiableListView<FResizableRegionData> all)? onResizeEnd,
  }) = _CascadeController;

  /// Updates the regions at the given indexes in addition to their neighbours. Returns true if haptic feedback should
  /// be performed.
  bool update(int left, int right, double delta);

  /// Notifies the region at the indexes that they and their neighbours have been resized.
  void end(int left, int right);
}

/// A non-cascading [FResizableController].
final class _ResizableController extends FResizableController {
  final void Function(List<FResizableRegionData> resized)? onResizeUpdate;
  final void Function(List<FResizableRegionData> resized)? onResizeEnd;

  _ResizableController({this.onResizeUpdate, this.onResizeEnd}) : super._();

  @override
  bool update(int left, int right, double delta) {
    final (shrink, expand, lhs) = switch (delta) {
      < 0 => (regions[left], regions[right], false),
      _ => (regions[right], regions[left], true),
    };

    // We always want to resize the shrunken region first. This allows us to remove any overlaps caused by shrinking a
    // region beyond the minimum size.
    final (shrunk, translated) = shrink.update(delta, lhs: lhs);
    if (shrink.offset != shrunk.offset) {
      final (expanded, _) = expand.update(translated, lhs: !lhs);
      regions[shrunk.index] = shrunk;
      regions[expanded.index] = expanded;

      assert(
        regions.sum((r) => r.extent.current, initial: 0.0) == regions[0].extent.total,
        'Current total extent: ${regions.sum((r) => r.extent.current, initial: 0.0)} != initial total extent: '
        '${regions[0].extent.total}. This is likely a bug in Forui. Please file a bug report: '
        'https://github.com/forus-labs/forui/issues/new?template=bug_report.md',
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
  void end(int left, int right) {
    if (onResizeEnd case final onResizeEnd?) {
      onResizeEnd([regions[left], regions[right]]);
    }
  }
}

/// A cascading [FResizableController].
final class _CascadeController extends FResizableController {
  final void Function(List<FResizableRegionData> resized)? onResizeUpdate;
  final void Function(UnmodifiableListView<FResizableRegionData> all)? onResizeEnd;

  _CascadeController({this.onResizeUpdate, this.onResizeEnd}) : super._();

  @override
  bool update(int left, int right, double delta) {
    final (shrinks, expand, lhs) = switch (delta) {
      < 0 => (regions.sublist(0, right).reversed.toList(), regions[right], false),
      _ => (regions.sublist(right), regions[left], true),
    };

    // We always want to resize the shrunken region first. This allows us to remove any overlaps caused by shrinking a
    // region beyond the minimum size.
    late FResizableRegionData shrunk;
    late double translated;

    // Shrink affected regions without updating offsets.
    final shrunks = <FResizableRegionData>[];
    for (final shrink in shrinks) {
      (shrunk, translated) = shrink.update(delta, lhs: lhs);
      shrunks.add(shrunk);

      // Currently shrunk region is not at minimum size. No need to continue cascade.
      if (translated != 0) {
        break;
      }
    }

    // All shrunk regions are already at minimum size. No need to rebuild.
    if (translated == 0) {
      final haptic = _haptic;
      _haptic = false;
      return haptic;
    }

    // Update all affected regions' offsets.
    final (expanded, _) = expand.update(translated, lhs: !lhs);
    var (:min, :max) = expanded.offset;

    regions[expanded.index] = expanded;
    final moved = onResizeUpdate == null ? null : [expanded];

    if (lhs) {
      for (final region in shrunks) {
        final updated = region.copyWith(minOffset: max, maxOffset: max + region.extent.current);
        (:min, :max) = updated.offset;

        regions[updated.index] = updated;
        moved?.add(updated);
      }
    } else {
      for (final region in shrunks) {
        final updated = region.copyWith(minOffset: min - region.extent.current, maxOffset: min);
        (:min, :max) = updated.offset;

        regions[updated.index] = updated;
        moved?.add(updated);
      }
    }

    assert(
      regions.sum((r) => r.extent.current, initial: 0.0).around(regions[0].extent.total),
      'Current total size: ${regions.sum((r) => r.extent.current, initial: 0.0)} != initial total size: ${regions[0].extent.total}. '
      'This is likely a bug in Forui. Please file a bug report: https://github.com/forus-labs/forui/issues/new?template=bug_report.md',
    );

    onResizeUpdate?.call(moved!);
    _haptic = true;
    notifyListeners();

    return false;
  }

  @override
  void end(int left, int right) {
    if (onResizeEnd case final onResizeEnd?) {
      onResizeEnd(UnmodifiableListView(regions));
    }
  }
}

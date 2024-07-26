import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable/resizable_region_data.dart';

/// Possible ways for a user to interact with a [FResizable].
sealed class FResizableInteraction {
  /// Allows the user to interact with a [FResizableRegion] by resizing it without selecting it first.
  const factory FResizableInteraction.resize() = Resize;
}

@internal
final class Resize implements FResizableInteraction {
  const Resize();

  @override
  bool operator ==(Object other) => identical(this, other) || other is Resize && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

@internal
class ResizableController extends ChangeNotifier {
  final List<FResizableRegionData> regions;
  final Axis axis;
  final double? hapticFeedbackVelocity;
  final void Function(FResizableRegionData, FResizableRegionData)? _onResizeUpdate;
  final void Function(FResizableRegionData, FResizableRegionData)? _onResizeEnd;
  final FResizableInteraction _interaction;
  bool _haptic;

  ResizableController({
    required this.regions,
    required this.axis,
    required this.hapticFeedbackVelocity,
    required void Function(FResizableRegionData, FResizableRegionData)? onResizeUpdate,
    required void Function(FResizableRegionData, FResizableRegionData)? onResizeEnd,
    required FResizableInteraction interaction,
  })  : _onResizeUpdate = onResizeUpdate,
        _onResizeEnd = onResizeEnd,
        _interaction = interaction,
        _haptic = false;

  /// Updates the resizable and its neighbours' sizes at the given index, and returns true if the resizable has been
  /// minimized or maximized.
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
    if (shrink.offset != shrunk.offset) {
      final (expanded, _) = expand.update(expandDirection, adjusted);
      regions[shrunk.index] = shrunk;
      regions[expanded.index] = expanded;

      _onResizeUpdate?.call(selected, neighbour);
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

  /// Notifies the region at the [index] and its neighbour that it has been resized.
  void end(int index, AxisDirection direction) {
    final (resized, neighbour) = _find(index, direction);
    _onResizeEnd?.call(resized, neighbour);
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

  FResizableInteraction get interaction => _interaction;
}

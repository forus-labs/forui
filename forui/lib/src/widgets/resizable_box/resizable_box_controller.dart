import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/resizable_box/resizable_controller.dart';
import 'package:forui/src/widgets/resizable_box/resized.dart';
import 'package:meta/meta.dart';

/// Possible ways for a user to interact with a [FResizableBox].
sealed class FResizableInteraction {
  /// Allows the user to interact with a [FResizableBox] by
  const factory FResizableInteraction.selectAndResize(int index) = SelectAndResize;

  const factory FResizableInteraction.resize() = Resize;
}

@internal
final class SelectAndResize implements FResizableInteraction {
  final int index;

  const SelectAndResize(this.index);
}

@internal
final class Resize implements FResizableInteraction {
  const Resize();
}

@internal
class ResizableBoxController {
  final List<ResizableController> controllers;
  final double? hapticFeedbackVelocity;
  final void Function(int)? _onPress;
  final void Function(Resized, Resized)? _onResizeUpdate;
  final void Function(Resized, Resized)? _onResizeEnd;
  FResizableInteraction _interaction;
  bool _haptic;

  ResizableBoxController({
    required this.controllers,
    required this.hapticFeedbackVelocity,
    required void Function(int)? onPress,
    required void Function(Resized, Resized)? onResizeUpdate,
    required void Function(Resized, Resized)? onResizeEnd,
    required FResizableInteraction interaction,
  })  : assert(2 <= controllers.length, 'ResizableBox should have at least 2 Resizables.'),
        _onPress = onPress,
        _onResizeUpdate = onResizeUpdate,
        _onResizeEnd = onResizeEnd,
        _interaction = interaction,
        _haptic = false;

  /// Updates the [ResizableController] and its neighbours' sizes at the given index, and returns true if the
  /// [ResizableController] has been minimized or maximized.
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

    final previous = shrink.resized.offsets;
    final adjusted = shrink.update(shrinkDirection, delta);
    if (previous != shrink.resized.offsets) {
      expand.update(expandDirection, adjusted);
      _onResizeUpdate?.call(selected.resized, neighbour.resized);
      _haptic = true;
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
    final (selected, neighbour) = _find(index, direction);
    _onResizeEnd?.call(selected.resized, neighbour.resized);
  }

  (ResizableController selected, ResizableController neighbour) _find(int index, AxisDirection direction) {
    final selected = controllers[index];
    final neighbour = switch (direction) {
      AxisDirection.left || AxisDirection.up => controllers[index - 1],
      AxisDirection.right || AxisDirection.down => controllers[index + 1],
    };

    return (selected, neighbour);
  }

  void select(int value) {
    _onPress?.call(value);

    if (_interaction case SelectAndResize(index: final old)) {
      _interaction = SelectAndResize(value);
      controllers[old].selected = false;
      controllers[value].selected = true;
    }
  }

  FResizableInteraction get interaction => _interaction;
}

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/resizable_box/resizable_data.dart';
import 'package:meta/meta.dart';

/// Possible ways for a user to interact with a [FResizableBox].
sealed class FResizableInteraction {
  /// Allows the user to interact with a [FResizable] by selecting before resizing it.
  const factory FResizableInteraction.selectAndResize(int initialIndex) = SelectAndResize;

  /// Allows the user to interact with a [FResizable] by resizing it without selecting it first.
  const factory FResizableInteraction.resize() = Resize;
}

@internal
final class SelectAndResize implements FResizableInteraction {
  final int index;

  const SelectAndResize(this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SelectAndResize && runtimeType == other.runtimeType && index == other.index;

  @override
  int get hashCode => index.hashCode;
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
class ResizableBoxController extends ChangeNotifier {
  final List<FResizableData> resizables;
  final Axis axis;
  final double? hapticFeedbackVelocity;
  final void Function(int)? _onPress;
  final void Function(FResizableData, FResizableData)? _onResizeUpdate;
  final void Function(FResizableData, FResizableData)? _onResizeEnd;
  FResizableInteraction _interaction;
  bool _haptic;

  ResizableBoxController({
    required this.resizables,
    required this.axis,
    required this.hapticFeedbackVelocity,
    required void Function(int)? onPress,
    required void Function(FResizableData, FResizableData)? onResizeUpdate,
    required void Function(FResizableData, FResizableData)? onResizeEnd,
    required FResizableInteraction interaction,
  })  : _onPress = onPress,
        _onResizeUpdate = onResizeUpdate,
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
    if (shrink.offsets != shrunk.offsets) {
      final (expanded, _) = expand.update(expandDirection, adjusted);
      resizables[shrunk.index] = shrunk;
      resizables[expanded.index] = expanded;

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

  (FResizableData resized, FResizableData neighbour) _find(int index, AxisDirection direction) {
    final resized = resizables[index];
    final neighbour = switch (direction) {
      AxisDirection.left || AxisDirection.up => resizables[index - 1],
      AxisDirection.right || AxisDirection.down => resizables[index + 1],
    };

    return (resized, neighbour);
  }

  bool select(int value) {
    if (_interaction case SelectAndResize(index: final old) when old != value) {
      _onPress?.call(value);
      _interaction = SelectAndResize(value);
      resizables[old] = resizables[old].copyWith(selected: false);
      resizables[value] = resizables[value].copyWith(selected: true);

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  FResizableInteraction get interaction => _interaction;
}

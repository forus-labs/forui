import 'package:flutter/widgets.dart';
import 'package:forui/src/widgets/resizable_box/resized.dart';
import 'package:meta/meta.dart';

@internal
class ResizableController extends ChangeNotifier {
  Resized _resized;

  ResizableController(this._resized);

  /// Updates the current height/width, returning an offset with any shrinkage beyond the minimum height/width removed.
  Offset update(AxisDirection direction, Offset delta) {
    final (:min, :max) = _resized.offsets;
    final Offset(:dx, :dy) = delta;
    final (x, y) = switch (direction) {
      AxisDirection.left => (_resize(direction, min + dx, max), 0.0),
      AxisDirection.right => (-_resize(direction, min, max + dx), 0.0),
      AxisDirection.up => (0.0, _resize(direction, min + dy, max)),
      AxisDirection.down => (0.0, -_resize(direction, min, max + dy)),
    };

    return delta.translate(x, y);
  }

  double _resize(AxisDirection direction, double min, double max) {
    final constraints = _resized.constraints;
    final size = max - min;
    assert(size <= constraints.max, '$size should be less than ${constraints.max}.');

    if (constraints.min <= size) {
      _resized = _resized.copyWith(minOffset: min, maxOffset: max);
      notifyListeners();
      return 0;
    }

    if (direction == AxisDirection.left || direction == AxisDirection.up) {
      final min = max - constraints.min;
      if (_resized.offsets.min != min) {
        _resized = _resized.copyWith(minOffset: min);
        notifyListeners();
      }
    } else {
      final max = min + constraints.min;
      if (_resized.offsets.max != max) {
        _resized = _resized.copyWith(maxOffset: max);
        notifyListeners();
      }
    }

    return size - constraints.min;
  }

  /// The resized area's information.
  Resized get resized => _resized;

  /// True if the resized area's selected.
  bool get selected => _resized.selected;

  set selected(bool value) {
    _resized = _resized.copyWith(selected: value);
    notifyListeners();
  }
}

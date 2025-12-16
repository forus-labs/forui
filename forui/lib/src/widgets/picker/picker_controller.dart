import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';

import 'package:forui/forui.dart';

part 'picker_controller.control.dart';

/// A picker's controller.
///
/// The [value] contains the index of the selected item in each wheel. The indexes are ordered:
/// * From left to right if the current text direction is LTR
/// * From right to left if the current text direction is RTL
class FPickerController extends FValueNotifier<List<int>> {
  /// The controllers for the individual picker wheels.
  ///
  /// The controllers are ordered:
  /// * from left to right if the current text direction is LTR
  /// * from right to left if the current text direction is RTL
  ///
  /// ## Contract
  /// Reading the controllers before this FPickerController is attached to a [FPicker] is undefined behavior.
  ///
  /// Modifying [wheels] is undefined behavior.
  final List<FixedExtentScrollController> wheels = [];

  /// Creates a [FPickerController].
  FPickerController({required List<int> indexes}) : super([...indexes]);

  /// Animates the wheels to the given [value].
  Future<void> animateTo(
    List<int> value, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutCubic,
  }) async {
    if (!listEquals(_rawValue, value)) {
      _rawValue = value;
      await _animateTo(value, duration, curve);
    }
  }

  Future<void> _animateTo(List<int> value, Duration duration, Curve curve) async {
    assert(
      wheels.isEmpty || value.length == wheels.length,
      'The value must have the same length as the number of wheels.',
    );

    await Future.wait([
      for (final (i, index) in value.indexed) wheels[i].animateToItem(index, duration: duration, curve: curve),
    ]);
  }

  @override
  List<int> get value => [..._rawValue];

  @override
  set value(List<int> value) {
    assert(
      wheels.isEmpty || value.length == wheels.length,
      'The value must have the same length as the number of wheels.',
    );

    if (wheels.isNotEmpty) {
      for (final (i, index) in value.indexed) {
        wheels[i].jumpToItem(index);
      }
    }

    if (!listEquals(_rawValue, value)) {
      _rawValue = value;
    }
  }

  List<int> get _rawValue => super.value;

  set _rawValue(List<int> value) => super.value = value;

  @override
  void dispose() {
    for (final wheel in wheels) {
      wheel.dispose();
    }
    super.dispose();
  }
}

@internal
extension InternalFPickerController on FPickerController {
  void replace(List<int> value) {
    if (!listEquals(_rawValue, value)) {
      _rawValue = value;
    }
  }
}

class _ProxyController extends FPickerController {
  List<int> _unsynced;
  ValueChanged<List<int>> _onChange;
  Duration _duration;
  Curve _curve;
  int _monotonic = 0;

  _ProxyController(this._unsynced, this._onChange, this._duration, this._curve) : super(indexes: _unsynced);

  void update(List<int> newValue, ValueChanged<List<int>> onChange, Duration duration, Curve curve) {
    _onChange = onChange;
    _duration = duration;
    _curve = curve;

    ++_monotonic;
    if (!listEquals(super._rawValue, newValue)) {
      _unsynced = newValue;
      super._rawValue = newValue;
      for (final (i, index) in super._rawValue.indexed) {
        wheels[i].animateToItem(index, duration: _duration, curve: _curve);
      }
    } else if (!listEquals(_unsynced, newValue)) {
      _unsynced = newValue;
      for (final (i, index) in super._rawValue.indexed) {
        wheels[i].animateToItem(index, duration: _duration, curve: _curve);
      }
      notifyListeners();
    }
  }

  @override
  set _rawValue(List<int> value) {
    final current = ++_monotonic;
    if (!listEquals(super._rawValue, value)) {
      _unsynced = value;
      _onChange(value);

      // The animation is wrapped in a post frame callback since _rawValue is called when ScrollEndNotification is
      // fired, and animating during that notification causes the animation to be ignored.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (current == _monotonic) {
          for (final (i, index) in super._rawValue.indexed) {
            wheels[i].animateToItem(index, duration: _duration, curve: _curve);
          }
        }
      });
    }
  }
}

/// A [FPickerControl] defines how a [FPicker] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FPickerControl with Diagnosticable, _$FPickerControlMixin {
  /// Creates a [FPickerControl].
  const factory FPickerControl.managed({
    FPickerController? controller,
    List<int>? initial,
    ValueChanged<List<int>>? onChange,
  }) = FPickerManagedControl;

  /// Creates a [FPickerControl] for controlling a picker using lifted state.
  ///
  /// It does not prevent the user from scrolling to invalid indexes. To animate back to the provided [indexes],
  /// consider passing in `onChange: (_) => setState(() {})`.
  ///
  /// The [indexes] represent the current indexes.
  /// The [onChange] callback is invoked when the user changes the value.
  /// The [duration] when animating to [indexes] from an invalid/different index. Defaults to 300 milliseconds.
  /// The [curve] when animating to [indexes] from an invalid/different index. Defaults to [Curves.easeOutCubic].
  const factory FPickerControl.lifted({
    required List<int> indexes,
    required ValueChanged<List<int>> onChange,
    Duration duration,
    Curve curve,
  }) = _Lifted;

  const FPickerControl._();

  (FPickerController, bool) _update(
    FPickerControl old,
    FPickerController controller,
    VoidCallback callback,
    int wheelCount,
  );

  // The attachment logic must be handled inside FPickerControl since it will otherwise always be called when updating
  // from Lifted -> Lifted, causing an infinite loop.
  void _updateWheels(FPickerController controller) {
    for (final wheel in controller.wheels) {
      wheel.dispose();
    }
    controller.wheels.clear();

    for (final (index, item) in controller.value.indexed) {
      controller.wheels.add(
        FixedExtentScrollController(
          initialItem: item,
          onAttach: (position) {
            if (position.hasContentDimensions) {
              final copy = controller.value;
              // This is evil but it's the only way to get the item index as it's hidden in a private class.
              copy[index] = (position as FixedExtentMetrics).itemIndex;
              controller.replace(copy);
            }
          },
        ),
      );
    }
  }
}

/// A [FPickerManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FPickerManagedControl extends FPickerControl with Diagnosticable, _$FPickerManagedControlMixin {
  /// The controller.
  @override
  final FPickerController? controller;

  /// The initial indexes. Defaults to all zeros.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final List<int>? initial;

  /// Called when the selected indexes change.
  @override
  final ValueChanged<List<int>>? onChange;

  /// Creates a [FPickerControl].
  const FPickerManagedControl({this.controller, this.initial, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial indexes. Pass the initial indexes to the controller instead.',
      ),
      super._();

  @override
  FPickerController createController(int wheelCount) {
    final created = controller ?? .new(indexes: initial ?? .filled(wheelCount, 0));
    _updateWheels(created);

    return created;
  }
}

class _Lifted extends FPickerControl with _$_LiftedMixin {
  @override
  final List<int> indexes;
  @override
  final ValueChanged<List<int>> onChange;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const _Lifted({
    required this.indexes,
    required this.onChange,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutCubic,
  }) : super._();

  @override
  FPickerController createController(int _) {
    final created = _ProxyController(indexes, onChange, duration, curve);
    _updateWheels(created);

    return created;
  }

  @override
  void _updateController(FPickerController controller, int _) {
    (controller as _ProxyController).update(indexes, onChange, duration, curve);
  }
}

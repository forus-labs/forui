import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';

part 'picker_controller.control.dart';

/// A picker's controller.
///
/// The [value] contains the index of the selected item in each wheel. The indexes are ordered:
/// * From left to right if the current text direction is LTR
/// * From right to left if the current text direction is RTL
class FPickerController extends FValueNotifier<List<int>> {
  /// The picker wheels' initial indexes.
  final List<int> initialIndexes;

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
  FPickerController({required this.initialIndexes}) : super([...initialIndexes]);

  @override
  List<int> get value => [...super.value];

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

    _value = value;
  }

  // ignore: avoid_setters_without_getters
  set _value(List<int> value) {
    if (!listEquals(super.value, value)) {
      super.value = value;
    }
  }

  @override
  void dispose() {
    for (final wheel in wheels) {
      wheel.dispose();
    }
    super.dispose();
  }
}

@internal
extension InternalPickerController on FPickerController {
  // ignore: use_setters_to_change_properties
  void replace(List<int> value) => _value = value;
}

class _Controller extends FPickerController {
  /// The indexes that the user scrolled to, which differs from the controller's value.
  List<int> _scrolled;
  ValueChanged<List<int>> _onChange;
  int _monotonic = 0;

  _Controller({required super.initialIndexes, required ValueChanged<List<int>> onChange})
    : _scrolled = initialIndexes,
      _onChange = onChange;

  void update(List<int> value, ValueChanged<List<int>> onChange, Duration duration, Curve curve) {
    _onChange = onChange;
    if (!listEquals(_scrolled, value)) {
      for (final (i, index) in value.indexed) {
        wheels[i].animateToItem(index, duration: duration, curve: curve);
      }
      super._value = value;
    }
  }

  @override
  set value(List<int> value) {
    _scrolled = value;
    _onChange(value);
  }

  @override
  // TODO: https://github.com/dart-lang/sdk/issues/62198
  // ignore: unused_element
  set _value(List<int> value) {
    final current = ++_monotonic;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (current == _monotonic) {
        _scrolled = value;
        _onChange(value);
      }
    });
  }
}

/// Defines how a [FPicker]'s value is controlled.
sealed class FPickerControl with Diagnosticable, _$FPickerControlMixin {
  /// Creates a [FPickerControl] for controlling a picker using lifted state.
  ///
  /// It does not prevent the user from scrolling to invalid indexes. To animate back to the provided [value],
  /// consider passing in `onChange: (_) => setState(() {})`.
  ///
  /// The [value] parameter contains the current indexes.
  /// The [onChange] callback is invoked when the user changes the value.
  /// The [duration] when animating to [value] from an invalid/different index. Defaults to 200 milliseconds.
  /// The [curve] when animating to [value] from an invalid/different index. Defaults to [Curves.easeOutCubic].
  const factory FPickerControl.lifted({
    required List<int> value,
    required ValueChanged<List<int>> onChange,
    Duration duration,
    Curve curve,
  }) = Lifted;

  /// Creates a [FPickerControl] for controlling a picker using a controller.
  ///
  /// Either [controller] or [initial] can be provided. If neither is provided,
  /// an internal controller with default indexes (all zeros) is created.
  ///
  /// The [onChange] callback is invoked when the value changes.
  ///
  /// ## Contract
  /// Throws [AssertionError] if both [controller] and [initial] are provided.
  const factory FPickerControl.managed({
    FPickerController? controller,
    List<int>? initial,
    ValueChanged<List<int>>? onChange,
  }) = Managed;

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

@internal
class Lifted extends FPickerControl with _$LiftedMixin {
  @override
  final List<int> value;
  @override
  final ValueChanged<List<int>> onChange;
  @override
  final Duration duration;
  @override
  final Curve curve;

  const Lifted({
    required this.value,
    required this.onChange,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
  }) : super._();

  @override
  FPickerController _create(VoidCallback callback, int wheelCount) {
    final controller = _Controller(initialIndexes: value, onChange: onChange);
    _updateWheels(controller);

    return controller..addListener(callback);
  }

  @override
  void _updateController(FPickerController controller, int _) {
    (controller as _Controller).update(value, onChange, duration, curve);
  }
}

@internal
class Managed extends FPickerControl with Diagnosticable, _$ManagedMixin {
  @override
  final FPickerController? controller;
  @override
  final List<int>? initial;
  @override
  final ValueChanged<List<int>>? onChange;

  const Managed({this.controller, this.initial, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Set the value directly in the controller.',
      ),
      super._();

  @override
  FPickerController _create(VoidCallback callback, int wheelCount) {
    final created = controller ?? FPickerController(initialIndexes: initial ?? .filled(wheelCount, 0));
    _updateWheels(created);

    return created..addListener(callback);
  }
}

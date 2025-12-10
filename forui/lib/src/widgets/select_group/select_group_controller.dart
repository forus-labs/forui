import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

part 'select_group_controller.control.dart';

/// A [FSelectGroup]'s controller.
typedef FSelectGroupController<T> = FMultiValueNotifier<T>;

class _Controller<T> extends FMultiValueNotifier<T> {
  ValueChanged<Set<T>> _onChange;

  _Controller({required super.value, required ValueChanged<Set<T>> onChange}) : _onChange = onChange;

  void updateState(Set<T> value, ValueChanged<Set<T>> onChange) {
    if (super.value != value) {
      super.value = value;
    }
    _onChange = onChange;
  }

  @override
  set value(Set<T> value) {
    if (super.value != value) {
      _onChange(value);
    }
  }

  @override
  void update(T value, {required bool add}) {
    final copy = {...super.value};
    if ((add && copy.add(value)) || (!add && copy.remove(value))) {
      _onChange(copy);
    }
  }
}

/// Defines how a [FSelectGroup]'s value is controlled.
sealed class FSelectGroupControl<T> with Diagnosticable, _$FSelectGroupControlMixin<T> {
  /// Creates a [FSelectGroupControl] for controlling the select group using lifted state.
  const factory FSelectGroupControl.lifted({required Set<T> value, required ValueChanged<Set<T>> onChange}) = Lifted<T>;

  /// Creates a [FSelectGroupControl] for controlling the select group using a controller.
  ///
  /// ## Contract
  /// Throws [AssertionError] if:
  /// * both [controller] and [initial] are provided.
  /// * both [controller] and [min] are provided.
  /// * both [controller] and [max] are provided.
  const factory FSelectGroupControl.managed({
    FSelectGroupController<T>? controller,
    Set<T>? initial,
    int min,
    int? max,
    ValueChanged<Set<T>>? onChange,
  }) = Managed<T>;

  const FSelectGroupControl._();

  (FSelectGroupController<T>, bool) _update(
    FSelectGroupControl<T> old,
    FSelectGroupController<T> controller,
    VoidCallback callback,
  );
}

@internal
final class Lifted<T> extends FSelectGroupControl<T> with _$LiftedMixin<T> {
  @override
  final Set<T> value;
  @override
  final ValueChanged<Set<T>> onChange;

  const Lifted({required this.value, required this.onChange}) : super._();

  @override
  FSelectGroupController<T> _create(VoidCallback callback) =>
      _Controller(value: value, onChange: onChange)..addListener(callback);

  @override
  void _updateController(FSelectGroupController<T> controller) =>
      (controller as _Controller<T>).updateState(value, onChange);
}

@internal
final class Managed<T> extends FSelectGroupControl<T> with _$ManagedMixin<T> {
  @override
  final FSelectGroupController<T>? controller;
  @override
  final Set<T>? initial;
  @override
  final int min;
  @override
  final int? max;
  @override
  final ValueChanged<Set<T>>? onChange;

  const Managed({this.controller, this.initial, this.min = 0, this.max, this.onChange})
    : assert(controller == null || initial == null, 'Cannot provide both an initial value and a controller.'),
      assert(controller == null || min == 0, 'Cannot provide both a min value and a controller.'),
      assert(controller == null || max == null, 'Cannot provide both a max value and a controller.'),
      super._();

  @override
  FSelectGroupController<T> _create(VoidCallback callback) =>
      (controller ?? FMultiValueNotifier(value: initial ?? {}, min: min, max: max))..addListener(callback);
}

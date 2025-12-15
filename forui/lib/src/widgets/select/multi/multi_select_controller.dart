import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';

import 'package:forui/forui.dart';

part 'multi_select_controller.control.dart';

class _ProxyController<T> extends FMultiValueNotifier<T> {
  Set<T> _unsynced;
  ValueChanged<Set<T>> _onChange;

  _ProxyController({required super.value, required ValueChanged<Set<T>> onChange})
    : _unsynced = value,
      _onChange = onChange;

  void _update(Set<T> newValue, ValueChanged<Set<T>> onChange) {
    _onChange = onChange;
    if (!setEquals(super.value, newValue)) {
      _unsynced = newValue;
      super.value = newValue;
    } else if (!setEquals(_unsynced, newValue)) {
      _unsynced = newValue;
      notifyListeners();
    }
  }

  @override
  void update(T newValue, {required bool add}) {
    final copy = {...super.value};
    if ((add && copy.add(newValue)) || (!add && copy.remove(newValue))) {
      _unsynced = {...copy};
      _onChange(copy);
    }
  }

  @override
  set value(Set<T> newValue) {
    _unsynced = {...newValue};
    if (!setEquals(super.value, newValue)) {
      _onChange(newValue);
    }
  }
}

/// A [FMultiSelectControl] defines how a [FMultiSelect] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FMultiSelectControl<T> with Diagnosticable, _$FMultiSelectControlMixin<T> {
  /// Creates a [FMultiSelectControl].
  const factory FMultiSelectControl.managed({
    FMultiValueNotifier<T>? controller,
    Set<T>? initial,
    int min,
    int? max,
    ValueChanged<Set<T>>? onChange,
  }) = FMultiSelectManagedControl<T>;

  /// Creates a [FMultiSelectControl] for controlling multi-select using lifted state.
  ///
  /// The [value] parameter contains the current selected values.
  /// The [onChange] callback is invoked when the user selects or deselects an item.
  const factory FMultiSelectControl.lifted({required Set<T> value, required ValueChanged<Set<T>> onChange}) =
      _Lifted<T>;

  const FMultiSelectControl._();

  (FMultiValueNotifier<T>, bool) _update(
    FMultiSelectControl<T> old,
    FMultiValueNotifier<T> controller,
    VoidCallback callback,
  );
}

/// A [FMultiSelectManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FMultiSelectManagedControl<T> extends FMultiSelectControl<T>
    with Diagnosticable, _$FMultiSelectManagedControlMixin<T> {
  /// The controller.
  @override
  final FMultiValueNotifier<T>? controller;

  /// The initial values. Defaults to an empty set.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final Set<T>? initial;

  /// The minimum number of selected items. Defaults to 0.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [min] is non-zero and [controller] is provided.
  @override
  final int min;

  /// The maximum number of selected items. Defaults to no limit.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [max] and [controller] are both provided.
  @override
  final int? max;

  /// Called when the selected values change.
  @override
  final ValueChanged<Set<T>>? onChange;

  /// Creates a [FMultiSelectControl].
  const FMultiSelectManagedControl({this.controller, this.initial, this.min = 0, this.max, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Set the value directly in the controller.',
      ),
      assert(
        controller == null || min == 0,
        'Cannot provide both controller and min. Set the min directly in the controller.',
      ),
      assert(
        controller == null || max == null,
        'Cannot provide both controller and max. Set the max directly in the controller.',
      ),
      super._();

  @override
  FMultiValueNotifier<T> createController() =>
      controller ?? FMultiValueNotifier<T>(value: initial ?? const {}, min: min, max: max);
}

class _Lifted<T> extends FMultiSelectControl<T> with _$_LiftedMixin<T> {
  @override
  final Set<T> value;
  @override
  final ValueChanged<Set<T>> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  FMultiValueNotifier<T> createController() => _ProxyController(value: value, onChange: onChange);

  @override
  void _updateController(FMultiValueNotifier<T> controller) =>
      (controller as _ProxyController<T>)._update(value, onChange);
}

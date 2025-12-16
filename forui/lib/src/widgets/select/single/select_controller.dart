import 'package:flutter/foundation.dart';

import 'package:forui/forui.dart';

part 'select_controller.control.dart';

/// The [FSelect]'s controller.
class FSelectController<T> extends FValueNotifier<T?> {
  /// True if the items in the select can toggled (unselected). Defaults to false.
  final bool toggleable;

  /// Creates a [FSelectController].
  FSelectController({T? value, this.toggleable = false}) : super(value);

  @override
  set value(T? value) => super.value = toggleable && super.value == value ? null : value;
}

class _ProyController<T> extends FSelectController<T> {
  T? _unsynced;
  ValueChanged<T?> _onChange;

  _ProyController({required super.value, required ValueChanged<T?> onChange}) : _unsynced = value, _onChange = onChange;

  void _update(T? newValue, ValueChanged<T?> onChange) {
    _onChange = onChange;
    if (super.value != newValue) {
      _unsynced = newValue;
      super.value = newValue;
    } else if (_unsynced != newValue) {
      _unsynced = newValue;
      notifyListeners();
    }
  }

  @override
  set value(T? newValue) {
    if (super.value != newValue) {
      _unsynced = newValue;
      _onChange(newValue);
    }
  }
}

/// A [FSelectControl] defines how a [FSelect] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FSelectControl<T> with Diagnosticable, _$FSelectControlMixin<T> {
  /// Creates a [FSelectControl].
  const factory FSelectControl.managed({
    FSelectController<T>? controller,
    T? initial,
    bool toggleable,
    ValueChanged<T?>? onChange,
  }) = FSelectManagedControl<T>;

  /// Creates a [FSelectControl] for controlling select using lifted state.
  ///
  /// The [value] parameter contains the current selected value.
  /// The [onChange] callback is invoked when the user selects an item.
  const factory FSelectControl.lifted({required T? value, required ValueChanged<T?> onChange}) = _Lifted<T>;

  const FSelectControl._();

  (FSelectController<T>, bool) _update(FSelectControl<T> old, FSelectController<T> controller, VoidCallback callback);
}

/// A [FSelectManagedControl] enables widgets to manage their own controller internally while exposing parameters for
/// common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
class FSelectManagedControl<T> extends FSelectControl<T> with Diagnosticable, _$FSelectManagedControlMixin<T> {
  /// The controller.
  @override
  final FSelectController<T>? controller;

  /// The initial value. Defaults to null.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [initial] and [controller] are both provided.
  @override
  final T? initial;

  /// Whether the selection is toggleable. Defaults to false.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [toggleable] and [controller] are both provided
  @override
  final bool? toggleable;

  /// Called when the selected value changes.
  @override
  final ValueChanged<T?>? onChange;

  /// Creates a [FSelectControl].
  const FSelectManagedControl({this.controller, this.initial, this.toggleable, this.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Pass initial value to the controller.',
      ),
      assert(
        controller == null || toggleable == null,
        'Cannot provide both controller and toggleable. Pass toggleable to the controller.',
      ),
      super._();

  @override
  FSelectController<T> createController() =>
      controller ?? FSelectController<T>(value: initial, toggleable: toggleable ?? false);
}

class _Lifted<T> extends FSelectControl<T> with _$_LiftedMixin<T> {
  @override
  final T? value;
  @override
  final ValueChanged<T?> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  FSelectController<T> createController() => _ProyController(value: value, onChange: onChange);

  @override
  void _updateController(FSelectController<T> controller) =>
      (controller as _ProyController<T>)._update(value, onChange);
}

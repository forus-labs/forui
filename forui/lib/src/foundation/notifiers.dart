import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';

import 'package:forui/src/foundation/debug.dart';

part 'notifiers.control.dart';

/// A [ChangeNotifier] that provides additional life-cycle tracking capabilities.
class FChangeNotifier with ChangeNotifier {
  bool _disposed = false;

  /// Creates a [FChangeNotifier].
  FChangeNotifier() {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  /// True if this notifier has been disposed.
  bool get disposed => _disposed;

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}

/// A [ValueNotifier] that provides additional life-cycle tracking capabilities.
@Deprecated(
  "Use ValueNotifier instead. Please open an issue at https://github.com/duobaseio/forui/issues if that doesn't cover your use case.",
)
class FValueNotifier<T> extends ValueNotifier<T> {
  final List<ValueChanged<T>> _listeners = [];
  bool _disposed = false;

  /// Creates a [FValueNotifier].
  @Deprecated('Use ValueNotifier instead.')
  FValueNotifier(super._value);

  /// Registers a closure to be called with a new value when the notifier changes if not null.
  @Deprecated(
    "Use lifted state instead. Please open an issue at https://github.com/duobaseio/forui/issues if that doesn't cover your use case.",
  )
  void addValueListener(ValueChanged<T>? listener) {
    if (listener != null) {
      _listeners.add(listener);
    }
  }

  /// Removes a previously registered closure from the list of closures that are notified when the object changes.
  @Deprecated(
    "Use lifted state instead. Please open an issue at https://github.com/duobaseio/forui/issues if that doesn't cover your use case.",
  )
  void removeValueListener(ValueChanged<T>? listener) => _listeners.remove(listener);

  @override
  @protected
  void notifyListeners() {
    super.notifyListeners();
    for (final listener in _listeners) {
      listener(value);
    }
  }

  @override
  bool get hasListeners => super.hasListeners || _listeners.isNotEmpty;

  /// True if this notifier has been disposed.
  bool get disposed => _disposed;

  @override
  @mustCallSuper
  void dispose() {
    _listeners.clear();
    super.dispose();
    _disposed = true;
  }
}

/// A notifier that manages a set of values.
class FMultiValueNotifier<T> extends FValueNotifier<Set<T>> {
  final List<ValueChanged<(T, bool)>> _updateListeners = [];
  final int _min;
  final int? _max;

  /// Creates a [FMultiValueNotifier] with a [min] and [max] number of elements allowed. Defaults to no min and max.
  ///
  /// # Contract:
  /// [min] and [max] must be: `0 <= min <= max`.
  FMultiValueNotifier({Set<T> value = const {}, int min = 0, int? max})
    : _min = min,
      _max = max,
      assert(debugCheckInclusiveRange<FMultiValueNotifier<T>>(min, max)),
      super(value);

  /// Creates a [FMultiValueNotifier] that allows only one element at a time.
  factory FMultiValueNotifier.radio([T? value]) = _RadioNotifier<T>;

  /// Returns true if the notifier contains the [value].
  bool contains(T value) => super.value.contains(value);

  /// Adds or removes the [value] from this notifier.
  ///
  /// Subclasses _must_:
  /// * call [notifyUpdateListeners] after changing the value.
  /// * additionally override [FMultiValueNotifier.value].
  void update(T value, {required bool add}) {
    if (add) {
      if (_max case final max? when max <= this.value.length) {
        return;
      }

      super.value = {...this.value, value};
      notifyUpdateListeners(value, add: add);
    } else {
      if (this.value.length <= _min) {
        return;
      }

      super.value = {...this.value}..remove(value);
      notifyUpdateListeners(value, add: add);
    }
  }

  /// Registers a closure to be called whenever [update] successfully adds/removes an element if not null.
  @Deprecated(
    "Use lifted state instead. Please open an issue at https://github.com/duobaseio/forui/issues if that doesn't cover your use case.",
  )
  void addUpdateListener(ValueChanged<(T, bool)>? listener) {
    if (listener != null) {
      _updateListeners.add(listener);
    }
  }

  /// Removes a previously registered closure from the list of closures that are notified whenever [update] successfully
  /// adds/removes a value.
  @Deprecated(
    "Use lifted state instead. Please open an issue at https://github.com/duobaseio/forui/issues if that doesn't cover your use case.",
  )
  void removeUpdateListener(ValueChanged<(T, bool)>? listener) => _updateListeners.remove(listener);

  /// Notifies all registered update listeners of a change.
  @protected
  void notifyUpdateListeners(T value, {required bool add}) {
    for (final listener in _updateListeners) {
      listener((value, add));
    }
  }

  /// Subclasses _must_:
  /// * additionally override [update].
  @override
  set value(Set<T> value) {
    if (value.length < _min || (_max != null && _max < value.length)) {
      throw ArgumentError(
        _max == null
            ? 'The number of elements must be <= $_min.'
            : 'The number of elements must be between $_min and $_max.',
      );
    }

    super.value = {...value};
  }

  @override
  void dispose() {
    _updateListeners.clear();
    super.dispose();
  }
}

class _RadioNotifier<T> extends FMultiValueNotifier<T> {
  _RadioNotifier([T? value]) : super(value: {?value});

  @override
  void update(T value, {required bool add}) {
    if (!add || contains(value)) {
      return;
    }

    super.value = {value};
    notifyUpdateListeners(value, add: add);
  }

  @override
  set value(Set<T> value) {
    if (1 < value.length) {
      throw ArgumentError('Can contain only 1 element.');
    }

    super.value = {...value};
  }
}

class _ProxyNotifier<T> extends FMultiValueNotifier<T> {
  Set<T> _unsynced;
  ValueChanged<Set<T>> _onChange;

  _ProxyNotifier({required super.value, required ValueChanged<Set<T>> onChange})
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

/// A [FMultiValueControl] defines how a [FMultiValueNotifier] is controlled.
///
/// {@macro forui.foundation.doc_templates.control}
sealed class FMultiValueControl<T> with Diagnosticable, _$FMultiValueControlMixin<T> {
  /// Creates a [FMultiValueControl] for multiple value selection.
  const factory FMultiValueControl.managed({
    FMultiValueNotifier<T>? controller,
    Set<T>? initial,
    int min,
    int? max,
    ValueChanged<Set<T>>? onChange,
  }) = _Normal<T>;

  /// Creates a [FMultiValueControl] for single value selection.
  ///
  /// The [initial] parameter contains the initially selected value. It may be null.
  /// The [onChange] callback is invoked when the user selects a different item.
  const factory FMultiValueControl.managedRadio({
    FMultiValueNotifier<T>? controller,
    T? initial,
    ValueChanged<Set<T>>? onChange,
  }) = _Radio<T>;

  /// Creates a [FMultiValueControl] for controlling multi-value notifier using lifted state.
  ///
  /// The [value] parameter contains the current selected values.
  /// The [onChange] callback is invoked when the user selects or deselects an item.
  const factory FMultiValueControl.lifted({required Set<T> value, required ValueChanged<Set<T>> onChange}) = _Lifted<T>;

  const FMultiValueControl._();

  (FMultiValueNotifier<T>, bool) _update(
    FMultiValueControl<T> old,
    FMultiValueNotifier<T> controller,
    VoidCallback callback,
  );
}

/// A [FMultiValueManagedControl] enables widgets to manage their own controller internally while exposing parameters
/// for common configurations.
///
/// {@macro forui.foundation.doc_templates.managed}
abstract class FMultiValueManagedControl<T> extends FMultiValueControl<T>
    with Diagnosticable, _$FMultiValueManagedControlMixin<T> {
  /// The controller.
  @override
  final FMultiValueNotifier<T>? controller;

  /// The minimum number of selected items. Defaults to 0.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [min] is non-zero and [controller] is provided.
  @override
  final int? min;

  /// The maximum number of selected items. Defaults to no limit.
  ///
  /// ## Contract
  /// Throws [AssertionError] if [max] and [controller] are both provided.
  @override
  final int? max;

  /// Called when the selected values change.
  @override
  final ValueChanged<Set<T>>? onChange;

  /// Creates a [FMultiValueControl].
  const FMultiValueManagedControl({this.controller, this.min, this.max, this.onChange})
    : assert(controller == null || min == null, 'Cannot provide both controller and min. Pass min to the controller.'),
      assert(controller == null || max == null, 'Cannot provide both controller and max. Pass max to the controller.'),
      super._();
}

class _Normal<T> extends FMultiValueManagedControl<T> {
  final Set<T>? initial;

  const _Normal({this.initial, super.controller, super.min, super.max, super.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Pass initial value to the controller.',
      );

  @override
  FMultiValueNotifier<T> createController() =>
      controller ?? FMultiValueNotifier<T>(value: initial ?? const {}, min: min ?? 0, max: max);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('initial', initial));
  }
}

class _Radio<T> extends FMultiValueManagedControl<T> {
  final T? initial;

  const _Radio({this.initial, super.controller, super.onChange})
    : assert(
        controller == null || initial == null,
        'Cannot provide both controller and initial. Pass initial value to the controller.',
      );

  @override
  FMultiValueNotifier<T> createController() => controller ?? FMultiValueNotifier<T>.radio(initial);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('initial', initial));
  }
}

class _Lifted<T> extends FMultiValueControl<T> with _$_LiftedMixin<T> {
  @override
  final Set<T> value;
  @override
  final ValueChanged<Set<T>> onChange;

  const _Lifted({required this.value, required this.onChange}) : super._();

  @override
  FMultiValueNotifier<T> createController() => _ProxyNotifier(value: value, onChange: onChange);

  @override
  void _updateController(FMultiValueNotifier<T> controller) =>
      (controller as _ProxyNotifier<T>)._update(value, onChange);
}

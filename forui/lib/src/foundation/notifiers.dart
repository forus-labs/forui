import 'package:flutter/foundation.dart';

import 'package:forui/src/foundation/debug.dart';

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
class FValueNotifier<T> extends ValueNotifier<T> {
  final List<ValueChanged<T>> _listeners = [];
  bool _disposed = false;

  /// Creates a [FValueNotifier].
  FValueNotifier(super._value);

  /// Registers a closure to be called with a new value when the notifier changes if not null.
  void addValueListener(ValueChanged<T>? listener) {
    if (listener != null) {
      _listeners.add(listener);
    }
  }

  /// Removes a previously registered closure from the list of closures that are notified when the object changes.
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
  void addUpdateListener(ValueChanged<(T, bool)>? listener) {
    if (listener != null) {
      _updateListeners.add(listener);
    }
  }

  /// Removes a previously registered closure from the list of closures that are notified whenever [update] successfully
  /// adds/removes a value.
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
      if (_max == null) {
        throw ArgumentError('The number of elements must be <= $_min.');
      } else {
        throw ArgumentError('The number of elements must be between $_min and $_max.');
      }
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

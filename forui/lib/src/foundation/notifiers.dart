import 'package:flutter/foundation.dart';

// ignore_for_file: always_call_super_dispose_last

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
  final Map<ValueChanged<T>, VoidCallback> _listeners = {};
  bool _disposed = false;

  /// Creates a [FValueNotifier].
  FValueNotifier(super._value);

  /// Register a closure to be called with a new value when the notifier changes.
  void addValueListener(ValueChanged<T> listener) {
    void callback() => listener(value);
    _listeners[listener] = callback;
    addListener(callback);
  }

  /// Remove a previously registered closure from the list of closures that are notified when the object changes.
  void removeValueListener(ValueChanged<T> listener) {
    final callback = _listeners.remove(listener);
    if (callback != null) {
      removeListener(callback);
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

/// A notifier that manages a set of elements.
abstract class FMultiValueNotifier<T> extends FValueNotifier<Set<T>> {
  final List<ValueChanged<(T, bool)>> _updateListeners = [];

  /// Creates a [FMultiValueNotifier] with a [min] and [max] number of elements allowed. Defaults to no min and max.
  ///
  /// # Contract:
  /// Throws [AssertionError] if:
  /// * [min] < 0.
  /// * [max] < 0.
  /// * [min] > [max].
  factory FMultiValueNotifier({int min, int? max, Set<T>? values}) = _MultiNotifier<T>;

  /// Creates a [FMultiValueNotifier] that allows only one element at a time.
  factory FMultiValueNotifier.radio({T? value}) = _RadioNotifier<T>;

  FMultiValueNotifier._(super._value);

  /// Returns true if the notifier contains the [value].
  bool contains(T value) => _value.contains(value);

  /// Adds or removes the [value] from this notifier.
  ///
  /// Subclasses _must_ call [notifyUpdateListeners] after changing the value.
  void update(T value, {required bool add});

  /// Register a closure to be called whenever [update] successfully adds/removes an element.
  void addUpdateListener(ValueChanged<(T, bool)> listener) => _updateListeners.add(listener);

  /// Remove a previously registered closure from the list of closures that are notified whenever [update] successfully
  /// adds/removes an element.
  void removeUpdateListener(ValueChanged<(T, bool)> listener) => _updateListeners.remove(listener);

  /// Notify all registered update listeners of a change.
  @protected
  void notifyUpdateListeners(T value, {required bool add}) {
    for (final listener in _updateListeners) {
      listener((value, add));
    }
  }

  @override
  set value(Set<T> values) {
    _value
      ..clear()
      ..addAll(values);

    notifyListeners();
  }

  Set<T> get _value => super.value;

  @override
  void dispose() {
    _updateListeners.clear();
    super.dispose();
  }
}

class _MultiNotifier<T> extends FMultiValueNotifier<T> {
  final int min;
  final int? max;

  _MultiNotifier({this.min = 0, this.max, Set<T>? values})
    : assert(min >= 0, 'The min must be greater than or equal to 0.'),
      assert(max == null || max >= 0, 'The max must be greater than or equal to 0.'),
      assert(max == null || min <= max, 'The max must be greater than or equal to the min.'),
      super._(values ?? {});

  @override
  void update(T value, {required bool add}) {
    if (add) {
      if (max case final max? when max <= _value.length) {
        return;
      }

      _value.add(value);
    } else {
      if (_value.length <= min) {
        return;
      }

      _value.remove(value);
    }

    notifyUpdateListeners(value, add: add);
    notifyListeners();
  }

  @override
  set value(Set<T> value) {
    if (value.length < min || (max != null && max! < value.length)) {
      throw ArgumentError('The number of elements must be between $min and ${max ?? 'infinite'}.');
    }

    super.value = value;
  }
}

class _RadioNotifier<T> extends FMultiValueNotifier<T> {
  _RadioNotifier({T? value}) : super._({if (value != null) value});

  @override
  void update(T value, {required bool add}) {
    if (!add || contains(value)) {
      return;
    }

    _value
      ..clear()
      ..add(value);

    notifyUpdateListeners(value, add: add);
    notifyListeners();
  }

  @override
  set value(Set<T> value) {
    if (1 < value.length) {
      throw ArgumentError('Can contain only 1 element.');
    }
    super.value = value;
  }
}

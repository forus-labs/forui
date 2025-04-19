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
  bool contains(T value) => super.value.contains(value);

  /// Adds or removes the [value] from this notifier.
  ///
  /// Subclasses _must_ call [notifyUpdateListeners] after changing the value.
  void update(T value, {required bool add});

  /// Registers a closure to be called whenever [update] successfully adds/removes an element if not null.
  void addUpdateListener(ValueChanged<(T, bool)>? listener) {
    if (listener != null) {
      _updateListeners.add(listener);
    }
  }

  /// Removes a previously registered closure from the list of closures that are notified whenever [update] successfully
  /// adds/removes an element.
  void removeUpdateListener(ValueChanged<(T, bool)>? listener) => _updateListeners.remove(listener);

  /// Notifies all registered update listeners of a change.
  @protected
  void notifyUpdateListeners(T value, {required bool add}) {
    for (final listener in _updateListeners) {
      listener((value, add));
    }
  }

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
      if (max case final max? when max <= this.value.length) {
        return;
      }

      super.value = {...this.value, value};
      notifyUpdateListeners(value, add: add);
    } else {
      if (this.value.length <= min) {
        return;
      }

      super.value = {...this.value}..remove(value);
      notifyUpdateListeners(value, add: add);
    }
  }

  @override
  set value(Set<T> value) {
    if (value.length < min || (max != null && max! < value.length)) {
      throw ArgumentError('The number of elements must be between $min and ${max ?? 'infinite'}.');
    }

    super.value = {...value};
  }
}

class _RadioNotifier<T> extends FMultiValueNotifier<T> {
  _RadioNotifier({T? value}) : super._({if (value != null) value});

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

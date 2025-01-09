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

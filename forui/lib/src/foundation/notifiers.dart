import 'package:flutter/foundation.dart';

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
  bool _disposed = false;

  /// Creates a [FValueNotifier].
  FValueNotifier(super._value);

  /// True if this notifier has been disposed.
  bool get disposed => _disposed;

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}

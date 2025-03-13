import 'package:flutter/foundation.dart';
import 'package:forui/forui.dart';

/// A select controller that manages the selection state of a group of values.
abstract class FSelectController<T> extends FValueNotifier<Set<T>> {
  final List<ValueChanged<(T, bool)>> _changeListeners = [];

  /// Creates a [FSelectController] with a [min] and [max] number of selected elements allowed. Defaults to no min and 
  /// max.
  ///
  /// # Contract:
  /// Throws [AssertionError] if:
  /// * [min] < 0.
  /// * [max] < 0.
  /// * [min] > [max].
  factory FSelectController({int min, int? max, Set<T> values}) = _MultiController<T>;

  /// Creates a [FSelectController] that allows only one element at a time.
  factory FSelectController.radio({T? value}) = _RadioController<T>;

  FSelectController._({required Set<T> values}) : super(values);

  /// Returns true if [value] is selected.
  bool contains(T value) => _value.contains(value);

  /// Updates the selection state of the given [value].
  ///
  /// Returns true if the notifier was updated.
  ///
  /// Custom implementations _must_ call [notifyChangeListeners] after changing the value.
  void update(T value, {required bool selected});

  /// Register a closure to be called whenever [update] successfully updates a selection.
  void addChangeListener(ValueChanged<(T, bool)> listener) => _changeListeners.add(listener);

  /// Remove a previously registered closure from the list of closures that are notified whenever [update] successfully
  /// changes a selection.
  void removeChangeListener(ValueChanged<(T, bool)> listener) => _changeListeners.remove(listener);

  /// Notify all registered listeners of a change.
  @protected
  void notifyChangeListeners(T value, {required bool add}) {
    for (final listener in _changeListeners) {
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
    _changeListeners.clear();
    super.dispose();
  }
}

class _MultiController<T> extends FSelectController<T> {
  final int min;
  final int? max;

  _MultiController({this.min = 0, this.max, Set<T>? values})
      : assert(min >= 0, 'The min must be greater than or equal to 0.'),
        assert(max == null || max >= 0, 'The max must be greater than or equal to 0.'),
        assert(max == null || min <= max, 'The max must be greater than or equal to the min.'),
        super._(values: values ?? {});

  @override
  void update(T value, {required bool selected}) {
    if (selected) {
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

    notifyChangeListeners(value, add: selected);
    notifyListeners();
  }

  @override
  set value(Set<T> value) {
    if (value.length < min || (max != null && max! < value.length)) {
      throw ArgumentError('The number of selected values must be between $min and ${max ?? 'infinite'}.');
    }

    super.value = value;
  }
}

class _RadioController<T> extends FSelectController<T> {
  _RadioController({T? value}) : super._(values: value == null ? {} : {value});

  @override
  void update(T value, {required bool selected}) {
    if (!selected || contains(value)) {
      return;
    }

    _value
      ..clear()
      ..add(value);

    notifyChangeListeners(value, add: selected);
    notifyListeners();
  }

  @override
  set value(Set<T> value) {
    if (1 < value.length) {
      throw ArgumentError('Can contain only 1 selected value.');
    }
    super.value = value;
  }
}

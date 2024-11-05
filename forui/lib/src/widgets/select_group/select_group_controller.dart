import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

/// A controller for a select group.
abstract class FSelectGroupController<T> extends FChangeNotifier {
  final Set<T> _values;

  /// Creates a [FSelectGroupController].
  FSelectGroupController({Set<T> values = const {}}) : _values = {...values};

  /// Handles a change in the selection.
  // ignore: avoid_positional_boolean_parameters
  void select(T value, bool selected);

  /// Returns true if a value is selected.
  bool contains(T value) => _values.contains(value);

  /// The currently selected values.
  Set<T> get values => {..._values};

  @protected
  set values(Set<T> values) => {
        _values.clear(),
        _values.addAll(values),
        notifyListeners(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FSelectGroupController && runtimeType == other.runtimeType && values == other.values;

  @override
  int get hashCode => _values.hashCode;
}

@internal
// ignore: avoid_implementing_value_types
class DelegateSelectGroupController<T> implements FSelectGroupController<T> {
  FSelectGroupController<T> delegate;

  DelegateSelectGroupController(this.delegate);

  @override
  @mustCallSuper
  bool contains(T value) => delegate.contains(value);

  @override
  @mustCallSuper
  void select(T value, bool selected) => delegate.select(value, selected);

  @override
  @mustCallSuper
  void addListener(VoidCallback listener) => delegate.addListener(listener);

  @override
  @mustCallSuper
  void notifyListeners() => delegate.notifyListeners();

  @override
  @mustCallSuper
  void removeListener(VoidCallback listener) => delegate.removeListener(listener);

  @override
  @mustCallSuper
  void dispose() => delegate.dispose();

  @override
  @mustCallSuper
  bool get hasListeners => delegate.hasListeners;

  @override
  @mustCallSuper
  bool get disposed => delegate.disposed;

  @override
  @mustCallSuper
  Set<T> get values => delegate.values;

  @override
  @mustCallSuper
  set values(Set<T> values) => delegate.values = values;

  @override
  @mustCallSuper
  Set<T> get _values => delegate.values;
}

/// A [FSelectGroupController] that allows only one selection mimicking the behaviour of radio buttons.
class FRadioSelectGroupController<T> extends FSelectGroupController<T> {
  /// Creates a [FRadioSelectGroupController].
  FRadioSelectGroupController({T? value}) : super(values: value == null ? {} : {value});

  @override
  void select(T value, bool selected) {
    if (!selected || contains(value)) {
      return;
    }

    _values
      ..clear()
      ..add(value);

    notifyListeners();
  }
}

/// A [FSelectGroupController] that allows multiple selections.
class FMultiSelectGroupController<T> extends FSelectGroupController<T> {
  final int _min;
  final int? _max;

  /// Creates a [FMultiSelectGroupController].
  ///
  /// The [min] and [max] values are the minimum and maximum number of selections allowed. Defaults to no minimum or maximum.
  ///
  /// # Contract:
  /// * Throws [AssertionError] if [min] < 0.
  /// * Throws [AssertionError] if [max] < 0.
  /// * Throws [AssertionError] if [min] > [max].
  FMultiSelectGroupController({
    int min = 0,
    int? max,
    super.values,
  })  : _min = min,
        _max = max,
        assert(min >= 0, 'The min value must be greater than or equal to 0.'),
        assert(max == null || max >= 0, 'The max value must be greater than or equal to 0.'),
        assert(max == null || min <= max, 'The max value must be greater than or equal to the min value.');

  @override
  void select(T value, bool selected) {
    if (selected) {
      if (_max != null && _values.length >= _max) {
        return;
      }

      _values.add(value);
    } else {
      if (_values.length <= _min) {
        return;
      }

      _values.remove(value);
    }

    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FMultiSelectGroupController &&
          runtimeType == other.runtimeType &&
          _min == other._min &&
          _max == other._max;

  @override
  int get hashCode => _min.hashCode ^ _max.hashCode;
}

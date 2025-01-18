import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:meta/meta.dart';

/// A select group's controller that manages the selection state of a group of values.
///
/// See:
/// * [FRadioSelectGroupController] for a single radio button like selection.
/// * [FMultiSelectGroupController] for multiple selections.
abstract class FSelectGroupController<T> extends FValueNotifier<Set<T>> {
  /// Creates a [FSelectGroupController].
  FSelectGroupController({Set<T> values = const {}}) : super({...values});

  /// Returns true if a value is selected.
  bool contains(T value) => super.value.contains(value);

  /// Updates the selection state of the given [value].
  void update(T value, {required bool selected});

  @override
  Set<T> get value => {..._value};

  @override
  set value(Set<T> values) {
    _value
      ..clear()
      ..addAll(values);

    notifyListeners();
  }

  Set<T> get _value => super.value;
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
  void update(T value, {required bool selected}) => delegate.update(value, selected: selected);

  @override
  @mustCallSuper
  void addListener(VoidCallback listener) => delegate.addListener(listener);

  @override
  void addValueListener(ValueChanged<Set<T>> listener) => delegate.addValueListener(listener);

  @override
  @mustCallSuper
  void notifyListeners() => delegate.notifyListeners();

  @override
  @mustCallSuper
  void removeListener(VoidCallback listener) => delegate.removeListener(listener);

  @override
  void removeValueListener(ValueChanged<Set<T>> listener) => delegate.removeValueListener(listener);

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
  Set<T> get value => delegate.value;

  @override
  @mustCallSuper
  set value(Set<T> value) => delegate.value = value;

  @override
  Set<T> get _value => delegate._value;
}

/// A [FSelectGroupController] that allows only one selection, mimicking the behaviour of radio buttons.
class FRadioSelectGroupController<T> extends FSelectGroupController<T> {
  /// A callback that is called when the selection of a value is updated via [update].
  ///
  /// It is called before listeners registered via [addListener] and [addValueListener].
  final ValueChanged<(T, bool)>? onUpdate;

  /// Creates a [FRadioSelectGroupController].
  FRadioSelectGroupController({T? value, this.onUpdate}) : super(values: value == null ? {} : {value});

  @override
  void update(T value, {required bool selected}) {
    if (!selected || contains(value)) {
      return;
    }

    _value
      ..clear()
      ..add(value);

    onUpdate?.call((value, selected));
    notifyListeners();
  }

  @override
  set value(Set<T> value) {
    if (1 < value.length) {
      throw ArgumentError('Only one value can be selected.');
    }

    super.value = value;
  }
}

/// A [FSelectGroupController] that allows multiple selections.
class FMultiSelectGroupController<T> extends FSelectGroupController<T> {
  /// A callback that is called when the selection of a value is updated via [update].
  ///
  /// It is called before listeners registered via [addListener] and [addValueListener].
  final ValueChanged<(T, bool)>? onUpdate;
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
    this.onUpdate,
    super.values,
  })  : _min = min,
        _max = max,
        assert(min >= 0, 'The min value must be greater than or equal to 0.'),
        assert(max == null || max >= 0, 'The max value must be greater than or equal to 0.'),
        assert(max == null || min <= max, 'The max value must be greater than or equal to the min value.');

  @override
  void update(T value, {required bool selected}) {
    if (selected) {
      if (_max != null && _value.length >= _max) {
        return;
      }

      _value.add(value);
    } else {
      if (_value.length <= _min) {
        return;
      }

      _value.remove(value);
    }

    onUpdate?.call((value, selected));
    notifyListeners();
  }

  @override
  set value(Set<T> value) {
    if (value.length < _min || (_max != null && _max < value.length)) {
      throw ArgumentError('The number of values must be between $_min and ${_max ?? ''}.');
    }

    super.value = value;
  }
}

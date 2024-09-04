import 'package:flutter/widgets.dart';

abstract class FSelectGroupController<T> with ChangeNotifier {
  final Set<T> _values;

  FSelectGroupController({Set<T> values = const {}}) : _values = values;

  void onChange(T value, bool selected);

  Set<T> get values => {..._values};
}

class FRadioSelectGroupController<T> extends FSelectGroupController<T> {
  FRadioSelectGroupController({T? value}) : super(values: value == null ? {} : {value});

  @override
  void onChange(T value, bool selected) {
    if (selected) {
      _values
        ..clear()
        ..add(value);
    }

    notifyListeners();
  }
}

class FMultiSelectGroupController<T> extends FSelectGroupController<T> {
  int _min;
  int _max;

  FMultiSelectGroupController({
    Set<T> values = const {},
    int min = 0,
    int max = -1,
  })  : _min = min,
        _max = max,
        super(values: values);

  @override
  void onChange(T value, bool selected) {
    if (selected) {
      if (_max > -1 && _values.length >= _max) {
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
}

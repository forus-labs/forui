import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

/// Creates a [FMultiValueNotifier] that manages a set of elements and is automatically disposed.
FMultiValueNotifier<T> useFSelectGroupController<T>({
  Set<T> value = const {},
  int min = 0,
  int? max,
  List<Object?>? keys,
}) => useFMultiValueNotifier<T>(value: value, min: min, max: max, keys: keys);

/// Creates a [FMultiValueNotifier] that allows only one element at a time.
FMultiValueNotifier<T> useFRadioSelectGroupController<T>({T? value, List<Object?>? keys}) =>
    useFRadioMultiValueNotifier<T>(value: value, keys: keys);

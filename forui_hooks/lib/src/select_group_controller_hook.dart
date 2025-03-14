import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

/// Creates a [FSelectGroupController] that manages a set of elements and is automatically disposed.
FSelectGroupController<T> useFSelectGroupController<T>({Set<T>? values, int min = 0, int? max, List<Object?>? keys}) =>
    useFMultiValueNotifier<T>(values: values, min: min, max: max, keys: keys);

/// Creates a [FSelectGroupController] that allows only one element at a time.
FSelectGroupController<T> useFRadioSelectGroupController<T>({T? value, List<Object?>? keys}) =>
    useFRadioMultiValueNotifier<T>(value: value, keys: keys);

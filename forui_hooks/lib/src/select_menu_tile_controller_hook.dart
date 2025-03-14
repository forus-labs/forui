import 'package:forui/forui.dart';

import 'package:forui_hooks/forui_hooks.dart';

/// Creates a [FSelectMenuTileController] that manages a set of elements and is automatically disposed.
FSelectMenuTileController<T> useFSelectMenuTileController<T>({
  Set<T>? values,
  int min = 0,
  int? max,
  List<Object?>? keys,
}) => useFMultiValueNotifier<T>(values: values, min: min, max: max, keys: keys);

/// Creates a [FSelectMenuTileController] that allows only one element at a time.
FSelectMenuTileController<T> useFRadioSelectMenuTileController<T>({T? value, List<Object?>? keys}) =>
    useFRadioMultiValueNotifier<T>(value: value, keys: keys);

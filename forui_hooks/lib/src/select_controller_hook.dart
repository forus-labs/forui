import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FSelectController] that allows an item to be selected.
FSelectController<T> useFSelectController<T>({T? value, bool toggleable = false, List<Object?>? keys}) => use(
  _SelectHook(value: value, toggleable: toggleable, debugLabel: 'useFSelectController', keys: keys),
);

class _SelectHook<T> extends Hook<FSelectController<T>> {
  final T? value;
  final bool toggleable;
  final String _debugLabel;

  const _SelectHook({required this.value, required this.toggleable, required String debugLabel, super.keys})
    : _debugLabel = debugLabel;

  @override
  _SelectHookState<T> createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('value', value))
      ..add(FlagProperty('toggleable', value: toggleable, ifTrue: 'toggleable'));
  }
}

class _SelectHookState<T> extends HookState<FSelectController<T>, _SelectHook<T>> {
  late final _controller = FSelectController<T>(value: hook.value, toggleable: hook.toggleable);

  @override
  FSelectController<T> build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => hook._debugLabel;
}

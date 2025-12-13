import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:forui/forui.dart';

/// Creates a [FAutocompleteController] that is automatically disposed.
FAutocompleteController useFAutocompleteController({
  String? text,
  List<String> suggestions = const [],
  List<Object?>? keys,
}) => use(_AutocompleteControllerHook(text: text, suggestions: suggestions, keys: keys));

class _AutocompleteControllerHook extends Hook<FAutocompleteController> {
  final String? text;
  final List<String> suggestions;

  const _AutocompleteControllerHook({required this.text, required this.suggestions, super.keys});

  @override
  _AutocompleteControllerHookState createState() => .new();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('text', text))
      ..add(IterableProperty('suggestions', suggestions));
  }
}

class _AutocompleteControllerHookState extends HookState<FAutocompleteController, _AutocompleteControllerHook> {
  late final _controller = FAutocompleteController(text: hook.text, suggestions: hook.suggestions);

  @override
  FAutocompleteController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  bool get debugHasShortDescription => false;

  @override
  String get debugLabel => 'useFAutocompleteController';
}

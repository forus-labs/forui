import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A function type that provides text styles for the typeahead controller.
typedef FTypeaheadControllerTextStyles =
    (TextStyle textStyle, TextStyle composingStyle, TextStyle completionStyle) Function(BuildContext context);

/// A [TextEditingController] with typeahead support.
///
/// A typeahead controller manages suggestions and provides inline completions as the user types. When the current text
/// matches the beginning of a suggestion, the remaining text is shown as a completion that can be accepted.
class FTypeaheadController extends TextEditingController {
  final FTypeaheadControllerTextStyles _textStyles;
  List<String> _suggestions;
  ({String completion, String replacement})? _current;

  /// A monotonic counter to ensure that only latest suggestions are processed. This prevents stale data from being
  /// processed when the suggestions are provided async.
  int _monotonic = 0;
  bool _disposed = false;

  /// Creates a [FTypeaheadController] with an optional initial text and completion.
  FTypeaheadController({
    required FTypeaheadControllerTextStyles textStyles,
    List<String> suggestions = const [],
    super.text,
  }) : _textStyles = textStyles,
       _suggestions = suggestions {
    findCompletion();
  }

  /// Creates a [FTypeaheadController] from a [TextEditingValue].
  FTypeaheadController.fromValue(
    super.value, {
    required FTypeaheadControllerTextStyles textStyles,
    List<String> suggestions = const [],
  }) : _textStyles = textStyles,
       _suggestions = suggestions,
       super.fromValue() {
    findCompletion();
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, required bool withComposing, TextStyle? style}) {
    assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to preserve the tree integrity, otherwise
    // in release mode a RangeError will be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange = !value.isComposingRangeValid || !withComposing;
    final (textStyle, composingStyle, completionStyle) = _textStyles(context);

    return TextSpan(
      children: [
        if (composingRegionOutOfRange)
          TextSpan(text: text, style: style)
        else ...[
          TextSpan(text: value.composing.textBefore(value.text), style: style),
          TextSpan(text: value.composing.textInside(value.text), style: composingStyle),
          TextSpan(text: value.composing.textAfter(value.text), style: style),
        ],
        if (current case (:final completion, replacement: final _)) TextSpan(text: completion, style: completionStyle),
      ],
    );
  }

  /// Completes the current typeahead suggestion by replacing the text with the replacement.
  void complete() {
    if (current case (completion: final _, :final replacement)) {
      current = null;
      // We call super.value to avoid finding completions.
      super.value = TextEditingValue(
        text: replacement,
        selection: .collapsed(offset: replacement.length),
      );
    }
  }

  /// Finds and sets the current completion based on the current text and available suggestions.
  ///
  /// This method should be overridden to customize the completion logic. It should never call [notifyListeners].
  ///
  /// The default implementation performs a case-insensitive prefix match against the suggestions.
  /// If a match is found, [current] is set with the completion text and full replacement.
  /// If no match is found or text is empty, [current] is set to null to disable typeahead.
  @visibleForOverriding
  @visibleForTesting
  void findCompletion([String? text]) {
    text ??= this.text;
    if (text.isEmpty) {
      current = null;
      return;
    }

    for (final suggestion in _suggestions) {
      if (suggestion.toLowerCase().startsWith(text.toLowerCase())) {
        current = (completion: suggestion.substring(text.length), replacement: suggestion);
        return;
      }
    }

    current = null;
  }

  /// Loads suggestions from a [Future] or an [Iterable].
  Future<void> loadSuggestions(FutureOr<Iterable<String>> suggestions) async {
    final monotonic = ++_monotonic;
    switch (suggestions) {
      case final Future<Iterable<String>> future:
        final iterable = await future;
        if (!_disposed && monotonic == _monotonic) {
          _loadSuggestions(iterable);
        }

      case final Iterable<String> iterable:
        _loadSuggestions(iterable);
    }
  }

  void _loadSuggestions(Iterable<String> iterable) {
    final suggestions = [...iterable];
    if (!listEquals(_suggestions, suggestions)) {
      _suggestions = suggestions;
      findCompletion();
      notifyListeners();
    }
  }

  /// The suggestions from which a completion is derived.
  ///
  /// For example, if the user types "appl", the suggestions might include "apple", "application", etc.
  List<String> get suggestions => _suggestions;

  /// Updates the current [text] to the given `newText`, and removes existing selection and composing range held by the
  /// controller.
  ///
  /// Unlike [TextEditingController.text], [FTypeaheadController.text] sets the selection to the end of the new text
  /// rather than selecting the entire text.
  @override
  set text(String newText) {
    if (text != newText) {
      value = value.copyWith(
        text: newText,
        selection: .collapsed(offset: newText.length),
        composing: .empty,
      );
    }
  }

  @override
  set value(TextEditingValue newValue) {
    // notifyListeners will always be called if text changes.
    if (text != newValue.text) {
      // We have to call [findCompletion] before setting the value to ensure listeners will see the correct completion.
      // We have to pass in the new text since value is not updated yet.
      findCompletion(newValue.text);
    }
    super.value = newValue;
  }

  /// The current completion and corresponding replacement text, or null if no completion is available.
  ({String completion, String replacement})? get current => _current;

  @protected
  @nonVirtual
  set current(({String completion, String replacement})? value) => _current = value;

  @override
  @mustCallSuper
  void dispose() {
    try {
      super.dispose();
    } finally {
      _disposed = true;
    }
  }
}

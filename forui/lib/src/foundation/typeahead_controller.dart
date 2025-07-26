import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A [TextEditingController] with typeahead support.
///
/// A typeahead controller manages suggestions and provides inline completions as the user types. When the current text
/// matches the beginning of a suggestion, the remaining text is shown as a completion that can be accepted.
class FTypeaheadController extends TextEditingController {
  final (TextStyle, TextStyle, TextStyle) Function(BuildContext) _textStyles;
  List<String> _suggestions;
  ({String completion, String replacement})? _current;

  /// Creates a [FTypeaheadController] with an optional initial text and completion.
  FTypeaheadController({
    required (TextStyle textStyle, TextStyle composingStyle, TextStyle completionStyle) Function(BuildContext)
    textStyles,
    List<String> suggestions = const [],
    super.text,
  }) : _textStyles = textStyles,
       _suggestions = suggestions {
    findCompletion();
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, required bool withComposing, TextStyle? style}) {
    assert(!value.composing.isValid || !withComposing || value.isComposingRangeValid);
    // If the composing range is out of range for the current text, ignore it to
    // preserve the tree integrity, otherwise in release mode a RangeError will
    // be thrown and this EditableText will be built with a broken subtree.
    final bool composingRegionOutOfRange = !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      return TextSpan(style: style, text: text);
    }

    final (textStyle, composingStyle, completionStyle) = _textStyles(context);
    return TextSpan(
      children: [
        TextSpan(text: value.composing.textBefore(value.text), style: style),
        TextSpan(text: value.composing.textInside(value.text), style: composingStyle),
        TextSpan(text: value.composing.textAfter(value.text), style: style),
        if (current case (:final completion, replacement: final _)) TextSpan(text: completion, style: completionStyle),
      ],
    );
  }

  /// Completes the current typeahead suggestion by replacing the text with the replacement.
  void complete() {
    if (current case (completion: final _, :final replacement)) {
      current = null;
      super.value = TextEditingValue(
        // We call super.value to avoid
        text: replacement,
        selection: TextSelection.collapsed(offset: replacement.length),
      );
      notifyListeners();
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
  void findCompletion() {
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

  @override
  set value(TextEditingValue newValue) {
    // notifyListeners will always be called if text changes.
    if (text != newValue.text) {
      findCompletion();
    }
    super.value = newValue;
  }

  /// The suggestions from which a completion is derived.
  ///
  /// For example, if the user types "appl", the suggestions might include "apple", "application", etc.
  List<String> get suggestions => _suggestions;

  set suggestions(List<String> value) {
    if (!listEquals(_suggestions, value)) {
      _suggestions = value;
      findCompletion();
      notifyListeners();
    }
  }

  /// The current completion and corresponding replacement text, or null if no completion is available.
  ({String completion, String replacement})? get current => _current;

  @protected
  @nonVirtual
  set current(({String completion, String replacement})? value) {
    _current = value;
  }
}

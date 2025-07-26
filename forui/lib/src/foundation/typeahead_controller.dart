import 'package:flutter/widgets.dart';

/// A [TextEditingController] with typeahead support.
class FTypeaheadController extends TextEditingController {
  final (TextStyle, TextStyle) Function(BuildContext) _styles;

  /// The entire text is stored to act as a cache, making it easier to work with async completions.
  String? _completion;

  /// Creates a [FTypeaheadController] with an optional initial text and completion.
  FTypeaheadController({
    required (TextStyle textStyle, TextStyle completionStyle) Function(BuildContext) styles,
    String completion = '',
    super.text,
  }) : _styles = styles,
       _completion = completion;

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, bool? withComposing}) {
    final (textStyle, completionStyle) = _styles(context);
    return TextSpan(
      children: [
        TextSpan(text: text, style: textStyle),
        if (_completion case final completion?) TextSpan(text: completion, style: completionStyle),
      ],
    );
  }

  /// Accepts the current suggestion and appends it to the text.
  void accept() {
    if (_completion case final completion?) {
      final full = text + completion;
      _completion = null;
      value = TextEditingValue(
        text: full,
        selection: TextSelection.collapsed(offset: full.length),
      );
    }
  }

  /// The completion.
  ///
  /// For example, if the user types "appl", the completion might be "e" to suggest "apple".
  String? get completion => _completion;

  set completion(String? value) {
    if (value != _completion) {
      _completion = value;
      notifyListeners();
    }
  }
}

import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/input/parser.dart';

@internal
abstract class InputController extends TextEditingController {
  final FTextFieldStyle style;
  final WidgetStatesController statesController;
  final Parser parser;
  final String placeholder;
  bool mutating = false;

  InputController(this.style, this.parser, this.placeholder, TextEditingValue? value)
    : statesController = WidgetStatesController(),
      super.fromValue(value);

  void traverse({required bool forward});

  void adjust(int amount);

  @override
  set value(TextEditingValue value) {
    if (mutating) {
      return;
    }

    final TextSelection(:baseOffset, :extentOffset) = value.selection;
    // Selected everything without doing anything else.
    if (baseOffset == 0 && extentOffset == value.text.length && text == value.text) {
      super.value = value;
      return;
    }

    try {
      mutating = true;
      final current = this.value;

      super.value = switch (value) {
        _ when value.text.isEmpty => TextEditingValue(
          text: placeholder,
          selection: TextSelection(baseOffset: 0, extentOffset: placeholder.length),
        ),
        _ when text != value.text => _update(value),
        _ => selector.resolve(value) ?? this.value,
      };

      if (current.text != this.value.text) {
        onValueChanged(this.value.text);
      }
    } finally {
      mutating = false;
    }
  }

  TextEditingValue _update(TextEditingValue value) {
    final current = selector.split(value.text);
    if (current.length != parser.pattern.length) {
      return this.value;
    }

    final (parts, selected) = parser.update(selector.split(text), current);
    switch (selected) {
      case None():
        return this.value;

      case Single(:final index):
        return selector.select(parts, index);

      case Many():
        final text = selector.join(parts);
        return TextEditingValue(text: text, selection: TextSelection(baseOffset: 0, extentOffset: text.length));
    }
  }

  Selector get selector;

  @protected
  void onValueChanged(String newValue) {}

  @protected
  set rawValue(TextEditingValue value) => super.value = value; // ignore: avoid_setters_without_getters

  @override
  TextSpan buildTextSpan({required BuildContext context, required bool withComposing, TextStyle? style}) {
    if (text == placeholder) {
      final states = statesController.value;
      // TODO: explore custom widget states.
      style =
          states.contains(WidgetState.focused)
              ? this.style.contentTextStyle.resolve(states)
              : this.style.hintTextStyle.maybeResolve({}) ?? style;
    }

    return super.buildTextSpan(context: context, withComposing: withComposing, style: style);
  }
}

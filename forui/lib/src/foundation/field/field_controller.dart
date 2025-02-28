import 'package:flutter/widgets.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/field/parser.dart';

@internal
abstract class FieldController extends TextEditingController {
  final FTextFieldStyle style;
  final WidgetStatesController states;
  final Parser parser;
  final String placeholder;
  bool mutating = false;

  FieldController(this.style, this.parser, this.placeholder, TextEditingValue? value)
    : states = WidgetStatesController(),
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
      style = switch (states.value) {
        // Disabled styles
        final values when values.containsAll(const {WidgetState.disabled, WidgetState.focused}) =>
          this.style.disabledStyle.contentTextStyle,
        final values when values.contains(WidgetState.disabled) => this.style.disabledStyle.contentTextStyle,
        // Error styles
        final values when values.containsAll(const {WidgetState.error, WidgetState.focused}) =>
          this.style.errorStyle.contentTextStyle,
        final values when values.contains(WidgetState.error) => this.style.errorStyle.contentTextStyle,
        // Enabled styles
        final values when values.containsAll({WidgetState.focused}) => this.style.enabledStyle.contentTextStyle,
        _ => this.style.enabledStyle.hintTextStyle,
      };
    }

    return super.buildTextSpan(context: context, withComposing: withComposing, style: style);
  }
}

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/foundation/field/parser.dart';
import 'package:meta/meta.dart';

@internal
abstract class FieldController extends TextEditingController {
  final FTextFieldStyle style;
  final WidgetStatesController states;
  final Parser parser;
  final String placeholder;
  bool mutating = false;

  FieldController(this.style, this.parser, this.placeholder, TextEditingValue? value)
    : states = WidgetStatesController(), super.fromValue(value);

  // ignore: avoid_setters_without_getters
  set rawValue(TextEditingValue value) => super.value = value;

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
      final current = super.value;
      super.value = switch (value) {
        _ when value.text.isEmpty => TextEditingValue(
          text: placeholder,
          selection: TextSelection(baseOffset: 0, extentOffset: placeholder.length),
        ),
        _ when text != value.text => _updateParts(value),
        _ => selectParts(value),
      };

      if (current.text != super.value.text) {
        onValueChanged(super.value.text);
      }
    } finally {
      mutating = false;
    }
  }

  TextEditingValue _updateParts(TextEditingValue value) {
    final current = split(value.text);
    if (current.length != parser.parts.length) {
      return super.value;
    }

    final (parts, selected) = parser.update(split(text), current);
    switch (selected) {
      case None():
        return super.value;

      case Single(:final index):
        return updatePart(parts, index);

      case Many():
        final text = join(parts);
        return TextEditingValue(text: text, selection: TextSelection(baseOffset: 0, extentOffset: text.length));
    }
  }

  @protected
  void onValueChanged(String newValue) {}

  @protected
  TextEditingValue updatePart(List<String> parts, int index);

  @protected
  TextEditingValue selectParts(TextEditingValue value);

  @protected
  List<String> split(String raw);

  @protected
  String join(List<String> parts);

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

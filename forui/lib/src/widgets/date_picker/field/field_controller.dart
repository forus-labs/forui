import 'package:flutter/widgets.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_picker/field/parser.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

///
@internal
typedef Select = TextEditingValue Function(TextEditingValue, int first, int last, int end, int separator);

TextEditingValue _first(TextEditingValue value, int first, int _, int __, int ___) =>
    value.copyWith(selection: TextSelection(baseOffset: 0, extentOffset: first));

TextEditingValue _middle(TextEditingValue value, int first, int last, int _, int separator) =>
    value.copyWith(selection: TextSelection(baseOffset: first + separator, extentOffset: last));

TextEditingValue _last(TextEditingValue value, int _, int last, int end, int separator) =>
    value.copyWith(selection: TextSelection(baseOffset: last + separator, extentOffset: end));

@internal
class FieldController extends TextEditingController {
  final FCalendarController<DateTime?> controller;
  final FDatePickerStyle style;
  final WidgetStatesController states;
  final String placeholder;
  final FLocalizations _localizations;
  final Parser _parser;
  final DateFormat _format;
  final RegExp _suffix;
  bool _mutating = false;

  factory FieldController(
    FCalendarController<DateTime?> controller,
    FDatePickerStyle style,
    FLocalizations localizations,
    int initialYear,
  ) {
    final format = DateFormat.yMd(localizations.localeName);
    final placeholder =
        format.pattern!.replaceAll(RegExp('d{1,2}'), 'DD').replaceAll(RegExp('M{1,2}'), 'MM').replaceAll('y', 'YYYY');
    final text = controller.value == null ? placeholder : localizations.shortDate(controller.value!);
    return FieldController.fromValue(
      controller,
      style,
      localizations,
      placeholder,
      initialYear,
      TextEditingValue(text: text),
    );
  }

  @visibleForTesting
  FieldController.fromValue(
    this.controller,
    this.style,
    this._localizations,
    this.placeholder,
    int initialYear,
    TextEditingValue? value,
  )   : states = WidgetStatesController(),
        _parser = Parser(_localizations.localeName, initialYear),
        _format = DateFormat.yMd(_localizations.localeName),
        _suffix = RegExp(RegExp.escape(_localizations.shortDateSuffix) + r'$'),
        super.fromValue(value) {
    controller.addListener(update);
  }

  void traverse({required bool forward}) {
    _mutating = true;
    super.value = forward
        ? selectParts(value, onFirst: _middle, onMiddle: _last)
        : selectParts(value, onMiddle: _first, onLast: _middle);
    _mutating = false;
  }

  void adjust(int adjustment) {
    _mutating = true;
    final parts = value.text.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);
    super.value = selectParts(
      value,
      onFirst: (value, _, __, ___, ____) => _update(_parser.adjust(parts, 0, adjustment), 0),
      onMiddle: (value, _, __, ___, ____) => _update(_parser.adjust(parts, 1, adjustment), 1),
      onLast: (value, _, __, ___, ____) => _update(_parser.adjust(parts, 2, adjustment), 2),
    );
    controller.value = _format.tryParseStrict(super.value.text, true);
    _mutating = false;
  }

  @override
  set value(TextEditingValue value) {
    if (_mutating) {
      return;
    }

    final TextSelection(:baseOffset, :extentOffset) = value.selection;
    // Selected everything without doing anything else.
    if (baseOffset == 0 && extentOffset == value.text.length && text == value.text) {
      super.value = value;
      return;
    }

    _mutating = true;

    final current = super.value;
    super.value = switch (value) {
      _ when value.text.isEmpty =>
        TextEditingValue(text: placeholder, selection: TextSelection(baseOffset: 0, extentOffset: placeholder.length)),
      _ when text != value.text => updateParts(value),
      _ => selectParts(value),
    };

    if (current.text != super.value.text) {
      controller.value = _format.tryParseStrict(super.value.text, true);
    }

    _mutating = false;
  }

  @visibleForTesting
  TextEditingValue updateParts(TextEditingValue value) {
    final old = text.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);
    final current = value.text.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);

    if (current.length != 3) {
      return super.value;
    }

    final (parts, selected) = _parser.parse(old, current);
    switch (selected) {
      case None():
        return super.value;

      case Single(:final index):
        return _update(parts, index);

      case Many():
        final text = parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix;
        return TextEditingValue(text: text, selection: TextSelection(baseOffset: 0, extentOffset: text.length));
    }
  }

  @visibleForTesting
  TextEditingValue selectParts(
    TextEditingValue value, {
    Select onFirst = _first,
    Select onMiddle = _middle,
    Select onLast = _last,
  }) {
    // precondition: value's text is valid.
    // There's generally 2 cases:
    // * User selects part of the text -> select the whole enclosing date part.
    // * User selects a seperator -> revert to the previous selection.
    final separator = _localizations.shortDateSeparator.length;

    final first = value.text.indexOf(_localizations.shortDateSeparator);
    final last = value.text.indexOf(_localizations.shortDateSeparator, first + separator);
    final end = value.text.length - _localizations.shortDateSuffix.length;
    final offset = value.selection.extentOffset;

    return switch (offset) {
      _ when 0 <= offset && offset <= first => onFirst(value, first, last, end, separator),
      _ when first + separator <= offset && offset <= last => onMiddle(value, first, last, end, separator),
      _ when last + separator <= offset && offset <= end => onLast(value, first, last, end, separator),
      _ => super.value,
    };
  }

  TextEditingValue _update(List<String> parts, int index) {
    final text = parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix;

    var start = 0;
    var end = parts[0].length;
    for (var i = 1; i <= index; i++) {
      start = end + _localizations.shortDateSeparator.length;
      end = start + parts[i].length;
    }

    return TextEditingValue(text: text, selection: TextSelection(baseOffset: start, extentOffset: end));
  }

  @visibleForTesting
  void update() {
    if (!_mutating) {
      super.value = TextEditingValue(
        text: switch (controller.value) {
          null => placeholder,
          final value => _localizations.shortDate(value),
        },
      );
    }
  }

  @override
  TextSpan buildTextSpan({required BuildContext context, required bool withComposing, TextStyle? style}) {
    if (text == placeholder) {
      final textFieldStyle = this.style.textFieldStyle;
      style = switch (states.value) {
        // Disabled styles
        final values when values.containsAll(const {WidgetState.disabled, WidgetState.focused}) =>
          textFieldStyle.disabledStyle.contentTextStyle,
        final values when values.contains(WidgetState.disabled) => textFieldStyle.disabledStyle.contentTextStyle,
        // Error styles
        final values when values.containsAll(const {WidgetState.error, WidgetState.focused}) =>
          textFieldStyle.errorStyle.contentTextStyle,
        final values when values.contains(WidgetState.error) => textFieldStyle.errorStyle.contentTextStyle,
        // Enabled styles
        final values when values.containsAll({WidgetState.focused}) => textFieldStyle.enabledStyle.contentTextStyle,
        _ => textFieldStyle.enabledStyle.hintTextStyle,
      };
    }

    return super.buildTextSpan(context: context, withComposing: withComposing, style: style);
  }
}

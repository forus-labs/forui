import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_picker/field/parser.dart';
import 'package:meta/meta.dart';

///
@internal
typedef Select = TextEditingValue Function(TextEditingValue, int first, int last, int end, int separator);

TextEditingValue _first(TextEditingValue value, int first, int last, int end, int separator) =>
    value.copyWith(selection: TextSelection(baseOffset: 0, extentOffset: first));

TextEditingValue _middle(TextEditingValue value, int first, int last, int end, int separator) =>
    value.copyWith(selection: TextSelection(baseOffset: first + separator, extentOffset: last));

TextEditingValue _last(TextEditingValue value, int first, int last, int end, int separator) =>
    value.copyWith(selection: TextSelection(baseOffset: last + separator, extentOffset: end));

@internal
class FieldController {
  final TextEditingController controller;
  final FLocalizations _localizations;
  final Parser _parser;
  final RegExp _suffix;
  TextEditingValue _old;
  bool _mutating = false;

  FieldController(this.controller, this._localizations)
      : _parser = Parser(_localizations.localeName),
        _suffix = RegExp(RegExp.escape(_localizations.shortDateSuffix) + r'$'),
        _old = controller.value {
    controller.addListener(update);
  }

  /// Modifies the controller's selection and text whenever it receives a new value.
  void update() {
    if (_mutating) {
      return;
    }

    final value = controller.value;
    final TextSelection(:baseOffset, :extentOffset) = value.selection;
    // Selected everything without doing anything else.
    if (baseOffset == 0 && extentOffset == value.text.length && _old.text == value.text) {
      return;
    }

    _mutating = true;
    _set(
      switch (value) {
        _ when value.text.isEmpty => _old,
        _ when _old.text != value.text => updateParts(value),
        _ => selectParts(value),
      },
    );
    _mutating = false;
  }

  void traverse({required bool forward}) {
    final value = controller.value;
    _mutating = true;
    _set(
      forward
          ? selectParts(value, onFirst: _middle, onMiddle: _last)
          : selectParts(value, onMiddle: _first, onLast: _middle),
    );
    _mutating = false;
  }

  void adjust(int adjustment) {
    _mutating = true;
    final value = controller.value;
    final parts = value.text.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);
    _set(selectParts(
      value,
      onFirst: (value, _, __, ___, ____) => _update(_parser.adjust(parts, 0, adjustment), 0),
      onMiddle: (value, _, __, ___, ____) => _update(_parser.adjust(parts, 1, adjustment), 1),
      onLast: (value, _, __, ___, ____) => _update(_parser.adjust(parts, 2, adjustment), 2),
    ));
    _mutating = false;
  }

  @visibleForTesting
  TextEditingValue updateParts(TextEditingValue value) {
    final old = _old.text.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);
    final current = value.text.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);

    if (current.length != 3) {
      return _old;
    }

    final (parts, selected) = _parser.parse(old, current);
    switch (selected) {
      case None():
        return _old;

      case Single(:final index):
        return _update(parts, index);

      case Many():
        final text = parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix;
        return TextEditingValue(text: text, selection: TextSelection(baseOffset: 0, extentOffset: text.length));
    }
  }

  @visibleForTesting
  TextEditingValue selectParts(TextEditingValue value,
      {Select onFirst = _first, Select onMiddle = _middle, Select onLast = _last}) {
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
      _ => _old,
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

  void _set(TextEditingValue value) => _old = controller.value = value;
}

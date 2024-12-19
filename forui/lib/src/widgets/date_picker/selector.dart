import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_picker/parser.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class Selector {
  final TextEditingController controller;
  final FLocalizations _localizations;
  final Parser _parser;
  TextEditingValue _old;
  bool _mutating = false;

  Selector(this.controller, this._localizations)
      : _parser = Parser(_localizations.localeName),
        _old = controller.value {
    controller.addListener(_update);
  }

  void _update() {
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

    if (_old.text != value.text) {
      final old = _old.text.split(_localizations.shortDateSeparator);
      final current = value.text.split(_localizations.shortDateSeparator);

      final (parts, selected) = _parser.parse(old, current);
      switch (selected) {
        case None():
          _set(_old);

        case Single(:final index):
          final text = parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix;

          var start = 0;
          var end = parts[0].length;
          for (var i = 1; i <= index; i++) {
            start = end + _localizations.shortDateSeparator.length;
            end = start + parts[i].length;
          }

          _set(TextEditingValue(text: text, selection: TextSelection(baseOffset: start, extentOffset: end)));

        case Many():
          final text = parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix;
          _set(TextEditingValue(text: text, selection: TextSelection(baseOffset: 0, extentOffset: text.length)));
      };

    } else {
      _set(_selectPart(value));
    }

    _mutating = false;
  }

  TextEditingValue _selectPart(TextEditingValue value) {
    // There's generally 2 cases:
    // * User selects part of the text -> select the whole enclosing date part.
    // * User selects a seperator -> revert to the previous selection.
    final separator = _localizations.shortDateSeparator.length;

    var start = 0;
    for (final part in value.text.split(_localizations.shortDateSeparator)) {
      // It's possible that the RTL marker, which is part of the separator, is part of the selection.
      var end = start + part.length;
      if (_localizations.shortDateSeparator.contains('\u200F') && end < value.text.length) {
        end += 1;
      }

      if (start <= value.selection.extentOffset && value.selection.extentOffset <= end) {
        return value.copyWith(selection: TextSelection(baseOffset: start, extentOffset: end));
      }

      start = start + part.length + separator;
    }

    return _old;
  }

  void _set(TextEditingValue value) => _old = controller.value = value;
}

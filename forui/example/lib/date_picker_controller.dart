import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class DatePickerController {
  final TextEditingController controller;
  final FLocalizations localizations;
  TextEditingValue _value;
  bool _mutating = false;

  DatePickerController(this.controller, this.localizations) : _value = controller.value {
    controller.addListener(() {
      if (_mutating) {
        return;
      }

      _mutating = true;
      if (_value.text != controller.value.text) {
        return;
      }

      final proposed = _select(controller.value);
      _value = controller.value;
      controller.value = proposed;

      _mutating = false;
    });
  }

  

  TextEditingValue _select(TextEditingValue value) {
    // There's generally 3 cases:
    // * User selects everything -> keep the selection.
    // * User selects part of the text -> select the whole enclosing date part.
    // * User selects a seperator -> revert to the previous selection.
    if (value.selection.baseOffset == 0 && value.selection.extentOffset == value.text.length) {
      return value;
    }

    final separator = localizations.shortDateSeparator.length;

    var start = 0;
    for (final part in value.text.split(localizations.shortDateSeparator)) {
      // It's possible that the RTL marker, which is part of the separator, is part of the selection.
      var end = start + part.length;
      if (localizations.shortDateSeparator.contains('\u200F') && end < value.text.length) {
        end += 1;
      }

      if (start <= value.selection.extentOffset && value.selection.extentOffset <= end) {
        return value.copyWith(selection: TextSelection(baseOffset: start, extentOffset: end));
      }

      start = start + part.length + separator;
    }

    return _value;
  }
}

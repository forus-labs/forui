import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/field/field_controller.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/date_field/field/date_parser.dart';

///
@internal
typedef Select = TextEditingValue Function(TextEditingValue, int first, int last, int end, int separator);

TextEditingValue _first(TextEditingValue value, int first, int _, int _, int _) =>
    value.copyWith(selection: TextSelection(baseOffset: 0, extentOffset: first));

TextEditingValue _middle(TextEditingValue value, int first, int last, int _, int separator) =>
    value.copyWith(selection: TextSelection(baseOffset: first + separator, extentOffset: last));

TextEditingValue _last(TextEditingValue value, int _, int last, int end, int separator) =>
    value.copyWith(selection: TextSelection(baseOffset: last + separator, extentOffset: end));

@internal
class DateFieldController extends FieldController {
  final FCalendarController<DateTime?> controller;
  final FLocalizations _localizations;
  final DateFormat _format;
  final RegExp _suffix;

  factory DateFieldController(
    FCalendarController<DateTime?> controller,
    FLocalizations localizations,
    FTextFieldStyle style,
    int initialYear,
  ) {
    final format = DateFormat.yMd(localizations.localeName);
    final placeholder = format.pattern!
        .replaceAll(RegExp('d{1,2}'), 'DD')
        .replaceAll(RegExp('M{1,2}'), 'MM')
        .replaceAll('y', 'YYYY');
    final text = controller.value == null ? placeholder : localizations.shortDate(controller.value!);
    return DateFieldController.fromValue(
      controller,
      localizations,
      style,
      placeholder,
      initialYear,
      TextEditingValue(text: text),
    );
  }

  @visibleForTesting
  DateFieldController.fromValue(
    this.controller,
    this._localizations,
    FTextFieldStyle style,
    String placeholder,
    int initialYear,
    TextEditingValue? value,
  ) : _format = DateFormat.yMd(_localizations.localeName),
      _suffix = RegExp(RegExp.escape(_localizations.shortDateSuffix) + r'$'),
      super(style, DateParser(_localizations.localeName, initialYear), placeholder, value) {
    controller.addListener(updateFromCalendar);
  }

  void traverse({required bool forward}) {
    try {
      mutating = true;
      super.rawValue =
          forward
              ? selectParts(value, onFirst: _middle, onMiddle: _last)
              : selectParts(value, onMiddle: _first, onLast: _middle);
    } finally {
      mutating = false;
    }
  }

  void adjust(int adjustment) {
    try {
      mutating = true;
      final parts = value.text.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);
      super.rawValue = selectParts(
        value,
        onFirst: (_, _, _, _, _) => updatePart(parser.adjust(parts, 0, adjustment), 0),
        onMiddle: (_, _, _, _, _) => updatePart(parser.adjust(parts, 1, adjustment), 1),
        onLast: (_, _, _, _, _) => updatePart(parser.adjust(parts, 2, adjustment), 2),
      );
      onValueChanged(super.value.text);
    } finally {
      mutating = false;
    }
  }

  @override
  void onValueChanged(String newValue) => controller.value = _format.tryParseStrict(newValue, true);

  @override
  @visibleForTesting
  TextEditingValue updatePart(List<String> parts, int index) {
    var start = 0;
    var end = parts[0].length;
    for (var i = 1; i <= index; i++) {
      start = end + _localizations.shortDateSeparator.length;
      end = start + parts[i].length;
    }

    return TextEditingValue(text: join(parts), selection: TextSelection(baseOffset: start, extentOffset: end));
  }

  @override
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
    // * User selects a separator -> revert to the previous selection.
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

  @override
  @protected
  List<String> split(String raw) => raw.replaceAll(_suffix, '').split(_localizations.shortDateSeparator);

  @override
  @protected
  String join(List<String> parts) => parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix;

  @visibleForTesting
  void updateFromCalendar() {
    if (!mutating) {
      super.rawValue = TextEditingValue(
        text: switch (controller.value) {
          null => placeholder,
          final value => _localizations.shortDate(value),
        },
      );
    }
  }
}

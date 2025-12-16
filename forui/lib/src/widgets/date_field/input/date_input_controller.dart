import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/input/input_controller.dart';
import 'package:forui/src/foundation/input/parser.dart';
import 'package:forui/src/widgets/date_field/input/date_parser.dart';

@internal
typedef Select<T> = T Function(TextEditingValue value, int first, int last, int end, int separator);

TextEditingValue _first(TextEditingValue value, int first, int _, int _, int _) =>
    value.copyWith(selection: .new(baseOffset: 0, extentOffset: first));

TextEditingValue _middle(TextEditingValue value, int first, int last, int _, int separator) => value.copyWith(
  selection: .new(baseOffset: first + separator, extentOffset: last),
);

TextEditingValue _last(TextEditingValue value, int _, int last, int end, int separator) => value.copyWith(
  selection: .new(baseOffset: last + separator, extentOffset: end),
);

@internal
class DateInputController extends InputController {
  @override
  final DateSelector selector;
  final FCalendarController<DateTime?> controller;
  final DateFormat _format;

  factory DateInputController(
    FCalendarController<DateTime?> controller,
    FLocalizations localizations,
    FTextFieldStyle style,
    int initialYear,
  ) {
    final placeholder = DateFormat.yMd(localizations.localeName).pattern!
        .replaceAll(RegExp('d{1,2}'), 'DD')
        .replaceAll(RegExp('M{1,2}'), 'MM')
        .replaceAll('y', 'YYYY')
        .replaceAll("'", '');
    final text = controller.value == null ? placeholder : localizations.shortDate(controller.value!);
    return .test(controller, localizations, style, placeholder, initialYear, TextEditingValue(text: text));
  }

  @visibleForTesting
  DateInputController.test(
    this.controller,
    FLocalizations localizations,
    FTextFieldStyle style,
    String placeholder,
    int initialYear,
    TextEditingValue? value,
  ) : selector = DateSelector(localizations),
      _format = .yMd(localizations.localeName),
      super(value, style, DateParser(localizations.localeName, initialYear), placeholder) {
    controller.addListener(updateFromCalendar);
  }

  @override
  void traverse({required bool forward}) {
    try {
      mutating = true;
      rawValue =
          (forward
              ? selector.navigate(value, onFirst: _middle, onMiddle: _last)
              : selector.navigate(value, onMiddle: _first, onLast: _middle)) ??
          value;
    } finally {
      mutating = false;
    }
  }

  @override
  void adjust(int amount) {
    try {
      mutating = true;
      final parts = selector.split(text);
      rawValue =
          selector.navigate(
            value,
            onFirst: (_, _, _, _, _) => selector.select(parser.adjust(parts, 0, amount), 0),
            onMiddle: (_, _, _, _, _) => selector.select(parser.adjust(parts, 1, amount), 1),
            onLast: (_, _, _, _, _) => selector.select(parser.adjust(parts, 2, amount), 2),
          ) ??
          value;
    } finally {
      mutating = false;
    }
  }

  // Used for input-driven changes only.
  @override
  set rawValue(TextEditingValue newValue) {
    // Allow selection & arrow key traversal
    if (super.rawValue.text == newValue.text) {
      super.rawValue = newValue;
      return;
    }

    final proposed = _format.tryParseStrict(newValue.text, true);
    if (proposed == controller.value) {
      // Prevent toggling controller.value.
      super.rawValue = newValue;
      return;
    }

    controller.value = proposed;
    if (controller.value == proposed) {
      super.rawValue = newValue;
    }
  }

  // Used for calendar/external-driven changes only.
  @visibleForTesting
  void updateFromCalendar() {
    if (!mutating) {
      super.rawValue = selector.map(
        rawValue,
        TextEditingValue(
          text: switch (controller.value) {
            null => placeholder,
            final value => selector.localizations.shortDate(value),
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(updateFromCalendar);
    super.dispose();
  }
}

@internal
class DateSelector extends Selector {
  DateSelector(FLocalizations localizations)
    : super(localizations, RegExp(RegExp.escape(localizations.shortDateSuffix) + r'$'));

  @override
  TextEditingValue? navigate(
    TextEditingValue value, {
    Select<TextEditingValue> onFirst = _first,
    Select<TextEditingValue> onMiddle = _middle,
    Select<TextEditingValue> onLast = _last,
  }) => _map(value, onFirst: onFirst, onMiddle: onMiddle, onLast: onLast);

  @override
  TextEditingValue map(TextEditingValue oldValue, TextEditingValue newValue) {
    final index = _map(
      oldValue,
      onFirst: (_, _, _, _, _) => 0,
      onMiddle: (_, _, _, _, _) => 1,
      onLast: (_, _, _, _, _) => 2,
    );

    return index == null ? newValue : select(split(newValue.text), index);
  }

  T? _map<T>(
    TextEditingValue value, {
    required Select<T> onFirst,
    required Select<T> onMiddle,
    required Select<T> onLast,
  }) {
    // precondition: value's text is valid.
    // There's generally 2 cases:
    // * User selects part of the text -> select the whole enclosing date part.
    // * User selects a separator -> revert to the previous selection.
    final separator = localizations.shortDateSeparator.length;

    final first = value.text.indexOf(localizations.shortDateSeparator);
    final last = value.text.indexOf(localizations.shortDateSeparator, first + separator);
    final end = value.text.length - localizations.shortDateSuffix.length;
    final offset = value.selection.extentOffset;

    return switch (offset) {
      _ when 0 <= offset && offset <= first => onFirst(value, first, last, end, separator),
      _ when first + separator <= offset && offset <= last => onMiddle(value, first, last, end, separator),
      _ when last + separator <= offset && offset <= end => onLast(value, first, last, end, separator),
      _ => null,
    };
  }

  @override
  TextEditingValue select(List<String> parts, int index) {
    var start = 0;
    var end = parts[0].length;
    for (var i = 1; i <= index; i++) {
      start = end + localizations.shortDateSeparator.length;
      end = start + parts[i].length;
    }

    return TextEditingValue(
      text: join(parts),
      selection: .new(baseOffset: start, extentOffset: end),
    );
  }

  @override
  List<String> split(String raw) => raw.replaceAll(suffix, '').split(localizations.shortDateSeparator);

  @override
  String join(List<String> parts) => parts.join(localizations.shortDateSeparator) + localizations.shortDateSuffix;
}

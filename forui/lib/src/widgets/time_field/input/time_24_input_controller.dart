import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/input/parser.dart';
import 'package:forui/src/widgets/time_field/input/time_input_controller.dart';

///
@internal
typedef Select24 = TextEditingValue Function(TextEditingValue, int only, int end, int separator);

TextEditingValue _first(TextEditingValue value, int only, int _, int _) =>
    value.copyWith(selection: TextSelection(baseOffset: 0, extentOffset: only));

TextEditingValue _last(TextEditingValue value, int only, int end, int separator) => value.copyWith(
  selection: TextSelection(baseOffset: only + separator, extentOffset: end),
);

@internal
class Time24InputController extends TimeInputController {
  @override
  final Time24Selector selector;

  Time24InputController(
    FLocalizations localizations,
    super.controller,
    super.format,
    super.style,
    super.parser,
    super.placeholder,
    super.value,
  ) : selector = Time24Selector(localizations),
      super.fromValue();

  @override
  void traverse({required bool forward}) {
    try {
      mutating = true;
      rawValue = (forward ? selector.resolve(value, onFirst: _last) : selector.resolve(value, onLast: _first)) ?? value;
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
          selector.resolve(
            value,
            onFirst: (_, _, _, _) => selector.select(parser.adjust(parts, 0, amount), 0),
            onLast: (_, _, _, _) => selector.select(parser.adjust(parts, 1, amount), 1),
          ) ??
          value;
      onValueChanged(text);
    } finally {
      mutating = false;
    }
  }
}

@internal
class Time24Selector extends Selector {
  Time24Selector(FLocalizations localizations)
    : super(localizations, RegExp(RegExp.escape(localizations.timeFieldSuffix) + r'$'));

  @override
  TextEditingValue? resolve(TextEditingValue value, {Select24 onFirst = _first, Select24 onLast = _last}) {
    final separator = localizations.timeFieldTimeSeparator.length;
    final only = value.text.indexOf(localizations.timeFieldTimeSeparator);
    final end = value.text.length - localizations.timeFieldSuffix.length;
    final offset = value.selection.extentOffset;

    return switch (offset) {
      _ when 0 <= offset && offset <= only => onFirst(value, only, end, separator),
      _ when only + separator <= offset && offset <= end => onLast(value, only, end, separator),
      _ => null,
    };
  }

  @override
  TextEditingValue select(List<String> parts, int index) {
    assert(index <= 1, 'index must be 0 or 1');

    final int start;
    final int end;
    if (index == 0) {
      start = 0;
      end = parts[0].length;
    } else {
      start = parts[0].length + localizations.timeFieldTimeSeparator.length;
      end = start + parts[index].length;
    }

    return TextEditingValue(
      text: join(parts),
      selection: TextSelection(baseOffset: start, extentOffset: end),
    );
  }

  @override
  List<String> split(String raw) => raw.replaceAll(suffix, '').split(localizations.timeFieldTimeSeparator);

  @override
  String join(List<String> parts) =>
      parts[0] + localizations.timeFieldTimeSeparator + parts[1] + localizations.timeFieldSuffix;
}

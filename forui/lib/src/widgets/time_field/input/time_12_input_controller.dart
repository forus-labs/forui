import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/foundation/input/parser.dart';
import 'package:forui/src/widgets/time_field/input/time_input_controller.dart';

///
@internal
typedef Select12 =
    TextEditingValue Function(
      TextEditingValue value,
      int first,
      int last,
      int end,
      int firstSeparator,
      int lastSeparator,
    );

TextEditingValue _onFirst(TextEditingValue value, int first, int _, int _, int _, int _) =>
    value.copyWith(selection: TextSelection(baseOffset: 0, extentOffset: first));

TextEditingValue _onMiddle(TextEditingValue value, int first, int last, int _, int firstSeparator, int _) =>
    value.copyWith(
      selection: TextSelection(baseOffset: first + firstSeparator, extentOffset: last),
    );

TextEditingValue _onLast(TextEditingValue value, int _, int last, int end, int _, int lastSeparator) => value.copyWith(
  selection: TextSelection(baseOffset: last + lastSeparator, extentOffset: end),
);

@internal
class Time12InputController extends TimeInputController {
  @override
  final Time12Selector selector;

  Time12InputController(
    FLocalizations localizations,
    super.controller,
    super.format,
    super.style,
    super.parser,
    super.placeholder,
    super.value,
  ) : selector = Time12Selector(localizations, format),
      super.fromValue();

  @override
  void traverse({required bool forward}) {
    try {
      mutating = true;
      rawValue =
          (forward
              ? selector.resolve(value, onFirst: _onMiddle, onMiddle: _onLast)
              : selector.resolve(value, onLast: _onMiddle, onMiddle: _onFirst)) ??
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
          selector.resolve(
            value,
            onFirst: (_, _, _, _, _, _) => selector.select(parser.adjust(parts, 0, amount), 0),
            onMiddle: (_, _, _, _, _, _) => selector.select(parser.adjust(parts, 1, amount), 1),
            onLast: (_, _, _, _, _, _) => selector.select(parser.adjust(parts, 2, amount), 2),
          ) ??
          value;
      onValueChanged(text);
    } finally {
      mutating = false;
    }
  }
}

@internal
class Time12Selector extends Selector {
  final String _first;
  final String _last;

  Time12Selector(FLocalizations localizations, DateFormat format)
    : _first = format.pattern!.startsWith('a')
          ? localizations.timeFieldPeriodSeparator
          : localizations.timeFieldTimeSeparator,
      _last = format.pattern!.startsWith('a')
          ? localizations.timeFieldTimeSeparator
          : localizations.timeFieldPeriodSeparator,
      super(localizations, RegExp(RegExp.escape(localizations.timeFieldSuffix) + r'$'));

  @override
  TextEditingValue? resolve(
    TextEditingValue value, {
    Select12 onFirst = _onFirst,
    Select12 onMiddle = _onMiddle,
    Select12 onLast = _onLast,
  }) {
    // precondition: value's text is valid.
    // There's generally 2 cases:
    // * User selects part of the text -> select the whole enclosing date part.
    // * User selects a separator -> revert to the previous selection.

    final f = _first.length;
    final first = switch (localizations.localeName) {
      // These locales do not have a separator between the period and time.
      'zh_HK' || 'zh_TW' => 2,
      _ => value.text.indexOf(_first),
    };

    final l = _last.length;
    final last = value.text.indexOf(_last, first + _first.length);

    final end = value.text.length - localizations.timeFieldSuffix.length;
    final offset = value.selection.extentOffset;

    return switch (offset) {
      _ when 0 <= offset && offset <= first => onFirst(value, first, last, end, f, l),
      _ when first + f <= offset && offset <= last => onMiddle(value, first, last, end, f, l),
      _ when last + l <= offset && offset <= end => onLast(value, first, last, end, f, l),
      _ => null,
    };
  }

  @override
  TextEditingValue select(List<String> parts, int index) {
    assert(index <= 2, 'index must be 0, 1 or 2');

    final int start;
    final int end;
    switch (index) {
      case 0:
        start = 0;
        end = parts[0].length;

      case 1:
        start = parts[0].length + _first.length;
        end = start + parts[1].length;

      default:
        start = parts[0].length + _first.length + parts[1].length + _last.length;
        end = start + parts[2].length;
    }

    return TextEditingValue(
      text: join(parts),
      selection: TextSelection(baseOffset: start, extentOffset: end),
    );
  }

  @override
  String join(List<String> parts) => parts[0] + _first + parts[1] + _last + parts[2] + localizations.timeFieldSuffix;

  @override
  List<String> split(String raw) {
    final truncated = raw.replaceAll(suffix, '');

    // These locales do not have a separator between the period and time.
    if (localizations.localeName == 'zh_HK' || localizations.localeName == 'zh_TW') {
      return [truncated.substring(0, 2), ...truncated.substring(2).split(localizations.timeFieldTimeSeparator)];
    }

    final parts = truncated.split(_last);
    // We rejoin the last part as it might contain `_last`.
    return [...parts[0].split(_first), parts.skip(1).join(_last)];
  }
}

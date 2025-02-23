import 'package:flutter/widgets.dart';
import 'package:forui/src/foundation/field/parser.dart' hide Parser;

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/forui.dart';

final _separator = RegExp(r'[: \u202F]');

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
abstract class FieldController extends TextEditingController {
  static final DateTime _date = DateTime.utc(1970);

  // final FDateFieldStyle style;
  // final WidgetStatesController states;
  // final String placeholder;
  // final FLocalizations _localizations;
  // final Parser _parser;
  // final DateFormat _format;
  bool _mutating = false;

  // factory FieldController(FDateFieldStyle style, FLocalizations localizations, FTime? time, {bool? hour24}) {
  //   final jm = DateFormat.jm(localizations.localeName);
  //   final format = switch (hour24) {
  //     true => DateFormat.Hm(localizations.localeName),
  //     false => DateFormat(jm.pattern!.contains(RegExp('HH|hh')) ? 'hh:mm a' : 'h:mm a', localizations.localeName),
  //     null => jm,
  //   };
  //   final placeholder = format.pattern!
  //       .replaceAll(RegExp('(h|H){1,2}'), 'HH')
  //       .replaceAll(RegExp('m{1,2}'), 'MM')
  //       .replaceAll('a', '--');
  //
  //   final parser = Parser(localizations.localeName, format.pattern!, format.pattern!.contains('a') ? 12 : 24);
  //   final value = TextEditingValue(text: time == null ? placeholder : format.format(time.withDate(_date)));
  //
  //   return FieldController.fromValue(
  //     style,
  //     placeholder,
  //     localizations,
  //     parser,
  //     format,
  //     value,
  //   );
  // }

  // @visibleForTesting
  // FieldController.fromValue(
  //   this.style,
  //   this.placeholder,
  //   this._localizations,
  //   this._parser,
  //   this._format,
  //   TextEditingValue? value,
  // ) : states = WidgetStatesController(),
  //     super.fromValue(value);
  //
  // void traverse({required bool forward});

  // void traverse({required bool forward}) {
  //   try {
  //     _mutating = true;
  //     super.value =
  //         forward
  //             ? selectParts(value, onFirst: _middle, onMiddle: _last)
  //             : selectParts(value, onMiddle: _first, onLast: _middle);
  //   } finally {
  //     _mutating = false;
  //   }
  // }

  // void adjust(int adjustment) {
  //   try {
  //     _mutating = true;
  //     final parts = value.text.split(_localizations.shortDateSeparator);
  //     super.value = selectParts(
  //       value,
  //       onFirst: (_, _, _, _, _) => _update(_parser.adjust(parts, 0, adjustment), 0),
  //       onMiddle: (_, _, _, _, _) => _update(_parser.adjust(parts, 1, adjustment), 1),
  //       onLast: (_, _, _, _, _) => _update(_parser.adjust(parts, 2, adjustment), 2),
  //     );
  //   } finally {
  //     _mutating = false;
  //   }
  // }
  //
  // @override
  // set value(TextEditingValue value) {
  //   if (_mutating) {
  //     return;
  //   }
  //
  //   final TextSelection(:baseOffset, :extentOffset) = value.selection;
  //   // Selected everything without doing anything else.
  //   if (baseOffset == 0 && extentOffset == value.text.length && text == value.text) {
  //     super.value = value;
  //     return;
  //   }
  //
  //   try {
  //     _mutating = true;
  //     super.value = switch (value) {
  //       _ when value.text.isEmpty => TextEditingValue(
  //         text: placeholder,
  //         selection: TextSelection(baseOffset: 0, extentOffset: placeholder.length),
  //       ),
  //       _ when text != value.text => updateParts(value),
  //       _ => selectParts(value),
  //     };
  //   } finally {
  //     _mutating = false;
  //   }
  // }
  //
  // @visibleForTesting
  // TextEditingValue updateParts(TextEditingValue value) {
  //   final old = text.split(_localizations.shortDateSeparator);
  //   final current = value.text.split(_localizations.shortDateSeparator);
  //
  //   if (current.length != 3) {
  //     return super.value;
  //   }
  //
  //   final (parts, selected) = _parser.parse(old, current);
  //   switch (selected) {
  //     case None():
  //       return super.value;
  //
  //     case Single(:final index):
  //       return _update(parts, index);
  //
  //     case Many():
  //       final text = parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix;
  //       return TextEditingValue(text: text, selection: TextSelection(baseOffset: 0, extentOffset: text.length));
  //   }
  // }
  //
  // @visibleForTesting
  // TextEditingValue selectParts(
  //   TextEditingValue value, {
  //   Select onFirst = _first,
  //   Select onMiddle = _middle,
  //   Select onLast = _last,
  // }) {
  //   // precondition: value's text is valid.
  //   // There's generally 2 cases:
  //   // * User selects part of the text -> select the whole enclosing date part.
  //   // * User selects a separator -> revert to the previous selection.
  //   final separator = _localizations.shortDateSeparator.length;
  //
  //   final first = value.text.indexOf(_localizations.shortDateSeparator);
  //   final last = value.text.indexOf(_localizations.shortDateSeparator, first + separator);
  //   final end = value.text.length - _localizations.shortDateSuffix.length;
  //   final offset = value.selection.extentOffset;
  //
  //   return switch (offset) {
  //     _ when 0 <= offset && offset <= first => onFirst(value, first, last, end, separator),
  //     _ when first + separator <= offset && offset <= last => onMiddle(value, first, last, end, separator),
  //     _ when last + separator <= offset && offset <= end => onLast(value, first, last, end, separator),
  //     _ => super.value,
  //   };
  // }
  //
  // TextEditingValue _update(List<String> parts, int index) {
  //   var start = 0;
  //   var end = parts[0].length;
  //   for (var i = 1; i <= index; i++) {
  //     start = end + _localizations.shortDateSeparator.length;
  //     end = start + parts[i].length;
  //   }
  //
  //   return TextEditingValue(
  //     text: parts.join(_localizations.shortDateSeparator) + _localizations.shortDateSuffix,
  //     selection: TextSelection(baseOffset: start, extentOffset: end),
  //   );
  // }
  //
  // @override
  // TextSpan buildTextSpan({required BuildContext context, required bool withComposing, TextStyle? style}) {
  //   if (text == placeholder) {
  //     final textFieldStyle = this.style.textFieldStyle;
  //     style = switch (states.value) {
  //       // Disabled styles
  //       final values when values.containsAll(const {WidgetState.disabled, WidgetState.focused}) =>
  //         textFieldStyle.disabledStyle.contentTextStyle,
  //       final values when values.contains(WidgetState.disabled) => textFieldStyle.disabledStyle.contentTextStyle,
  //       // Error styles
  //       final values when values.containsAll(const {WidgetState.error, WidgetState.focused}) =>
  //         textFieldStyle.errorStyle.contentTextStyle,
  //       final values when values.contains(WidgetState.error) => textFieldStyle.errorStyle.contentTextStyle,
  //       // Enabled styles
  //       final values when values.containsAll({WidgetState.focused}) => textFieldStyle.enabledStyle.contentTextStyle,
  //       _ => textFieldStyle.enabledStyle.hintTextStyle,
  //     };
  //   }
  //
  //   return super.buildTextSpan(context: context, withComposing: withComposing, style: style);
  // }
}

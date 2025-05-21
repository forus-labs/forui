import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/foundation/input/parser.dart';

@internal
abstract class TimeParser extends Parser {
  static List<String> _split(String pattern) =>
      RegExp("(hh|'h'|h|HH|H|mm|a)").allMatches(pattern).map((e) => e.group(1)!).where((e) => e != "'h'").toList();

  final NumberFormat _hour;
  final NumberFormat _minute;
  final int _hourDigit;
  final int _hourEnd;

  factory TimeParser(DateFormat format) => format.pattern!.contains('a') ? Time12Parser(format) : Time24Parser(format);

  TimeParser._(DateFormat format, this._hour, this._hourDigit, this._hourEnd)
    : _minute = NumberFormat('00', format.locale),
      super(_split(format.pattern!));

  @visibleForTesting
  (String, bool) updateHour(String previous, String current) {
    assert(previous.length <= 2, 'old day must be at most 2 characters long');

    final full = previous == 'HH' ? current : '$previous$current';
    switch (_hour.tryParse(full)?.toInt()) {
      // Backspace.
      case _ when current.isEmpty:
        return ('HH', false);

      case final hour? when 1 <= hour && hour <= _hourEnd:
        return (_hour.format(hour), _hourDigit <= hour);

      // Replace rather than append.
      case _?:
        final hour = _hour.parse(current);
        if (1 <= hour && hour <= _hourEnd) {
          return (_hour.format(hour), _hourDigit <= hour);
        } else {
          return (previous, false);
        }

      default:
        return (previous, false);
    }
  }

  @visibleForTesting
  (String, bool) updateMinute(String previous, String current) {
    assert(previous.length <= 2, 'old minute must be at most 2 characters long');

    final full = previous == 'MM' ? current : '$previous$current';
    switch (_minute.tryParse(full)?.toInt()) {
      // Backspace.
      case _ when current.isEmpty:
        return ('MM', false);

      case final minute? when 0 <= minute && minute <= 59:
        return (_minute.format(minute), 6 <= minute);

      // Replace rather than append.
      case _?:
        final minute = _minute.parse(current);
        if (0 <= minute && minute <= 59) {
          return (_minute.format(minute), 6 <= minute);
        } else {
          return (previous, false);
        }

      default:
        return (previous, false);
    }
  }

  @visibleForTesting
  String adjustHour(String current, int amount);

  @visibleForTesting
  String adjustMinute(String current, int amount) {
    assert(current.length <= 2, 'Minute must be at most 2 characters long.');

    final minute = (_minute.tryParse(current)?.toInt() ?? (amount <= 0 ? 1 : 0)) + amount;
    return _minute.format(minute % 60);
  }
}

@internal
class Time12Parser extends TimeParser {
  static final _morning = DateTime(1970, 1, 1, 11);
  static final _afternoon = DateTime(1970, 1, 1, 13);

  final List<String> periods;
  final List<String> _matches;

  Time12Parser(DateFormat format)
    : periods = [DateFormat('a', format.locale).format(_morning), DateFormat('a', format.locale).format(_afternoon)],
      _matches = [
        DateFormat('a', format.locale).format(_morning).toLowerCase(),
        DateFormat('a', format.locale).format(_afternoon).toLowerCase(),
      ],
      super._(format, NumberFormat(format.pattern!.contains('hh') ? '00' : '#0', format.locale), 2, 12);

  @override
  @protected
  (String, bool) updatePart(String pattern, String previous, String current) => switch (pattern) {
    'hh' || 'h' || 'HH' || 'H' => updateHour(previous, current),
    'mm' => updateMinute(previous, current),
    'a' => updatePeriod(previous, current),
    _ => (previous, false),
  };

  @visibleForTesting
  (String, bool) updatePeriod(String previous, String current) {
    final full = (previous == '--' ? current : '$previous$current').replaceAll('-', '').toLowerCase();
    return switch (full) {
      // Backspace.
      _ when current.isEmpty => ('--', false),
      // Conflicting matches
      _ when _matches[0].startsWith(full) && _matches[1].startsWith(full) => (full.padRight(2, '-'), false),
      // Single matches
      _ when _matches[0].startsWith(full) => (periods[0], true),
      _ when _matches[1].startsWith(full) => (periods[1], true),
      // Replace rather than append
      _ when _matches[0].startsWith(current) && _matches[1].startsWith(current) => (current.padRight(2, '-'), false),
      _ when _matches[0].startsWith(current) => (periods[0], true),
      _ when _matches[1].startsWith(current) => (periods[1], true),
      _ => (previous, false),
    };
  }

  @override
  String adjustPart(String pattern, String current, int amount) => switch (pattern) {
    'hh' || 'h' || 'HH' || 'H' => adjustHour(current, amount),
    'mm' => adjustMinute(current, amount),
    'a' => adjustPeriod(current, amount),
    _ => current,
  };

  @override
  @visibleForTesting
  String adjustHour(String current, int amount) {
    assert(current.length <= 2, 'Hour must be at most 2 characters long');

    final hour = (_hour.tryParse(current)?.toInt() ?? (amount <= 0 ? 1 : 0)) + amount;
    return _hour.format(((hour - 1) % 12) + 1);
  }

  @visibleForTesting
  String adjustPeriod(String current, int amount) => switch (current) {
    '--' => periods[amount < 0 ? 1 : 0],
    _ when periods[0] == current => periods[1],
    _ => periods[0],
  };
}

@internal
class Time24Parser extends TimeParser {
  Time24Parser(DateFormat format)
    : super._(format, NumberFormat(format.pattern!.contains('HH') ? '00' : '#0', format.locale), 3, 23);

  @override
  @protected
  (String, bool) updatePart(String pattern, String previous, String current) => switch (pattern) {
    'hh' || 'h' || 'HH' || 'H' => updateHour(previous, current),
    'mm' => updateMinute(previous, current),
    _ => (previous, false),
  };

  @override
  String adjustPart(String pattern, String current, int amount) => switch (pattern) {
    'hh' || 'h' || 'HH' || 'H' => adjustHour(current, amount),
    'mm' => adjustMinute(current, amount),
    _ => current,
  };

  @override
  @visibleForTesting
  String adjustHour(String current, int amount) {
    assert(current.length <= 2, 'Hour must be at most 2 characters long');

    final hour = (_hour.tryParse(current)?.toInt() ?? (amount <= 0 ? 1 : 0)) + amount;
    return _hour.format(hour % 24);
  }
}

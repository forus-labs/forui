import 'dart:math';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@internal
class Parser {
  final List<String> periods;
  final NumberFormat _hour;
  final NumberFormat _minute;
  final List<String> _periodMatches;
  final int _hours;

  Parser(String locale, String pattern, int hours)
    : this._(RegExp('([A-z]+)').allMatches(pattern).map((e) => e.group(1)!).toList(), hours, locale);

  Parser._(List<String> parts, this._hours, String locale)
    : periods = [
        DateFormat('a', locale).format(DateTime(1970, 1, 1, 11)),
        DateFormat('a', locale).format(DateTime(1970, 1, 1, 13)),
      ],
      _hour = NumberFormat((parts.contains('hh') || parts.contains('HH')) ? '00' : '#0', locale),
      _minute = NumberFormat('00', locale),
      _periodMatches = [
        DateFormat('a', locale).format(DateTime(1970, 1, 1, 11)).toLowerCase(),
        DateFormat('a', locale).format(DateTime(1970, 1, 1, 13)).toLowerCase(),
      ];

  (List<String>, Changes) parse(List<String> old, List<String> current) {
    assert(old.length <= 3, 'old must have 2/3 parts');
    assert(current.length <= 3, 'current must have 2/3 parts');

    final partsLength = _hours == 12 ? 3 : 2;
    Changes changes = const None();
    for (int i = 0; i < partsLength; i++) {
      final oldPart = old[i];
      final currentPart = current[i];

      if (oldPart == currentPart) {
        continue;
      }

      final (parsed, next) = switch (i) {
        0 => parseHour(oldPart, currentPart),
        1 => parseMinute(oldPart, currentPart),
        2 => parsePeriod(oldPart, currentPart),
        _ => (oldPart, false),
      };

      current[i] = parsed;
      if (parsed != oldPart) {
        changes = changes.add(min(next ? i + 1 : i, partsLength - 1));
      }
    }

    return (current, changes);
  }

  (String, bool) parseHour(String old, String current) {
    assert(old.length <= 2, 'old day must be at most 2 characters long');

    final full = old == 'HH' ? current : '$old$current';
    final end = _hours == 12 ? _hours : 23;

    switch (_hour.tryParse(full)?.toInt()) {
      // Backspace.
      case _ when current.isEmpty:
        return ('HH', false);

      case final hour? when 1 <= hour && hour <= end:
        return (_hour.format(hour), (_hours == 12 ? 2 : 3) <= hour);

      // Replace rather than append.
      case _?:
        final hour = _hour.parse(current);
        if (1 <= hour && hour <= end) {
          return (_hour.format(hour), (_hours == 12 ? 2 : 3) <= hour);
        } else {
          return (old, false);
        }

      default:
        return (old, false);
    }
  }

  (String, bool) parseMinute(String old, String current) {
    assert(old.length <= 2, 'old minute must be at most 2 characters long');

    final full = old == 'MM' ? current : '$old$current';
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
          return (old, false);
        }

      default:
        return (old, false);
    }
  }

  (String, bool) parsePeriod(String old, String current) {
    final full = (old == '--' ? current : '$old$current').toLowerCase();
    return switch (full) {
      // Backspace.
      _ when current.isEmpty => ('--', false),
      // Conflicting matches
      _ when _periodMatches[0].startsWith(full) && _periodMatches[1].startsWith(full) => (full, false),
      //
      _ when _periodMatches[0].startsWith(full) => (periods[0], true),
      _ when _periodMatches[1].startsWith(full) => (periods[1], true),
      // Replace rather than append
      _ when _periodMatches[0].startsWith(current) && _periodMatches[1].startsWith(current) => (old, false),
      _ when _periodMatches[0].startsWith(current) => (periods[0], true),
      _ when _periodMatches[1].startsWith(current) => (periods[1], true),
      _ => (old, false),
    };
  }

  List<String> adjust(List<String> parts, int selected, int adjustment) {
    assert(parts.length == 2 || parts.length == 3, 'Must have 2/3 parts.');

    final part = parts[selected];
    parts[selected] = switch (selected) {
      0 => adjustHour(part, adjustment),
      1 => adjustMinute(part, adjustment),
      2 when _hours == 12 => adjustPeriod(part, adjustment),
      _ => part,
    };

    return parts;
  }

  String adjustHour(String value, int adjustment) {
    assert(value.length <= 2, 'Hour must be at most 2 characters long');

    final hour = (_hour.tryParse(value)?.toInt() ?? (adjustment <= 0 ? 1 : 0)) + adjustment;
    return _hours == 12 ? _hour.format((hour - 1) % _hours + 1) : _hour.format(hour % _hours);
  }

  String adjustMinute(String value, int adjustment) {
    assert(value.length <= 2, 'Minute must be at most 2 characters long.');

    final minute = (_minute.tryParse(value)?.toInt() ?? (adjustment <= 0 ? 1 : 0)) + adjustment;
    return _minute.format(minute % 60);
  }

  String adjustPeriod(String value, int adjustment) => switch (value) {
    '--' => periods[adjustment < 0 ? 1 : 0],
    _ when periods[0] == value => periods[1],
    _ => periods[0],
  };
}

@internal
sealed class Changes {
  const Changes();

  Changes add(int i);
}

@internal
class None extends Changes {
  const None();

  @override
  Changes add(int i) => Single(i);
}

@internal
class Single extends Changes {
  final int index;

  const Single(this.index);

  @override
  Changes add(int i) => const Many();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Single && runtimeType == other.runtimeType && index == other.index;

  @override
  int get hashCode => index.hashCode;

  @override
  String toString() => 'Single($index)';
}

@internal
class Many extends Changes {
  const Many();

  @override
  Changes add(int _) => this;
}

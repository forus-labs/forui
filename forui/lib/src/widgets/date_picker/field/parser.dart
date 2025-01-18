import 'dart:math';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@internal
class Parser {
  final List<String> _parts;
  final NumberFormat _day;
  final NumberFormat _month;
  final NumberFormat _year;
  final int _initialYear;

  Parser(String locale, int initialYear)
      : this._(
          RegExp('([A-z]+)').allMatches(DateFormat.yMd(locale).pattern!).map((e) => e.group(1)!).toList(),
          initialYear,
          locale,
        );

  Parser._(this._parts, this._initialYear, String locale)
      : _day = NumberFormat(_parts.contains('d') ? '#0' : '00', locale),
        _month = NumberFormat(_parts.contains('M') ? '#0' : '00', locale),
        _year = NumberFormat('0000', locale);

  (List<String>, Changes) parse(List<String> old, List<String> current) {
    assert(old.length == 3, 'old must have 3 parts');
    assert(current.length == 3, 'current must have 3 parts');

    Changes changes = const None();
    for (int i = 0; i < 3; i++) {
      final oldPart = old[i];
      final currentPart = current[i];

      if (oldPart == currentPart) {
        continue;
      }

      final (parsed, next) = switch (_parts[i]) {
        'd' || 'dd' => parseDay(oldPart, currentPart),
        'M' || 'MM' => parseMonth(oldPart, currentPart),
        'y' => parseYear(oldPart, currentPart),
        _ => (oldPart, false),
      };

      current[i] = parsed;
      if (parsed != oldPart) {
        changes = changes.add(min(next ? i + 1 : i, 2));
      }
    }

    return (current, changes);
  }

  (String, bool) parseDay(String old, String current) {
    assert(old.length <= 2, 'old day must be at most 2 characters long');

    final full = old == 'DD' ? current : '$old$current';
    switch (_day.tryParse(full)?.toInt()) {
      // Backspace.
      case _ when current.isEmpty:
        return ('DD', false);

      case final day? when 1 <= day && day <= 31:
        return (_day.format(day), 4 <= day);

      // Replace rather than append.
      case _?:
        final day = _day.parse(current);
        if (1 <= day && day <= 31) {
          return (_day.format(day), 4 <= day);
        } else {
          return (old, false);
        }

      default:
        return (old, false);
    }
  }

  (String, bool) parseMonth(String old, String current) {
    assert(old.length <= 2, 'old month must be at most 2 characters long');

    final full = old == 'MM' ? current : '$old$current';
    switch (_month.tryParse(full)?.toInt()) {
      // Backspace.
      case _ when current.isEmpty:
        return ('MM', false);

      case final month? when 1 <= month && month <= 12:
        return (_month.format(month), 2 <= month);

      // Replace rather than append.
      case _?:
        final month = _month.parse(current);
        if (1 <= month && month <= 12) {
          return (_month.format(month), 2 <= month);
        } else {
          return (old, false);
        }

      default:
        return (old, false);
    }
  }

  (String, bool) parseYear(String old, String current) {
    assert(old.length <= 4, 'old month must be at most 4 characters long');

    final full = old == 'YYYY' ? current : '$old$current';
    switch (_year.tryParse(full)?.toInt()) {
      // Backspace.
      case _ when current.isEmpty:
        return ('YYYY', false);

      case final year? when 1 <= year && year <= 9999:
        return (_year.format(year), 1000 <= year);

      // Replace rather than append.
      case final _?:
        final year = _year.parse(current);
        if (1 <= year && year <= 9999) {
          return (_year.format(year), 1000 <= year);
        } else {
          return (old, false);
        }

      default:
        return (old, false);
    }
  }

  List<String> adjust(List<String> parts, int selected, int adjustment) {
    assert(parts.length == 3, 'Must have 3 parts.');

    final part = parts[selected];
    parts[selected] = switch (_parts[selected]) {
      'd' || 'dd' => adjustDay(part, adjustment),
      'M' || 'MM' => adjustMonth(part, adjustment),
      'y' => adjustYear(part, adjustment),
      _ => part,
    };

    return parts;
  }

  String adjustDay(String value, int adjustment) {
    assert(value.length <= 2, 'day must be at most 2 characters long');

    final day = (_day.tryParse(value)?.toInt() ?? (adjustment <= 0 ? 1 : 0)) + adjustment;
    return _day.format((day - 1) % 31 + 1);
  }

  String adjustMonth(String value, int adjustment) {
    assert(value.length <= 2, 'month must be at most 2 characters long');

    final month = (_month.tryParse(value)?.toInt() ?? (adjustment <= 0 ? 1 : 0)) + adjustment;
    return _month.format((month - 1) % 12 + 1);
  }

  String adjustYear(String value, int adjustment) {
    assert(value.length <= 4, 'year must be at most 4 characters long');
    if (value == 'YYYY') {
      return _year.format(_initialYear + adjustment);
    }

    final year = (_year.tryParse(value)?.toInt() ?? 0) + adjustment;
    return _year.format((year - 1) % 9999 + 1);
  }
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

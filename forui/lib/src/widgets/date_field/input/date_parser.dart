import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'package:forui/src/foundation/input/parser.dart';

@internal
class DateParser extends Parser {
  final NumberFormat _day;
  final NumberFormat _month;
  final NumberFormat _year;
  final int _initialYear;

  DateParser(String locale, int initialYear)
    : this._(
        RegExp('(y|MM|M|dd|d)').allMatches(DateFormat.yMd(locale).pattern!).map((e) => e.group(1)!).toList(),
        initialYear,
        locale,
      );

  DateParser._(super.pattern, this._initialYear, String locale)
    : _day = NumberFormat(pattern.contains('d') ? '#0' : '00', locale),
      _month = NumberFormat(pattern.contains('M') ? '#0' : '00', locale),
      _year = NumberFormat('0000', locale);

  @override
  @protected
  (String, bool) updatePart(String pattern, String previous, String current) => switch (pattern) {
    'd' || 'dd' => updateDay(previous, current),
    'M' || 'MM' => updateMonth(previous, current),
    'y' => updateYear(previous, current),
    _ => (previous, false),
  };

  @visibleForTesting
  (String, bool) updateDay(String previous, String current) {
    assert(previous.length <= 2, 'previous day must be at most 2 characters long');

    final full = previous == 'DD' ? current : '$previous$current';
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
          return (previous, false);
        }

      default:
        return (previous, false);
    }
  }

  @visibleForTesting
  (String, bool) updateMonth(String previous, String current) {
    assert(previous.length <= 2, 'previous month must be at most 2 characters long');

    final full = previous == 'MM' ? current : '$previous$current';
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
          return (previous, false);
        }

      default:
        return (previous, false);
    }
  }

  @visibleForTesting
  (String, bool) updateYear(String previous, String current) {
    assert(previous.length <= 4, 'old month must be at most 4 characters long');

    final full = previous == 'YYYY' ? current : '$previous$current';
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
          return (previous, false);
        }

      default:
        return (previous, false);
    }
  }

  @override
  @protected
  String adjustPart(String pattern, String current, int amount) => switch (pattern) {
    'd' || 'dd' => adjustDay(current, amount),
    'M' || 'MM' => adjustMonth(current, amount),
    'y' => adjustYear(current, amount),
    _ => current,
  };

  @visibleForTesting
  String adjustDay(String current, int amount) {
    assert(current.length <= 2, 'day must be at most 2 characters long');

    final day = (_day.tryParse(current)?.toInt() ?? (amount <= 0 ? 1 : 0)) + amount;
    return _day.format((day - 1) % 31 + 1);
  }

  @visibleForTesting
  String adjustMonth(String value, int adjustment) {
    assert(value.length <= 2, 'month must be at most 2 characters long');

    final month = (_month.tryParse(value)?.toInt() ?? (adjustment <= 0 ? 1 : 0)) + adjustment;
    return _month.format((month - 1) % 12 + 1);
  }

  @visibleForTesting
  String adjustYear(String value, int adjustment) {
    assert(value.length <= 4, 'year must be at most 4 characters long');
    if (value == 'YYYY') {
      return _year.format(_initialYear + adjustment);
    }

    final year = (_year.tryParse(value)?.toInt() ?? 0) + adjustment;
    return _year.format((year - 1) % 9999 + 1);
  }
}

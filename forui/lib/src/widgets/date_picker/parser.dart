import 'dart:math';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

@internal
class Parser {
  final List<String> _parts;
  final NumberFormat _day;
  final NumberFormat _month;
  final NumberFormat _year;

  Parser(String locale)
      : this._(RegExp('([A-z]+)').allMatches(DateFormat.yMd(locale).pattern!).map((e) => e.group(1)!).toList(), locale);

  Parser._(this._parts, String locale)
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
        changes = changes.add(next ? i + 1 : i);
      }
    }

    return (current, changes);
  }

  (String, bool) parseDay(String old, String current) {
    assert(old.length <= 2, 'old day must be at most 2 characters long');

    final full = old == 'DD' ? current : '$old$current';
    return switch (_day.tryParse(full)) {
      final day? when 1 <= day && day <= 31 => (_day.format(day), 4 <= day),
      final day? when 1 <= day =>
      _ => (old, false),
    };
  }

  (String, bool) parseMonth(String old, String current) {
    assert(old.length <= 2, 'old month must be at most 2 characters long');

    final full = old == 'MM' ? current : '$old$current';
    if (_month.tryParse(full) case final month? when 1 <= month && month <= 12) {
      return (_month.format(month), 2 <= month);
    }

    return (old, false);
  }

  (String, bool) parseYear(String old, String current) {
    assert(old.length <= 4, 'old month must be at most 4 characters long');

    final full = old == 'YYYY' ? current : '$old$current';
    if (_year.tryParse(full) case final year? when 1 <= year) {
      return (_year.format(year), false);
    }

    return (old, false);
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
}

@internal
class Many extends Changes {
  const Many();

  @override
  Changes add(int _) => this;
}

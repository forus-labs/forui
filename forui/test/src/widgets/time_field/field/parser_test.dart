import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/src/widgets/time_field/field/parser.dart';

void main() {
  late Parser enSG; // h:mm a (am/pm)
  late Parser enUS; // h:mm a (AM/PM)
  late Parser zh; // hh:mm a
  late Parser ja; // H:mm
  late Parser fr; // HH:mm

  setUpAll(() {
    initializeDateFormatting();
    enSG = Parser('en_SG', 'h:mm a', 12);
    enUS = Parser('en_US', 'h:mm a', 12);
    zh = Parser('zh', 'hh:mm a', 12);
    ja = Parser('ja', 'H:mm', 24);
    fr = Parser('fr', 'HH:mm', 24);
  });

  group('parse(...)', () {
    for (final (index, (old, current, expected))
    in [
      // None - no changes
      (['1', '30', 'am'], ['1', '30', 'am'], (['1', '30', 'am'], const None())),
      (['HH', '30', 'am'], ['13', '30', 'am'], (['HH', '30', 'am'], const None())),
      (['1', 'MM', 'am'], ['1', '60', 'am'], (['1', 'MM', 'am'], const None())),
      (['1', '30', '--'], ['1', '30', 'xx'], (['1', '30', '--'], const None())),

      // Single - hour changes
      (['HH', '30', 'am'], ['1', '30', 'am'], (['1', '30', 'am'], const Single(0))),
      (['HH', '30', 'am'], ['1', '30', 'am'], (['1', '30', 'am'], const Single(0))),
      (['1', '30', 'am'], ['2', '30', 'am'], (['12', '30', 'am'], const Single(1))),
      (['1', '30', 'am'], ['3', '30', 'am'], (['3', '30', 'am'], const Single(1))),

      // Single - minute changes
      (['1', 'MM', 'am'], ['1', '3', 'am'], (['1', '03', 'am'], const Single(1))),
      (['1', 'MM', 'am'], ['1', '3', 'am'], (['1', '03', 'am'], const Single(1))),
      (['1', '06', 'am'], ['1', '1', 'am'], (['1', '01', 'am'], const Single(1))),
      (['1', '06', 'am'], ['1', '7', 'am'], (['1', '07', 'am'], const Single(2))),

      // Single - period changes
      (['1', '30', '--'], ['1', '30', 'a'], (['1', '30', 'am'], const Single(2))),
      (['1', '30', '--'], ['1', '30', 'p'], (['1', '30', 'pm'], const Single(2))),
      (['1', '30', 'am'], ['1', '30', 'p'], (['1', '30', 'pm'], const Single(2))),
      (['1', '30', 'pm'], ['1', '30', 'a'], (['1', '30', 'am'], const Single(2))),

      // Many - multiple changes
      (['HH', 'MM', '--'], ['1', '30', 'am'], (['1', '30', 'am'], const Many())),
      (['HH', '10', '--'], ['2', '20', 'am'], (['2', '20', 'am'], const Many())),
      (['1', 'MM', '--'], ['2', '30', 'am'], (['12', '30', 'am'], const Many())),
      (['1', '10', '--'], ['2', '20', 'pm'], (['12', '20', 'pm'], const Many())),
      (['HH', 'MM', 'am'], ['2', '20', 'pm'], (['2', '20', 'pm'], const Many())),
    ].indexed) {
      test('12 hour format - $index', () {
        final (parts, changes) = enSG.parse(old, current);
        expect(parts, expected.$1);
        expect(changes, expected.$2);
      });
    }

    for (final (index, (old, current, expected))
    in [
      // None - no changes
      (['1', '30'], ['1', '30'], (['1', '30'], const None())),
      (['HH', '30'], ['24', '30'], (['HH', '30'], const None())),
      (['1', 'MM'], ['1', '60'], (['1', 'MM'], const None())),
      (['1', '30'], ['1', '30'], (['1', '30'], const None())),

      // Single - hour changes
      (['HH', '30'], ['1', '30'], (['1', '30'], const Single(0))),
      (['HH', '30'], ['1', '30'], (['1', '30'], const Single(0))),
      (['2', '30'], ['3', '30'], (['23', '30'], const Single(1))),
      (['32', '30'], ['5', '30'], (['5', '30'], const Single(1))),

      // Single - minute changes
      (['1', 'MM'], ['1', '3'], (['1', '03'], const Single(1))),
      (['1', 'MM'], ['1', '3'], (['1', '03'], const Single(1))),
      (['1', '06'], ['1', '1'], (['1', '01'], const Single(1))),
      (['1', '06'], ['1', '7'], (['1', '07'], const Single(1))),

      // Many - multiple changes
      (['HH', 'MM'], ['1', '30'], (['1', '30'], const Many())),
      (['HH', '10'], ['2', '20'], (['2', '20'], const Many())),
      (['1', 'MM'], ['2', '30'], (['12', '30'], const Many())),
      (['1', '10'], ['2', '20'], (['12', '20'], const Many())),
      (['HH', 'MM'], ['2', '20'], (['2', '20'], const Many())),
    ].indexed) {
      test('24 hour format - $index', () {
        final (parts, changes) = ja.parse(old, current);
        expect(parts, expected.$1);
        expect(changes, expected.$2);
      });
    }
  });

  group('parseHour(...)', () {
    for (final (i, (old, current, expected))
    in [
      // Backspace
      ('04', '', ('HH', false)),
      ('12', '', ('HH', false)),
      ('HH', '', ('HH', false)),
      // Normal
      ('HH', '1', ('1', false)),
      ('HH', '2', ('2', true)),
      ('HH', '12', ('12', true)),
      ('HH', '3.3', ('3', true)), // This is a quirk but it's not worth fixing
      ('1', '2', ('12', true)),
      ('01', '2.2', ('12', true)), // This is a quirk but it's not worth fixing
      // Replace rather than append
      ('01', '3', ('3', true)),
      ('10', '1', ('1', false)),
      ('10', '2', ('2', true)),
      // Do nothing
      ('HH', 'A', ('HH', false)),
      ('1', 'B', ('1', false)),
      ('HH', '-1', ('HH', false)),
      ('2', '-1', ('2', false)),
      ('HH', '13', ('HH', false)),
      ('HH', '321', ('HH', false)),
    ].indexed) {
      test('12 hour, single digit - $i', () => expect(enSG.parseHour(old, current), expected));
    }

    for (final (i, (old, current, expected))
    in [
      // Backspace
      ('04', '', ('HH', false)),
      ('12', '', ('HH', false)),
      ('HH', '', ('HH', false)),
      // Normal
      ('HH', '1', ('01', false)),
      ('HH', '2', ('02', true)),
      ('HH', '12', ('12', true)),
      ('HH', '3.3', ('03', true)), // This is a quirk but it's not worth fixing
      ('01', '2', ('12', true)),
      // Replace rather than append
      ('01', '3', ('03', true)),
      ('10', '1', ('01', false)),
      // Do nothing
      ('HH', 'A', ('HH', false)),
      ('01', 'B', ('01', false)),
      ('HH', '-1', ('HH', false)),
      ('02', '-1', ('02', false)),
    ].indexed) {
      test('12 hour, double digit - $i', () => expect(zh.parseHour(old, current), expected));
    }

    for (final (i, (old, current, expected))
    in [
      // Backspace
      ('04', '', ('HH', false)),
      ('12', '', ('HH', false)),
      ('HH', '', ('HH', false)),
      // Normal
      ('HH', '1', ('1', false)),
      ('HH', '2', ('2', false)),
      ('HH', '12', ('12', true)),
      ('HH', '3.3', ('3', true)), // This is a quirk but it's not worth fixing
      ('2', '3', ('23', true)),
      // Replace rather than append
      ('03', '1', ('1', false)),
      ('10', '1', ('1', false)),
      // Do nothing
      ('HH', 'A', ('HH', false)),
      ('1', 'B', ('1', false)),
      ('HH', '-1', ('HH', false)),
      ('2', '-1', ('2', false)),
      ('HH', '24', ('HH', false)),
    ].indexed) {
      test('24 hour, single digit - $i', () => expect(ja.parseHour(old, current), expected));
    }
  });

  group('parseMinute(...)', () {
    for (final (i, (old, current, expected))
        in [
          // Backspace
          ('04', '', ('MM', false)),
          ('12', '', ('MM', false)),
          ('MM', '', ('MM', false)),
          // Normal
          ('MM', '5', ('05', false)),
          ('MM', '6', ('06', true)),
          ('MM', '12', ('12', true)),
          ('MM', '3.3', ('03', false)), // This is a quirk but it's not worth fixing
          ('5', '9', ('59', true)),
          ('02', '3.3', ('23', true)), // This is a quirk but it's not worth fixing
          // Replace rather than append
          ('06', '3', ('03', false)),
          ('10', '3', ('03', false)),
          ('10', '6', ('06', true)),
          ('03', '02', ('02', false)),
          // Do nothing
          ('MM', 'A', ('MM', false)),
          ('01', 'B', ('01', false)),
          ('MM', '-1', ('MM', false)),
          ('02', '-1', ('02', false)),
          ('MM', '60', ('MM', false)),
          ('MM', '321', ('MM', false)),
        ].indexed) {
      test('double digit - $i', () => expect(enSG.parseMinute(old, current), expected));
    }
  });

  group('parsePeriod(...)', () {
    for (final (i, (old, current, expected))
        in [
          // Backspace
          ('--', '', ('--', false)),
          ('am', '', ('--', false)),
          ('pm', '', ('--', false)),
          // Normal
          ('--', 'a', ('am', true)),
          ('--', 'p', ('pm', true)),
          ('--', 'A', ('am', true)),
          ('--', 'P', ('pm', true)),
          // Replace rather than append
          ('am', 'p', ('pm', true)),
          ('pm', 'a', ('am', true)),
          // Do nothing
          ('--', 'C', ('--', false)),
          ('am', 'B', ('am', false)),
          ('--', '-1', ('--', false)),
          ('am', '-1', ('am', false)),
          ('--', 'amm', ('--', false)),
        ].indexed) {
      test('EN locale lower case- $i', () => expect(enSG.parsePeriod(old, current), expected));
    }

    for (final (i, (old, current, expected))
        in [
          // Backspace
          ('--', '', ('--', false)),
          ('AM', '', ('--', false)),
          ('PM', '', ('--', false)),
          // Normal
          ('--', 'A', ('AM', true)),
          ('--', 'P', ('PM', true)),
          ('--', 'a', ('AM', true)),
          ('--', 'p', ('PM', true)),
          // Replace rather than append
          ('AM', 'p', ('PM', true)),
          ('PM', 'a', ('AM', true)),
          // Do nothing
          ('--', 'C', ('--', false)),
          ('AM', 'B', ('AM', false)),
          ('--', '-1', ('--', false)),
          ('AM', '-1', ('AM', false)),
          ('--', 'amm', ('--', false)),
        ].indexed) {
      test('EN locale upper case - $i', () => expect(enUS.parsePeriod(old, current), expected));
    }

    for (final (i, (old, current, expected))
        in [
          // Backspace
          ('--', '', ('--', false)),
          ('午前', '', ('--', false)),
          ('午後', '', ('--', false)),
          // Normal
          ('--', '午', ('午', false)),
          ('午', '前', ('午前', true)),
          ('午', '後', ('午後', true)),
          ('--', '午前', ('午前', true)),
          ('--', '午後', ('午後', true)),
          // Replace rather than append
          ('午前', '午後', ('午後', true)),
          ('午後', '午前', ('午前', true)),
          // Do nothing
          ('--', 'C', ('--', false)),
          ('午前', 'B', ('午前', false)),
          ('--', '-1', ('--', false)),
          ('午前', '-1', ('午前', false)),
          ('--', '前', ('--', false)),
          ('午後', '午', ('午後', false)),
        ].indexed) {
      test('JA locale - $i', () => expect(ja.parsePeriod(old, current), expected));
    }
  });

  group('adjust(...)', () {
    for (final (index, (parts, selected, adjustment, expected))
        in [
          // Hour
          (['HH', 'MM', '--'], 0, 1, ['1', 'MM', '--']),
          (['HH', 'MM', '--'], 0, -1, ['12', 'MM', '--']),
          (['1', 'MM', '--'], 0, 1, ['2', 'MM', '--']),
          // Minute
          (['HH', 'MM', '--'], 1, 1, ['HH', '01', '--']),
          (['HH', 'MM', '--'], 1, -1, ['HH', '00', '--']),
          (['HH', '01', '--'], 1, 1, ['HH', '02', '--']),
          // Period
          (['HH', 'MM', '--'], 2, 1, ['HH', 'MM', 'am']),
          (['HH', 'MM', '--'], 2, -1, ['HH', 'MM', 'pm']),
          (['HH', 'MM', 'pm'], 2, 1, ['HH', 'MM', 'am']),
        ].indexed) {
      test('12 hours - $index', () => expect(enSG.adjust(parts, selected, adjustment), expected));
    }

    for (final (index, (parts, selected, adjustment, expected))
        in [
          // Hour
          (['HH', 'MM', '--'], 0, 1, ['1', 'MM', '--']),
          (['HH', 'MM', '--'], 0, -1, ['0', 'MM', '--']),
          (['1', 'MM', '--'], 0, 1, ['2', 'MM', '--']),
          // Minute
          (['HH', 'MM', '--'], 1, 1, ['HH', '01', '--']),
          (['HH', 'MM', '--'], 1, -1, ['HH', '00', '--']),
          (['HH', '01', '--'], 1, 1, ['HH', '02', '--']),
        ].indexed) {
      test('24 hours - $index', () => expect(ja.adjust(parts, selected, adjustment), expected));
    }
  });

  group('adjustHour(...)', () {
    for (final (index, (minute, adjustment, expected))
        in [
          ('11', 1, '12'),
          ('11', -1, '10'),
          //
          ('12', 1, '1'),
          ('12', -1, '11'),
        ].indexed) {
      test('single digit, 12 hours - $index', () => expect(enSG.adjustHour(minute, adjustment), expected));
    }

    for (final (index, (minute, adjustment, expected))
        in [
          ('11', 1, '12'),
          ('11', -1, '10'),
          //
          ('12', 1, '01'),
          ('12', -1, '11'),
        ].indexed) {
      test('double digit, 12 hours - $index', () => expect(zh.adjustHour(minute, adjustment), expected));
    }

    for (final (index, (minute, adjustment, expected))
        in [
          ('11', 1, '12'),
          ('11', -1, '10'),
          ('12', 1, '13'),
          ('12', -1, '11'),
          //
          ('0', 1, '1'),
          ('0', -1, '23'),
          ('23', 1, '0'),
          ('23', -1, '22'),
        ].indexed) {
      test('single digit, 24 hours - $index', () => expect(ja.adjustHour(minute, adjustment), expected));
    }

    for (final (index, (minute, adjustment, expected))
        in [
          ('11', 1, '12'),
          ('11', -1, '10'),
          ('12', 1, '13'),
          ('12', -1, '11'),
          //
          ('00', 1, '01'),
          ('0', -1, '23'),
          ('23', 1, '00'),
          ('23', -1, '22'),
        ].indexed) {
      test('double digit, 24 hours - $index', () => expect(fr.adjustHour(minute, adjustment), expected));
    }
  });

  for (final (index, (minute, adjustment, expected))
      in [('00', 1, '01'), ('00', -1, '59'), ('59', 1, '00'), ('59', -1, '58')].indexed) {
    test('adjustMinute(...) - $index', () => expect(enSG.adjustMinute(minute, adjustment), expected));
  }

  for (final (index, (period, adjustment, expected))
      in [
        ('--', 1, 'am'),
        ('--', 0, 'am'),
        ('--', -1, 'pm'),
        ('am', 1, 'pm'),
        ('am', 0, 'pm'),
        ('am', -1, 'pm'),
        ('pm', 1, 'am'),
        ('pm', 0, 'am'),
        ('pm', -1, 'am'),
      ].indexed) {
    test('adjustPeriod(...) - $index', () => expect(enSG.adjustPeriod(period, adjustment), expected));
  }
}

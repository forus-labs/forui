import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:forui/src/foundation/field/parser.dart';
import 'package:forui/src/widgets/time_field/field/time_parser.dart';

void main() {
  late Time12Parser enSG; // h:mm a (am/pm)
  late Time12Parser enUS; // h:mm a (AM/PM)
  late Time12Parser zhHK; // ah:mm (上午/下午)
  late Time24Parser ja; // H:mm
  late Time24Parser frCA; // HH 'h' mm

  setUpAll(() {
    initializeDateFormatting();
    enSG = Time12Parser(DateFormat.jm('en_SG'));
    enUS = Time12Parser(DateFormat.jm('en_US'));
    zhHK = Time12Parser(DateFormat.jm('zh_HK'));
    ja = Time24Parser(DateFormat.jm('ja'));
    frCA = Time24Parser(DateFormat.jm('fr_CA'));
  });

  group('update(...)', () {
    for (final (index, (previous, current, expected))
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
        final (parts, changes) = enSG.update(previous, current);
        expect(parts, expected.$1);
        expect(changes, expected.$2);
      });
    }

    for (final (index, (previous, current, expected))
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
        final (parts, changes) = ja.update(previous, current);
        expect(parts, expected.$1);
        expect(changes, expected.$2);
      });
    }

    for (final (index, (previous, current, expected))
        in [
          // None - no changes
          (['--', '1', '30'], ['--', '1', '30'], (['--', '1', '30'], const None())),
          (['--', 'HH', '30'], ['--', '13', '30'], (['--', 'HH', '30'], const None())),
          (['--', '1', 'MM'], ['--', '1', '60'], (['--', '1', 'MM'], const None())),
          (['上午', '1', '30'], ['上午', '1', '30'], (['上午', '1', '30'], const None())),

          // Single - period changes
          (['--', '1', '30'], ['上午', '1', '30'], (['上午', '1', '30'], const Single(1))),
          (['--', '1', '30'], ['下午', '1', '30'], (['下午', '1', '30'], const Single(1))),
          (['上午', '1', '30'], ['下午', '1', '30'], (['下午', '1', '30'], const Single(1))),
          (['下午', '1', '30'], ['上午', '1', '30'], (['上午', '1', '30'], const Single(1))),

          // Single - hour changes
          (['--', 'HH', '30'], ['--', '1', '30'], (['--', '1', '30'], const Single(1))),
          (['--', '1', '30'], ['--', '2', '30'], (['--', '12', '30'], const Single(2))),
          (['--', '1', '30'], ['--', '3', '30'], (['--', '3', '30'], const Single(2))),
          (['上午', 'HH', '30'], ['上午', '1', '30'], (['上午', '1', '30'], const Single(1))),

          // Single - minute changes
          (['--', '1', 'MM'], ['--', '1', '3'], (['--', '1', '03'], const Single(2))),
          (['--', '1', '06'], ['--', '1', '1'], (['--', '1', '01'], const Single(2))),
          (['--', '1', '06'], ['--', '1', '7'], (['--', '1', '07'], const Single(2))),
          (['上午', '1', 'MM'], ['上午', '1', '3'], (['上午', '1', '03'], const Single(2))),

          // Many - multiple changes
          (['--', 'HH', 'MM'], ['上午', '1', '30'], (['上午', '1', '30'], const Many())),
          (['--', 'HH', '10'], ['下午', '2', '20'], (['下午', '2', '20'], const Many())),
          (['--', '1', 'MM'], ['上午', '2', '30'], (['上午', '12', '30'], const Many())),
          (['--', '1', '10'], ['下午', '2', '20'], (['下午', '12', '20'], const Many())),
          (['上午', 'HH', 'MM'], ['下午', '2', '20'], (['下午', '2', '20'], const Many())),
        ].indexed) {
      test('zh_HK, period first - $index', () {
        final (parts, changes) = zhHK.update(previous, current);
        expect(parts, expected.$1);
        expect(changes, expected.$2);
      });
    }
  });

  group('updateHour(...)', () {
    for (final (i, (previous, current, expected))
        in [
          // Backspace
          ('4', '', ('HH', false)),
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
          ('1', '3', ('3', true)),
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
      test('12 hour, single digit - $i', () => expect(enSG.updateHour(previous, current), expected));
    }

    for (final (i, (previous, current, expected))
        in [
          // Backspace
          ('4', '', ('HH', false)),
          ('12', '', ('HH', false)),
          ('HH', '', ('HH', false)),
          // Normal
          ('HH', '1', ('1', false)),
          ('HH', '2', ('2', false)),
          ('HH', '12', ('12', true)),
          ('HH', '3.3', ('3', true)), // This is a quirk but it's not worth fixing
          ('2', '3', ('23', true)),
          // Replace rather than append
          ('3', '1', ('1', false)),
          ('10', '1', ('1', false)),
          ('2', '4', ('4', true)),
          // Do nothing
          ('HH', 'A', ('HH', false)),
          ('1', 'B', ('1', false)),
          ('HH', '-1', ('HH', false)),
          ('2', '-1', ('2', false)),
          ('HH', '24', ('HH', false)),
        ].indexed) {
      test('24 hour, single digit - $i', () => expect(ja.updateHour(previous, current), expected));
    }

    for (final (i, (previous, current, expected))
        in [
          // Backspace
          ('4', '', ('HH', false)),
          ('12', '', ('HH', false)),
          ('HH', '', ('HH', false)),
          // Normal
          ('HH', '1', ('01', false)),
          ('HH', '2', ('02', false)),
          ('HH', '12', ('12', true)),
          ('HH', '3.3', ('HH', false)), // This is a quirk but it's not worth fixing
          ('2', '3', ('23', true)),
          // Replace rather than append
          ('03', '1', ('01', false)),
          ('10', '1', ('01', false)),
          ('02', '4', ('04', true)),
          // Do nothing
          ('HH', 'A', ('HH', false)),
          ('01', 'B', ('01', false)),
          ('HH', '-1', ('HH', false)),
          ('02', '-1', ('02', false)),
          ('HH', '24', ('HH', false)),
        ].indexed) {
      test('24 hour, double digit - $i', () {
        expect(frCA.updateHour(previous, current), expected);
      });
    }
  });

  for (final (i, (previous, current, expected))
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
    test('updateMinute(...) - $i', () => expect(enSG.updateMinute(previous, current), expected));
  }

  group('updatePeriod(...)', () {
    for (final (i, (previous, current, expected))
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
      test('en_SG, lower case - $i', () => expect(enSG.updatePeriod(previous, current), expected));
    }

    for (final (i, (previous, current, expected))
        in [
          // Backspace
          ('--', '', ('--', false)),
          ('am', '', ('--', false)),
          ('pm', '', ('--', false)),
          // Normal
          ('--', 'a', ('AM', true)),
          ('--', 'p', ('PM', true)),
          ('--', 'A', ('AM', true)),
          ('--', 'P', ('PM', true)),
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
      test('en_US, upper case - $i', () => expect(enUS.updatePeriod(previous, current), expected));
    }

    for (final (i, (previous, current, expected))
        in [
          // Backspace
          ('--', '', ('--', false)),
          ('上午', '', ('--', false)),
          ('下午', '', ('--', false)),
          // Normal
          ('--', '上', ('上午', true)),
          ('--', '下', ('下午', true)),
          // Replace rather than append
          ('上午', '下', ('下午', true)),
          ('下午', '上', ('上午', true)),
          // Do nothing
          ('--', 'C', ('--', false)),
          ('上午', 'B', ('上午', false)),
          ('--', '-1', ('--', false)),
          ('上午', '-1', ('上午', false)),
          ('--', 'amm', ('--', false)),
        ].indexed) {
      test('zh_HK - $i', () => expect(zhHK.updatePeriod(previous, current), expected));
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
          // Period
          (['--', 'HH', 'MM'], 0, 1, ['上午', 'HH', 'MM']),
          (['--', 'HH', 'MM'], 0, -1, ['下午', 'HH', 'MM']),
          (['下午', 'HH', 'MM'], 0, 1, ['上午', 'HH', 'MM']),
          // Hour
          (['--', 'HH', 'MM'], 1, 1, ['--', '1', 'MM']),
          (['--', 'HH', 'MM'], 1, -1, ['--', '12', 'MM']),
          (['--', '1', 'MM'], 1, 1, ['--', '2', 'MM']),
          // Minute
          (['--', 'HH', 'MM'], 2, 1, ['--', 'HH', '01']),
          (['--', 'HH', 'MM'], 2, -1, ['--', 'HH', '00']),
          (['--', 'HH', '01'], 2, 1, ['--', 'HH', '02']),
        ].indexed) {
      test('12 hours, period first - $index', () => expect(zhHK.adjust(parts, selected, adjustment), expected));
    }

    for (final (index, (parts, selected, adjustment, expected))
        in [
          // Hour
          (['HH', 'MM'], 0, 1, ['1', 'MM']),
          (['HH', 'MM'], 0, -1, ['0', 'MM']),
          (['1', 'MM'], 0, 1, ['2', 'MM']),
          // Minute
          (['HH', 'MM'], 1, 1, ['HH', '01']),
          (['HH', 'MM'], 1, -1, ['HH', '00']),
          (['HH', '01'], 1, 1, ['HH', '02']),
        ].indexed) {
      test('24 hours - $index', () => expect(ja.adjust(parts, selected, adjustment), expected));
    }

    for (final (index, (parts, selected, adjustment, expected))
        in [
          // Hour
          (['HH', 'MM'], 0, 1, ['01', 'MM']),
          (['HH', 'MM'], 0, -1, ['00', 'MM']),
          (['01', 'MM'], 0, 1, ['02', 'MM']),
          // Minute
          (['HH', 'MM'], 1, 1, ['HH', '01']),
          (['HH', 'MM'], 1, -1, ['HH', '00']),
          (['HH', '01'], 1, 1, ['HH', '02']),
        ].indexed) {
      test('24 hours, h separator - $index', () => expect(frCA.adjust(parts, selected, adjustment), expected));
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
      test('double digit, 24 hours - $index', () => expect(frCA.adjustHour(minute, adjustment), expected));
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

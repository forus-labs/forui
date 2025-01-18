import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/widgets/date_picker/field/parser.dart';
import 'package:intl/date_symbol_data_local.dart';

final bg = Parser('bg', 2000); // d.MM.y r.
final hr = Parser('hr', 2000); // dd. MM. y.

final enSG = Parser('en_SG', 2000); // dd/MM/y
final enIE = Parser('en_IE', 2000); // d/M/y

void main() {
  setUpAll(initializeDateFormatting);

  group('parse(...)', () {
    for (final (index, (old, current, expected)) in [
      // None
      (['01', '01', '2024'], ['01', '01', '2024'], (['01', '01', '2024'], const None())),
      (['DD', '02', '2024'], ['32', '02', '2024'], (['DD', '02', '2024'], const None())),
      (['01', 'MM', '2024'], ['01', '13', '2024'], (['01', 'MM', '2024'], const None())),
      (['01', '01', 'YYYY'], ['01', '01', '10000'], (['01', '01', 'YYYY'], const None())),
      // Single
      (['DD', '02', '2024'], ['3', '02', '2024'], (['03', '02', '2024'], const Single(0))),
      (['0', '02', '2024'], ['3', '02', '2024'], (['03', '02', '2024'], const Single(0))),
      (['1', '02', '2024'], ['2', '02', '2024'], (['12', '02', '2024'], const Single(1))),
      (['01', 'MM', '2024'], ['01', '1', '2024'], (['01', '01', '2024'], const Single(1))),
      (['01', '01', '2024'], ['01', '2', '2024'], (['01', '12', '2024'], const Single(2))),
      (['01', '02', '2024'], ['01', '3', '2024'], (['01', '03', '2024'], const Single(2))),
      (['01', '01', 'YYYY'], ['01', '01', '4'], (['01', '01', '0004'], const Single(2))),
      (['01', '01', '0202'], ['01', '01', '4'], (['01', '01', '2024'], const Single(2))),
      (['01', '01', '2024'], ['01', '01', '2'], (['01', '01', '0002'], const Single(2))),
      // Many
      (['DD', 'MM', '2024'], ['3', '2', '2024'], (['03', '02', '2024'], const Many())),
      (['DD', '02', 'YYYY'], ['3', '02', '2024'], (['03', '02', '2024'], const Many())),
      (['03', 'MM', 'YYYY'], ['03', '2', '2024'], (['03', '02', '2024'], const Many())),
      (['DD', 'MM', 'YYYY'], ['3', '2', '2024'], (['03', '02', '2024'], const Many())),
    ].indexed) {
      test('en_SG (double digit) - $index', () {
        final (parts, changes) = enSG.parse(old, current);
        expect(parts, expected.$1);
        expect(changes, expected.$2);
      });
    }

    for (final (index, (old, current, expected)) in [
      // None
      (['1', '1', '2024'], ['1', '1', '2024'], (['1', '1', '2024'], const None())),
      (['DD', '2', '2024'], ['32', '2', '2024'], (['DD', '2', '2024'], const None())),
      (['1', 'MM', '2024'], ['1', '13', '2024'], (['1', 'MM', '2024'], const None())),
      (['1', '1', 'YYYY'], ['1', '1', '10000'], (['1', '1', 'YYYY'], const None())),
      // Single
      (['DD', '2', '2024'], ['3', '2', '2024'], (['3', '2', '2024'], const Single(0))),
      (['0', '2', '2024'], ['3', '2', '2024'], (['3', '2', '2024'], const Single(0))),
      (['1', '2', '2024'], ['2', '2', '2024'], (['12', '2', '2024'], const Single(1))),
      (['1', 'MM', '2024'], ['1', '1', '2024'], (['1', '1', '2024'], const Single(1))),
      (['1', '1', '2024'], ['1', '2', '2024'], (['1', '12', '2024'], const Single(2))),
      (['1', '2', '2024'], ['1', '3', '2024'], (['1', '3', '2024'], const Single(2))),
      (['1', '1', 'YYYY'], ['1', '1', '4'], (['1', '1', '0004'], const Single(2))),
      (['1', '1', '202'], ['1', '1', '4'], (['1', '1', '2024'], const Single(2))),
      (['1', '1', '2024'], ['1', '1', '2'], (['1', '1', '0002'], const Single(2))),
      // Many
      (['DD', 'MM', '2024'], ['3', '2', '2024'], (['3', '2', '2024'], const Many())),
      (['DD', '2', 'YYYY'], ['3', '2', '2024'], (['3', '2', '2024'], const Many())),
      (['3', 'MM', 'YYYY'], ['3', '2', '2024'], (['3', '2', '2024'], const Many())),
      (['DD', 'MM', 'YYYY'], ['3', '2', '2024'], (['3', '2', '2024'], const Many())),
    ].indexed) {
      test('enIE (single digit) - $index', () {
        final (parts, changes) = enIE.parse(old, current);
        expect(parts, expected.$1);
        expect(changes, expected.$2);
      });
    }
  });

  group('parseDay(...)', () {
    for (final (i, (old, current, expected)) in [
      // Backspace
      ('04', '', ('DD', false)),
      ('12', '', ('DD', false)),
      ('DD', '', ('DD', false)),
      // Normal
      ('DD', '3', ('03', false)),
      ('DD', '4', ('04', true)),
      ('DD', '12', ('12', true)),
      ('DD', '3.3', ('03', false)), // This is a quirk but it's not worth fixing
      ('03', '1', ('31', true)),
      ('02', '3.3', ('23', true)), // This is a quirk but it's not worth fixing
      // Replace rather than append
      ('03', '2', ('02', false)),
      ('04', '3', ('03', false)),
      ('03', '4', ('04', true)),
      ('10', '3', ('03', false)),
      ('10', '4', ('04', true)),
      ('03', '02', ('02', false)),
      ('05', '03', ('03', false)),
      ('05', '04', ('04', true)),
      // Do nothing
      ('DD', 'A', ('DD', false)),
      ('01', 'B', ('01', false)),
      ('DD', '-1', ('DD', false)),
      ('02', '-1', ('02', false)),
      ('DD', '32', ('DD', false)),
      ('DD', '321', ('DD', false)),
    ].indexed) {
      test('double digit - $i', () => expect(enSG.parseDay(old, current), expected));
    }

    for (final (i, (old, current, expected)) in [
      // Backspace
      ('4', '', ('DD', false)),
      ('12', '', ('DD', false)),
      ('DD', '', ('DD', false)),
      // Normal
      ('DD', '3', ('3', false)),
      ('DD', '4', ('4', true)),
      ('DD', '12', ('12', true)),
      ('DD', '3,3', ('3', false)), // This is a quirk but it's not worth fixing
      ('3', '1', ('31', true)),
      ('2', '3,3', ('23', true)), // This is a quirk but it's not worth fixing
      // Replace rather than append
      ('3', '2', ('2', false)),
      ('4', '3', ('3', false)),
      ('3', '4', ('4', true)),
      ('10', '3', ('3', false)),
      ('10', '4', ('4', true)),
      ('3', '02', ('2', false)),
      ('5', '03', ('3', false)),
      ('5', '04', ('4', true)),
      // Do nothing
      ('DD', 'A', ('DD', false)),
      ('1', 'B', ('1', false)),
      ('DD', '-1', ('DD', false)),
      ('2', '-1', ('2', false)),
      ('DD', '32', ('DD', false)),
      ('DD', '321', ('DD', false)),
    ].indexed) {
      test('single digit - $i', () => expect(bg.parseDay(old, current), expected));
    }
  });

  group('parseMonth(...)', () {
    for (final (i, (old, current, expected)) in [
      // Backspace
      ('04', '', ('MM', false)),
      ('12', '', ('MM', false)),
      ('MM', '', ('MM', false)),
      // Normal
      ('MM', '1', ('01', false)),
      ('MM', '2', ('02', true)),
      ('MM', '12', ('12', true)),
      ('MM', '1.1', ('01', false)), // This is a quirk but it's not worth fixing
      ('01', '2', ('12', true)),
      ('01', '1.1', ('11', true)), // This is a quirk but it's not worth fixing
      // Replace rather than append
      ('03', '2', ('02', true)),
      ('02', '1', ('01', false)),
      ('03', '2', ('02', true)),
      ('10', '3', ('03', true)),
      ('12', '1', ('01', false)),
      // Do nothing
      ('MM', 'A', ('MM', false)),
      ('01', 'B', ('01', false)),
      ('MM', '-1', ('MM', false)),
      ('02', '-1', ('02', false)),
      ('MM', '13', ('MM', false)),
      ('MM', '321', ('MM', false)),
    ].indexed) {
      test('double digit month - $i', () => expect(enSG.parseMonth(old, current), expected));
    }

    for (final (i, (old, current, expected)) in [
      // Backspace
      ('4', '', ('MM', false)),
      ('12', '', ('MM', false)),
      ('MM', '', ('MM', false)),
      // Normal
      ('MM', '1', ('1', false)),
      ('MM', '2', ('2', true)),
      ('MM', '12', ('12', true)),
      ('MM', '1.1', ('1', false)), // This is a quirk but it's not worth fixing
      ('1', '2', ('12', true)),
      ('1', '1.1', ('11', true)), // This is a quirk but it's not worth fixing
      // Replace rather than append
      ('3', '2', ('2', true)),
      ('2', '1', ('1', false)),
      ('3', '2', ('2', true)),
      ('10', '3', ('3', true)),
      ('12', '1', ('1', false)),
      // Do nothing
      ('MM', 'A', ('MM', false)),
      ('1', 'B', ('1', false)),
      ('MM', '-1', ('MM', false)),
      ('2', '-1', ('2', false)),
      ('MM', '13', ('MM', false)),
      ('MM', '321', ('MM', false)),
    ].indexed) {
      test('single digit day - $i', () => expect(enIE.parseMonth(old, current), expected));
    }
  });

  group('parseYear(...)', () {
    for (final (i, (old, current, expected)) in [
      // Backspace
      ('0001', '', ('YYYY', false)),
      ('0012', '', ('YYYY', false)),
      ('0123', '', ('YYYY', false)),
      ('1234', '', ('YYYY', false)),
      ('YYYY', '', ('YYYY', false)),
      // Normal
      ('YYYY', '1', ('0001', false)),
      ('0001', '2', ('0012', false)),
      ('0012', '3', ('0123', false)),
      ('0123', '4', ('1234', true)),
      ('YYYY', '3.3', ('0003', false)), // This is a quirk but it's not worth fixing
      ('0002', '3.3', ('0023', false)), // This is a quirk but it's not worth fixing
      // Replace rather than append
      ('2024', '1', ('0001', false)),
      ('2024', '12', ('0012', false)),
      ('2024', '123', ('0123', false)),
      ('2024', '1234', ('1234', true)),
      // Do nothing
      ('YYYY', 'A', ('YYYY', false)),
      ('0001', 'B', ('0001', false)),
      ('YYYY', '-1', ('YYYY', false)),
      ('0002', '-1', ('0002', false)),
      ('YYYY', '10000', ('YYYY', false)),
    ].indexed) {
      test('4 digit year - $i', () => expect(enSG.parseYear(old, current), expected));
    }
  });

  for (final (index, (parts, selected, adjustment, expected)) in [
    // Days
    (['DD', 'MM', 'YYYY'], 0, 1, ['01', 'MM', 'YYYY']),
    (['DD', 'MM', 'YYYY'], 0, -1, ['31', 'MM', 'YYYY']),
    (['01', 'MM', 'YYYY'], 0, 1, ['02', 'MM', 'YYYY']),
    // Months
    (['DD', 'MM', 'YYYY'], 1, 1, ['DD', '01', 'YYYY']),
    (['DD', 'MM', 'YYYY'], 1, -1, ['DD', '12', 'YYYY']),
    (['DD', '01', 'YYYY'], 1, 1, ['DD', '02', 'YYYY']),
    // Years
    (['DD', 'MM', 'YYYY'], 2, 1, ['DD', 'MM', '2001']),
    (['DD', 'MM', 'YYYY'], 2, -1, ['DD', 'MM', '1999']),
    (['DD', 'MM', '0001'], 2, 1, ['DD', 'MM', '0002']),
  ].indexed) {
    test('adjust(...) - $index', () => expect(enSG.adjust(parts, selected, adjustment), expected));
  }

  for (final (index, (year, adjustment, expected)) in [
    ('DD', 1, '01'),
    ('DD', 0, '01'),
    ('DD', -1, '31'),
    ('31', 1, '01'),
    ('01', -1, '31'),
    ('05', 1, '06'),
    ('05', -1, '04'),
  ].indexed) {
    test('adjustDay(...) - $index', () => expect(enSG.adjustDay(year, adjustment), expected));
  }

  for (final (index, (year, adjustment, expected)) in [
    ('MM', 1, '01'),
    ('MM', 0, '01'),
    ('MM', -1, '12'),
    ('12', 1, '01'),
    ('01', -1, '12'),
    ('05', 1, '06'),
    ('05', -1, '04'),
  ].indexed) {
    test('adjustMonth(...) - $index', () => expect(enSG.adjustMonth(year, adjustment), expected));
  }

  for (final (index, (year, adjustment, expected)) in [
    ('YYYY', 1, '2001'),
    ('YYYY', 0, '2000'),
    ('YYYY', -1, '1999'),
    ('9999', 1, '0001'),
    ('0001', -1, '9999'),
    ('2024', 1, '2025'),
    ('2024', -1, '2023'),
  ].indexed) {
    test('adjustYear(...) - $index', () => expect(enSG.adjustYear(year, adjustment), expected));
  }
}

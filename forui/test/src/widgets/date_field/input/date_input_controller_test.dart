import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localizations_bg.dart';
import 'package:forui/src/localizations/localizations_en.dart';
import 'package:forui/src/localizations/localizations_hr.dart';
import 'package:forui/src/widgets/date_field/input/date_input_controller.dart';
import '../../../test_scaffold.dart';

void main() {
  late FCalendarController<DateTime?> calendarController;
  late DateInputController controller;

  setUpAll(initializeDateFormatting);

  setUp(() {
    calendarController = .date();
    controller = DateInputController.test(
      calendarController,
      FLocalizationsEnSg(),
      TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
      'DD/MM/YYYY',
      2000,
      null,
    );
  });

  for (final (index, (localizations, initial, expected)) in [
    (FLocalizationsEnSg(), null, 'DD/MM/YYYY'),
    (FLocalizationsHr(), null, 'DD. MM. YYYY.'),
    (FLocalizationsEnSg(), DateTime(2024, 1, 2), '02/01/2024'),
    (FLocalizationsEnIe(), DateTime(2024, 1, 2), '2/1/2024'),
  ].indexed) {
    test('FieldController.() - $index', () {
      expect(
        DateInputController(
          .date(initial: initial),
          localizations,
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          2000,
        ).text,
        expected,
      );
    });
  }

  tearDown(() {
    calendarController.dispose();
    controller.dispose();
  });

  group('value', () {
    for (final (index, (old, value, expected, date)) in [
      // Select everything
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        null, // Null because we initialized the calendar controller value to null.
      ),
      // Backspace
      (
        const TextEditingValue(text: '01/02/2024'),
        TextEditingValue.empty,
        const TextEditingValue(text: 'DD/MM/YYYY', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        null,
      ),
      // Malformed paste
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01-04-2024', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01/02/2024'),
        null, // Null because we initialized the calendar controller value to null.
      ),
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/03/2024/01', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01/02/2024'),
        null, // Null because we initialized the calendar controller value to null.
      ),
      // Changes
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/50/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        const TextEditingValue(text: '01/02/2024'),
        null, // Null because we initialized the calendar controller value to null.
      ),
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/04/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        const TextEditingValue(text: '01/04/2024', selection: TextSelection(baseOffset: 6, extentOffset: 10)),
        DateTime.utc(2024, 4),
      ),
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '02/03/2025', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '02/03/2025', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        DateTime.utc(2025, 3, 2),
      ),
      // Select part
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
        null, // Null because we initialized the calendar controller value to null.
      ),
    ].indexed) {
      test('single separator - $index', () {
        controller = .test(
          calendarController,
          FLocalizationsEnSg(),
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          'DD/MM/YYYY',
          2000,
          old,
        )..value = value;
        expect(controller.value, expected);
        expect(calendarController.value, date);
      });
    }

    for (final (index, (old, value, expected)) in [
      // Select everything
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      ),
      // Backspace
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        TextEditingValue.empty,
        const TextEditingValue(text: 'DD. MM. YYYY.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      ),
      // Malformed paste
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        const TextEditingValue(text: '01-04-2024', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01. 02. 2024.'),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        const TextEditingValue(text: '01. 03. 2024. 01.', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01. 02. 2024.'),
      ),
      // Changes
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        const TextEditingValue(text: '01. 50. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 12)),
        const TextEditingValue(text: '01. 02. 2024.'),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        const TextEditingValue(text: '01. 04. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 12)),
        const TextEditingValue(text: '01. 04. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024'),
        const TextEditingValue(text: '02. 03. 2025.', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '02. 03. 2025.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      ),
      // Select part
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
    ].indexed) {
      test('multiple separator & suffix - $index', () {
        controller = .test(
          calendarController,
          FLocalizationsHr(),
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          'DD. MM. YYYY.',
          2000,
          old,
        )..value = value;
        expect(controller.value, expected);
      });
    }
  });

  group('traverse', () {
    for (final (index, (value, expected)) in [
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      ),
    ].indexed) {
      test('forward - $index', () {
        controller = .test(
          calendarController,
          FLocalizationsHr(),
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          '',
          2000,
          value,
        )..traverse(forward: true);
        expect(controller.value, expected);
      });
    }

    for (final (index, (value, expected)) in [
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      ),
    ].indexed) {
      test('backward - $index', () {
        controller = .test(
          calendarController,
          FLocalizationsHr(),
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          '',
          2000,
          value,
        )..traverse(forward: false);
        expect(controller.value, expected);
      });
    }
  });

  for (final (index, (value, adjustment, expectedText, expectedDate)) in [
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      1,
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      null, // Null because we initialized the calendar controller value to null.
    ),
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      1,
      const TextEditingValue(text: '02. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      DateTime.utc(2024, 2, 2),
    ),
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      1,
      const TextEditingValue(text: '01. 03. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      DateTime.utc(2024, 3),
    ),
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      1,
      const TextEditingValue(text: '01. 02. 2025.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      DateTime.utc(2025, 2),
    ),
    (
      const TextEditingValue(text: 'DD. MM. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      1,
      const TextEditingValue(text: 'DD. MM. 2025.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      null,
    ),
  ].indexed) {
    test('adjust - $index', () {
      controller = .test(
        calendarController,
        FLocalizationsHr(),
        TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
        '',
        2000,
        value,
      )..adjust(adjustment);
      expect(controller.value, expectedText);
      expect(calendarController.value, expectedDate);
    });
  }

  group('DateSelector.resolve(...)', () {
    for (final (index, (value, expected)) in [
      // 1st part
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 0)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 2)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      // 2nd part
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 3)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
      ),
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
      ),
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 5)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
      ),
      // 3rd part
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 6)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 6, extentOffset: 10)),
      ),
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 7)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 6, extentOffset: 10)),
      ),
      (
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 10)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 6, extentOffset: 10)),
      ),
      // invalid
      (const TextEditingValue(text: '01/02/2024'), null),
    ].indexed) {
      test('single separator - $index', () {
        controller = .test(
          calendarController,
          FLocalizationsEnSg(),
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          '',
          2000,
          null,
        );
        expect(controller.selector.navigate(value), expected);
      });
    }

    for (final (index, (value, expected)) in [
      // 1st part
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 0)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 2)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
      // 2nd part
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 5)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 6)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      ),
      // 3rd part
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 8)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 9)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 12)),
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      ),
      // invalid
      (const TextEditingValue(text: '01. 02. 2024.'), null),
      (const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 3)), null),
    ].indexed) {
      test('multiple separator - $index', () {
        controller = .test(
          calendarController,
          FLocalizationsHr(),
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          '',
          2000,
          null,
        );
        expect(controller.selector.navigate(value), expected);
      });
    }

    for (final (index, (value, expected)) in [
      // 3rd part
      (
        const TextEditingValue(text: '01.02.2024\u202f\u0433.', selection: TextSelection.collapsed(offset: 6)),
        const TextEditingValue(
          text: '01.02.2024\u202f\u0433.',
          selection: TextSelection(baseOffset: 6, extentOffset: 10),
        ),
      ),
      (
        const TextEditingValue(text: '01.02.2024\u202f\u0433.', selection: TextSelection.collapsed(offset: 7)),
        const TextEditingValue(
          text: '01.02.2024\u202f\u0433.',
          selection: TextSelection(baseOffset: 6, extentOffset: 10),
        ),
      ),
      (
        const TextEditingValue(text: '01.02.2024\u202f\u0433.', selection: TextSelection.collapsed(offset: 10)),
        const TextEditingValue(
          text: '01.02.2024\u202f\u0433.',
          selection: TextSelection(baseOffset: 6, extentOffset: 10),
        ),
      ),
      (const TextEditingValue(text: '01.02.2024\u202f\u0433.'), null),
      (const TextEditingValue(text: '01.02.2024\u202f\u0433.', selection: TextSelection.collapsed(offset: 11)), null),
      (const TextEditingValue(text: '01.02.2024\u202f\u0433.', selection: TextSelection.collapsed(offset: 12)), null),
    ].indexed) {
      test('suffix - $index', () {
        controller = .test(
          calendarController,
          FLocalizationsBg(),
          TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
          '',
          2000,
          null,
        );
        expect(controller.selector.navigate(value), expected);
      });
    }
  });

  for (final (index, (initial, value, expected)) in [
    (null, DateTime.utc(2025, 2), const TextEditingValue(text: '01/02/2025')),
    (DateTime.utc(2025, 2), null, const TextEditingValue(text: 'DD/MM/YYYY')),
  ].indexed) {
    test('update from calendar(...) - $index', () {
      calendarController = FCalendarController.date(initial: initial);
      controller = .test(
        calendarController,
        FLocalizationsEnSg(),
        TestScaffold.blueScreen.dateFieldStyle.fieldStyle,
        'DD/MM/YYYY',
        2000,
        null,
      );
      calendarController.value = value;

      expect(controller.value, expected);
    });
  }
}

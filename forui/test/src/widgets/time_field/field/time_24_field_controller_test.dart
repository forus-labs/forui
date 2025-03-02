import 'package:flutter/painting.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localizations_bg.dart';
import 'package:forui/src/localizations/localizations_eu.dart';
import 'package:forui/src/localizations/localizations_fr.dart';
import 'package:forui/src/widgets/time_field/field/time_field_controller.dart';
import '../../../test_scaffold.dart';

void main() {
  setUp(initializeDateFormatting);

  group('value', () {
    for (final (index, (old, value, expected))
        in [
          // Select everything
          (
            const TextEditingValue(text: '13 h 30'),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
          ),
          // Backspace
          (
            const TextEditingValue(text: '13 h 30'),
            TextEditingValue.empty,
            const TextEditingValue(text: 'HH h MM', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
          ),
          // Malformed paste
          (
            const TextEditingValue(text: '13 h 30'),
            const TextEditingValue(text: '13:30', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: '13 h 30'),
          ),
          (
            const TextEditingValue(text: '13 h 30'),
            const TextEditingValue(text: '13 h 30 h 1', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: '13 h 30'),
          ),
          // Changes
          (
            const TextEditingValue(text: '13 h 30'),
            const TextEditingValue(text: '13 h 71', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
            const TextEditingValue(text: '13 h 30'),
          ),
          (
            const TextEditingValue(text: '13 h 30'),
            const TextEditingValue(text: '13 h 45', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
            const TextEditingValue(text: '13 h 45', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
          (
            const TextEditingValue(text: '13 h 30'),
            const TextEditingValue(text: '11 h 30', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: '11 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
          // Select part
          (
            const TextEditingValue(text: '13 h 30'),
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
        ].indexed) {
      test('multiple separator - $index', () {
        final controller = TimeFieldController.test(
          FLocalizationsFrCa(),
          FTimeFieldController(vsync: const TestVSync()),
          DateFormat.jm('fr_CA'),
          TestScaffold.blueScreen.textFieldStyle,
          'HH h MM',
          old,
        )..value = value;

        expect(controller.value, expected);
      });
    }
  });

  group('traverse', () {
    for (final (index, (value, expected))
        in [
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
        ].indexed) {
      test('forward - $index', () {
        final controller = TimeFieldController.test(
          FLocalizationsFrCa(),
          FTimeFieldController(vsync: const TestVSync()),
          DateFormat.jm('fr_CA'),
          TestScaffold.blueScreen.textFieldStyle,
          'HH h MM',
          value,
        )..traverse(forward: true);

        expect(controller.value, expected);
      });
    }

    for (final (index, (value, expected))
        in [
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
        ].indexed) {
      test('backward - $index', () {
        final controller = TimeFieldController.test(
          FLocalizationsFrCa(),
          FTimeFieldController(vsync: const TestVSync()),
          DateFormat.jm('fr_CA'),
          TestScaffold.blueScreen.textFieldStyle,
          'HH h MM',
          value,
        )..traverse(forward: false);

        expect(controller.value, expected);
      });
    }
  });

  for (final (index, (value, amount, expectedText))
      in [
        // TODO: This is a quirk, but what should the expected behavior be?
        (
          const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 7)),
          1,
          const TextEditingValue(text: '13 h 31', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
        ),
        (
          const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          1,
          const TextEditingValue(text: '14 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
        ),
        (
          const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          1,
          const TextEditingValue(text: '13 h 31', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
        ),
        (
          const TextEditingValue(text: 'HH h MM', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          1,
          const TextEditingValue(text: 'HH h 01', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
        ),
      ].indexed) {
    testWidgets('adjust - $index', (tester) async {
      final controller = TimeFieldController.test(
        FLocalizationsFrCa(),
        FTimeFieldController(vsync: const TestVSync()),
        DateFormat.jm('fr_CA'),
        TestScaffold.blueScreen.textFieldStyle,
        'HH h MM',
        value,
      )..adjust(amount);

      expect(controller.value, expectedText);
    });
  }

  group('resolve(...)', () {
    for (final (index, (value, expected))
        in [
          // 1st part
          (
            const TextEditingValue(text: '13:30', selection: TextSelection.collapsed(offset: 0)),
            const TextEditingValue(text: '13:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '13:30', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: '13:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '13:30', selection: TextSelection.collapsed(offset: 2)),
            const TextEditingValue(text: '13:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          // 2nd part
          (
            const TextEditingValue(text: '13:30', selection: TextSelection.collapsed(offset: 3)),
            const TextEditingValue(text: '13:30', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '13:30', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: '13:30', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '13:30', selection: TextSelection.collapsed(offset: 5)),
            const TextEditingValue(text: '13:30', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          // invalid
          (const TextEditingValue(text: '13:30'), null),
        ].indexed) {
      test('single time separator - $index', () {
        final controller = TimeFieldController(
          FLocalizationsEu(),
          FTimeFieldController(vsync: const TestVSync()),
          DateFormat.jm('eu'),
          TestScaffold.blueScreen.textFieldStyle,
        );

        expect(controller.selector.resolve(value), expected);
      });
    }

    for (final (index, (value, expected))
        in [
          // 1st part
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 0)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 2)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          // 2nd part
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 5)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 6)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
          (
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 7)),
            const TextEditingValue(text: '13 h 30', selection: TextSelection(baseOffset: 5, extentOffset: 7)),
          ),
          // invalid
          (const TextEditingValue(text: '13 h 30'), null),
          (const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 3)), null),
        ].indexed) {
      test('multiple time separator - $index', () {
        final controller = TimeFieldController(
          FLocalizationsFrCa(),
          FTimeFieldController(vsync: const TestVSync()),
          DateFormat.jm('fr_CA'),
          TestScaffold.blueScreen.textFieldStyle,
        );

        expect(controller.selector.resolve(value), expected);
      });
    }

    for (final (index, (value, expected))
        in [
          // 3rd part
          (
            const TextEditingValue(text: '13:30 ч.', selection: TextSelection.collapsed(offset: 3)),
            const TextEditingValue(text: '13:30 ч.', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '13:30 ч.', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: '13:30 ч.', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '13:30 ч.', selection: TextSelection.collapsed(offset: 5)),
            const TextEditingValue(text: '13:30 ч.', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (const TextEditingValue(text: '13:30 ч.'), null),
          (const TextEditingValue(text: '13:30 ч.', selection: TextSelection.collapsed(offset: 11)), null),
          (const TextEditingValue(text: '13:30 ч.', selection: TextSelection.collapsed(offset: 12)), null),
        ].indexed) {
      test('suffix - $index', () {
        final controller = TimeFieldController(
          FLocalizationsBg(),
          FTimeFieldController(vsync: const TestVSync()),
          DateFormat.jm('bg'),
          TestScaffold.blueScreen.textFieldStyle,
        );

        expect(controller.selector.resolve(value), expected);
      });
    }
  });

  for (final (index, (initial, value, expected))
      in [
        (null, const FTime(9, 30), const TextEditingValue(text: '09:30 ч.')),
        (const FTime(9, 30), null, const TextEditingValue(text: 'HH:MM ч.')),
      ].indexed) {
    test('update from time controller(...) - $index', () {
      final timeController = FTimeFieldController(vsync: const TestVSync(), initialTime: initial);
      final controller = TimeFieldController(
        FLocalizationsBg(),
        timeController,
        DateFormat.jm('bg'),
        TestScaffold.blueScreen.textFieldStyle,
      );
      timeController.value = value;

      expect(controller.value, expected);
    });
  }
}

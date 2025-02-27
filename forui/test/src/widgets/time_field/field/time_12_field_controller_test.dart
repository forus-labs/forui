import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:forui/src/localizations/localizations_en.dart';
import 'package:forui/src/localizations/localizations_ko.dart';
import 'package:forui/src/localizations/localizations_zh.dart';
import 'package:forui/src/widgets/time_field/field/time_field_controller.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../test_scaffold.dart';

void main() {
  setUp(initializeDateFormatting);

  group('value', () {
    for (final (index, (old, value, expected))
        in [
          // Select everything
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
          ),
          // Backspace
          (
            const TextEditingValue(text: '12:30 pm'),
            TextEditingValue.empty,
            const TextEditingValue(text: 'HH:MM --', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
          ),
          // Malformed paste
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '13 h 30', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: '12:30 pm'),
          ),
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '12:30 :00 pm', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: '12:30 pm'),
          ),
          // Changes
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '12:71 pm', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
            const TextEditingValue(text: '12:30 pm'),
          ),
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '1:30 pm', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: '1:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 1)),
          ),
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '12:31 pm', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
            const TextEditingValue(text: '12:31 pm', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
          ),
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '12:30 am', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
            const TextEditingValue(text: '12:30 am', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
          ),
          // Select part
          (
            const TextEditingValue(text: '12:30 pm'),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
        ].indexed) {
      test('single separator - $index', () {
        final controller = TimeFieldController.test(
          FLocalizationsEnSg(),
          FTimeFieldController(),
          DateFormat.jm('en_SG'),
          TestScaffold.blueScreen.textFieldStyle,
          'HH:MM --',
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
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
          ),
          (
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
          ),
          (
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
          ),
        ].indexed) {
      test('forward - $index', () {
        final controller = TimeFieldController.test(
          FLocalizationsEnSg(),
          FTimeFieldController(),
          DateFormat.jm('en_SG'),
          TestScaffold.blueScreen.textFieldStyle,
          'HH:MM --',
          value,
        )..traverse(forward: true);

        expect(controller.value, expected);
      });
    }

    for (final (index, (value, expected))
        in [
          // TODO: This is a quirk, but what should the expected behavior be?
          (
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
            const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
        ].indexed) {
      test('backward - $index', () {
        final controller = TimeFieldController.test(
          FLocalizationsEnSg(),
          FTimeFieldController(),
          DateFormat.jm('en_SG'),
          TestScaffold.blueScreen.textFieldStyle,
          'HH:MM --',
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
          const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 8)),
          1,
          const TextEditingValue(text: '12:30 am', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
        ),
        (
          const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          1,
          const TextEditingValue(text: '1:30 pm', selection: TextSelection(baseOffset: 0, extentOffset: 1)),
        ),
        (
          const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          1,
          const TextEditingValue(text: '12:31 pm', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
        ),
        (
          const TextEditingValue(text: '12:30 pm', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
          1,
          const TextEditingValue(text: '12:30 am', selection: TextSelection(baseOffset: 6, extentOffset: 8)),
        ),
      ].indexed) {
    testWidgets('adjust - $index', (tester) async {
      final controller = TimeFieldController.test(
        FLocalizationsEnSg(),
        FTimeFieldController(),
        DateFormat.jm('en_SG'),
        TestScaffold.blueScreen.textFieldStyle,
        'HH:MM --',
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
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 0)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 2)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          // 2nd part
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 3)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 5)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          // 3rd part
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 6)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 6, extentOffset: 16)),
          ),
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 8)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 6, extentOffset: 16)),
          ),
          (
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection.collapsed(offset: 16)),
            const TextEditingValue(text: '12:30 e pasdites', selection: TextSelection(baseOffset: 6, extentOffset: 16)),
          ),
        ].indexed) {
      test('period with spaces - $index', () {
        final controller = TimeFieldController(
          FLocalizationsKo(),
          FTimeFieldController(),
          DateFormat.jm('sq'),
          TestScaffold.blueScreen.textFieldStyle,
        );

        expect(controller.selector.resolve(value), expected);
      });
    }

    // Korean locale displays AM/PM in Hangul script in Flutter.
    for (final (index, (value, expected))
        in [
          // 1st part
          (
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection.collapsed(offset: 0)),
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection.collapsed(offset: 1)),
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          (
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection.collapsed(offset: 2)),
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
          ),
          // 2nd part
          (
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection.collapsed(offset: 3)),
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection.collapsed(offset: 4)),
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
          (
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection.collapsed(offset: 5)),
            const TextEditingValue(text: 'PM 12:30', selection: TextSelection(baseOffset: 3, extentOffset: 5)),
          ),
        ].indexed) {
      test('period first - $index', () {
        final controller = TimeFieldController(
          FLocalizationsKo(),
          FTimeFieldController(),
          DateFormat.jm('ko'),
          TestScaffold.blueScreen.textFieldStyle,
        );

        expect(controller.selector.resolve(value), expected);
      });
    }

    for (final (localization, locale) in [(FLocalizationsZhHk(), 'zh_HK'), (FLocalizationsZhTw(), 'zh_TW')]) {
      for (final (index, (value, expected))
          in [
            // 1st part
            (
              const TextEditingValue(text: '下午12:30', selection: TextSelection.collapsed(offset: 0)),
              const TextEditingValue(text: '下午12:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
            ),
            (
              const TextEditingValue(text: '下午12:30', selection: TextSelection.collapsed(offset: 1)),
              const TextEditingValue(text: '下午12:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
            ),
            (
              const TextEditingValue(text: '下午12:30', selection: TextSelection.collapsed(offset: 2)),
              const TextEditingValue(text: '下午12:30', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
            ),
            // 2nd part
            (
              const TextEditingValue(text: '下午12:30', selection: TextSelection.collapsed(offset: 3)),
              const TextEditingValue(text: '下午12:30', selection: TextSelection(baseOffset: 2, extentOffset: 4)),
            ),
            (
              const TextEditingValue(text: '下午12:30', selection: TextSelection.collapsed(offset: 4)),
              const TextEditingValue(text: '下午12:30', selection: TextSelection(baseOffset: 2, extentOffset: 4)),
            ),
          ].indexed) {
        test('period with no separator - locale - $index', () {
          final controller = TimeFieldController(
            localization,
            FTimeFieldController(),
            DateFormat.jm(locale),
            TestScaffold.blueScreen.textFieldStyle,
          );

          expect(controller.selector.resolve(value), expected);
        });
      }
    }
  });

  for (final (index, (initial, value, expected))
      in [
        (null, const FTime(9, 30), const TextEditingValue(text: '9:30 am')),
        (const FTime(9, 30), null, const TextEditingValue(text: 'HH:MM --')),
      ].indexed) {
    test('update from time controller(...) - $index', () {
      final timeController = FTimeFieldController(initial: initial);
      final controller = TimeFieldController(
        FLocalizationsEnSg(),
        timeController,
        DateFormat.jm('en_SG'),
        TestScaffold.blueScreen.textFieldStyle,
      );
      timeController.value = value;

      expect(controller.value, expected);
    });
  }
}

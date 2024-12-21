import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/src/localizations/localizations_bg.dart';
import 'package:forui/src/localizations/localizations_en.dart';
import 'package:forui/src/localizations/localizations_hr.dart';
import 'package:forui/src/widgets/date_picker/field/field_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  late TextEditingController controller;

  setUpAll(initializeDateFormatting);

  setUp(() => controller = TextEditingController());

  group('update', () {
    for (final (index, (old, value, expected)) in [
      // Select everything
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
      ),
      // Backspace
      (
        const TextEditingValue(text: '01/02/2024'),
        TextEditingValue.empty,
        const TextEditingValue(text: '01/02/2024'),
      ),
      // Malformed paste
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01-04-2024', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01/02/2024'),
      ),
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/03/2024/01', selection: TextSelection.collapsed(offset: 4)),
        const TextEditingValue(text: '01/02/2024'),
      ),
      // Changes
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/50/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        const TextEditingValue(text: '01/02/2024'),
      ),
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/04/2024', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
        const TextEditingValue(text: '01/04/2024', selection: TextSelection(baseOffset: 6, extentOffset: 10)),
      ),
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '02/03/2025', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '02/03/2025', selection: TextSelection(baseOffset: 0, extentOffset: 10)),
      ),
      // Select part
      (
        const TextEditingValue(text: '01/02/2024'),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection.collapsed(offset: 1)),
        const TextEditingValue(text: '01/02/2024', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      ),
    ].indexed) {
      test('single separator - $index', () {
        controller.value = old;
        FieldController(controller, FLocalizationsEnSg());

        controller.value = value;
        expect(controller.value, expected);
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
        const TextEditingValue(text: '01. 02. 2024.'),
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
        controller.value = old;
        FieldController(controller, FLocalizationsHr());

        controller.value = value;
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
        controller.value = value;
        FieldController(controller, FLocalizationsHr()).traverse(forward: true);

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
        controller.value = value;
        FieldController(controller, FLocalizationsHr()).traverse(forward: false);

        expect(controller.value, expected);
      });
    }
  });

  for (final (index, (value, adjustment, expected)) in [
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
      1,
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 13)),
    ),
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
      1,
      const TextEditingValue(text: '02. 02. 2024.', selection: TextSelection(baseOffset: 0, extentOffset: 2)),
    ),
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
      1,
      const TextEditingValue(text: '01. 03. 2024.', selection: TextSelection(baseOffset: 4, extentOffset: 6)),
    ),
    (
      const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
      1,
      const TextEditingValue(text: '01. 02. 2025.', selection: TextSelection(baseOffset: 8, extentOffset: 12)),
    ),
  ].indexed) {
    test('adjust - $index', () {
      controller.value = value;
      FieldController(controller, FLocalizationsHr()).adjust(adjustment);

      expect(controller.value, expected);
    });
  }

  group('selectPart(...)', () {
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
      (
        const TextEditingValue(text: '01/02/2024'),
        TextEditingValue.empty,
      ),
    ].indexed) {
      test('single separator - $index', () {
        final updater = FieldController(controller, FLocalizationsEnSg());
        expect(updater.selectParts(value), expected);
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
      (
        const TextEditingValue(text: '01. 02. 2024.'),
        TextEditingValue.empty,
      ),
      (
        const TextEditingValue(text: '01. 02. 2024.', selection: TextSelection.collapsed(offset: 3)),
        TextEditingValue.empty,
      ),
    ].indexed) {
      test('multiple separator - $index', () {
        final updater = FieldController(controller, FLocalizationsHr());
        expect(updater.selectParts(value), expected);
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
      (
        const TextEditingValue(text: '01.02.2024\u202f\u0433.'),
        TextEditingValue.empty,
      ),
      (
        const TextEditingValue(text: '01.02.2024\u202f\u0433.', selection: TextSelection.collapsed(offset: 11)),
        TextEditingValue.empty,
      ),
      (
        const TextEditingValue(text: '01.02.2024\u202f\u0433.', selection: TextSelection.collapsed(offset: 12)),
        TextEditingValue.empty,
      ),
    ].indexed) {
      test('suffix - $index', () {
        final updater = FieldController(controller, FLocalizationsBg());
        expect(updater.selectParts(value), expected);
      });
    }
  });

  tearDown(() => controller.dispose());
}

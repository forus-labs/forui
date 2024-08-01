import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FCalendarController.date(...)', () {
    test(
      'constructor throws error',
      () => expect(() => FCalendarController.date(initialSelection: DateTime.now()), throwsAssertionError),
    );

    for (final (date, expected) in [
      (DateTime.utc(2024, 5, 4), true),
      (DateTime.utc(2024, 5, 5), false),
    ]) {
      test('selected(...) contains date', () {
        final controller = FCalendarController.date(initialSelection: DateTime.utc(2024, 5, 4));
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      (null, DateTime.utc(2024), DateTime.utc(2024)),
      (null, DateTime.utc(2025), DateTime.utc(2025)),
      (DateTime.utc(2024), DateTime.utc(2025), DateTime.utc(2025)),
      (DateTime.utc(2024), DateTime.utc(2024), null),
    ]) {
      test('select(...)', () {
        final controller = FCalendarController.date(initialSelection: initial)..select(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarController.dates', () {
    for (final (date, expected) in [
      (DateTime.utc(2024), true),
      (DateTime.utc(2025), false),
    ]) {
      test('selected(...)', () {
        final controller = FCalendarController.dates(initialSelections: {DateTime.utc(2024)});
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ({DateTime.utc(2024)}, DateTime.utc(2024), <DateTime>{}),
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}),
      ({DateTime.utc(2024)}, DateTime.utc(2025), {DateTime.utc(2024), DateTime.utc(2025)}),
    ]) {
      test('select(...)', () {
        final controller = FCalendarController.dates(initialSelections: initial)..select(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarController.range(...)', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarController.range(initialSelection: (DateTime(2025), DateTime(2024))),
        throwsAssertionError,
      ),
    );

    for (final (initial, date, expected) in [
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2024), true),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2025), true),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2023), false),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2026), false),
      (null, DateTime.utc(2023), false),
    ]) {
      test('selected(...)', () {
        final controller = FCalendarController.range(initialSelection: initial);
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2024), null),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2025), null),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2023), (DateTime.utc(2023), DateTime.utc(2025))),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2026), (DateTime.utc(2024), DateTime.utc(2026))),
      ((DateTime.utc(2024), DateTime.utc(2027)), DateTime.utc(2025), (DateTime.utc(2024), DateTime.utc(2025))),
      (null, DateTime.utc(2023), (DateTime.utc(2023), DateTime.utc(2023))),
    ]) {
      test('select(...)', () {
        final controller = FCalendarController.range(initialSelection: initial)..select(date);
        expect(controller.value, expected);
      });
    }
  });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FCalendarValueController', () {
    test(
      'constructor throws error',
      () => expect(() => FCalendarValueController(initialSelection: DateTime.now()), throwsAssertionError),
    );

    for (final (date, expected) in [
      (DateTime.utc(2024, 5, 4), true),
      (DateTime.utc(2024, 5, 5), false),
    ]) {
      test('contains(...) contains date', () {
        final controller = FCalendarValueController(initialSelection: DateTime.utc(2024, 5, 4));
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
        final controller = FCalendarValueController(initialSelection: initial)..select(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarMultiValueController', () {
    for (final (date, expected) in [
      (DateTime.utc(2024), true),
      (DateTime.utc(2025), false),
    ]) {
      test('contains(...)', () {
        final controller = FCalendarMultiValueController(initialSelections: {DateTime.utc(2024)});
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ({DateTime.utc(2024)}, DateTime.utc(2024), <DateTime>{}),
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}),
      ({DateTime.utc(2024)}, DateTime.utc(2025), {DateTime.utc(2024), DateTime.utc(2025)}),
    ]) {
      test('select(...)', () {
        final controller = FCalendarMultiValueController(initialSelections: initial)..select(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarRangeController', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarRangeController(initialSelection: (DateTime(2025), DateTime(2024))),
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
      test('selected(...)', () {
        final controller = FCalendarRangeController(initialSelection: initial);
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
        final controller = FCalendarRangeController(initialSelection: initial)..select(date);
        expect(controller.value, expected);
      });
    }
  });
}

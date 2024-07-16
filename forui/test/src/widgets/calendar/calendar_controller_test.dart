import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';

void main() {
  group('FCalendarSingleValueController', () {
    test(
      'constructor throws error',
      () => expect(() => FCalendarSingleValueController(DateTime.now()), throwsAssertionError),
    );

    for (final (date, expected) in [
      (DateTime.utc(2024, 5, 4), true),
      (DateTime.utc(2024, 5, 5), false),
    ]) {
      test('contains(...) contains date', () {
        final controller = FCalendarSingleValueController(DateTime.utc(2024, 5, 4));
        expect(controller.contains(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      (null, DateTime.utc(2024), DateTime.utc(2024)),
      (null, DateTime.utc(2025), DateTime.utc(2025)),
      (DateTime.utc(2024), DateTime.utc(2025), DateTime.utc(2025)),
      (DateTime.utc(2024), DateTime.utc(2024), null),
    ]) {
      test('onPress(...)', () {
        final controller = FCalendarSingleValueController(initial)..onPress(date);
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
        final controller = FCalendarMultiValueController({DateTime.utc(2024)});
        expect(controller.contains(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ({DateTime.utc(2024)}, DateTime.utc(2024), <DateTime>{}),
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}),
      ({DateTime.utc(2024)}, DateTime.utc(2025), {DateTime.utc(2024), DateTime.utc(2025)}),
    ]) {
      test('onPress(...)', () {
        final controller = FCalendarMultiValueController(initial)..onPress(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarSingleRangeController', () {
    test(
      'constructor throws error',
      () => expect(() => FCalendarSingleRangeController((DateTime(2025), DateTime(2024))), throwsAssertionError),
    );

    for (final (initial, date, expected) in [
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2024), true),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2025), true),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2023), false),
      ((DateTime.utc(2024), DateTime.utc(2025)), DateTime.utc(2026), false),
      (null, DateTime.utc(2023), false),
    ]) {
      test('contains(...)', () {
        final controller = FCalendarSingleRangeController(initial);
        expect(controller.contains(date), expected);
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
      test('onPress(...)', () {
        final controller = FCalendarSingleRangeController(initial)..onPress(date);
        expect(controller.value, expected);
      });
    }
  });
}

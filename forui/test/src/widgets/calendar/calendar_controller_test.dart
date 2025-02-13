import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

void main() {
  group('FCalendarController.date(...)', () {
    test(
      'constructor converts date time',
      () => expect(
        FCalendarController.date(initialSelection: DateTime(2024, 11, 30, 12)).value,
        DateTime.utc(2024, 11, 30),
      ),
    );

    test('selectable(...)', () {
      FCalendarController.date(
        selectable: (date) {
          expect(date, DateTime.utc(2024));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime(2024, 5, 4, 3), true), (DateTime(2024, 5, 5, 3), false)]) {
      test('selected(...) contains date', () {
        final controller = FCalendarController.date(initialSelection: DateTime(2024, 5, 4));
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      (null, DateTime(2024), DateTime.utc(2024)),
      (null, DateTime(2025), DateTime.utc(2025)),
      (DateTime(2024), DateTime(2025), DateTime.utc(2025)),
      (DateTime(2024), DateTime(2024), null),
    ]) {
      test('select(...)', () {
        final controller = FCalendarController.date(initialSelection: initial)..select(date);
        expect(controller.value, expected);
      });
    }

    test('value', () {
      final controller = FCalendarController.date()..value = DateTime(2024, 11, 30, 12);
      expect(controller.value, DateTime.utc(2024, 11, 30));
    });
  });

  group('FCalendarController.date(...) no auto-convert', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarController.date(initialSelection: DateTime.now(), truncateAndStripTimezone: false),
        throwsAssertionError,
      ),
    );

    test('selectable(...)', () {
      FCalendarController.date(
        truncateAndStripTimezone: false,
        selectable: (date) {
          expect(date, DateTime(2024, 1, 1, 1));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime.utc(2024, 5, 4), true), (DateTime.utc(2024, 5, 5), false)]) {
      test('selected(...) contains date', () {
        final controller = FCalendarController.date(
          initialSelection: DateTime.utc(2024, 5, 4),
          truncateAndStripTimezone: false,
        );
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
        final controller = FCalendarController.date(initialSelection: initial, truncateAndStripTimezone: false)
          ..select(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarController.dates(...)', () {
    test(
      'constructor converts date time',
      () => expect(FCalendarController.dates(initialSelections: {DateTime(2024, 11, 30, 12)}).value, {
        DateTime.utc(2024, 11, 30),
      }),
    );

    test('selectable(...)', () {
      FCalendarController.dates(
        selectable: (date) {
          expect(date, DateTime.utc(2024));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime(2024), true), (DateTime(2025), false)]) {
      test('selected(...)', () {
        final controller = FCalendarController.dates(initialSelections: {DateTime.utc(2024)});
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ({DateTime(2024)}, DateTime(2024), <DateTime>{}),
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}),
      ({DateTime(2024)}, DateTime(2025), {DateTime.utc(2024), DateTime.utc(2025)}),
    ]) {
      test('select(...)', () {
        final controller = FCalendarController.dates(initialSelections: initial)..select(date);
        expect(controller.value, expected);
      });
    }

    test('value', () {
      final controller = FCalendarController.dates()..value = {DateTime(2024, 11, 30, 12)};
      expect(controller.value, {DateTime.utc(2024, 11, 30)});
    });
  });

  group('FCalendarController.dates(...) no auto-convert', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarController.dates(initialSelections: {DateTime.now()}, truncateAndStripTimezone: false),
        throwsAssertionError,
      ),
    );

    test('selectable(...)', () {
      FCalendarController.dates(
        truncateAndStripTimezone: false,
        selectable: (date) {
          expect(date, DateTime(2024, 1, 1, 1));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (date, expected) in [(DateTime.utc(2024), true), (DateTime.utc(2025), false)]) {
      test('selected(...)', () {
        final controller = FCalendarController.dates(
          initialSelections: {DateTime.utc(2024)},
          truncateAndStripTimezone: false,
        );
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ({DateTime.utc(2024)}, DateTime.utc(2024), <DateTime>{}),
      (<DateTime>{}, DateTime.utc(2024), {DateTime.utc(2024)}),
      ({DateTime.utc(2024)}, DateTime.utc(2025), {DateTime.utc(2024), DateTime.utc(2025)}),
    ]) {
      test('select(...)', () {
        final controller = FCalendarController.dates(initialSelections: initial, truncateAndStripTimezone: false)
          ..select(date);
        expect(controller.value, expected);
      });
    }
  });

  group('FCalendarController.range(...)', () {
    test(
      'constructor converts date time',
      () => expect(
        FCalendarController.range(initialSelection: (DateTime(2024, 11, 30, 12), DateTime(2024, 12, 12, 12))).value,
        (DateTime.utc(2024, 11, 30), DateTime.utc(2024, 12, 12)),
      ),
    );

    test('selectable(...)', () {
      FCalendarController.range(
        selectable: (date) {
          expect(date, DateTime.utc(2024));
          return true;
        },
      ).selectable(DateTime(2024, 1, 1, 1));
    });

    for (final (initial, date, expected) in [
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2024), true),
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2025), true),
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2023), false),
      ((DateTime(2024), DateTime(2025)), DateTime.utc(2026), false),
      (null, DateTime.utc(2023), false),
    ]) {
      test('selected(...)', () {
        final controller = FCalendarController.range(initialSelection: initial);
        expect(controller.selected(date), expected);
      });
    }

    for (final (initial, date, expected) in [
      ((DateTime(2024), DateTime(2025)), DateTime(2024), null),
      ((DateTime(2024), DateTime(2025)), DateTime(2025), null),
      ((DateTime(2024), DateTime(2025)), DateTime(2023), (DateTime.utc(2023), DateTime.utc(2025))),
      ((DateTime(2024), DateTime(2025)), DateTime(2026), (DateTime.utc(2024), DateTime.utc(2026))),
      ((DateTime(2024), DateTime(2027)), DateTime(2025), (DateTime.utc(2024), DateTime.utc(2025))),
      (null, DateTime(2023), (DateTime.utc(2023), DateTime.utc(2023))),
    ]) {
      test('select(...)', () {
        final controller = FCalendarController.range(initialSelection: initial)..select(date);
        expect(controller.value, expected);
      });
    }

    test('value', () {
      final controller = FCalendarController.range()..value = (DateTime(2024, 11, 30, 12), DateTime(2024, 12, 12, 12));
      expect(controller.value, (DateTime.utc(2024, 11, 30), DateTime.utc(2024, 12, 12)));
    });
  });

  group('FCalendarController.range(...) no auto-convert', () {
    test(
      'constructor throws error',
      () => expect(
        () => FCalendarController.range(
          initialSelection: (DateTime(2025), DateTime(2024)),
          truncateAndStripTimezone: false,
        ),
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
        final controller = FCalendarController.range(initialSelection: initial, truncateAndStripTimezone: false);
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
        final controller = FCalendarController.range(initialSelection: initial, truncateAndStripTimezone: false)
          ..select(date);
        expect(controller.value, expected);
      });
    }
  });
}

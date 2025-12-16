// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/forui.dart';
import '../../locale_scaffold.dart';
import '../../test_scaffold.dart';

void main() {
  const key = Key('field');

  setUpAll(initializeDateFormatting);

  for (final (index, (date, start, end, expected)) in [
    ('01/01/1899', null, null, 'January 2025'),
    ('01/01/1949', DateTime.utc(1950), null, 'January 2025'),
    ('01/01/1951', DateTime.utc(1950), null, 'January 1951'),
    ('01/01/2101', null, null, 'January 2025'),
    ('01/01/2051', null, DateTime.utc(2050), 'January 2025'),
    ('01/01/2049', null, DateTime.utc(2050), 'January 2049'),
  ].indexed) {
    testWidgets('initial month - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            calendar: FDateFieldCalendarProperties(start: start, end: end, today: DateTime.utc(2025, 1, 15)),
          ),
        ),
      );

      await tester.enterText(find.byKey(key), date);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(find.text(expected), findsOneWidget);
    });
  }

  testWidgets('unselect', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField(
          key: key,
          calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15)),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('15/01/2025'), findsOneWidget);

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();

    expect(find.text('15/01/2025'), findsNothing);
  });

  group('controller', () {
    testWidgets('input only - change locale', (tester) async {
      final controller = autoDispose(FDateFieldController());

      await tester.pumpWidget(
        TestScaffold.app(
          child: LocaleScaffold(
            child: FDateField.input(
              control: .managed(controller: controller),
              key: key,
            ),
          ),
        ),
      );
      expect(find.text('MM/DD/YYYY'), findsOneWidget);
      expect(find.text('YYYY. MM. DD.'), findsNothing);

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('MM/DD/YYYY'), findsNothing);
      expect(find.text('YYYY. MM. DD.'), findsOneWidget);
    });

    testWidgets('calendar only - change locale', (tester) async {
      final controller = autoDispose(FDateFieldController());

      await tester.pumpWidget(
        TestScaffold.app(
          child: LocaleScaffold(
            child: FDateField.calendar(control: .managed(controller: controller)),
          ),
        ),
      );
      expect(find.text('Pick a date'), findsOneWidget);
      expect(find.text('날짜 선택'), findsNothing);

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('Pick a date'), findsNothing);
      expect(find.text('날짜 선택'), findsOneWidget);
    });

    for (final (name, field) in [
      (
        'calendar only',
        (controller, focus) => FDateField.calendar(
          control: .managed(controller: controller),
          focusNode: focus,
        ),
      ),
      (
        'input only',
        (controller, focus) => FDateField.input(
          control: .managed(controller: controller),
          focusNode: focus,
        ),
      ),
      (
        'both',
        (controller, focus) => FDateField(
          control: .managed(controller: controller),
          focusNode: focus,
        ),
      ),
    ]) {
      group(name, () {
        testWidgets('update focus', (tester) async {
          final first = autoDispose(FocusNode());

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));

          expect(first.hasListeners, true);

          final second = autoDispose(FocusNode());

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, second))));

          expect(first.hasListeners, false);
          expect(second.hasListeners, true);
        });

        testWidgets('dispose focus', (tester) async {
          final first = autoDispose(FocusNode());

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(null, first))));
          expect(first.hasListeners, true);

          await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));
          expect(first.hasListeners, false);
        });
      });
    }
  });

  group('lifted', () {
    testWidgets('text input interaction works', (tester) async {
      DateTime? value;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) => FDateField(
              key: key,
              control: .lifted(date: value, onChange: (v) => setState(() => value = v)),
            ),
          ),
        ),
      );

      await tester.enterText(find.byKey(key), '15/01/2025');
      await tester.pumpAndSettle();

      expect(value, DateTime.utc(2025, 1, 15));
    });

    testWidgets('calendar interaction works', (tester) async {
      DateTime? value;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) => FDateField(
              key: key,
              control: .lifted(date: value, onChange: (v) => setState(() => value = v)),
              calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15)),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(value, DateTime.utc(2025, 1, 15));
    });

    testWidgets('text input value does not change when onChange does not update state', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) => FDateField(
              key: key,
              control: .lifted(date: null, onChange: (v) => setState(() {})),
            ),
          ),
        ),
      );

      await tester.enterText(find.byKey(key), '15/01/2025');
      await tester.pumpAndSettle();

      expect(find.text('DD/MM/YYYY'), findsOneWidget);
    });

    testWidgets('calendar value does not change when onChange does not update state', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) => FDateField(
              key: key,
              control: .lifted(date: null, onChange: (v) => setState(() {})),
              calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15)),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      expect(find.text('DD/MM/YYYY'), findsOneWidget);
    });

    testWidgets('adjustment does not work when text is valid date', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) => FDateField(
              key: key,
              control: .lifted(date: DateTime.utc(2025, 1, 15), onChange: (_) {}),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();

      expect(find.text('15/01/2025'), findsOneWidget);
    });

    testWidgets('adjustment does not produce full date from placeholder', (tester) async {
      DateTime? value;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: StatefulBuilder(
            builder: (context, setState) => FDateField(
              key: key,
              control: .lifted(date: value, onChange: (_) {}),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();

      expect(value, null);
    });

    testWidgets('adjustment produces partial date from placeholder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            key: key,
            control: .lifted(date: null, onChange: (_) {}),
          ),
        ),
      );

      await tester.tapAt(tester.getTopLeft(find.byKey(key)));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.arrowUp);
      await tester.pumpAndSettle();

      expect(find.text('01/MM/YYYY'), findsOneWidget);
    });
  });

  group('managed', () {
    testWidgets('called when value changes', (tester) async {
      DateTime? changed;
      final controller = autoDispose(FDateFieldController());

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FDateField(
            control: .managed(controller: controller, onChange: (v) => changed = v),
          ),
        ),
      );

      controller.value = DateTime.utc(2025, 1, 15);
      await tester.pump();

      expect(changed, DateTime.utc(2025, 1, 15));
    });
  });
}

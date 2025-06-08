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
    testWidgets('old controller is not disposed', (tester) async {
      final first = autoDispose(FDateFieldController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField(
            key: key,
            controller: first,
            calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15)),
          ),
        ),
      );

      final second = autoDispose(FDateFieldController(vsync: tester));
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField(
            key: key,
            controller: second,
            calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15)),
          ),
        ),
      );

      expect(first.disposed, false);
      expect(second.disposed, false);
    });

    testWidgets('input only - change locale without changing controller', (tester) async {
      final controller = autoDispose(FDateFieldController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: LocaleScaffold(
            child: FDateField.input(controller: controller, key: key),
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

    testWidgets('calendar only - change locale without changing controller', (tester) async {
      final controller = autoDispose(FDateFieldController(vsync: tester));

      await tester.pumpWidget(
        TestScaffold.app(
          child: LocaleScaffold(child: FDateField.calendar(controller: controller)),
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
      ('calendar only', (controller, focus) => FDateField.calendar(controller: controller, focusNode: focus)),
      ('input only', (controller, focus) => FDateField.input(controller: controller, focusNode: focus)),
      ('both', (controller, focus) => FDateField(controller: controller, focusNode: focus)),
    ]) {
      group(name, () {
        testWidgets('update controller', (tester) async {
          final first = autoDispose(FDateFieldController(vsync: tester));

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(first, null))));

          expect(first.hasListeners, true);
          expect(first.disposed, false);

          final second = autoDispose(FDateFieldController(vsync: tester));

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(second, null))));

          expect(first.hasListeners, false);
          expect(first.calendar.hasListeners, false);
          expect(first.disposed, false);
          expect(second.hasListeners, true);
          expect(second.disposed, false);
        });

        testWidgets('dispose controller', (tester) async {
          final controller = autoDispose(FDateFieldController(vsync: tester));

          await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: field(controller, null))));

          expect(controller.hasListeners, true);
          expect(controller.disposed, false);

          await tester.pumpWidget(TestScaffold.app(child: const LocaleScaffold(child: SizedBox())));

          expect(controller.hasListeners, false);
          expect(controller.calendar.hasListeners, false);
          expect(controller.disposed, false);
        });

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

  for (final (name, constructor) in [
    ('default', (controller, initialDate) => FDateField(controller: controller, initialDate: initialDate)),
    ('calendar', (controller, initialDate) => FDateField.calendar(controller: controller, initialDate: initialDate)),
    ('input', (controller, initialDate) => FDateField.input(controller: controller, initialDate: initialDate)),
  ]) {
    test('$name - constructor cannot provide both controller and initialDate', () {
      expect(
        () => constructor(FDateFieldController(vsync: const TestVSync()), DateTime.utc(2023)),
        throwsAssertionError,
      );
    });
  }

  for (final (name, field) in [
    ('calendar only', (controller, onChange) => FDateField.calendar(controller: controller, onChange: onChange)),
    ('input only', (controller, onChange) => FDateField.input(controller: controller, onChange: onChange)),
    ('both', (controller, onChange) => FDateField(controller: controller, onChange: onChange)),
  ]) {
    group('$name - onChange', () {
      testWidgets('when controller changes but onChange callback is the same', (tester) async {
        int count = 0;
        void onChange(DateTime? _) => count++;

        final firstController = autoDispose(FDateFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(firstController, onChange)));

        firstController.value = DateTime.utc(2023);
        await tester.pump();

        expect(count, 1);

        final secondController = autoDispose(FDateFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(secondController, onChange)));

        firstController.value = DateTime.utc(2024);
        secondController.value = DateTime.utc(2025);
        await tester.pump();

        expect(count, 2);
      });

      testWidgets('when onChange callback changes but controller is the same', (tester) async {
        int first = 0;
        int second = 0;

        final controller = autoDispose(FDateFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(controller, (_) => first++)));

        controller.value = DateTime.utc(2023);
        await tester.pump();

        expect(first, 1);

        await tester.pumpWidget(TestScaffold.app(child: field(controller, (_) => second++)));

        controller.value = DateTime.utc(2024);
        await tester.pump();

        expect(first, 1);
        expect(second, 1);
      });

      testWidgets('when both controller and onChange callback change', (tester) async {
        int first = 0;
        int second = 0;

        final firstController = autoDispose(FDateFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(firstController, (_) => first++)));

        firstController.value = DateTime.utc(2023);
        await tester.pump();
        expect(first, 1);

        final secondController = autoDispose(FDateFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(secondController, (_) => second++)));

        secondController.value = DateTime.utc(2024);
        await tester.pump();

        firstController.value = DateTime.utc(2025);
        await tester.pump();

        expect(first, 1);
        expect(second, 1);
      });

      testWidgets('disposed when controller is external', (tester) async {
        int count = 0;

        final controller = autoDispose(FDateFieldController(vsync: tester));
        await tester.pumpWidget(TestScaffold.app(child: field(controller, (_) => count++)));

        controller.value = DateTime.utc(2023);
        await tester.pump();

        expect(count, 1);

        await tester.pumpWidget(TestScaffold.app(child: const SizedBox()));

        controller.value = DateTime.utc(2024);
        await tester.pump();

        expect(count, 1);
      });
    });
  }

  for (final (name, field) in [
    (
      'calendar',
      (controller, date, save) => FDateField.calendar(controller: controller, initialDate: date, onSaved: save),
    ),
    ('input', (controller, date, save) => FDateField.input(controller: controller, initialDate: date, onSaved: save)),
    ('both', (controller, date, save) => FDateField(controller: controller, initialDate: date, onSaved: save)),
  ]) {
    group('$name - form', () {
      testWidgets('set initial value using initialValue', (tester) async {
        final key = GlobalKey<FormState>();

        DateTime? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: Form(key: key, child: field(null, DateTime(2025, 1, 1, 10, 25), (v) => initial = v)),
          ),
        );

        expect(find.textContaining(RegExp('(1 Jan 2025)|(01/01/2025)')), findsOne);

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, DateTime.utc(2025));
      });

      testWidgets('controller provided', (tester) async {
        final key = GlobalKey<FormState>();

        DateTime? initial;
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: Form(
              key: key,
              child: field(
                autoDispose(FDateFieldController(vsync: tester, initialDate: DateTime(2025, 1, 1, 10, 25))),
                null,
                (v) => initial = v,
              ),
            ),
          ),
        );

        expect(find.textContaining(RegExp('(1 Jan 2025)|(01/01/2025)')), findsOne);

        key.currentState!.save();
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(initial, DateTime.utc(2025));
      });
    });
  }
}

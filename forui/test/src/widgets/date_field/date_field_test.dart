import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/forui.dart';
import '../../locale_scaffold.dart';
import '../../test_scaffold.dart';

void main() {
  const key = Key('field');

  setUpAll(initializeDateFormatting);

  for (final (index, (date, start, end, expected))
      in [
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
        child: FDateField(key: key, calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15))),
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

  testWidgets('old controller is not disposed', (tester) async {
    final first = FDateFieldController(vsync: tester);
    await tester.pumpWidget(
      TestScaffold.app(
        child: FDateField(key: key, calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15))),
      ),
    );

    final second = FDateFieldController(vsync: tester);
    await tester.pumpWidget(
      TestScaffold.app(
        child: FDateField(key: key, calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15))),
      ),
    );

    expect(first.disposed, false);
    expect(second.disposed, false);
  });

  testWidgets('input only - change locale without changing controller', (tester) async {
    final controller = FDateFieldController(vsync: tester);

    await tester.pumpWidget(TestScaffold.app(child: LocaleScaffold(child: FDateField.input(controller: controller,))));
    expect(find.text('MM/DD/YYYY'), findsOneWidget);
    expect(find.text('YYYY. MM. DD.'), findsNothing);

    await tester.tap(find.byType(FButton));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    
    await tester.enterText(find.byType(FTextField), '2025. 02. 27.');

    expect(find.text('MM/DD/YYYY'), findsNothing);
    expect(find.text('YYYY. MM. DD.'), findsOneWidget);
  });

  testWidgets('calendar only - change locale without changing controller', (tester) async {
    final controller = FDateFieldController(vsync: tester);

    await tester.pumpWidget(
      TestScaffold.app(child: LocaleScaffold(child: FDateField.calendar(controller: controller))),
    );
    expect(find.text('Pick a date'), findsOneWidget);
    expect(find.text('날짜 선택'), findsNothing);

    await tester.tap(find.byType(FButton));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('Pick a date'), findsNothing);
    expect(find.text('날짜 선택'), findsOneWidget);
  });
}

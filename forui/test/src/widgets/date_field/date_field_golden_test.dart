@Tags(['golden'])
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = Key('field');

  setUpAll(initializeDateFormatting);

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FDateField(style: TestScaffold.blueScreen.dateFieldStyle, key: key),
        ),
      ),
    );

    await tester.tap(find.byKey(key));

    await expectBlueScreen(find.byType(TestScaffold));
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with placeholder', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FDateField(key: key)));

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/placeholder.png'),
      );
    });

    testWidgets('${theme.name} with no icon', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FDateField(prefixBuilder: null)));

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/no-icon.png'),
      );
    });

    testWidgets('${theme.name} hr locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('hr'),
          alignment: Alignment.topCenter,
          child: FDateField(key: key, calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15))),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/hr-locale.png'),
      );
    });

    testWidgets('${theme.name} click shows calendar', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: Alignment.topCenter,
          child: FDateField(key: key, calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15))),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/show-calendar.png'),
      );
    });

    testWidgets('${theme.name} click shows calendar', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: Alignment.topCenter,
          child: FDateField(key: key, calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15))),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/calendar-updates-field.png'),
      );
    });

    testWidgets('${theme.name} field', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: Alignment.topCenter,
          child: FDateField(key: key, calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15))),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(key), '15/01/2025');
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/field-updates-calendar.png'),
      );
    });

    testWidgets('${theme.name} does not auto hide', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: Alignment.topCenter,
          child: FDateField(
            key: key,
            calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15), autoHide: false),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/no-auto-hide.png'),
      );
    });

    testWidgets('${theme.name} disabled', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FDateField(enabled: false, key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/disabled.png'),
      );
    });

    testWidgets('${theme.name} error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: Alignment.topCenter,
          theme: theme.data,
          child: FDateField(
            calendar: FDateFieldCalendarProperties(today: DateTime.utc(2025, 1, 15)),
            forceErrorText: 'Error',
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/error.png'),
      );
    });

    testWidgets('${theme.name} tap outside does not unfocus on Android/iOS', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, alignment: Alignment.topCenter, child: const FDateField(key: key)),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/mobile-focused.png'),
      );
    });

    testWidgets('${theme.name} tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, alignment: Alignment.topCenter, child: const FDateField(key: key)),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/field-calendar/desktop-unfocused.png'),
      );

      debugDefaultTargetPlatformOverride = null;
    });
  }
}

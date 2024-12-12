import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FLocalizations', () {
    testWidgets('no localization provided', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: Builder(
            builder: (context) {
              final localizations = FLocalizations.of(context);
              expect(localizations, null);
              return const Placeholder();
            },
          ),
        ),
      );
    });

    testWidgets('correct localization', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('de'),
          child: Builder(
            builder: (context) {
              final localizations = FLocalizations.of(context) ?? DefaultLocalizations();
              expect(localizations.localeName, 'de');
              return const Placeholder();
            },
          ),
        ),
      );

      await expectLater(tester.takeException(), null);
    });
  });

  group('FDateTimeLocalizations', () {
    group('firstDayOfWeek', () {
      test('default implementation', () => expect(DefaultLocalizations().firstDayOfWeek, 7));

      testWidgets('monday', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('de'),
            child: Builder(
              builder: (context) {
                final localizations = FLocalizations.of(context) ?? DefaultLocalizations();
                expect(localizations.firstDayOfWeek, 1);
                return const Placeholder();
              },
            ),
          ),
        );

        await expectLater(tester.takeException(), null);
      });

      testWidgets('sunday', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en'),
            child: Builder(
              builder: (context) {
                final localizations = FLocalizations.of(context) ?? DefaultLocalizations();
                expect(localizations.firstDayOfWeek, 7);
                return const Placeholder();
              },
            ),
          ),
        );

        await expectLater(tester.takeException(), null);
      });
    });

    group('shortWeekdays', () {
      test('default implementation', () {
        expect(DefaultLocalizations().shortWeekDays, ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']);
      });

      testWidgets('de locale', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('de'),
            child: Builder(
              builder: (context) {
                final localizations = FLocalizations.of(context) ?? DefaultLocalizations();
                expect(localizations.shortWeekDays, ['So.', 'Mo.', 'Di.', 'Mi.', 'Do.', 'Fr.', 'Sa.']);
                return const Placeholder();
              },
            ),
          ),
        );

        await expectLater(tester.takeException(), null);
      });
    });

    group('narrowWeekDays', () {
      test('default implementation', () {
        expect(DefaultLocalizations().narrowWeekDays, ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']);
      });

      testWidgets('de locale', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('de'),
            child: Builder(
              builder: (context) {
                final localizations = FLocalizations.of(context) ?? DefaultLocalizations();
                expect(localizations.narrowWeekDays, ['S', 'M', 'D', 'M', 'D', 'F', 'S']);
                return const Placeholder();
              },
            ),
          ),
        );

        await expectLater(tester.takeException(), null);
      });

      testWidgets('en_SG locale', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            locale: const Locale('en', 'SG'),
            child: Builder(
              builder: (context) {
                final localizations = FLocalizations.of(context) ?? DefaultLocalizations();
                expect(localizations.narrowWeekDays, ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']);
                return const Placeholder();
              },
            ),
          ),
        );

        await expectLater(tester.takeException(), null);
      });
    });
  });
}

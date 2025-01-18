import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../test_scaffold.dart';

void main() {
  const key = Key('picker');

  setUpAll(initializeDateFormatting);

  for (final (index, (locale, placeholder)) in const [
    (null, 'Pick a date'),
    (Locale('en', 'SG'), 'Pick a date'),
    (Locale('hr'), 'Odaberite datum'),
  ].indexed) {
    testWidgets('placeholder - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: locale,
          child: const FDatePicker.calendar(),
        ),
      );

      expect(find.text(placeholder), findsOneWidget);
    });
  }

  for (final (index, (locale, day, date)) in const [
    (null, '15', 'Jan 15, 2025'), // M/d/y
    (Locale('en', 'SG'), '15', '15 Jan 2025'), // dd/MM/y
    (Locale('hr'), '15.', '15. sij 2025.'),
  ].indexed) {
    testWidgets('formatted date - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: locale,
          child: FDatePicker.calendar(
            key: key,
            today: DateTime.utc(2025, 1, 15),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text(day));
      await tester.pumpAndSettle();

      expect(find.text(date), findsOneWidget);
    });
  }

  testWidgets('validator', (tester) async {
    final controller = FDatePickerController(
      vsync: const TestVSync(),
      validator: (date) {
        if (date == DateTime.utc(2025, 1, 16)) {
          return 'Custom error.';
        }

        return null;
      },
    );

    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDatePicker.calendar(
          controller: controller,
          key: key,
          today: DateTime.utc(2025, 1, 15),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('16'));
    await tester.pumpAndSettle();

    expect(find.text('16 Jan 2025'), findsNothing);
  });

  testWidgets('unselect', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDatePicker.calendar(
          key: key,
          today: DateTime.utc(2025, 1, 15),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('15 Jan 2025'), findsOneWidget);

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();

    expect(find.text('15 Jan 2025'), findsNothing);
  });

  testWidgets('custom format', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDatePicker.calendar(
          key: key,
          format: DateFormat.yMMMMd('en_SG'),
          today: DateTime.utc(2025, 1, 15),
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('15 January 2025'), findsOneWidget);
  });
}

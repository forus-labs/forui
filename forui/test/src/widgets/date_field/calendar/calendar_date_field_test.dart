import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  for (final (index, (locale, placeholder)) in const [
    (null, 'Pick a date'),
    (Locale('en', 'SG'), 'Pick a date'),
    (Locale('hr'), 'Odaberite datum'),
  ].indexed) {
    testWidgets('placeholder - $index', (tester) async {
      await tester.pumpWidget(TestScaffold.app(locale: locale, child: FDateField.calendar()));

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
          child: FDateField.calendar(key: key, today: DateTime.utc(2025, 1, 15)),
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
    final controller = autoDispose(
      FDateFieldController(
        vsync: const TestVSync(),
        validator: (date) {
          if (date == DateTime.utc(2025, 1, 16)) {
            return 'Custom error.';
          }

          return null;
        },
      ),
    );

    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField.calendar(controller: controller, key: key, today: DateTime.utc(2025, 1, 15)),
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
        child: FDateField.calendar(key: key, today: DateTime.utc(2025, 1, 15)),
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
        child: FDateField.calendar(key: key, format: DateFormat.yMMMMd('en_SG'), today: DateTime.utc(2025, 1, 15)),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.text('15 January 2025'), findsOneWidget);
  });

  testWidgets('holding & releasing on date field does not cause calendar to disappear & reappear', (tester) async {
    await tester.pumpWidget(TestScaffold.app(child: FDateField.calendar(key: key, today: DateTime.utc(2025, 1, 15))));

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    final gesture = await tester.startGesture(tester.getCenter(find.byKey(key)), kind: PointerDeviceKind.mouse);
    await tester.pumpAndSettle();

    expect(find.text('15'), findsOneWidget);

    await gesture.up();
    await tester.pumpAndSettle();

    expect(find.text('15'), findsNothing);
  });

  group('clearable', () {
    testWidgets('no clear icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, today: DateTime.utc(2025, 1, 15)),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.bySemanticsLabel('Clear'), findsNothing);
    });

    testWidgets('shows clear icon', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, today: DateTime.utc(2025, 1, 15), clearable: true),
        ),
      );
      expect(find.bySemanticsLabel('Clear'), findsNothing);

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('15'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.bySemanticsLabel('Clear'), findsOne);
    });
  });

  group('focus', () {
    testWidgets('tap on text-field should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('escape should refocus', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, true);
    });

    testWidgets('tap outside unfocuses on Android/iOS', (tester) async {
      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);
    });

    testWidgets('tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      final focus = autoDispose(FocusNode());

      await tester.pumpWidget(
        TestScaffold.app(
          child: FDateField.calendar(key: key, focusNode: focus),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(const Offset(500, 500));
      await tester.pumpAndSettle();

      expect(focus.hasFocus, false);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}

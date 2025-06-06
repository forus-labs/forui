import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  for (final (description, field) in [
    ('input only', FDateField.input(key: key)),
    ('input & calendar', FDateField(key: key)),
  ]) {
    for (final (index, (locale, placeholder)) in const [
      (null, 'MM/DD/YYYY'), // M/d/y
      (Locale('en', 'SG'), 'DD/MM/YYYY'), // dd/MM/y
      (Locale('hr'), 'DD. MM. YYYY.'),
      (Locale('bg'), 'DD.MM.YYYY г.'),
    ].indexed) {
      testWidgets('placeholder - $description - $index', (tester) async {
        await tester.pumpWidget(TestScaffold.app(locale: locale, child: field));

        expect(find.text(placeholder), findsOneWidget);
      });
    }

    testWidgets('arrow key adjustment - $description', (tester) async {
      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field));

      await tester.tapAt(tester.getTopLeft(find.byKey(key)));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pumpAndSettle();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();

      expect(find.text('01/12/2001'), findsOneWidget);
    });
  }

  group('validator', () {
    for (final (description, field) in [
      ('input only', FDateField.input(key: key)),
      ('input & calendar', FDateField(key: key)),
    ]) {
      testWidgets('placeholder - $description', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field));

        await tester.tapAt(tester.getTopLeft(find.byKey(key)));
        await tester.pumpAndSettle();

        await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
        await tester.pumpAndSettle();

        await tester.tapAt(tester.getBottomRight(find.byType(TestScaffold)));
        await tester.pumpAndSettle();

        expect(find.text('Invalid date.'), findsNothing);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('partial date - $description', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field));

        await tester.enterText(find.byKey(key), '28/MM/YYYY');
        await tester.pumpAndSettle();

        await tester.tapAt(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text('Invalid date.'), findsOneWidget);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('partial date - hr locale - $description', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('hr'), child: field));

        await tester.enterText(find.byKey(key), '28. MM. YYYY');
        await tester.pumpAndSettle();

        await tester.tapAt(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text('Nevažeći datum.'), findsOneWidget);

        debugDefaultTargetPlatformOverride = null;
      });

      testWidgets('full date - $description', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field));

        await tester.enterText(find.byKey(key), '14/01/2025');
        await tester.pumpAndSettle();

        await tester.tapAt(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text('Invalid date.'), findsNothing);

        debugDefaultTargetPlatformOverride = null;
      });
    }

    for (final (description, field) in [
      ('input only', (controller) => FDateField.input(key: key, controller: controller)),
      ('input & calendar', (controller) => FDateField(key: key, controller: controller)),
    ]) {
      testWidgets('custom invalid date - $description', (tester) async {
        debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

        final controller = autoDispose(FDateFieldController(
          vsync: const TestVSync(),
          validator: (date) {
            if (date == DateTime.utc(1984)) {
              return 'Custom error.';
            }

            return null;
          },
        ));

        await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field(controller)));

        await tester.enterText(find.byKey(key), '01/01/1984');
        await tester.pumpAndSettle();

        await tester.tapAt(Offset.zero);
        await tester.pumpAndSettle();

        expect(find.text('Custom error.'), findsOneWidget);

        debugDefaultTargetPlatformOverride = null;
      });
    }
  });

  for (final (description, field, expected) in [
    ('input only', FDateField.input(key: key), 0),
    ('input & calendar', FDateField(key: key), 0),
    ('input only, clearable', FDateField.input(key: key, clearable: true), 1),
    ('input & calendar, clearable', FDateField(key: key, clearable: true), 1),
  ]) {
    testWidgets(description, (tester) async {
      await tester.pumpWidget(TestScaffold.app(locale: const Locale('en', 'SG'), child: field));

      expect(find.bySemanticsLabel('Clear'), findsNothing);

      await tester.enterText(find.byKey(key), '14/01/2025');
      await tester.pumpAndSettle();

      expect(find.bySemanticsLabel('Clear'), findsExactly(expected));
    });
  }

  testWidgets('enter closes popover', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: FDateField(key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(find.byType(FCalendar), findsOne);

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    expect(find.byType(FCalendar), findsNothing);
  });
}

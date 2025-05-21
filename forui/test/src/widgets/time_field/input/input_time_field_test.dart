import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  for (final (index, (locale, placeholder))
      in const [
        (null, 'HH:MM --'),
        (Locale('en', 'SG'), 'HH:MM --'),
        (Locale('bg'), 'HH:MM ч.'),
        (Locale('fr', 'CA'), 'HH h MM'),
        (Locale('zh', 'HK'), '--HH:MM'),
      ].indexed) {
    testWidgets('placeholder - $index', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(locale: locale, child: const FTimeField(key: key)),
      );

      expect(find.text(placeholder), findsOneWidget);
    });
  }

  testWidgets('arrow key adjustment', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('en', 'SG'),
        child: const FTimeField(key: key),
      ),
    );

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

    expect(find.text('1:00 am'), findsOneWidget);
  });

  group('validator', () {
    testWidgets('placeholder', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: const FTimeField(key: key),
        ),
      );

      await tester.tapAt(tester.getTopLeft(find.byKey(key)));
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
      await tester.pumpAndSettle();

      await tester.tapAt(tester.getBottomRight(find.byType(TestScaffold)));

      expect(find.text('Invalid time.'), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('partial time', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: const FTimeField(key: key),
        ),
      );

      await tester.enterText(find.byKey(key), '12:MM --');
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('Invalid time.'), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('partial time - zh HK', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('zh', 'HK'),
          child: const FTimeField(key: key),
        ),
      );

      await tester.enterText(find.byKey(key), '--HH:12');
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('無效的時間。'), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('full time', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: const FTimeField(key: key),
        ),
      );

      await tester.enterText(find.byKey(key), '12:30 pm');
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('Invalid time.'), findsNothing);

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('custom invalid time', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      final controller = FTimeFieldController(
        vsync: const TestVSync(),
        validator: (time) {
          if (time == const FTime(12, 30)) {
            return 'Custom error.';
          }

          return null;
        },
      );

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en', 'SG'),
          child: FTimeField(controller: controller, key: key),
        ),
      );

      await tester.enterText(find.byKey(key), '12:30 pm');
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      expect(find.text('Custom error.'), findsOneWidget);

      debugDefaultTargetPlatformOverride = null;
    });
  });
}

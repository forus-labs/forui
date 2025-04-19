import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(TestScaffold.blue(child: FTimeField(style: TestScaffold.blueScreen.timeFieldStyle)));

    await expectBlueScreen(find.byType(TestScaffold));
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with placeholder', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FTimeField(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/input/placeholder.png'));
    });

    testWidgets('${theme.name} with no icon', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FTimeField(prefixBuilder: null)));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/input/no-icon.png'));
    });

    testWidgets('${theme.name} with builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTimeField(
            key: key,
            builder: (context, data, child) => ColoredBox(color: context.theme.colors.destructive, child: child!),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/input/builder.png'));
    });

    testWidgets('${theme.name} 24 hours', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'US'),
          child: const FTimeField(hour24: true, key: key),
        ),
      );

      await tester.enterText(find.byKey(key), '13:00');
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/input/hour-24.png'));
    });

    testWidgets('${theme.name} hr locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, locale: const Locale('hr'), child: const FTimeField()),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/input/hr-locale.png'));
    });

    testWidgets('${theme.name} disabled', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FTimeField(enabled: false, key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/input/disabled.png'));
    });

    testWidgets('${theme.name} error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, child: const FTimeField(forceErrorText: 'Error', key: key)),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/input/error.png'));
    });

    testWidgets('${theme.name} unsupported locale defaults to en_US', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, locale: const Locale('ar'), child: const FTimeField(key: key)),
      );

      await tester.enterText(find.byKey(key), '12:00 PM');
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('time-field/${theme.name}/input/unsupported-locale.png'),
      );
    });

    testWidgets('${theme.name} tap outside does not unfocus on Android/iOS', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FTimeField(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('time-field/${theme.name}/input/mobile-focused.png'),
      );
    });

    testWidgets('${theme.name} tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FTimeField(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('time-field/${theme.name}/input/desktop-unfocused.png'),
      );

      debugDefaultTargetPlatformOverride = null;
    });

    testWidgets('${theme.name} tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FTimeField(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('time-field/${theme.name}/input/desktop-unfocused.png'),
      );

      debugDefaultTargetPlatformOverride = null;
    });
  }
}

@Tags(['golden'])
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/field/placeholder.png'));
    });

    testWidgets('${theme.name} with no icon', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FTimeField(prefixBuilder: null)));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/field/no-icon.png'));
    });

    testWidgets('${theme.name} hr locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, locale: const Locale('hr'), child: const FTimeField()),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/field/hr-locale.png'));
    });

    testWidgets('${theme.name} disabled', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: const FTimeField(enabled: false, key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/field/disabled.png'));
    });

    testWidgets('${theme.name} error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, child: const FTimeField(forceErrorText: 'Error', key: key)),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/field/error.png'));
    });

    testWidgets('${theme.name} unsupported locale defaults to en_US', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, locale: const Locale('ar'), child: const FTimeField(key: key)),
      );

      await tester.enterText(find.byKey(key), '12:00 PM');
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('time-field/${theme.name}/field/unsupported-locale.png'),
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
        matchesGoldenFile('time-field/${theme.name}/field/mobile-focused.png'),
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
        matchesGoldenFile('time-field/${theme.name}/field/desktop-unfocused.png'),
      );

      debugDefaultTargetPlatformOverride = null;
    });
  }
}
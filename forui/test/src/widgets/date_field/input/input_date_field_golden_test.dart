import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(TestScaffold.blue(child: FDateField.input(style: TestScaffold.blueScreen.dateFieldStyle)));

    await expectBlueScreen(find.byType(TestScaffold));
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with placeholder', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FDateField.input(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/input/placeholder.png'));
    });

    testWidgets('${theme.name} with no icon', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: FDateField.input(prefixBuilder: null)));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/input/no-icon.png'));
    });

    testWidgets('${theme.name} with builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FDateField.input(
            key: key,
            builder: (context, data, child) => ColoredBox(color: context.theme.colors.destructive, child: child!),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/input/builder.png'));
    });

    testWidgets('${theme.name} hr locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, locale: const Locale('hr'), child: FDateField.input()),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/input/hr-locale.png'));
    });

    testWidgets('${theme.name} disabled', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FDateField.input(enabled: false, key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/input/disabled.png'));
    });

    testWidgets('${theme.name} error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, child: FDateField.input(forceErrorText: 'Error', key: key)),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('date-field/${theme.name}/input/error.png'));
    });

    testWidgets('${theme.name} unsupported locale defaults to en_US', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(theme: theme.data, locale: const Locale('ar'), child: FDateField.input(key: key)),
      );

      await tester.enterText(find.byKey(key), '1/14/2024');
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input/unsupported-locale.png'),
      );
    });

    testWidgets('${theme.name} tap outside does not unfocus on Android/iOS', (tester) async {
      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FDateField.input(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input/mobile-focused.png'),
      );
    });

    testWidgets('${theme.name} tap outside unfocuses on desktop', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      await tester.pumpWidget(TestScaffold.app(theme: theme.data, child: FDateField.input(key: key)));

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('date-field/${theme.name}/input/desktop-unfocused.png'),
      );

      debugDefaultTargetPlatformOverride = null;
    });
  }
}

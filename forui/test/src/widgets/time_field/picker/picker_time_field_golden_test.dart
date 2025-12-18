import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/picker/picker_wheel.dart';
import '../../../test_scaffold.dart';

void main() {
  const key = Key('field');

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FTimeField.picker(style: TestScaffold.blueScreen.timeFieldStyle, key: key),
        ),
      ),
    );

    await tester.tap(find.byKey(key));

    await expectBlueScreen();
  });

  group('lifted', () {
    testWidgets('programmatically changed value', (tester) async {
      FTime? value = const FTime(10, 30);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          alignment: .topCenter,
          child: StatefulBuilder(
            builder: (_, setState) => FTimeField.picker(
              key: key,
              control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      value = const FTime(14, 45);

      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          alignment: .topCenter,
          child: StatefulBuilder(
            builder: (_, setState) => FTimeField.picker(
              key: key,
              control: .lifted(time: value, onChange: (v) => setState(() => value = v)),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/picker/lifted-value-change.png'));
    });

    testWidgets('drag back', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          locale: const Locale('en'),
          alignment: .topCenter,
          child: FTimeField.picker(
            key: key,
            control: .lifted(time: const FTime(10, 30), onChange: (_) {}),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(BuilderWheel).first, const Offset(0, -50));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/picker/lifted-drag-back.png'));
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('${theme.name} with no icon', (tester) async {
      await tester.pumpWidget(TestScaffold(theme: theme.data, child: const FTimeField.picker(prefixBuilder: null)));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/picker/no-icon.png'));
    });

    testWidgets('${theme.name} with builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FTimeField.picker(
            key: key,
            builder: (context, _, _, child) => ColoredBox(color: context.theme.colors.destructive, child: child),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/picker/builder.png'));
    });

    testWidgets('${theme.name} zh locale', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('zh', 'HK'),
          alignment: .topCenter,
          child: const FTimeField.picker(key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('time-field/${theme.name}/picker/zh_HK-locale.png'),
      );
    });

    testWidgets('${theme.name} text', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          locale: const Locale('en', 'SG'),
          alignment: .topCenter,
          child: const FTimeField.picker(key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(BuilderWheel).first, const Offset(0, 50));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/picker/text.png'));
    });

    testWidgets('${theme.name} disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: const FTimeField.picker(enabled: false, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/picker/disabled.png'));
    });

    testWidgets('${theme.name} error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          alignment: .topCenter,
          theme: theme.data,
          child: const FTimeField.picker(forceErrorText: 'Error', key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('time-field/${theme.name}/picker/error.png'));
    });

    testWidgets('${theme.name} keyboard navigation', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: const FTimeField.picker(key: key),
        ),
      );

      await tester.sendKeyEvent(.tab);
      await tester.sendKeyEvent(.enter);
      await tester.pumpAndSettle();

      await tester.sendKeyEvent(.tab);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('time-field/${theme.name}/picker/keyboard-navigation.png'),
      );
    });
  }
}

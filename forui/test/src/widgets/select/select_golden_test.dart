import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  const key = ValueKey('select');

  group('blue screen', () {
    testWidgets('basic', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>(
            key: key,
            style: TestScaffold.blueScreen.selectStyle,
            children: [
              FSelectSection(label: const Text('A'), children: [FSelectItem.text('B')]),
              for (int i = 0; i < 10; i++) FSelectItem.text('$i'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('basic', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>(key: key, style: TestScaffold.blueScreen.selectStyle, children: const []),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('handles', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>(
            key: key,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            children: [
              FSelectSection(label: const Text('A'), children: [FSelectItem.text('B')]),
              for (int i = 0; i < 10; i++) FSelectItem.text('$i'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('search', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>.search(
            key: key,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            filter: (_) => [],
            contentBuilder: (_, _) => [for (int i = 0; i < 10; i++) FSelectItem.text('$i')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('search - waiting', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>.search(
            key: key,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              return [];
            },
            contentBuilder: (_, _) => [for (int i = 0; i < 10; i++) FSelectItem.text('$i')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });
  });

  for (final theme in TestScaffold.themes) {
    group('FSelect', () {
      testWidgets('auto-hide disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(key: key, autoHide: false, children: [FSelectItem.text('A'), FSelectItem.text('B')]),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await tester.tap(find.text('B'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/auto-hide-disabled.png'));
      });

      testWidgets('with builder', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              autoHide: false,
              children: [FSelectItem.text('A'), FSelectItem.text('B')],
              builder: (_, _, child) => DecoratedBox(decoration: const BoxDecoration(color: Colors.red), child: child),
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await tester.tap(find.text('B'));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/builder.png'));
      });
    });

    group('FSelect.new', () {
      testWidgets('empty', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: const FSelect<String>(key: key, children: []),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/empty.png'));
      });
    });
  }
}

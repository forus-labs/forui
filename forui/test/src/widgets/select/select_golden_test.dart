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
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            children: [
              FSelectSection(label: const Text('A'), children: [FSelectItem('B', 'B')]),
              for (int i = 0; i < 10; i++) FSelectItem('$i', '$i'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('basic - empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>(
            key: key,
            style: TestScaffold.blueScreen.selectStyle,
            format: (s) => s,
            children: const [],
          ),
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
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            children: [
              FSelectSection(label: const Text('A'), children: [FSelectItem('B', 'B')]),
              for (int i = 0; i < 10; i++) FSelectItem('$i', '$i'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('fromMap', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<int>.fromMap(const {'A': 1, 'B': 2}, key: key, style: TestScaffold.blueScreen.selectStyle),
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
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            filter: (_) => [],
            contentBuilder: (_, _) => [for (int i = 0; i < 10; i++) FSelectItem('$i', '$i')],
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
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              return [];
            },
            contentBuilder: (_, _) => [for (int i = 0; i < 10; i++) FSelectItem('$i', '$i')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen(find.byType(TestScaffold));
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('fromMap', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/from-map.png'));
    });

    testWidgets('auto-hide disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.fromMap(const {'A': 'A', 'B': 'B'}, key: key, autoHide: false),
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
            format: (s) => s,
            autoHide: false,
            children: [FSelectItem('A', 'A'), FSelectItem('B', 'B')],
            builder: (_, _, child) => DecoratedBox(
              decoration: const BoxDecoration(color: Colors.red),
              child: child,
            ),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.text('B'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/builder.png'));
    });

    testWidgets('empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.fromMap(const {}, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/empty.png'));
    });
  }
}

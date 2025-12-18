import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = {
  'A': 'A',
  'B': 'B',
  'C': 'C',
  'D': 'D',
  'E': 'E',
  'F': 'F',
  'G': 'G',
  'H': 'H',
  'I': 'I',
  'J': 'J',
  'K': 'K',
  'L': 'L',
  'M': 'M',
  'N': 'N',
  'O': 'O',
};

void main() {
  const key = ValueKey('select');

  group('blue screen', () {
    testWidgets('basic', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            children: [
              .richSection(
                label: const Text('A'),
                children: [const .item(title: Text('B'), value: 'B')],
              ),
              for (int i = 0; i < 10; i++) .item(title: Text('$i'), value: '$i'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('basic - empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>.rich(
            key: key,
            style: TestScaffold.blueScreen.selectStyle,
            format: (s) => s,
            children: const [],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('handles', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            children: [
              .richSection(
                label: const Text('A'),
                children: [const .item(title: Text('B'), value: 'B')],
              ),
              for (int i = 0; i < 10; i++) .item(title: Text('$i'), value: '$i'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('constructor', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<int>(items: const {'A': 1, 'B': 2}, key: key, style: TestScaffold.blueScreen.selectStyle),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('search', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>.searchBuilder(
            key: key,
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            filter: (_) => [],
            contentBuilder: (_, _, _) => [for (int i = 0; i < 10; i++) FSelectItem(title: Text('$i'), value: '$i')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('search - waiting', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<String>.searchBuilder(
            key: key,
            format: (s) => s,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              return [];
            },
            contentBuilder: (_, _, _) => [for (int i = 0; i < 10; i++) .item(title: Text('$i'), value: '$i')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('searchFromMap', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelect<int>.search(
            items: {for (int i = 0; i < 10; i++) '$i': i},
            key: key,
            style: TestScaffold.blueScreen.selectStyle,
            contentScrollHandles: true,
            filter: (_) => [],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('constructor', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FSelect<int>(items: const {'1': 1, '2': 2}, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/from-map.png'));
    });

    testWidgets('search', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FSelect<String>.search(
            items: letters,
            key: key,
            contentScrollHandles: true,
            filter: (query) => letters.keys.where((l) => l.startsWith(query)),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(FTextField).last, 'C');
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/search-from-map.png'));
    });

    testWidgets('auto-hide disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FSelect<String>(items: const {'A': 'A', 'B': 'B'}, key: key, autoHide: false),
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
          alignment: .topCenter,
          child: FSelect<String>.rich(
            key: key,
            format: (s) => s,
            autoHide: false,
            children: [
              .item(title: const Text('A'), value: 'A'),
              .item(title: const Text('B'), value: 'B'),
            ],
            builder: (_, _, _, child) => DecoratedBox(
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
          alignment: .topCenter,
          child: FSelect<String>(items: const {}, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/empty.png'));
    });

    testWidgets('enabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FSelect<String>(
            control: const .managed(initial: 'A'),
            items: letters,
            label: const Text('Letters'),
            description: const Text('Select your favorite letters'),
            clearable: true,
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/enabled.png'));
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FSelect(
            control: const .managed(initial: 'A'),
            items: letters,
            enabled: false,
            label: const Text('Letters'),
            description: const Text('Select your favorite letters'),
            clearable: true,
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/disabled.png'));
    });

    testWidgets('error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FSelect(
            control: const .managed(initial: 'A'),
            items: letters,
            label: const Text('Letters'),
            description: const Text('Select your favorite letters'),
            autovalidateMode: .always,
            validator: (value) => value == null ? null : 'Too many letters',
            clearable: true,
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/error.png'));
    });
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = {
  'Apple': 'Apple',
  'Banana': 'Banana',
  'Cherry': 'Cherry',
  'Dragonfruit': 'Dragonfruit',
  'Elderberry': 'Elderberry',
  'Fig': 'Fig',
  'Grape': 'Grape',
  'Honeydew': 'Honeydew',
  'Italian plum': 'Italian plum',
  'Jackfruit': 'Jackfruit',
  'Kiwi': 'Kiwi',
  'Lemon': 'Lemon',
  'Mango': 'Mango',
  'Nectarine': 'Nectarine',
  'Orange': 'Orange',
};

void main() {
  const key = ValueKey('select');

  group('blue screen', () {
    testWidgets('basic', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FMultiSelect<String>(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
            children: [
              FSelectSection(label: const Text('A'), children: [FSelectItem('B', 'B')]),
              for (int i = 0; i < 10; i++) FSelectItem('$i', '$i'),
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
          child: FMultiSelect<String>(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
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
          child: FMultiSelect<String>(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
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

      await expectBlueScreen();
    });

    testWidgets('fromMap', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FMultiSelect<int>.fromMap(
            const {'A': 1, 'B': 2},
            key: key,
            style: TestScaffold.blueScreen.multiSelectStyle,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('search', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FMultiSelect<String>.search(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
            contentScrollHandles: true,
            filter: (_) => [],
            contentBuilder: (_, _, _) => [for (int i = 0; i < 10; i++) FSelectItem('$i', '$i')],
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
          child: FMultiSelect<String>.search(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
            contentScrollHandles: true,
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              return [];
            },
            contentBuilder: (_, _, _) => [for (int i = 0; i < 10; i++) FSelectItem('$i', '$i')],
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
          child: FMultiSelect<int>.searchFromMap(
            {for (int i = 0; i < 10; i++) '$i': i},
            key: key,
            style: TestScaffold.blueScreen.multiSelectStyle,
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
    testWidgets('fromMap', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect.fromMap(letters, initialValue: const {'Apple', 'Banana'}, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/from-map.png'));
    });

    testWidgets('searchFromMap', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect<String>.searchFromMap(
            letters,
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/search-from-map.png'));
    });

    testWidgets('empty', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect<String>.fromMap(const {}, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/empty.png'));
    });

    testWidgets('clearable', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect.fromMap(letters, initialValue: const {'Apple', 'Banana'}, clearable: true, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/clearable.png'));
    });

    testWidgets('clearable & hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect.fromMap(letters, initialValue: const {'Apple', 'Banana'}, clearable: true, key: key),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      final gesture = await tester.createPointerGesture();
      await gesture.moveTo(tester.getCenter(find.byIcon(FIcons.x).last));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('multi-select/${theme.name}/clearable-hovered.png'),
      );
    });

    testWidgets('enabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect.fromMap(
            letters,
            initialValue: const {'Apple', 'Banana'},
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            clearable: true,
            key: key,
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/enabled.png'));
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect.fromMap(
            letters,
            initialValue: const {'Apple', 'Banana'},
            enabled: false,
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            clearable: true,
            key: key,
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/disabled.png'));
    });

    testWidgets('error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FMultiSelect.fromMap(
            letters,
            initialValue: const {'Apple', 'Banana'},
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            autovalidateMode: AutovalidateMode.always,
            validator: (value) => value.isNotEmpty ? 'Too many fruits' : null,
            clearable: true,
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/error.png'));
    });
  }

  testWidgets('hint in different locale', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        locale: const Locale('fr'),
        alignment: Alignment.topCenter,
        child: FMultiSelect<int>.fromMap(const {'1': 1, '2': 2}, key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/locale.png'));
  });

  testWidgets('automatically wraps tag', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FMultiSelect<String>.fromMap(
          letters,
          initialValue: const {
            'Apple',
            'Banana',
            'Cherry',
            'Dragonfruit',
            'Elderberry',
            'Fig',
            'Grape',
            'Honeydew',
            'Italian plum',
          },
          key: key,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/automatically-wraps-tag.png'));
  });

  testWidgets('automatically wraps', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FMultiSelect<String>.fromMap(
          letters,
          initialValue: const {'Apple', 'Banana', 'Cherry', 'Dragonfruit', 'Elderberry', 'Fig', 'Grape', 'Honeydew'},
          key: key,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/automatically-wraps.png'));
  });

  testWidgets('custom tag builder', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FMultiSelect<String>.fromMap(
          letters,
          initialValue: const {'Apple', 'Banana', 'Cherry'},
          tagBuilder: (context, _, _, _, child) => child,
          key: key,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/custom-tag.png'));
  });

  testWidgets('focus on most recently selected item', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FMultiSelect<String>.fromMap(letters, initialValue: const {'Grape', 'Apple', 'Banana'}, key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/most-recent-item.png'));
  });

  testWidgets('sort', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FMultiSelect<String>.fromMap(
          letters,
          sort: (a, b) => a.compareTo(b),
          initialValue: const {'Grape', 'Apple', 'Banana'},
          key: key,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/sort.png'));
  });
}

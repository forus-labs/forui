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
          child: FMultiSelect<String>.rich(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
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
          child: FMultiSelect<String>.rich(
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
          child: FMultiSelect<String>.rich(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
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

    testWidgets('fromMap', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FMultiSelect<int>(
            key: key,
            items: const {'A': 1, 'B': 2},
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
          child: FMultiSelect<String>.searchBuilder(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
            contentScrollHandles: true,
            filter: (_) => [],
            contentBuilder: (_, _, _) => [for (int i = 0; i < 10; i++) .item(title: Text('$i'), value: '$i')],
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
          child: FMultiSelect<String>.searchBuilder(
            key: key,
            format: Text.new,
            style: TestScaffold.blueScreen.multiSelectStyle,
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
          child: FMultiSelect<int>.search(
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
    testWidgets('constructor', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FMultiSelect(
            control: const .managed(initial: {'Apple', 'Banana'}),
            items: letters,
            key: key,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/${theme.name}/from-map.png'));
    });

    testWidgets('search', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: .topCenter,
          child: FMultiSelect<String>.search(
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
          alignment: .topCenter,
          child: FMultiSelect<String>(items: const {}, key: key),
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
          alignment: .topCenter,
          child: FMultiSelect(
            control: const .managed(initial: {'Apple', 'Banana'}),
            items: letters,
            clearable: true,
            key: key,
          ),
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
          alignment: .topCenter,
          child: FMultiSelect(
            control: const .managed(initial: {'Apple', 'Banana'}),
            items: letters,
            clearable: true,
            key: key,
          ),
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
          alignment: .topCenter,
          child: FMultiSelect(
            control: const .managed(initial: {'Apple', 'Banana'}),
            items: letters,
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
          alignment: .topCenter,
          child: FMultiSelect(
            control: const .managed(initial: {'Apple', 'Banana'}),
            items: letters,
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
          alignment: .topCenter,
          child: FMultiSelect(
            control: const .managed(initial: {'Apple', 'Banana'}),
            items: letters,
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            autovalidateMode: .always,
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
        alignment: .topCenter,
        child: FMultiSelect<int>(items: const {'1': 1, '2': 2}, key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/locale.png'));
  });

  testWidgets('show hint when no items selected', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: .topCenter,
        child: FMultiSelect<int>(items: const {'1': 1, '2': 2}, hint: const Text('hint'), keepHint: false, key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/hide-hint-unselected.png'));
  });

  testWidgets('hide hint when items selected', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: .topCenter,
        child: FMultiSelect<int>(items: const {'1': 1, '2': 2}, hint: const Text('hint'), keepHint: false, key: key),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('1'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/hide-hint-selected.png'));
  });

  testWidgets('automatically wraps tag', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: .topCenter,
        child: FMultiSelect<String>(
          control: const .managed(
            initial: {
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
          ),
          items: letters,
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
        alignment: .topCenter,
        child: FMultiSelect<String>(
          control: const .managed(
            initial: {'Apple', 'Banana', 'Cherry', 'Dragonfruit', 'Elderberry', 'Fig', 'Grape', 'Honeydew'},
          ),
          items: letters,
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
        alignment: .topCenter,
        child: FMultiSelect<String>(
          control: const .managed(initial: {'Apple', 'Banana', 'Cherry'}),
          items: letters,
          tagBuilder: (context, _, _, _, _, child) => child,
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
        alignment: .topCenter,
        child: FMultiSelect<String>(
          control: const .managed(initial: {'Grape', 'Apple', 'Banana'}),
          items: letters,
          key: key,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/most-recent-item.png'));
  });

  testWidgets('sort', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: .topCenter,
        child: FMultiSelect<String>(
          control: const .managed(initial: {'Grape', 'Apple', 'Banana'}),
          items: letters,
          sort: (a, b) => a.compareTo(b),
          key: key,
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('multi-select/sort.png'));
  });
}

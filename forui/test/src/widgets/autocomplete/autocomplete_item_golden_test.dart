import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

const fruits = [
  'Apple',
  'Banana',
  'Blueberry',
  'Grapes',
  'Lemon',
  'Mango',
  'Kiwi',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Plum',
  'Raspberry',
  'Strawberry',
  'Watermelon',
];

void main() {
  const key = ValueKey('autocomplete');

  group('blue screen', () {
    testWidgets('items & sections', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FAutocomplete.builder(
            key: key,
            style: TestScaffold.blueScreen.autocompleteStyle.copyWith(
              fieldStyle: (s) => s.copyWith(cursorColor: const Color(0xFF03A9F4)),
            ),
            filter: (query) => fruits.where((f) => f.toLowerCase().startsWith(query.toLowerCase())),
            contentBuilder: (context, query, items) => [
              FAutocompleteSection(
                label: const Text('Most popular'),
                items: const ['Apple', 'Kiwi'],
              ),
              FAutocompleteSection(label: const Text('Others'), items: const ['Banana', 'Blueberry']),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('sections', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FAutocomplete.builder(
            key: key,
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            initialText: 'App',
            filter: (query) => fruits.where((f) => f.toLowerCase().startsWith(query.toLowerCase())),
            contentBuilder: (context, query, items) => [
              FAutocompleteSection(
                label: const Text('Most popular'),
                items: const ['Apple', 'Kiwi'],
              ),
              FAutocompleteSection(label: const Text('Others'), items: const ['Banana', 'Blueberry']),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/item/${theme.name}/sections.png'));
    });

    testWidgets('dividers', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FAutocomplete.builder(
            key: key,
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            initialText: 'App',
            filter: (query) => fruits.where((f) => f.toLowerCase().startsWith(query.toLowerCase())),
            contentDivider: FItemDivider.full,
            contentBuilder: (context, query, items) => [
              FAutocompleteSection(
                divider: FItemDivider.indented,
                label: const Text('Most popular'),
                items: const ['Apple', 'Kiwi'],
              ),
              FAutocompleteSection(label: const Text('Others'), items: const ['Banana', 'Blueberry']),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/item/${theme.name}/dividers.png'));
    });

    testWidgets('hover effect', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FAutocomplete(key: key, items: const ['item'],)
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      final gesture = await tester.createPointerGesture();

      await gesture.moveTo(tester.getCenter(find.text('item')));
      await tester.pump();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/item/${theme.name}/hover.png'));
    });

    testWidgets('press effect on mobile', (tester) async {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      await tester.pumpWidget(
        TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FAutocomplete(key: key, items: const ['item'],)
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      final gesture = await tester.createPointerGesture(kind: PointerDeviceKind.touch);
      await gesture.down(tester.getCenter(find.text('item')));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/item/${theme.name}/press.png'));

      debugDefaultTargetPlatformOverride = null;
    });
  }
}

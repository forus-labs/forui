import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    testWidgets('default', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FAutocomplete(
            key: key,
            style: TestScaffold.blueScreen.autocompleteStyle.copyWith(
              fieldStyle: (s) => s.copyWith(cursorColor: const Color(0xFF03A9F4)),
            ),
            items: fruits,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('builder', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FAutocomplete.builder(
            key: key,
            style: TestScaffold.blueScreen.autocompleteStyle.copyWith(
              fieldStyle: (s) => s.copyWith(cursorColor: const Color(0xFF03A9F4)),
            ),
            filter: (_) => [],
            contentBuilder: (_, _, _) => [for (int i = 0; i < 10; i++) FAutocompleteItem(value: '$i')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pump(const Duration(seconds: 1));

      await expectBlueScreen();
    });

    testWidgets('waiting', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FAutocomplete.builder(
            key: key,
            style: TestScaffold.blueScreen.autocompleteStyle.copyWith(
              fieldStyle: (s) => s.copyWith(cursorColor: const Color(0xFF03A9F4)),
            ),
            filter: (_) async {
              await Future.delayed(const Duration(seconds: 1));
              return [];
            },
            contentBuilder: (_, _, _) => [for (int i = 0; i < 10; i++) FAutocompleteItem(value: '$i')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('no completion', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FAutocomplete.builder(
            key: key,
            style: TestScaffold.blueScreen.autocompleteStyle.copyWith(
              fieldStyle: (s) => s.copyWith(cursorColor: const Color(0xFF03A9F4)),
            ),
            filter: (_) => [],
            contentBuilder: (_, _, _) => [],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('completion', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FAutocomplete(
            key: key,
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            initialText: 'App',
            items: fruits,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/${theme.name}/completion.png'));
    });

    testWidgets('no completion', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FAutocomplete(key: key, initialText: 'Zebra', items: fruits),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/${theme.name}/no-completion.png'));
    });

    testWidgets('loading', (tester) async {
      final completer = Completer<void>();

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          child: FAutocomplete(
            key: key,
            initialText: 'App',
            items: fruits,
            filter: (query) async {
              await completer.future;
              return [];
            },
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pump(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/${theme.name}/loading.png'));
    });

    testWidgets('auto-hide enabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FAutocomplete(key: key, items: fruits),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(key), 'App');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/${theme.name}/auto-hide.png'));
    });

    testWidgets('auto-hide disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FAutocomplete(key: key, items: fruits, autoHide: false),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(key), 'App');
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apple'));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('autocomplete/${theme.name}/auto-hide-disabled.png'),
      );
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FAutocomplete(
            key: key,
            items: fruits,
            enabled: false,
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/${theme.name}/disabled.png'));
    });

    testWidgets('error', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FAutocomplete(
            key: key,
            label: const Text('Fruits'),
            description: const Text('Select your favorite fruits'),
            autovalidateMode: AutovalidateMode.always,
            validator: (value) => value == 'Apple' ? null : 'Only Apple is allowed',
            items: fruits,
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/${theme.name}/error.png'));
    });
  }

  testWidgets('initial suggestions', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FAutocomplete(key: key, hint: 'Type to search', items: fruits),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/initial-suggestions.png'));
  });

  testWidgets('hint does not conflict with completion', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FAutocomplete(key: key, hint: 'Type to search', initialText: 'App', items: fruits),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(key), '');
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/hint-no-completion.png'));
  });

  testWidgets('selecting item discards completion', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FAutocomplete(key: key, initialText: 'B', items: fruits),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Blueberry'));
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/select-discards-completion.png'));
  });

  testWidgets('selecting item then entering text causes popover to reappear', (tester) async {
    final focus = autoDispose(FocusNode());
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FAutocomplete(key: key, focusNode: focus, items: fruits),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Blueberry'));
    await tester.pumpAndSettle();

    expect(focus.hasFocus, true);

    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/select-enter-text.png'));
  });

  testWidgets('selecting item then moving selection does not cause popover to reappear', (tester) async {
    final focus = autoDispose(FocusNode());
    await tester.pumpWidget(
      TestScaffold.app(
        alignment: Alignment.topCenter,
        child: FAutocomplete(key: key, focusNode: focus, items: fruits),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Blueberry'));
    await tester.pumpAndSettle();

    expect(focus.hasFocus, true);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pumpAndSettle();

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('autocomplete/select-move-selection.png'));
  });
}

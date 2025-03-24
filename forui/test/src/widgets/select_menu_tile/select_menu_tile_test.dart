import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FMultiValueNotifier<int> controller;

  setUp(() => controller = FMultiValueNotifier.radio());

  group('FSelectMenuTile', () {
    testWidgets('tap on tile opens menu', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile(
            selectController: controller,
            prefixIcon: const Icon(FIcons.calendar),
            label: const Text('Label'),
            description: const Text('Description'),
            title: const Text('Repeat'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('None'),
            menu: [
              FSelectTile(title: const Text('Item 1'), value: 1),
              FSelectTile(title: const Text('Item 2'), value: 2),
            ],
          ),
        ),
      );

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsNothing);

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOne);
      expect(find.text('Item 2'), findsOne);
    });

    testWidgets('selecting item in menu does not close it', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile(
            selectController: controller,
            prefixIcon: const Icon(FIcons.calendar),
            label: const Text('Label'),
            description: const Text('Description'),
            title: const Text('Repeat'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('None'),
            menu: [
              FSelectTile(title: const Text('Item 1'), value: 1),
              FSelectTile(title: const Text('Item 2'), value: 2),
            ],
          ),
        ),
      );
      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOne);
      expect(find.text('Item 2'), findsOne);

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOne);
      expect(find.text('Item 2'), findsOne);
    });

    testWidgets('selecting item in menu closes it', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile(
            autoHide: true,
            selectController: controller,
            prefixIcon: const Icon(FIcons.calendar),
            label: const Text('Label'),
            description: const Text('Description'),
            title: const Text('Repeat'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('None'),
            menu: [
              FSelectTile(title: const Text('Item 1'), value: 1),
              FSelectTile(title: const Text('Item 2'), value: 2),
            ],
          ),
        ),
      );
      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsOne);
      expect(find.text('Item 2'), findsOne);

      await tester.tap(find.text('Item 1'));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsNothing);
    });

    testWidgets('callbacks called', (tester) async {
      var changes = 0;
      var selections = 0;
      (int, bool)? selection;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            autoHide: true,
            selectController: controller,
            title: const Text('Repeat'),
            onChange: (_) => changes++,
            onSelect: (value) {
              selections++;
              selection = value;
            },
            menu: [FSelectTile(title: const Text('1'), value: 1)],
          ),
        ),
      );
      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(changes, 1);
      expect(selections, 1);
      expect(selection, (1, true));
    });

    testWidgets('update widget', (tester) async {
      final controller = FMultiValueNotifier<int>();

      var firstChanges = 0;
      var firstSelections = 0;
      (int, bool)? firstSelection;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            autoHide: true,
            selectController: controller,
            title: const Text('Repeat'),
            onChange: (_) => firstChanges++,
            onSelect: (value) {
              firstSelections++;
              firstSelection = value;
            },
            menu: [FSelectTile(title: const Text('1'), value: 1)],
          ),
        ),
      );
      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(firstChanges, 1);
      expect(firstSelections, 1);
      expect(firstSelection, (1, true));

      var secondChanges = 0;
      var secondSelections = 0;
      (int, bool)? secondSelection;

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile<int>(
            autoHide: true,
            selectController: controller,
            title: const Text('Repeat'),
            onChange: (_) => secondChanges++,
            onSelect: (value) {
              secondSelections++;
              secondSelection = value;
            },
            menu: [FSelectTile(title: const Text('1'), value: 1)],
          ),
        ),
      );
      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1'));
      await tester.pumpAndSettle();

      expect(firstChanges, 1);
      expect(firstSelections, 1);
      expect(firstSelection, (1, true));

      expect(secondChanges, 1);
      expect(secondSelections, 1);
      expect(secondSelection, (1, false));
    });
  });

  tearDown(() => controller.dispose());
}

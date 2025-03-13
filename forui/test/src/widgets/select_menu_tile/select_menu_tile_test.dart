import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FSelectController<int> controller;

  setUp(() => controller = FSelectController.radio());

  group('FSelectMenuTile', () {
    testWidgets('tap on tile opens menu', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile(
            selectController: controller,
            prefixIcon: FIcon(FAssets.icons.calendar),
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
            prefixIcon: FIcon(FAssets.icons.calendar),
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
            prefixIcon: FIcon(FAssets.icons.calendar),
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
  });

  tearDown(() => controller.dispose());
}

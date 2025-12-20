import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSelectMenuTile', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectMenuTile(
              selectControl: const .managed(initial: {1}),
              style: TestScaffold.blueScreen.selectMenuTileStyle,
              prefix: const Icon(FIcons.bluetooth),
              label: const Text('Label'),
              description: const Text('Description'),
              title: const Text('Bluetooth'),
              subtitle: const Text('Fee, Fo, Fum'),
              details: const Text('Duobase (5G)'),
              menu: const [.tile(title: Text('Menu'), value: 1)],
            ),
          ),
        );

        await expectBlueScreen();
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectMenuTile(
              selectControl: const .managed(initial: {1}),
              enabled: false,
              style: TestScaffold.blueScreen.selectMenuTileStyle,
              prefix: const Icon(FIcons.bluetooth),
              label: const Text('Label'),
              description: const Text('Description'),
              title: const Text('Bluetooth'),
              subtitle: const Text('Fee, Fo, Fum'),
              details: const Text('Duobase (5G)'),
              menu: const [.tile(title: Text('Menu'), value: 1)],
            ),
          ),
        );

        await expectBlueScreen();
      });
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('enabled - hidden - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FSelectMenuTile(
              selectControl: const .managed(initial: {1}),
              prefix: const Icon(FIcons.calendar),
              label: const Text('Label'),
              description: const Text('Description'),
              title: const Text('Repeat'),
              subtitle: const Text('Fee, Fo, Fum'),
              details: const Text('None'),
              menu: const [
                .tile(title: Text('Item 1'), value: 1),
                .tile(title: Text('Item 2'), value: 2),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-menu-tile/enabled-hidden-${theme.name}.png'),
        );
      });

      testWidgets('enabled - shown - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FSelectMenuTile(
              selectControl: const .managedRadio(initial: 1),
              prefix: const Icon(FIcons.calendar),
              label: const Text('Label'),
              description: const Text('Description'),
              title: const Text('Repeat'),
              subtitle: const Text('Fee, Fo, Fum'),
              details: const Text('None'),
              menu: const [
                .tile(title: Text('Item 1'), value: 1),
                .tile(title: Text('Item 2'), value: 2),
              ],
            ),
          ),
        );

        await tester.tap(find.byType(FSelectMenuTile<int>));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-menu-tile/enabled-shown-${theme.name}.png'),
        );
      });

      testWidgets('${theme.name} scrollable', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FSelectMenuTile(
              selectControl: const .managed(initial: {1}),
              maxHeight: 150,
              title: const Text('Title'),
              menu: const [
                .tile(title: Text('Tile 1'), value: 1),
                .tile(title: Text('Tile 2'), value: 2),
                .tile(title: Text('Tile 3'), value: 3),
                .tile(title: Text('Tile 4'), value: 4),
                .tile(title: Text('Tile 5'), value: 4),
              ],
            ),
          ),
        );

        await tester.tap(find.byType(FSelectMenuTile<int>));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-menu-tile/${theme.name}/scrollable.png'),
        );
      });

      testWidgets('disabled - hidden - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FSelectMenuTile(
              selectControl: const .managed(initial: {1}),
              enabled: false,
              prefix: const Icon(FIcons.calendar),
              label: const Text('Label'),
              description: const Text('Description'),
              title: const Text('Repeat'),
              subtitle: const Text('Fee, Fo, Fum'),
              details: const Text('None'),
              menu: const [
                .tile(title: Text('Item 1'), value: 1),
                .tile(title: Text('Item 2'), value: 2),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-menu-tile/disabled-${theme.name}.png'));
      });

      testWidgets('error - hidden - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FSelectMenuTile(
              selectControl: const .managed(initial: {1}),
              prefix: const Icon(FIcons.calendar),
              label: const Text('Label'),
              description: const Text('Description'),
              forceErrorText: 'This should appear',
              title: const Text('Repeat'),
              subtitle: const Text('Fee, Fo, Fum'),
              details: const Text('None'),
              menu: const [
                .tile(title: Text('Item 1'), value: 1),
                .tile(title: Text('Item 2'), value: 2),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-menu-tile/error-${theme.name}.png'));
      });
    }
  });

  group('FSelectMenuTile.builder', () {
    testWidgets('lazily built', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile.builder(
            selectControl: const .managed(initial: {1}),
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 250,
            title: const Text('Title'),
            menuBuilder: (context, index) => .tile(title: Text('Tile $index'), value: index),
          ),
        ),
      );

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-menu-tile/builder/lazy.png'));
    });

    testWidgets('limited by count', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile.builder(
            selectControl: const .managed(initial: {1}),
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 500,
            count: 2,
            title: const Text('Title'),
            menuBuilder: (context, index) => .tile(title: Text('Tile $index'), value: index),
          ),
        ),
      );

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-menu-tile/builder/count-limited.png'));
    });

    testWidgets('limited by returning null', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile.builder(
            selectControl: const .managed(initial: {1}),
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 500,
            count: 24,
            title: const Text('Title'),
            menuBuilder: (context, index) => index < 2 ? .tile(title: Text('Tile $index'), value: index) : null,
          ),
        ),
      );

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-menu-tile/builder/null-limited.png'));
    });
  });

  group('FSelectMenuTile.fromMap', () {
    testWidgets('enabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSelectMenuTile.fromMap(
            const {'Item 1': 1, 'Item 2': 2},
            selectControl: const .managedRadio(initial: 1),
            prefix: const Icon(FIcons.calendar),
            label: const Text('Label'),
            description: const Text('Description'),
            title: const Text('Repeat'),
            subtitle: const Text('Fee, Fo, Fum'),
            details: const Text('None'),
          ),
        ),
      );

      await tester.tap(find.byType(FSelectMenuTile<int>));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-menu-tile/from-map.png'));
    });
  });
}

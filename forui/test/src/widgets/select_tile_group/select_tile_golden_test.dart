import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_tile_group/select_tile.dart';
import '../../test_scaffold.dart';

void main() {
  late FMultiValueNotifier<int> controller;

  setUp(() => controller = .radio(1));

  tearDown(() => controller.dispose());

  group('FTSelectTile', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                style: TestScaffold.blueScreen.tileGroupStyle.tileStyle,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectBlueScreen();
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                style: TestScaffold.blueScreen.tileStyle,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FSelectTile<int>)));
        await tester.pumpAndSettle();

        await expectBlueScreen();
      });

      testWidgets('selected', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileData(
              controller: controller,
              selected: true,
              child: FSelectTile(
                style: TestScaffold.blueScreen.tileStyle,
                enabled: false,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectBlueScreen();
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                style: TestScaffold.blueScreen.tileStyle,
                enabled: false,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectBlueScreen();
      });
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('enabled - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: const FSelectTile(
                title: Text('Bluetooth'),
                subtitle: Text('Fee, Fo, Fum'),
                details: Text('Duobase (5G)'),
                suffix: Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/tile/enabled-${theme.name}.png'),
        );
      });

      testWidgets('hovered - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: const FSelectTile(
                title: Text('Bluetooth'),
                subtitle: Text('Fee, Fo, Fum'),
                details: Text('Duobase (5G)'),
                suffix: Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        final gesture = await tester.createPointerGesture();

        await gesture.moveTo(tester.getCenter(find.byType(FSelectTile<int>)));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/tile/hovered-${theme.name}.png'),
        );
      });

      testWidgets('disabled - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: const FSelectTile(
                enabled: false,
                title: Text('Bluetooth'),
                subtitle: Text('Fee, Fo, Fum'),
                details: Text('Duobase (5G)'),
                suffix: Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/tile/disabled-${theme.name}.png'),
        );
      });

      testWidgets('checked - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectTileData(
              controller: controller,
              selected: true,
              child: const FSelectTile(
                title: Text('Bluetooth'),
                subtitle: Text('Fee, Fo, Fum'),
                details: Text('Duobase (5G)'),
                suffix: Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/tile/checked-${theme.name}.png'),
        );
      });

      testWidgets('suffix icon - checked - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectTileData(
              controller: controller,
              selected: true,
              child: const FSelectTile.suffix(
                prefix: Icon(FIcons.bluetooth),
                title: Text('Bluetooth'),
                subtitle: Text('Fee, Fo, Fum'),
                details: Text('Duobase (5G)'),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/tile/suffix-checked-${theme.name}.png'),
        );
      });

      testWidgets('suffix icon - unchecked - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: const FSelectTile.suffix(
                prefix: Icon(FIcons.bluetooth),
                title: Text('Bluetooth'),
                subtitle: Text('Fee, Fo, Fum'),
                details: Text('Duobase (5G)'),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/tile/suffix-unchecked-${theme.name}.png'),
        );
      });
    }
  });
}

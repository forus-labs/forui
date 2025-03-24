import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_tile_group/select_tile.dart';
import '../../test_scaffold.dart';

void main() {
  late FMultiValueNotifier<int> controller;

  setUp(() => controller = FMultiValueNotifier.radio(value: 1));

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
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                style: TestScaffold.blueScreen.tileGroupStyle.tileStyle,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FSelectTile<int>)));
        await tester.pumpAndSettle();

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('selected', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileData(
              controller: controller,
              selected: true,
              child: FSelectTile(
                style: TestScaffold.blueScreen.tileGroupStyle.tileStyle,
                enabled: false,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                style: TestScaffold.blueScreen.tileGroupStyle.tileStyle,
                enabled: false,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
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
              child: FSelectTile(
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
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
              child: FSelectTile(
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);

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
              child: FSelectTile(
                enabled: false,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
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
              child: FSelectTile(
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: const Icon(FIcons.chevronRight),
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
              child: FSelectTile.suffix(
                prefixIcon: const Icon(FIcons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
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
              child: FSelectTile.suffix(
                prefixIcon: const Icon(FIcons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
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

  tearDown(() => controller.dispose());
}

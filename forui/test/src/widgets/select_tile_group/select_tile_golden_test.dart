@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/select_tile_group/select_tile.dart';
import '../../test_scaffold.dart';

void main() {
  late FSelectGroupController<int> controller;

  setUp(() => controller = FRadioSelectGroupController(value: 1));

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
                suffixIcon: FIcon(FAssets.icons.chevronRight),
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
                suffixIcon: FIcon(FAssets.icons.chevronRight),
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
                suffixIcon: FIcon(FAssets.icons.chevronRight),
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
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      testWidgets('enabled - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/tile/enabled-$themeName.png'));
      });

      testWidgets('hovered - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/tile/hovered-$themeName.png'));
      });

      testWidgets('disabled - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile(
                enabled: false,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/tile/disabled-$themeName.png'));
      });

      testWidgets('checked - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectTileData(
              controller: controller,
              selected: true,
              child: FSelectTile(
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Forus Labs (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 1,
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/tile/checked-$themeName.png'));
      });

      testWidgets('suffix icon - checked - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectTileData(
              controller: controller,
              selected: true,
              child: FSelectTile.suffix(
                prefixIcon: FIcon(FAssets.icons.bluetooth),
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
          matchesGoldenFile('select-tile-group/tile/suffix-checked-$themeName.png'),
        );
      });

      testWidgets('suffix icon - unchecked - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectTileData(
              controller: controller,
              selected: false,
              child: FSelectTile.suffix(
                prefixIcon: FIcon(FAssets.icons.bluetooth),
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
          matchesGoldenFile('select-tile-group/tile/suffix-unchecked-$themeName.png'),
        );
      });
    }
  });

  tearDown(() => controller.dispose());
}

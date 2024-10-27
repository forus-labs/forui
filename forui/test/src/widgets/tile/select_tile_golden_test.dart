@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/tile/select_tile.dart';
import '../../test_scaffold.dart';

void main() {
  late FSelectGroupController<int> controller;

  setUp(() {
    controller = FRadioSelectGroupController(value: 1);
  });

  group('FTSelectTile', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FSelectTileData<int>(
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
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FSelectTile<int>)));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });

      testWidgets('selected', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      testWidgets('enabled - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/select-tile/select/enabled-$name.png'));
      });

      testWidgets('hovered - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileData<int>(
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
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FSelectTile<int>)));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/select-tile/select/hovered-$name.png'));
      });

      testWidgets('disabled - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/select-tile/select/disabled-$name.png'));
      });

      testWidgets('checked - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/select-tile/select/checked-$name.png'));
      });

      testWidgets('suffix icon - checked - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/select-tile/suffix-checked-$name.png'));
      });

      testWidgets('suffix icon - unchecked - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileData<int>(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/select-tile/suffix-unchecked-$name.png'));
      });
    }
  });

  tearDown(() {
    controller.dispose();
  });
}

@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FSelectGroupController<int> controller;

  setUp(() => controller = FRadioSelectGroupController(value: 1));

  group('FSelectTileGroup', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileGroup(
              controller: controller,
              style: TestScaffold.blueScreen.tileGroupStyle,
              label: const Text('Network'),
              children: [
                FSelectTile(
                  title: const Text('WiFi'),
                  details: const Text('Forus Labs (5G)'),
                  suffixIcon: FIcon(FAssets.icons.chevronRight),
                  value: 1,
                ),
                FSelectTile.suffix(
                  prefixIcon: FIcon(FAssets.icons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo, Fum'),
                  details: const Text('Forus Labs (5G)'),
                  value: 2,
                ),
              ],
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileGroup(
              controller: controller,
              style: TestScaffold.blueScreen.tileGroupStyle,
              label: const Text('Network'),
              children: [
                FSelectTile(
                  title: const Text('WiFi'),
                  details: const Text('Forus Labs (5G)'),
                  suffixIcon: FIcon(FAssets.icons.chevronRight),
                  value: 1,
                ),
                FSelectTile.suffix(
                  prefixIcon: FIcon(FAssets.icons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo, Fum'),
                  details: const Text('Forus Labs (5G)'),
                  value: 2,
                ),
              ],
            ),
          ),
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FSelectTile<int>).first));
        await tester.pumpAndSettle();

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSelectTileGroup(
              controller: controller,
              style: TestScaffold.blueScreen.tileGroupStyle,
              enabled: false,
              label: const Text('Network'),
              children: [
                FSelectTile(
                  title: const Text('WiFi'),
                  details: const Text('Forus Labs (5G)'),
                  suffixIcon: FIcon(FAssets.icons.chevronRight),
                  value: 1,
                ),
                FSelectTile.suffix(
                  prefixIcon: FIcon(FAssets.icons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo, Fum'),
                  details: const Text('Forus Labs (5G)'),
                  value: 2,
                ),
              ],
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final (themeName, theme) in TestScaffold.themes) {
      for (final divider in FTileDivider.values) {
        testWidgets('enabled - $themeName - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              child: FSelectTileGroup(
                controller: controller,
                label: const Text('Network'),
                description: const Text('Configure your network'),
                errorBuilder: (context, error) => Text(error),
                divider: divider,
                children: [
                  FSelectTile(
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    value: 1,
                  ),
                  FSelectTile(
                    title: const Text('Mail'),
                    details: const Text('42'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    value: 2,
                  ),
                  FSelectTile(
                    title: const Text('Bluetooth'),
                    subtitle: const Text('Fee, Fo'),
                    details: const Text('FL (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    value: 3,
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('select-tile-group/group/$themeName/enabled/$divider.png'),
          );
        });

        for (final (index, position) in ['top', 'bottom'].indexed) {
          testWidgets('hovered - $themeName - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FSelectTileGroup(
                    controller: controller,
                    label: const Text('Network'),
                    divider: divider,
                    children: [
                      FSelectTile(
                        title: const Text('WiFi'),
                        details: const Text('FL (5G)'),
                        value: 1,
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                      ),
                      FSelectTile(
                        title: const Text('Bluetooth'),
                        subtitle: const Text('Fee, Fo'),
                        details: const Text('FL (5G)'),
                        value: 2,
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                      ),
                    ],
                  ),
                ),
              ),
            );

            final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
            await gesture.addPointer(location: Offset.zero);
            addTearDown(gesture.removePointer);
            await tester.pump();

            await gesture.moveTo(tester.getCenter(find.byType(FSelectTile<int>).at(index)));
            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('select-tile-group/group/$themeName/hovered/$divider-$position.png'),
            );
          });

          testWidgets('disabled - $themeName - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme,
                child: FSelectTileGroup(
                  controller: controller,
                  label: const Text('Network'),
                  description: const Text('Configure your network'),
                  enabled: false,
                  divider: divider,
                  children: [
                    FSelectTile(
                      enabled: index == 0,
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      value: 1,
                    ),
                    FSelectTile(
                      enabled: index == 1,
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      value: 2,
                    ),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('select-tile-group/group/$themeName/disabled/$divider-$position.png'),
            );
          });
        }
      }

      testWidgets('error - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileGroup(
                controller: controller,
                label: const Text('Network'),
                description: const Text('Configure your network'),
                forceErrorText: 'This should appear',
                children: [
                  FSelectTile(
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    value: 1,
                  ),
                  FSelectTile(
                    title: const Text('Bluetooth'),
                    subtitle: const Text('Fee, Fo'),
                    details: const Text('FL (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    value: 2,
                  ),
                ],
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/group/$themeName/error.png'));
      });

      testWidgets('single tile - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: FSelectTileGroup(
              controller: controller,
              label: const Text('Network'),
              children: [
                FSelectTile(
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffixIcon: FIcon(FAssets.icons.chevronRight),
                  value: 1,
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/group/$themeName/single.png'));
      });

      testWidgets('empty tile group - $themeName', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileGroup(
                controller: controller,
                label: const Text('Network'),
                children: const [],
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/group/$themeName/empty.png'));
      });
    }

    testWidgets('tile style overrides group style', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            controller: controller,
            label: const Text('Network'),
            children: [
              FSelectTile(
                title: const Text('WiFi'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 1,
              ),
              FSelectTile(
                style: FThemes.blue.dark.tileGroupStyle.tileStyle,
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 2,
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/group/override-style.png'));
    });

    testWidgets('tile state overrides group state', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            controller: controller,
            label: const Text('Network'),
            enabled: false,
            children: [
              FSelectTile(
                enabled: true,
                title: const Text('WiFi'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 1,
              ),
              FSelectTile(
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo'),
                details: const Text('FL (5G)'),
                suffixIcon: FIcon(FAssets.icons.chevronRight),
                value: 2,
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select-tile-group/group/override-state.png'));
    });
  });

  tearDown(() => controller.dispose());
}

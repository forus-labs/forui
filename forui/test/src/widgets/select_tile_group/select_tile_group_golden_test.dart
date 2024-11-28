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
              groupController: controller,
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
              groupController: controller,
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
              groupController: controller,
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

    for (final theme in TestScaffold.themes) {
      for (final divider in FTileDivider.values) {
        testWidgets('enabled - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FSelectTileGroup(
                groupController: controller,
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
            matchesGoldenFile('select-tile-group/group/${theme.name}/enabled/$divider.png'),
          );
        });

        testWidgets('${theme.name} scrollable', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              child: FSelectTileGroup(
                groupController: controller,
                maxHeight: 150,
                divider: divider,
                children: [
                  FSelectTile(
                    title: const Text('Tile 1'),
                    value: 1,
                  ),
                  FSelectTile(
                    title: const Text('Tile 2'),
                    value: 2,
                  ),
                  FSelectTile(
                    title: const Text('Tile 3'),
                    value: 3,
                  ),
                  FSelectTile(
                    title: const Text('Tile 4'),
                    value: 4,
                  ),
                  FSelectTile(
                    title: const Text('Tile 5'),
                    value: 4,
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('select-tile-group/group/${theme.name}/scrollable/$divider.png'),
          );
        });

        for (final (index, position) in ['top', 'bottom'].indexed) {
          testWidgets('hovered - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FSelectTileGroup(
                    groupController: controller,
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
              matchesGoldenFile('select-tile-group/group/${theme.name}/hovered/$divider-$position.png'),
            );
          });

          testWidgets('disabled - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FSelectTileGroup(
                  groupController: controller,
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
              matchesGoldenFile('select-tile-group/group/${theme.name}/disabled/$divider-$position.png'),
            );
          });
        }
      }

      testWidgets('error - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileGroup(
                groupController: controller,
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

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/group/${theme.name}/error.png'),
        );
      });

      testWidgets('single tile - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSelectTileGroup(
              groupController: controller,
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

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/group/${theme.name}/single.png'),
        );
      });

      testWidgets('empty tile group - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FSelectTileGroup(
                groupController: controller,
                label: const Text('Network'),
                children: const [],
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select-tile-group/group/${theme.name}/empty.png'),
        );
      });
    }

    testWidgets('tile style overrides group style', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup(
            groupController: controller,
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
            groupController: controller,
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

  group('FTileGroup.builder', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSelectTileGroup.builder(
            groupController: controller,
            style: TestScaffold.blueScreen.tileGroupStyle,
            maxHeight: 200,
            count: 5,
            label: const Text('Network'),
            tileBuilder: (context, index) => FSelectTile(title: Text('Tile $index'), value: index + 1),
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('lazily built', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup.builder(
            groupController: controller,
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 250,
            tileBuilder: (context, index) => FSelectTile(title: Text('Tile $index'), value: index),
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select-tile-group/group/builder/lazy.png'),
      );
    });

    testWidgets('limited by count', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup.builder(
            groupController: controller,
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 500,
            count: 2,
            tileBuilder: (context, index) => FSelectTile(title: Text('Tile $index'), value: index),
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select-tile-group/group/builder/count-limited.png'),
      );
    });

    testWidgets('limited by returning null', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FSelectTileGroup.builder(
            groupController: controller,
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 500,
            count: 24,
            tileBuilder: (context, index) => index < 2 ? FSelectTile(title: Text('Tile $index'), value: index) : null,
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select-tile-group/group/builder/null-limited.png'),
      );
    });
  });

  tearDown(() => controller.dispose());
}

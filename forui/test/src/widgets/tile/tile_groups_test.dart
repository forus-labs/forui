@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTileGroups', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FTileGroups(
                style: TestScaffold.blueScreen.tileGroupStyle,
                children: [
                  FTileGroup(
                    label: const Text('Network'),
                    children: [
                      FTile(
                        prefixIcon: FIcon(FAssets.icons.wifi),
                        title: const Text('WiFi'),
                        details: const Text('Forus Labs (5G)'),
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                        onPress: () {},
                      ),
                    ],
                  ),
                ],
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
              child: FTileGroup(
                style: TestScaffold.blueScreen.tileGroupStyle,
                label: const Text('Network'),
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('Forus Labs (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    onPress: () {},
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.bluetooth),
                    title: const Text('Bluetooth'),
                    subtitle: const Text('Fee, Fo, Fum'),
                    details: const Text('Forus Labs (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    onPress: () {},
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

        await gesture.moveTo(tester.getCenter(find.byType(FTile).first));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FTileGroup(
                style: TestScaffold.blueScreen.tileGroupStyle,
                label: const Text('Network'),
                children: [
                  FTile(
                    enabled: false,
                    prefixIcon: FIcon(FAssets.icons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('Forus Labs (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    onPress: () {},
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.bluetooth),
                    title: const Text('Bluetooth'),
                    subtitle: const Text('Fee, Fo, Fum'),
                    details: const Text('Forus Labs (5G)'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), isBlueScreen);
      });
    });

    for (final (name, theme, background) in TestScaffold.themes) {
      for (final divider in FTileDivider.values) {
        testWidgets('enabled - $name - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme,
              background: background,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FTileGroups(
                  label: const Text('Network'),
                  divider: divider,
                  children: [
                    FTileGroup(
                      children: [
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.wifi),
                          title: const Text('WiFi'),
                          details: const Text('FL (5G)'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.mail),
                          title: const Text('Mail'),
                          details: const Text('42'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.bluetooth),
                          title: const Text('Bluetooth'),
                          subtitle: const Text('Fee, Fo'),
                          details: const Text('FL (5G)'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                      ],
                    ),
                    FTileGroup(
                      children: [
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.wifi),
                          title: const Text('WiFi'),
                          details: const Text('FL (5G)'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.bluetooth),
                          title: const Text('Bluetooth'),
                          subtitle: const Text('Fee, Fo'),
                          details: const Text('FL (5G)'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                      ],
                    ),
                    FTileGroup(
                      children: [
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.wifi),
                          title: const Text('WiFi'),
                          details: const Text('FL (5G)'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.bluetooth),
                          title: const Text('Bluetooth'),
                          subtitle: const Text('Fee, Fo'),
                          details: const Text('FL (5G)'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/groups/$name/$divider.png'));
        });
      }
    }

    testWidgets('single group', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroups(
              children: [
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/groups/single.png'));
    });

    testWidgets('empty tile group', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: FTileGroups(
              label: Text('Network'),
              children: [],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/groups/empty.png'));
    });

    testWidgets('ignore group label', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroups(
              label: const Text('Network'),
              children: [
                FTileGroup(
                  label: const Text('Nested'),
                  children: [
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/groups/ignore-group-label.png'));
    });

    testWidgets('ignore group labels', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroups(
              label: const Text('Network'),
              children: [
                FTileGroup(
                  label: const Text('Child 1'),
                  children: [
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  label: const Text('Child 2'),
                  children: [
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/groups/ignore-group-labels.png'));
    });

    testWidgets('styles are overridden', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroups(
              children: [
                FTileGroup(
                  style: FThemes.green.dark.tileGroupStyle,
                  children: [
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                    FTile(
                      style: FThemes.blue.dark.tileGroupStyle.tileStyle,
                      prefixIcon: FIcon(FAssets.icons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/groups/override.png'));
    });
  });
}

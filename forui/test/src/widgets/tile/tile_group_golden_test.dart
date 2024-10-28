@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FTileGroup', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
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
                child: FTileGroup(
                  label: const Text('Network'),
                  description: const Text('Description'),
                  error: const Text('This should not appear'),
                  divider: divider,
                  children: [
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.mail),
                      title: const Text('Mail'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                    FTile(
                      prefixIcon: FIcon(FAssets.icons.bluetooth),
                      title: const Text('Bluetooth'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/$name/enabled/$divider.png'));
        });

        for (final (index, position) in ['top', 'bottom'].indexed) {
          testWidgets('hovered - $name - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme,
                background: background,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FTileGroup(
                    label: const Text('Network'),
                    divider: divider,
                    children: [
                      FTile(
                        prefixIcon: FIcon(FAssets.icons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        prefixIcon: FIcon(FAssets.icons.bluetooth),
                        title: const Text('Bluetooth'),
                        subtitle: const Text('Fee, Fo'),
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

            await gesture.moveTo(tester.getCenter(find.byType(FTile).at(index)));
            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('tile/group/$name/hovered/$divider-$position.png'),
            );
          });

          testWidgets('disabled - $name - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme,
                background: background,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FTileGroup(
                    label: const Text('Network'),
                    description: const Text('Configure your network'),
                    error: const Text('This should not appear'),
                    state: FLabelState.disabled,
                    divider: divider,
                    children: [
                      FTile(
                        enabled: index == 0,
                        prefixIcon: FIcon(FAssets.icons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        enabled: index == 1,
                        prefixIcon: FIcon(FAssets.icons.bluetooth),
                        title: const Text('Bluetooth'),
                        subtitle: const Text('Fee, Fo'),
                        suffixIcon: FIcon(FAssets.icons.chevronRight),
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('tile/group/$name/disabled/$divider-$position.png'),
            );
          });
        }
      }

      testWidgets('error - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTileGroup(
                label: const Text('Network'),
                description: const Text('Description'),
                error: const Text('This should appear'),
                state: FLabelState.error,
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.wifi),
                    title: const Text('WiFi'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    onPress: () {},
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.bluetooth),
                    title: const Text('Bluetooth'),
                    subtitle: const Text('Fee, Fo'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/$name/error.png'));
      });

      testWidgets('single tile - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTileGroup(
                label: const Text('Network'),
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
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/$name/single.png'));
      });

      testWidgets('empty tile group - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: FTileGroup(
                label: Text('Network'),
                children: [],
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/$name/empty.png'));
      });
    }

    testWidgets('tile style overrides group style', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroup(
              label: const Text('Network'),
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
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/override-style.png'));
    });

    testWidgets('tile state overrides group state', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroup(
              label: const Text('Network'),
              state: FLabelState.disabled,
              children: [
                FTile(
                  enabled: true,
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
                ),
              ],
            ),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/override-state.png'));
    });
  });

  group('FTileGroup.merge', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FTileGroup.merge(
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
                child: FTileGroup.merge(
                  label: const Text('Network'),
                  description: const Text('Description'),
                  error: const Text('This should not appear'),
                  divider: divider,
                  children: [
                    FTileGroup(
                      children: [
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.wifi),
                          title: const Text('WiFi'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.mail),
                          title: const Text('Mail'),
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.bluetooth),
                          title: const Text('Bluetooth'),
                          subtitle: const Text('Fee, Fo'),
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
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.bluetooth),
                          title: const Text('Bluetooth'),
                          subtitle: const Text('Fee, Fo'),
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
                          suffixIcon: FIcon(FAssets.icons.chevronRight),
                          onPress: () {},
                        ),
                        FTile(
                          prefixIcon: FIcon(FAssets.icons.bluetooth),
                          title: const Text('Bluetooth'),
                          subtitle: const Text('Fee, Fo'),
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

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/$name/$divider.png'));
        });
      }

      testWidgets('disabled - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTileGroup.merge(
                label: const Text('Network'),
                description: const Text('Description'),
                error: const Text('This should not appear'),
                state: FLabelState.disabled,
                children: [
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: FIcon(FAssets.icons.wifi),
                        title: const Text('WiFi'),
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/$name/disabled.png'));
      });

      testWidgets('error - $name', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme,
            background: background,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTileGroup.merge(
                label: const Text('Network'),
                description: const Text('Description'),
                error: const Text('This should appear'),
                state: FLabelState.error,
                children: [
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: FIcon(FAssets.icons.wifi),
                        title: const Text('WiFi'),
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/$name/error.png'));
      });

      testWidgets('single group', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTileGroup.merge(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/single.png'));
      });

      testWidgets('empty tile group', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: FThemes.zinc.light,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FTileGroup.merge(
                label: const Text('Network'),
                children: [],
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/empty.png'));
      });
    }

    testWidgets('ignore group label', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroup.merge(
              label: const Text('Network'),
              children: [
                FTileGroup(
                  label: const Text('Nested'),
                  description: const Text('Configure your network'),
                  error: const Text('This should not appear'),
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/ignore-group-label.png'));
    });

    testWidgets('ignore group labels', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroup.merge(
              label: const Text('Network'),
              children: [
                FTileGroup(
                  label: const Text('Child 1'),
                  description: const Text('Configure your network'),
                  error: const Text('This should not appear'),
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
                  description: const Text('Configure your network'),
                  error: const Text('This should not appear'),
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/ignore-group-labels.png'));
    });

    testWidgets('group style overrides group style', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroup.merge(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/override-style.png'));
    });

    testWidgets('group state overrides group state', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: FThemes.zinc.light,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FTileGroup.merge(
              state: FLabelState.disabled,
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
                      prefixIcon: FIcon(FAssets.icons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      details: const Text('FL (5G)'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                    ),
                  ],
                ),
                FTileGroup(
                  state: FLabelState.enabled,
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/override-state.png'));
    });
  });
}

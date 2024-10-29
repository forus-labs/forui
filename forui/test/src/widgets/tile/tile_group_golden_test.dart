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
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
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
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FTile).first));
        await tester.pumpAndSettle();

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
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
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('tile/group/${theme.name}/enabled/$divider.png'),
          );
        });

        for (final (index, position) in ['top', 'bottom'].indexed) {
          testWidgets('hovered - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
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
            );

            final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
            await gesture.addPointer(location: Offset.zero);
            addTearDown(gesture.removePointer);
            await tester.pump();

            await gesture.moveTo(tester.getCenter(find.byType(FTile).at(index)));
            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('tile/group/${theme.name}/hovered/$divider-$position.png'),
            );
          });

          testWidgets('disabled - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
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
            );

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('tile/group/${theme.name}/disabled/$divider-$position.png'),
            );
          });
        }
      }

      testWidgets('error - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
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
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/${theme.name}/error.png'));
      });

      testWidgets('single tile - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
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
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/${theme.name}/single.png'));
      });

      testWidgets('empty tile group - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: const FTileGroup(
              label: Text('Network'),
              children: [],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/${theme.name}/empty.png'));
      });
    }

    testWidgets('tile style overrides group style', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
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
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/override-style.png'));
    });

    testWidgets('tile state overrides group state', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
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
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/override-state.png'));
    });
  });

  group('FTileGroup.merge', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
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
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('hovered', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
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
        );

        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(FTile).first));
        await tester.pumpAndSettle();

        await expectBlueScreen(find.byType(TestScaffold));
      });

      testWidgets('disabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
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
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('tile/group/merge/${theme.name}/$divider.png'),
          );
        });
      }

      testWidgets('disabled - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
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
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/${theme.name}/disabled.png'));
      });

      testWidgets('error - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
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
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/${theme.name}/error.png'));
      });

      testWidgets('single group', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
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
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/single.png'));
      });

      testWidgets('empty tile group', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            child: FTileGroup.merge(
              label: const Text('Network'),
              children: [],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/empty.png'));
      });
    }

    testWidgets('ignore group label', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
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
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/ignore-group-label.png'));
    });

    testWidgets('ignore group labels', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
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
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/ignore-group-labels.png'));
    });

    testWidgets('group style overrides group style', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
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
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/override-style.png'));
    });

    testWidgets('group state overrides group state', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
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
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/override-state.png'));
    });
  });
}

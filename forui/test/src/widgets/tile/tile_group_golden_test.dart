@Tags(['golden'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  late ScrollController controller;

  setUp(() {
    controller = ScrollController(initialScrollOffset: 30);
  });

  group('FTileGroup', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FTileGroup(
              style: TestScaffold.blueScreen.tileGroupStyle,
              label: const Text('Network'),
              description: const Text('Description'),
              error: const Text('This should not appear'),
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

        testWidgets('constrained height, last outside viewport - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FTileGroup(
                maxHeight: 100,
                label: const Text('Network'),
                description: const Text('Description'),
                divider: divider,
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.wifi),
                    title: const Text('WiFi'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.mail),
                    title: const Text('Mail'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.bluetooth),
                    title: const Text('Bluetooth'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('tile/group/${theme.name}/constrained-last/$divider.png'),
          );
        });

        testWidgets('constrained height, first outside viewport - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FTileGroup(
                scrollController: controller,
                maxHeight: 100,
                label: const Text('Network'),
                description: const Text('Description'),
                divider: divider,
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.wifi),
                    title: const Text('WiFi'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.mail),
                    title: const Text('Mail'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.bluetooth),
                    title: const Text('Bluetooth'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('tile/group/${theme.name}/constrained-first/$divider.png'),
          );
        });

        testWidgets('constrained height, clamped scrolling physics - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FTileGroup(
                scrollController: controller,
                maxHeight: 100,
                label: const Text('Network'),
                description: const Text('Description'),
                divider: divider,
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.wifi),
                    title: const Text('WiFi'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.mail),
                    title: const Text('Mail'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.bluetooth),
                    title: const Text('Bluetooth'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                ],
              ),
            ),
          );

          await tester.drag(find.byType(FTile).at(1), const Offset(0, 100));

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('tile/group/${theme.name}/clamped-physics/$divider.png'),
          );
        });

        // The rounded corners will not be colored properly. This is a known issue that's a side effect of clipping the
        // tiles. There isn't a known, straightforward solution to this. It is minor enough that it is acceptable.
        testWidgets('focused on non-first bottom viewport - ${theme.name} - $divider', (tester) async {
          final focusNode = FocusNode();

          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FTileGroup(
                scrollController: controller,
                maxHeight: 100,
                label: const Text('Network'),
                description: const Text('Description'),
                divider: divider,
                children: [
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.wifi),
                    title: const Text('WiFi'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    focusNode: focusNode,
                    prefixIcon: FIcon(FAssets.icons.mail),
                    title: const Text('Mail'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.bluetooth),
                    title: const Text('Bluetooth'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                  FTile(
                    prefixIcon: FIcon(FAssets.icons.arrowDown),
                    title: const Text('Last'),
                    suffixIcon: FIcon(FAssets.icons.chevronRight),
                  ),
                ],
              ),
            ),
          );

          focusNode.requestFocus();
          await tester.pumpAndSettle();

          focusNode.nextFocus();
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('tile/group/${theme.name}/focused-bottom-viewport/$divider.png'),
          );
        });

        testWidgets('RTL - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              textDirection: TextDirection.rtl,
              child: FTileGroup(
                label: const Text('Network'),
                description: const Text('Description'),
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
            matchesGoldenFile('tile/group/${theme.name}/rtl/$divider.png'),
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

          testWidgets('focused - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FTileGroup(
                  label: const Text('Network'),
                  divider: divider,
                  children: [
                    FTile(
                      autofocus: index == 0,
                      prefixIcon: FIcon(FAssets.icons.wifi),
                      title: const Text('WiFi'),
                      suffixIcon: FIcon(FAssets.icons.chevronRight),
                      onPress: () {},
                    ),
                    FTile(
                      autofocus: index == 1,
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
              matchesGoldenFile('tile/group/${theme.name}/focused/$divider-$position.png'),
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
                  enabled: false,
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
            child: FTileGroup(
              label: const Text('Network'),
              children: const [],
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
            enabled: false,
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

  group('FTileGroup.builder', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FTileGroup.builder(
            style: TestScaffold.blueScreen.tileGroupStyle,
            label: const Text('Network'),
            description: const Text('Description'),
            error: const Text('This should not appear'),
            maxHeight: 300,
            tileBuilder: (context, index) => FTile(title: Text('Tile $index')),
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    testWidgets('lazily built', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTileGroup.builder(
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 250,
            tileBuilder: (context, index) => FTile(title: Text('Tile $index')),
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('tile/group/builder/lazy.png'),
      );
    });

    testWidgets('limited by count', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTileGroup.builder(
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 500,
            count: 2,
            tileBuilder: (context, index) => FTile(title: Text('Tile $index')),
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('tile/group/builder/count-limited.png'),
      );
    });

    testWidgets('limited by returning null', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTileGroup.builder(
            label: const Text('Network'),
            description: const Text('Description'),
            maxHeight: 500,
            count: 24,
            tileBuilder: (context, index) => index < 2 ? FTile(title: Text('Tile $index')) : null,
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('tile/group/builder/null-limited.png'),
      );
    });
  });

  tearDown(() => controller.dispose());
}

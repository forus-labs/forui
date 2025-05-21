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
                      prefixIcon: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('Forus Labs (5G)'),
                      suffixIcon: const Icon(FIcons.chevronRight),
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
                  prefixIcon: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('Forus Labs (5G)'),
                  suffixIcon: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
                FTile(
                  prefixIcon: const Icon(FIcons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo, Fum'),
                  details: const Text('Forus Labs (5G)'),
                  suffixIcon: const Icon(FIcons.chevronRight),
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
                  prefixIcon: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('Forus Labs (5G)'),
                  suffixIcon: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
                FTile(
                  prefixIcon: const Icon(FIcons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo, Fum'),
                  details: const Text('Forus Labs (5G)'),
                  suffixIcon: const Icon(FIcons.chevronRight),
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
                divider: divider,
                children: [
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        prefixIcon: const Icon(FIcons.mail),
                        title: const Text('Mail'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        prefixIcon: const Icon(FIcons.bluetooth),
                        title: const Text('Bluetooth'),
                        subtitle: const Text('Fee, Fo'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                    ],
                  ),
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        prefixIcon: const Icon(FIcons.bluetooth),
                        title: const Text('Bluetooth'),
                        subtitle: const Text('Fee, Fo'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                    ],
                  ),
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        prefixIcon: const Icon(FIcons.bluetooth),
                        title: const Text('Bluetooth'),
                        subtitle: const Text('Fee, Fo'),
                        suffixIcon: const Icon(FIcons.chevronRight),
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

        testWidgets('constrained height, last outside viewport - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FTileGroup.merge(
                maxHeight: 100,
                label: const Text('Network'),
                description: const Text('Description'),
                divider: divider,
                children: [
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                    ],
                  ),
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.mail),
                        title: const Text('Mail'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                      ),
                      FTile(
                        prefixIcon: const Icon(FIcons.bluetooth),
                        title: const Text('Bluetooth'),
                        suffixIcon: const Icon(FIcons.chevronRight),
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
            matchesGoldenFile('tile/group/merge/${theme.name}/constrained-last/$divider.png'),
          );
        });

        testWidgets('constrained height, first outside viewport - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FTileGroup.merge(
                maxHeight: 100,
                label: const Text('Network'),
                description: const Text('Description'),
                divider: divider,
                children: [
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                    ],
                  ),
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.mail),
                        title: const Text('Mail'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                      ),
                      FTile(
                        prefixIcon: const Icon(FIcons.bluetooth),
                        title: const Text('Bluetooth'),
                        suffixIcon: const Icon(FIcons.chevronRight),
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
            matchesGoldenFile('tile/group/merge/${theme.name}/constrained-first/$divider.png'),
          );
        });

        // The rounded corners will not be colored properly. This is a known issue that's a side effect of clipping the
        // tiles. There isn't a known, straightforward solution to this. It is minor enough that it is acceptable.
        testWidgets('focused on non-first bottom viewport - ${theme.name} - $divider', (tester) async {
          final focusNode = autoDispose(FocusNode());

          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FTileGroup.merge(
                maxHeight: 100,
                label: const Text('Network'),
                description: const Text('Description'),
                divider: divider,
                children: [
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.wifi),
                        title: const Text('WiFi'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        focusNode: focusNode,
                        prefixIcon: const Icon(FIcons.mail),
                        title: const Text('Mail'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                      ),
                    ],
                  ),
                  FTileGroup(
                    children: [
                      FTile(
                        prefixIcon: const Icon(FIcons.bluetooth),
                        title: const Text('Bluetooth'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                        onPress: () {},
                      ),
                      FTile(
                        prefixIcon: const Icon(FIcons.arrowDown),
                        title: const Text('Last'),
                        suffixIcon: const Icon(FIcons.chevronRight),
                      ),
                    ],
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
            matchesGoldenFile('tile/group/merge/${theme.name}/focused-bottom-viewport/$divider.png'),
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
              enabled: false,
              children: [
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffixIcon: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffixIcon: const Icon(FIcons.chevronRight),
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
              children: [
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffixIcon: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(
                      prefixIcon: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffixIcon: const Icon(FIcons.chevronRight),
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
                      prefixIcon: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      details: const Text('FL (5G)'),
                      suffixIcon: const Icon(FIcons.chevronRight),
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
        await tester.pumpWidget(TestScaffold(child: FTileGroup.merge(label: const Text('Network'), children: [])));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/empty.png'));
      });
    }

    testWidgets('full dividers between groups and no dividers between tiles', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FTileGroup.merge(
            divider: FTileDivider.indented,
            children: [
              FTileGroup(
                divider: FTileDivider.none,
                children: [
                  FTile(
                    prefixIcon: const Icon(FIcons.list, color: Colors.transparent),
                    title: const Text('Personalization'),
                    suffixIcon: const Icon(FIcons.user),
                    onPress: () {},
                  ),
                  FTile(
                    prefixIcon: const Icon(FIcons.list, color: Colors.transparent),
                    title: const Text('Network'),
                    suffixIcon: const Icon(FIcons.appWindowMac),
                    onPress: () {},
                  ),
                ],
              ),
              FTileGroup(
                divider: FTileDivider.none,
                children: [
                  FTile(
                    prefixIcon: const Icon(FIcons.list, color: Colors.transparent),
                    title: const Text('List View'),
                    suffixIcon: const Icon(FIcons.list),
                    onPress: () {},
                  ),
                  FTile(
                    prefixIcon: const Icon(FIcons.list, color: Colors.transparent),
                    title: const Text('Grid View'),
                    suffixIcon: const Icon(FIcons.layoutGrid),
                    onPress: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/full-no-dividers.png'));
    });

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
                    prefixIcon: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
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
                    prefixIcon: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
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
                    prefixIcon: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
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
                    prefixIcon: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                  FTile(
                    style: FThemes.blue.dark.tileGroupStyle.tileStyle,
                    prefixIcon: const Icon(FIcons.bluetooth),
                    title: const Text('Bluetooth'),
                    subtitle: const Text('Fee, Fo'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
                  ),
                ],
              ),
              FTileGroup(
                children: [
                  FTile(
                    prefixIcon: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
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
            enabled: false,
            children: [
              FTileGroup(
                children: [
                  FTile(
                    prefixIcon: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                  FTile(
                    prefixIcon: const Icon(FIcons.bluetooth),
                    title: const Text('Bluetooth'),
                    subtitle: const Text('Fee, Fo'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
                  ),
                ],
              ),
              FTileGroup(
                enabled: true,
                children: [
                  FTile(
                    prefixIcon: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffixIcon: const Icon(FIcons.chevronRight),
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

  tearDown(() => controller.dispose());
}

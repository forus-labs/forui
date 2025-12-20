import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late ScrollController controller;

  setUp(() {
    controller = ScrollController(initialScrollOffset: 30);
  });

  tearDown(() => controller.dispose());

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
                  .tile(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('Duobase (5G)'),
                    suffix: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });

    testWidgets('hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FTileGroup(
            style: TestScaffold.blueScreen.tileGroupStyle,
            label: const Text('Network'),
            children: [
              .tile(
                prefix: const Icon(FIcons.wifi),
                title: const Text('WiFi'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
              .tile(
                prefix: const Icon(FIcons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
            ],
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(FTile).first));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FTileGroup(
            style: TestScaffold.blueScreen.tileGroupStyle,
            label: const Text('Network'),
            children: [
              .tile(
                enabled: false,
                prefix: const Icon(FIcons.wifi),
                title: const Text('WiFi'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
              .tile(
                prefix: const Icon(FIcons.bluetooth),
                title: const Text('Bluetooth'),
                subtitle: const Text('Fee, Fo, Fum'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    for (final divider in FItemDivider.values) {
      testWidgets('enabled - ${theme.name} - $divider', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FTileGroup.merge(
              label: const Text('Network'),
              description: const Text('Description'),
              divider: divider,
              children: [
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    .tile(
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    .tile(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    .tile(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    .tile(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/${theme.name}/$divider.png'));
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
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                    ),
                    .tile(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      suffix: const Icon(FIcons.chevronRight),
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
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                    ),
                    .tile(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      suffix: const Icon(FIcons.chevronRight),
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
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    .tile(
                      focusNode: focusNode,
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                .group(
                  children: [
                    .tile(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    .tile(
                      prefix: const Icon(FIcons.arrowDown),
                      title: const Text('Last'),
                      suffix: const Icon(FIcons.chevronRight),
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
              .group(
                children: [
                  .tile(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
              .group(
                children: [
                  .tile(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
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
              .group(
                children: [
                  .tile(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
              .group(
                children: [
                  .tile(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
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
              .group(
                children: [
                  .tile(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    details: const Text('FL (5G)'),
                    suffix: const Icon(FIcons.chevronRight),
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
          child: FTileGroup.merge(label: const Text('Network'), children: const []),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tile/group/merge/empty.png'));
    });
  }

  testWidgets('full dividers between groups and no dividers between tiles', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FTileGroup.merge(
          divider: .indented,
          children: [
            .group(
              divider: .none,
              children: [
                .tile(
                  prefix: const Icon(FIcons.list, color: Colors.transparent),
                  title: const Text('Personalization'),
                  suffix: const Icon(FIcons.user),
                  onPress: () {},
                ),
                .tile(
                  prefix: const Icon(FIcons.list, color: Colors.transparent),
                  title: const Text('Network'),
                  suffix: const Icon(FIcons.appWindowMac),
                  onPress: () {},
                ),
              ],
            ),
            .group(
              divider: .none,
              children: [
                .tile(
                  prefix: const Icon(FIcons.list, color: Colors.transparent),
                  title: const Text('List View'),
                  suffix: const Icon(FIcons.list),
                  onPress: () {},
                ),
                .tile(
                  prefix: const Icon(FIcons.list, color: Colors.transparent),
                  title: const Text('Grid View'),
                  suffix: const Icon(FIcons.layoutGrid),
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
            .group(
              label: const Text('Nested'),
              description: const Text('Configure your network'),
              error: const Text('This should not appear'),
              children: [
                .tile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
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
            .group(
              label: const Text('Child 1'),
              description: const Text('Configure your network'),
              error: const Text('This should not appear'),
              children: [
                .tile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
              ],
            ),
            .group(
              label: const Text('Child 2'),
              description: const Text('Configure your network'),
              error: const Text('This should not appear'),
              children: [
                .tile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
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
            .group(
              style: FThemes.green.dark.tileGroupStyle,
              children: [
                .tile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
                .tile(
                  style: FThemes.blue.dark.tileGroupStyle.tileStyle,
                  prefix: const Icon(FIcons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                ),
              ],
            ),
            .group(
              children: [
                .tile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
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
            .group(
              children: [
                .tile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
                .tile(
                  prefix: const Icon(FIcons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                ),
              ],
            ),
            .group(
              enabled: true,
              children: [
                .tile(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
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
}

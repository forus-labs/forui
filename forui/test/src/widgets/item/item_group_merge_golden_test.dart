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
          child: FItemGroup.merge(
            style: TestScaffold.blueScreen.itemGroupStyle,
            children: [
              FItemGroup(
                children: [
                  FItem(
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
          child: FItemGroup(
            style: TestScaffold.blueScreen.itemGroupStyle,
            children: [
              FItem(
                prefix: const Icon(FIcons.wifi),
                title: const Text('WiFi'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
              FItem(
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

      await gesture.moveTo(tester.getCenter(find.byType(FItem).first));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FItemGroup(
            style: TestScaffold.blueScreen.itemGroupStyle,
            children: [
              FItem(
                enabled: false,
                prefix: const Icon(FIcons.wifi),
                title: const Text('WiFi'),
                details: const Text('Duobase (5G)'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () {},
              ),
              FItem(
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
            child: FItemGroup.merge(
              divider: divider,
              children: [
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/merge/${theme.name}/$divider.png'));
      });

      testWidgets('constrained height, last outside viewport - ${theme.name} - $divider', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FItemGroup.merge(
              maxHeight: 120,
              divider: divider,
              children: [
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                    ),
                    FItem(
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
          matchesGoldenFile('item/group/merge/${theme.name}/constrained-last/$divider.png'),
        );
      });

      testWidgets('constrained height, first outside viewport - ${theme.name} - $divider', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FItemGroup.merge(
              maxHeight: 120,
              divider: divider,
              children: [
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                    ),
                    FItem(
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
          matchesGoldenFile('item/group/merge/${theme.name}/constrained-first/$divider.png'),
        );
      });

      testWidgets('focused on non-first bottom viewport - ${theme.name} - $divider', (tester) async {
        final focusNode = autoDispose(FocusNode());

        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FItemGroup.merge(
              maxHeight: 100,
              divider: divider,
              children: [
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
                      focusNode: focusNode,
                      prefix: const Icon(FIcons.mail),
                      title: const Text('Mail'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
                FItemGroup(
                  children: [
                    FItem(
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
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
          matchesGoldenFile('item/group/merge/${theme.name}/focused-bottom-viewport/$divider.png'),
        );
      });
    }

    testWidgets('disabled - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FItemGroup.merge(
            enabled: false,
            children: [
              FItemGroup(
                children: [
                  FItem(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
              FItemGroup(
                children: [
                  FItem(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/merge/${theme.name}/disabled.png'));
    });

    testWidgets('single group', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItemGroup.merge(
            children: [
              FItemGroup(
                children: [
                  FItem(
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

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/merge/single.png'));
    });

    testWidgets('empty item group', (tester) async {
      await tester.pumpWidget(TestScaffold(child: FItemGroup.merge(children: const [])));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/merge/empty.png'));
    });
  }

  testWidgets('full dividers between groups and indented dividers between items', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FItemGroup.merge(
          children: [
            FItemGroup(
              divider: .indented,
              children: [
                FItem(
                  prefix: const Icon(FIcons.list, color: Colors.transparent),
                  title: const Text('Personalization'),
                  suffix: const Icon(FIcons.user),
                  onPress: () {},
                ),
                FItem(
                  prefix: const Icon(FIcons.list, color: Colors.transparent),
                  title: const Text('Network'),
                  suffix: const Icon(FIcons.appWindowMac),
                  onPress: () {},
                ),
              ],
            ),
            FItemGroup(
              divider: .indented,
              children: [
                FItem(
                  prefix: const Icon(FIcons.list, color: Colors.transparent),
                  title: const Text('List View'),
                  suffix: const Icon(FIcons.list),
                  onPress: () {},
                ),
                FItem(
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

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/merge/full-indented-dividers.png'));
  });

  testWidgets('group style overrides group style', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FItemGroup.merge(
          children: [
            FItemGroup(
              style: FThemes.green.dark.itemGroupStyle,
              children: [
                FItem(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
                FItem(
                  style: FThemes.blue.dark.itemGroupStyle.itemStyle,
                  prefix: const Icon(FIcons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                ),
              ],
            ),
            FItemGroup(
              children: [
                FItem(
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

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/merge/override-style.png'));
  });

  testWidgets('group state overrides group state', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FItemGroup.merge(
          enabled: false,
          children: [
            FItemGroup(
              children: [
                FItem(
                  prefix: const Icon(FIcons.wifi),
                  title: const Text('WiFi'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                  onPress: () {},
                ),
                FItem(
                  prefix: const Icon(FIcons.bluetooth),
                  title: const Text('Bluetooth'),
                  subtitle: const Text('Fee, Fo'),
                  details: const Text('FL (5G)'),
                  suffix: const Icon(FIcons.chevronRight),
                ),
              ],
            ),
            FItemGroup(
              enabled: true,
              children: [
                FItem(
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

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/merge/override-state.png'));
  });
}

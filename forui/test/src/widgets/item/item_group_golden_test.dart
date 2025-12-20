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

  group('FItemGroup', () {
    group('blue screen', () {
      testWidgets('enabled', (tester) async {
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
              child: FItemGroup(
                divider: divider,
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
                    suffix: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('item/group/${theme.name}/enabled/$divider.png'),
          );
        });

        testWidgets('constrained height, last outside viewport - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FItemGroup(
                maxHeight: 120,
                divider: divider,
                children: [
                  FItem(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
                  ),
                  FItem(
                    prefix: const Icon(FIcons.mail),
                    title: const Text('Mail'),
                    suffix: const Icon(FIcons.chevronRight),
                  ),
                  FItem(
                    prefix: const Icon(FIcons.bluetooth),
                    title: const Text('Bluetooth'),
                    suffix: const Icon(FIcons.chevronRight),
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('item/group/${theme.name}/constrained-last/$divider.png'),
          );
        });

        testWidgets('constrained height, first outside viewport - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FItemGroup(
                scrollController: controller,
                maxHeight: 120,
                divider: divider,
                children: [
                  FItem(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
                  ),
                  FItem(
                    prefix: const Icon(FIcons.mail),
                    title: const Text('Mail'),
                    suffix: const Icon(FIcons.chevronRight),
                  ),
                  FItem(
                    prefix: const Icon(FIcons.bluetooth),
                    title: const Text('Bluetooth'),
                    suffix: const Icon(FIcons.chevronRight),
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('item/group/${theme.name}/constrained-first/$divider.png'),
          );
        });

        testWidgets('hover', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              child: FItemGroup(
                divider: divider,
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

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('item/group/${theme.name}/hover/$divider.png'),
          );
        });

        testWidgets('focused on non-first bottom viewport - ${theme.name} - $divider', (tester) async {
          final focusNode = autoDispose(FocusNode());

          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FItemGroup(
                scrollController: controller,
                maxHeight: 100,
                divider: divider,
                children: [
                  FItem(
                    prefix: const Icon(FIcons.wifi),
                    title: const Text('WiFi'),
                    suffix: const Icon(FIcons.chevronRight),
                  ),
                  FItem(
                    focusNode: focusNode,
                    prefix: const Icon(FIcons.mail),
                    title: const Text('Mail'),
                    suffix: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
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
            ),
          );

          focusNode.requestFocus();
          await tester.pumpAndSettle();

          focusNode.nextFocus();
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('item/group/${theme.name}/focused-bottom-viewport/$divider.png'),
          );
        });

        testWidgets('RTL - ${theme.name} - $divider', (tester) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              textDirection: TextDirection.rtl,
              child: FItemGroup(
                divider: divider,
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
                    suffix: const Icon(FIcons.chevronRight),
                    onPress: () {},
                  ),
                ],
              ),
            ),
          );

          await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/${theme.name}/rtl/$divider.png'));
        });

        for (final (index, position) in ['top', 'bottom'].indexed) {
          testWidgets('hovered - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FItemGroup(
                  divider: divider,
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
              ),
            );

            final gesture = await tester.createPointerGesture();
            await tester.pump();

            await gesture.moveTo(tester.getCenter(find.byType(FItem).at(index)));
            await tester.pumpAndSettle();

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('item/group/${theme.name}/hovered/$divider-$position.png'),
            );
          });

          testWidgets('focused - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FItemGroup(
                  divider: divider,
                  children: [
                    FItem(
                      autofocus: index == 0,
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
                      autofocus: index == 1,
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('item/group/${theme.name}/focused/$divider-$position.png'),
            );
          });

          testWidgets('disabled - ${theme.name} - $divider - $position', (tester) async {
            await tester.pumpWidget(
              TestScaffold(
                theme: theme.data,
                child: FItemGroup(
                  enabled: false,
                  divider: divider,
                  children: [
                    FItem(
                      enabled: index == 0,
                      prefix: const Icon(FIcons.wifi),
                      title: const Text('WiFi'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                    FItem(
                      enabled: index == 1,
                      prefix: const Icon(FIcons.bluetooth),
                      title: const Text('Bluetooth'),
                      subtitle: const Text('Fee, Fo'),
                      suffix: const Icon(FIcons.chevronRight),
                      onPress: () {},
                    ),
                  ],
                ),
              ),
            );

            await expectLater(
              find.byType(TestScaffold),
              matchesGoldenFile('item/group/${theme.name}/disabled/$divider-$position.png'),
            );
          });
        }
      }

      testWidgets('single item - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FItemGroup(
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
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/${theme.name}/single.png'));
      });

      testWidgets('empty item group - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FItemGroup(children: const []),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/${theme.name}/empty.png'));
      });
    }

    testWidgets('item style overrides group style', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItemGroup(
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
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/override-style.png'));
    });

    testWidgets('item state overrides group state', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItemGroup(
            enabled: false,
            children: [
              FItem(
                enabled: true,
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
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/override-state.png'));
    });
  });

  group('FItemGroup.builder', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FItemGroup.builder(
            style: TestScaffold.blueScreen.itemGroupStyle,
            maxHeight: 300,
            itemBuilder: (context, index) => FItem(title: Text('Item $index')),
          ),
        ),
      );

      await expectBlueScreen();
    });

    testWidgets('lazily built', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItemGroup.builder(maxHeight: 250, itemBuilder: (context, index) => FItem(title: Text('Item $index'))),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/builder/lazy.png'));
    });

    testWidgets('limited by count', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItemGroup.builder(
            maxHeight: 500,
            count: 2,
            itemBuilder: (context, index) => FItem(title: Text('Item $index')),
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/builder/count-limited.png'));
    });

    testWidgets('limited by returning null', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          child: FItemGroup.builder(
            maxHeight: 500,
            count: 24,
            itemBuilder: (context, index) => index < 2 ? FItem(title: Text('Item $index')) : null,
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('item/group/builder/null-limited.png'));
    });
  });
}

@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  late FPopoverController controller;

  setUp(() => controller = FPopoverController(vsync: const TestVSync()));

  for (final theme in TestScaffold.themes) {
    group('FPopoverMenu', () {
      testWidgets('${theme.name} hidden ', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FPopoverMenu(
              controller: controller,
              menu: [
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Item 1'),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Item 1'),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 50,
                ),
              ),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/hidden-${theme.name}.png'));
      });

      testWidgets('${theme.name} shown', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FPopoverMenu(
              controller: controller,
              menu: [
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Group 1'),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Group 2'),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 50,
                ),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('popover-menu/shown-${theme.name}.png'));
      });

      testWidgets('${theme.name} with directional padding', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FPopoverMenu(
              menuAnchor: Alignment.topRight,
              childAnchor: Alignment.bottomRight,
              useDirectionalPadding: true,
              style: theme.data.popoverMenuStyle.copyWith(padding: const EdgeInsets.all(50)),
              controller: controller,
              menu: [
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Group 1'),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Group 2'),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 100,
                ),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('popover-menu/directional-padding-${theme.name}.png'),
        );
      });

      testWidgets('${theme.name} ignore directional padding', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            child: FPopoverMenu(
              menuAnchor: Alignment.topRight,
              childAnchor: Alignment.bottomRight,
              style: theme.data.popoverMenuStyle.copyWith(padding: const EdgeInsets.all(50)),
              controller: controller,
              menu: [
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Group 1'),
                      onPress: () {},
                    ),
                  ],
                ),
                FTileGroup(
                  children: [
                    FTile(
                      title: const Text('Group 2'),
                      onPress: () {},
                    ),
                  ],
                ),
              ],
              child: const ColoredBox(
                color: Colors.yellow,
                child: SizedBox.square(
                  dimension: 100,
                ),
              ),
            ),
          ),
        );

        unawaited(controller.show());
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('popover-menu/ignore-directional-padding-${theme.name}.png'),
        );
      });
    });
  }

  tearDown(() => controller.dispose());
}

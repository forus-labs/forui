import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FSidebar', () {
    group('blue screen', () {
      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          TestScaffold.blue(
            child: FSidebar(
              style: TestScaffold.blueScreen.sidebarStyle,
              children: [
                FSidebarGroup(
                  label: const Text('Group 1'),
                  action: const Icon(FIcons.plus),
                  onActionPress: () {},
                  children: [
                    FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
                    FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
                  ],
                ),
                FSidebarGroup(
                  label: const Text('Group 2'),
                  children: [FSidebarItem(icon: const Icon(FIcons.file), label: const Text('Item 3'), onPress: () {})],
                ),
              ],
            ),
          ),
        );

        await expectBlueScreen(find.byType(TestScaffold));
      });
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('default - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSidebar(
              header: const Text('Header'),
              footer: const Text('Footer'),
              children: [
                FSidebarGroup(
                  label: const Text('Group 1'),
                  action: const Icon(FIcons.plus),
                  onActionPress: () {},
                  children: [
                    FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
                    FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
                  ],
                ),
                FSidebarGroup(
                  label: const Text('Group 2'),
                  children: [FSidebarItem(icon: const Icon(FIcons.file), label: const Text('Item 3'), onPress: () {})],
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar/${theme.name}/default.png'));
      });

      testWidgets('minimal - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSidebar(
              children: [
                FSidebarGroup(
                  children: [
                    FSidebarItem(label: const Text('Item 1'), onPress: () {}),
                    FSidebarItem(label: const Text('Item 2'), onPress: () {}),
                  ],
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar/${theme.name}/minimal.png'));
      });

      testWidgets('with header only - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSidebar(
              header: const Text('Header'),
              children: [
                FSidebarGroup(
                  children: [
                    FSidebarItem(label: const Text('Item 1'), onPress: () {}),
                    FSidebarItem(label: const Text('Item 2'), onPress: () {}),
                  ],
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('sidebar/sidebar/${theme.name}/with-header-only.png'),
        );
      });

      testWidgets('with footer only - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSidebar(
              footer: const Text('Footer'),
              children: [
                FSidebarGroup(
                  children: [
                    FSidebarItem(label: const Text('Item 1'), onPress: () {}),
                    FSidebarItem(label: const Text('Item 2'), onPress: () {}),
                  ],
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('sidebar/sidebar/${theme.name}/with-footer-only.png'),
        );
      });

      testWidgets('with custom width - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSidebar(
              width: 500,
              header: const Text('Header'),
              footer: const Text('Footer'),
              children: [
                FSidebarGroup(
                  children: [
                    FSidebarItem(label: const Text('Item 1'), onPress: () {}),
                    FSidebarItem(label: const Text('Item 2'), onPress: () {}),
                  ],
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('sidebar/sidebar/${theme.name}/with-custom-width.png'),
        );
      });

      testWidgets('with builder - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSidebar.builder(
              header: const Text('Header'),
              footer: const Text('Footer'),
              itemCount: 2,
              itemBuilder: (context, index) => FSidebarGroup(
                children: [
                  FSidebarItem(label: Text('Item ${index + 1}'), onPress: () {}),
                  FSidebarItem(label: Text('Item ${index + 1}'), onPress: () {}),
                ],
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('sidebar/sidebar/${theme.name}/with-builder.png'),
        );
      });

      testWidgets('with raw content - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FSidebar.raw(
              header: const Text('Header'),
              footer: const Text('Footer'),
              child: ListView(
                children: [
                  FSidebarGroup(
                    children: [
                      FSidebarItem(label: const Text('Item 1'), onPress: () {}),
                      FSidebarItem(label: const Text('Item 2'), onPress: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('sidebar/sidebar/${theme.name}/with-raw-content.png'),
        );
      });

      testWidgets('RTL - ${theme.name}', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            textDirection: TextDirection.rtl,
            child: FSidebar(
              header: const Text('Header'),
              footer: const Text('Footer'),
              children: [
                FSidebarGroup(
                  label: const Text('Group 1'),
                  action: const Icon(FIcons.plus),
                  onActionPress: () {},
                  children: [
                    FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
                    FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
                  ],
                ),
                FSidebarGroup(
                  label: const Text('Group 2'),
                  children: [FSidebarItem(icon: const Icon(FIcons.file), label: const Text('Item 3'), onPress: () {})],
                ),
              ],
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar/${theme.name}/rtl.png'));
      });
    }
  });
}

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('blue screen', () {
    testWidgets('default', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSidebarGroup(
            style: TestScaffold.blueScreen.sidebarStyle.groupStyle,
            label: const Text('Group'),
            action: const Icon(FIcons.plus),
            onActionPress: () {},
            children: [
              FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });

    testWidgets('action hovered', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSidebarGroup(
            style: TestScaffold.blueScreen.sidebarStyle.groupStyle,
            label: const Text('Group'),
            action: const Icon(FIcons.plus),
            onActionPress: () {},
            children: [
              FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byIcon(FIcons.plus)));
      await tester.pumpAndSettle();

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('default - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarGroup(
            label: const Text('Group'),
            children: [
              FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-group/${theme.name}/default.png'),
      );
    });

    testWidgets('action - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarGroup(
            label: const Text('Group'),
            action: const Icon(FIcons.plus),
            onActionPress: () {},
            children: [
              FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-group/${theme.name}/action.png'));
    });

    testWidgets('action hovered - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarGroup(
            label: const Text('Group'),
            action: const Icon(FIcons.plus),
            onActionPress: () {},
            children: [
              FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byIcon(FIcons.plus)));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-group/${theme.name}/action-hovered.png'),
      );
    });

    testWidgets('with nested items - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarGroup(
            label: const Text('Group'),
            action: const Icon(FIcons.plus),
            onActionPress: () {},
            children: [
              FSidebarItem(
                icon: const Icon(FIcons.box),
                label: const Text('Item 1'),
                initiallyExpanded: true,
                children: [
                  FSidebarItem(icon: const Icon(FIcons.file), label: const Text('Child 1'), onPress: () {}),
                  FSidebarItem(icon: const Icon(FIcons.file), label: const Text('Child 2'), onPress: () {}),
                ],
                onPress: () {},
              ),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-group/${theme.name}/with-nested-items.png'),
      );
    });

    testWidgets('long label - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: SizedBox(
            width: 200,
            child: FSidebarGroup(
              label: const Text('This is a very long group label that should be truncated'),
              action: const Icon(FIcons.plus),
              onActionPress: () {},
              children: [
                FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
                FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
              ],
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-group/${theme.name}/long-label.png'),
      );
    });

    testWidgets('RTL - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          textDirection: .rtl,
          child: FSidebarGroup(
            label: const Text('Group'),
            action: const Icon(FIcons.plus),
            onActionPress: () {},
            children: [
              FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-group/${theme.name}/rtl.png'));
    });
  }
}

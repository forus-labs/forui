import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('blue screen', () {
    testWidgets('enabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSidebarItem(
            style: TestScaffold.blueScreen.sidebarStyle.groupStyle.itemStyle,
            icon: const Icon(FIcons.box),
            label: const Text('Item'),
            onPress: () {},
          ),
        ),
      );

      await expectBlueScreen();
    });

    testWidgets('disabled', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FSidebarItem(
            style: TestScaffold.blueScreen.sidebarStyle.groupStyle.itemStyle,
            icon: const Icon(FIcons.box),
            label: const Text('Item'),
          ),
        ),
      );

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('enabled - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-item/${theme.name}/enabled.png'));
    });

    testWidgets('disabled - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FSidebarItem(icon: Icon(FIcons.box), label: Text('Item')),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-item/${theme.name}/disabled.png'),
      );
    });

    testWidgets('hovered - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item'), onPress: () {}),
        ),
      );

      final gesture = await tester.createPointerGesture();
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.text('Item')));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-item/${theme.name}/hovered.png'));
    });

    testWidgets('selected - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item'), selected: true, onPress: () {}),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-item/${theme.name}/selected.png'),
      );
    });

    testWidgets('with children - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarItem(
            icon: const Icon(FIcons.box),
            label: const Text('Parent'),
            children: [
              FSidebarItem(label: const Text('Child 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Child 2'), onPress: () {}),
            ],
            onPress: () {},
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-item/${theme.name}/with-children.png'),
      );
    });

    testWidgets('with children expanded - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarItem(
            icon: const Icon(FIcons.box),
            label: const Text('Parent'),
            initiallyExpanded: true,
            children: [
              FSidebarItem(label: const Text('Child 1'), onPress: () {}),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Child 2'), onPress: () {}),
            ],
            onPress: () {},
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-item/${theme.name}/with-children-expanded.png'),
      );
    });

    testWidgets('with nested children expanded - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FSidebarItem(
            icon: const Icon(FIcons.box),
            label: const Text('Parent'),
            initiallyExpanded: true,
            children: [
              FSidebarItem(
                label: const Text('Child 1'),
                initiallyExpanded: true,
                children: [
                  FSidebarItem(label: const Text('Grandchild 1'), onPress: () {}),
                  FSidebarItem(icon: const Icon(FIcons.file), label: const Text('Grandchild 2'), onPress: () {}),
                ],
                onPress: () {},
              ),
              FSidebarItem(icon: const Icon(FIcons.folder), label: const Text('Child 2'), onPress: () {}),
            ],
            onPress: () {},
          ),
        ),
      );

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('sidebar/sidebar-item/${theme.name}/with-nested-children-expanded.png'),
      );
    });

    testWidgets('RTL - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          textDirection: .rtl,
          child: FSidebarItem(icon: const Icon(FIcons.box), label: const Text('Item'), onPress: () {}),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-item/${theme.name}/rtl.png'));
    });
  }

  testWidgets('minimal', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSidebarItem(label: const Text('Item'), onPress: () {}),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-item/minimal.png'));
  });

  testWidgets('long label', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: SizedBox(
          width: 200,
          child: FSidebarItem(
            icon: const Icon(FIcons.box),
            label: const Text('This is a very long label that should be truncated'),
            onPress: () {},
          ),
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-item/long-label.png'));
  });

  testWidgets('style changes when passed in style changes', (tester) async {
    await tester.pumpWidget(
      TestScaffold(
        child: FSidebarItem(
          key: const Key('item'),
          style: FThemes.zinc.light.sidebarStyle.groupStyle.itemStyle,
          label: const Text('Item'),
          onPress: () {},
        ),
      ),
    );

    await tester.pumpWidget(
      TestScaffold(
        child: FSidebarItem(
          key: const Key('item'),
          style: FThemes.zinc.dark.sidebarStyle.groupStyle.itemStyle,
          label: const Text('Item'),
          onPress: () {},
        ),
      ),
    );

    await expectLater(find.byType(TestScaffold), matchesGoldenFile('sidebar/sidebar-item/style-change.png'));
  });
}

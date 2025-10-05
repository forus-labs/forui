import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('blue screen', () {
    testWidgets('FTree', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FTree(
            style: TestScaffold.blueScreen.treeStyle,
            children: [
              FTreeItem(
                icon: const Icon(FIcons.folder),
                label: const Text('Folder 1'),
                children: [FTreeItem(icon: const Icon(FIcons.file), label: const Text('File 1'), onPress: () {})],
              ),
              FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Folder 2'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectBlueScreen();
    });
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('default - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FTree(
            children: [
              FTreeItem(
                icon: const Icon(FIcons.folder),
                label: const Text('Apple'),
                initiallyExpanded: true,
                children: [
                  FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Red Apple'), onPress: () {}),
                  FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Green Apple'), onPress: () {}),
                ],
              ),
              FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Banana'), onPress: () {}),
              FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Cherry'), onPress: () {}),
              FTreeItem(icon: const Icon(FIcons.file), label: const Text('Date'), onPress: () {}),
              FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Elderberry'), onPress: () {}),
              FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Fig'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tree/${theme.name}/default.png'));
    });

    testWidgets('nested - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FTree(
            children: [
              FTreeItem(
                icon: const Icon(FIcons.folder),
                label: const Text('Level 1'),
                initiallyExpanded: true,
                children: [
                  FTreeItem(
                    icon: const Icon(FIcons.folder),
                    label: const Text('Level 2'),
                    initiallyExpanded: true,
                    children: [
                      FTreeItem(
                        icon: const Icon(FIcons.folder),
                        label: const Text('Level 3'),
                        initiallyExpanded: true,
                        children: [
                          FTreeItem(icon: const Icon(FIcons.file), label: const Text('Deep File'), onPress: () {}),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tree/${theme.name}/nested.png'));
    });

    testWidgets('selected - ${theme.name}', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FTree(
            children: [
              FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Item 1'), selected: true, onPress: () {}),
              FTreeItem(icon: const Icon(FIcons.folder), label: const Text('Item 2'), onPress: () {}),
            ],
          ),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('tree/${theme.name}/selected.png'));
    });
  }
}

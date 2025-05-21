import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FDialog', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FDialog(
            style: TestScaffold.blueScreen.dialogStyle,
            direction: Axis.horizontal,
            title: const Text('Are you absolutely sure?'),
            body: const Text(
              'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
            ),
            actions: const [],
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      for (final direction in Axis.values) {
        testWidgets('${theme.name} with $direction FDialogContent', (
          tester,
        ) async {
          await tester.pumpWidget(
            TestScaffold(
              theme: theme.data,
              child: FDialog(
                direction: direction,
                title: const Text('Are you absolutely sure?'),
                body: const Text(
                  'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
                ),
                actions: [
                  FButton(onPress: () {}, child: const Text('Continue')),
                  FButton(
                    style: FButtonStyle.outline,
                    onPress: () {},
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          );

          await expectLater(
            find.byType(FDialog),
            matchesGoldenFile(
              'dialog/${theme.name}-$direction-content-dialog.png',
            ),
          );
        });
      }

      testWidgets('${theme.name} with raw content', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FDialog.raw(
              builder:
                  (context, style) => const SizedBox(width: 50, height: 50),
            ),
          ),
        );

        await expectLater(
          find.byType(FDialog),
          matchesGoldenFile('dialog/${theme.name}-raw-content-dialog.png'),
        );
      });

      testWidgets('${theme.name} adaptive on mobile device', (tester) async {
        tester.view.physicalSize = const Size(1290, 2796); // iPhone 15 Plus
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FDialog.adaptive(
              title: const Text('Are you absolutely sure?'),
              body: const Text(
                'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
              ),
              actions: [
                FButton(child: const Text('Continue'), onPress: () {}),
                FButton(
                  style: FButtonStyle.outline,
                  child: const Text('Cancel'),
                  onPress: () {},
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(FDialog),
          matchesGoldenFile('dialog/${theme.name}-adaptive-mobile.png'),
        );
      });

      testWidgets('${theme.name} adaptive on tablet device', (tester) async {
        tester.view.physicalSize = const Size(2388, 1668); // iPad Pro 11"
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FDialog.adaptive(
              title: const Text('Are you absolutely sure?'),
              body: const Text(
                'This action cannot be undone. This will permanently delete your account and remove your data from our servers.',
              ),
              actions: [
                FButton(child: const Text('Continue'), onPress: () {}),
                FButton(
                  style: FButtonStyle.outline,
                  child: const Text('Cancel'),
                  onPress: () {},
                ),
              ],
            ),
          ),
        );

        await expectLater(
          find.byType(FDialog),
          matchesGoldenFile('dialog/${theme.name}-adaptive-tablet.png'),
        );
      });
    }
  });
}

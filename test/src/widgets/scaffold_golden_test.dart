import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../test_scaffold.dart';

void main() {
  group('FScaffold', () {
    for (final theme in TestScaffold.themes) {
      testWidgets(theme.name, (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FScaffold(
              header: Row(
                children: [Expanded(child: Container(decoration: const BoxDecoration(color: Colors.red), height: 100))],
              ),
              footer: Row(
                children: [
                  Expanded(child: Container(decoration: const BoxDecoration(color: Colors.green), height: 100)),
                ],
              ),
              child: const Placeholder(),
            ),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('scaffold/${theme.name}.png'));
      });

      testWidgets('${theme.name} - have sheets', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FScaffold(
              header: Row(
                children: [
                  Expanded(
                    child: Builder(
                      builder:
                          (context) => FButton.icon(
                            child: const Icon(FIcons.chevronRight),
                            onPress: () {
                              autoDispose(
                                showFPersistentSheet(
                                  context: context,
                                  side: FLayout.ltr,
                                  draggable: false,
                                  builder:
                                      (context, controller) => Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: context.theme.colors.primary),
                                          color: context.theme.colors.background,
                                        ),
                                        child: const Center(child: Text('sheet')),
                                      ),
                                ),
                              );
                            },
                          ),
                    ),
                  ),
                ],
              ),
              footer: Row(
                children: [
                  Expanded(child: Container(decoration: const BoxDecoration(color: Colors.green), height: 100)),
                ],
              ),
              child: const Placeholder(),
            ),
          ),
        );

        await tester.tap(find.byType(FButton));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('scaffold/${theme.name}-sheets.png'));
      });
    }

    for (final resizeToAvoidBottomInset in [true, false]) {
      testWidgets('resizeToAvoidBottomInset - $resizeToAvoidBottomInset', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: TestScaffold.themes[0].data,
            child: FScaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              header: Container(decoration: const BoxDecoration(color: Colors.red), height: 100),
              footer: Container(decoration: const BoxDecoration(color: Colors.green), height: 100),
              child: const Placeholder(),
            ),
          ),
        );

        // Simulate keyboard.
        tester.view.viewInsets = const FakeViewPadding(bottom: 800);
        await tester.pump();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('scaffold/resizeToAvoidBottomInset-$resizeToAvoidBottomInset.png'),
        );
      });
    }
  });
}

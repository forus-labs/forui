@Tags(['golden'])
library;

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
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.red),
                      height: 100,
                    ),
                  ),
                ],
              ),
              content: const Placeholder(),
              footer: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.green),
                      height: 100,
                    ),
                  ),
                ],
              ),
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
                      builder: (context) => FButton.icon(
                        child: FIcon(FAssets.icons.chevronRight),
                        onPress: () {
                          showFPersistentSheet(
                            context: context,
                            side: Layout.ltr,
                            draggable: false,
                            builder: (context, controller) => Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: context.theme.colorScheme.primary),
                                color: context.theme.colorScheme.background,
                              ),
                              child: const Center(child: Text('sheet')),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              content: const Placeholder(),
              footer: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.green),
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FButton));
        await tester.pumpAndSettle(const Duration(seconds: 1));

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('scaffold/${theme.name}-sheets.png'));
      });
    }
  });
}

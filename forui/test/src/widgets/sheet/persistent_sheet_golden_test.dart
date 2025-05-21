import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  FPersistentSheetController? controller;

  group('showFSheet', () {
    for (final side in FLayout.values) {
      testWidgets('default - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder:
                    (context) => Center(
                      child: FButton.icon(
                        child: const Icon(FIcons.chevronRight),
                        onPress: () {
                          controller = showFPersistentSheet(
                            context: context,
                            side: side,
                            builder:
                                (context, controller) => Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: context.theme.colors.primary),
                                    color: context.theme.colors.background,
                                  ),
                                  child: const Center(child: Text('Sheet')),
                                ),
                          );
                        },
                      ),
                    ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FButton));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/persistent/default-$side.png'));
      });

      testWidgets('constrained - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder:
                    (context) => Center(
                      child: FButton.icon(
                        child: const Icon(FIcons.chevronRight),
                        onPress: () {
                          controller = showFPersistentSheet(
                            context: context,
                            side: side,
                            constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
                            builder:
                                (context, controller) => Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: context.theme.colors.primary),
                                    color: context.theme.colors.background,
                                  ),
                                  child: const Center(child: Text('Sheet')),
                                ),
                          );
                        },
                      ),
                    ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FButton));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/persistent/constrained-$side.png'));
      });

      testWidgets('scrollable - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder:
                    (context) => Center(
                      child: FButton.icon(
                        child: const Icon(FIcons.chevronRight),
                        onPress: () {
                          controller = showFPersistentSheet(
                            context: context,
                            side: side,
                            mainAxisMaxRatio: null,
                            builder:
                                (context, controller) => Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: context.theme.colors.primary),
                                    color: context.theme.colors.background,
                                  ),
                                  child: ListView.builder(
                                    scrollDirection: side.vertical ? Axis.vertical : Axis.horizontal,
                                    itemBuilder:
                                        (context, index) =>
                                            Padding(padding: const EdgeInsets.all(8.0), child: Text('Tile $index')),
                                    itemCount: 20,
                                  ),
                                ),
                          );
                        },
                      ),
                    ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FButton));
        await tester.pumpAndSettle();

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/persistent/scrollable-$side.png'));
      });
    }
  });

  tearDown(() {
    controller?.dispose();
    controller = null;
  });
}

@Tags(['golden'])
library;

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  FSheetController? controller;

  group('showFSheet', () {
    for (final side in Layout.values) {
      testWidgets('default - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder: (context) => Center(
                  child: FButton.icon(
                    child: FIcon(FAssets.icons.chevronRight),
                    onPress: () {
                      controller = showFSheet(
                        context: context,
                        side: side,
                        builder: (context) => Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: context.theme.colorScheme.primary),
                            color: context.theme.colorScheme.background,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/sheets/default-$side.png'));
      });

      testWidgets('constrained - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder: (context) => Center(
                  child: FButton.icon(
                    child: FIcon(FAssets.icons.chevronRight),
                    onPress: () {
                      controller = showFSheet(
                        context: context,
                        side: side,
                        constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
                        builder: (context) => Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: context.theme.colorScheme.primary),
                            color: context.theme.colorScheme.background,
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/sheets/constrained-$side.png'));
      });

      testWidgets('scrollable - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder: (context) => Center(
                  child: FButton.icon(
                    child: FIcon(FAssets.icons.chevronRight),
                    onPress: () {
                      controller = showFSheet(
                        context: context,
                        side: side,
                        mainAxisMaxRatio: null,
                        builder: (context) => Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: context.theme.colorScheme.primary),
                            color: context.theme.colorScheme.background,
                          ),
                          child: ListView.builder(
                            scrollDirection: side.vertical ? Axis.vertical : Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Tile $index'),
                            ),
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

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/sheets/scrollable-$side.png'));
      });
    }
  });

  tearDown(() {
    controller?.dispose();
    controller = null;
  });
}

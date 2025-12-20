import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  FPersistentSheetController? controller;

  tearDown(() {
    controller?.dispose();
    controller = null;
  });

  group('resizeToAvoidBottomInset', () {
    testWidgets('shifts up', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(viewInsets: .only(bottom: 100)),
          child: TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder: (context) => Center(
                  child: FButton.icon(
                    child: const Icon(FIcons.chevronRight),
                    onPress: () {
                      controller = showFPersistentSheet(
                        context: context,
                        side: .btt,
                        builder: (context, controller) => Container(
                          height: .infinity,
                          width: .infinity,
                          decoration: BoxDecoration(
                            border: .all(color: context.theme.colors.primary),
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
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/persistent/bottom-inset.png'));
    });

    testWidgets('does not overflow', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(viewInsets: .only(bottom: 1000)),
          child: TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder: (context) => Center(
                  child: FButton.icon(
                    child: const Icon(FIcons.chevronRight),
                    onPress: () {
                      controller = showFPersistentSheet(
                        context: context,
                        side: .btt,
                        builder: (context, controller) => Container(
                          height: .infinity,
                          width: .infinity,
                          decoration: BoxDecoration(
                            border: .all(color: context.theme.colors.primary),
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
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('sheet/persistent/bottom-inset-overflow.png'));
    });
  });

  for (final side in FLayout.values) {
    testWidgets('default - $side', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSheets(
            child: Builder(
              builder: (context) => Center(
                child: FButton.icon(
                  child: const Icon(FIcons.chevronRight),
                  onPress: () {
                    controller = showFPersistentSheet(
                      context: context,
                      side: side,
                      builder: (context, controller) => Container(
                        height: .infinity,
                        width: .infinity,
                        decoration: BoxDecoration(
                          border: .all(color: context.theme.colors.primary),
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
              builder: (context) => Center(
                child: FButton.icon(
                  child: const Icon(FIcons.chevronRight),
                  onPress: () {
                    controller = showFPersistentSheet(
                      context: context,
                      side: side,
                      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
                      builder: (context, controller) => Container(
                        height: .infinity,
                        width: .infinity,
                        decoration: BoxDecoration(
                          border: .all(color: context.theme.colors.primary),
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
              builder: (context) => Center(
                child: FButton.icon(
                  child: const Icon(FIcons.chevronRight),
                  onPress: () {
                    controller = showFPersistentSheet(
                      context: context,
                      side: side,
                      mainAxisMaxRatio: null,
                      builder: (context, controller) => Container(
                        height: .infinity,
                        width: .infinity,
                        decoration: BoxDecoration(
                          border: .all(color: context.theme.colors.primary),
                          color: context.theme.colors.background,
                        ),
                        child: ListView.builder(
                          scrollDirection: side.vertical ? .vertical : .horizontal,
                          itemBuilder: (context, index) =>
                              Padding(padding: const .all(8.0), child: Text('Tile $index')),
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
}

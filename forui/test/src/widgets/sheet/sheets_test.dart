import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/sheets.dart';
import '../../test_scaffold.dart';

void main() {
  FSheetController? controller;

  group('showFSheet', () {
    testWidgets('shows sheet', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSheets(
            child: Builder(
              builder: (context) => FButton.icon(
                child: FIcon(FAssets.icons.chevronRight),
                onPress: () {
                  controller = showFSheet(
                    context: context,
                    side: Layout.btt,
                    builder: (context) => Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: context.theme.colorScheme.background,
                      child: const Center(child: Text('sheet')),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsOne);

      await tester.drag(find.text('sheet'), const Offset(0, 200));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsNothing);
    });

    testWidgets('shows sheet when keepAliveOffstage is true', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSheets(
            child: Builder(
              builder: (context) => FButton.icon(
                child: FIcon(FAssets.icons.chevronRight),
                onPress: () {
                  controller = showFSheet(
                    context: context,
                    side: Layout.btt,
                    keepAliveOffstage: true,
                    builder: (context) => Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: context.theme.colorScheme.background,
                      child: const Center(child: Text('sheet')),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsOne);

      await tester.drag(find.text('sheet'), const Offset(0, 200));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsOne);
    });

    testWidgets('no FSheets ancestor', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: FIcon(FAssets.icons.chevronRight),
              onPress: () {
                controller = showFSheet(
                  context: context,
                  side: Layout.btt,
                  builder: (context) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: context.theme.colorScheme.background,
                    child: const Center(child: Text('sheet')),
                  ),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(tester.takeException(), isA<FlutterError>());
    });

    testWidgets('duplicate key', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSheets(
            child: Builder(
              builder: (context) => FButton.icon(
                child: FIcon(FAssets.icons.chevronRight),
                onPress: () {
                  controller = showFSheet(
                    key: const Key('test'),
                    context: context,
                    side: Layout.btt,
                    builder: (context) => Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: context.theme.colorScheme.background,
                      child: const Center(child: Text('sheet')),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(tester.takeException(), isA<FlutterError>());
    });

    testWidgets('dispose removes sheet', (tester) async {
      late FSheetController controller;
      const key = Key('test');

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSheets(
            key: key,
            child: Builder(
              builder: (context) => FButton.icon(
                child: FIcon(FAssets.icons.chevronRight),
                onPress: () {
                  controller = showFSheet(
                    context: context,
                    side: Layout.btt,
                    builder: (context) => Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: context.theme.colorScheme.background,
                      child: const Center(child: Text('sheet')),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(tester.state<FSheetsState>(find.byKey(key)).sheets.isEmpty, false);

      controller.dispose();
      expect(tester.state<FSheetsState>(find.byKey(key)).sheets.isEmpty, true);
    });

    for (final (side, offset) in [
      (Layout.btt, const Offset(0, 300)),
      (Layout.ttb, const Offset(0, -300)),
      (Layout.ltr, const Offset(-300, 0)),
      (Layout.rtl, const Offset(300, 0)),
    ]) {
      testWidgets('drag to dismiss - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder: (context) => FButton.icon(
                  child: FIcon(FAssets.icons.chevronRight),
                  onPress: () {
                    controller = showFSheet(
                      context: context,
                      side: side,
                      builder: (context) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: context.theme.colorScheme.background,
                        child: const Center(child: Text('sheet')),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FButton));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('sheet'), findsOne);

        await tester.drag(find.text('sheet'), offset);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('sheet'), findsNothing);
      });

      testWidgets('drag to dismiss on non-draggable - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder: (context) => FButton.icon(
                  child: FIcon(FAssets.icons.chevronRight),
                  onPress: () {
                    controller = showFSheet(
                      context: context,
                      side: side,
                      draggable: false,
                      builder: (context) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: context.theme.colorScheme.background,
                        child: const Center(child: Text('sheet')),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FButton));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('sheet'), findsOne);

        await tester.drag(find.text('sheet'), offset);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('sheet'), findsOne);
      });
    }

    tearDown(() {
      controller?.dispose();
      controller = null;
    });
  });
}

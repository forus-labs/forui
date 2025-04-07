import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/sheet/persistent_sheet.dart';
import '../../test_scaffold.dart';

void main() {
  group('showFPersistentSheet', () {
    testWidgets('shows sheet', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: FSheets(
            child: Builder(
              builder:
                  (context) => FButton.icon(
                    child: const Icon(FIcons.chevronRight),
                    onPress: () {
                      autoDispose(
                        showFPersistentSheet(
                          context: context,
                          side: FLayout.btt,
                          builder:
                              (context, controller) => Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: context.theme.colors.background,
                                child: const Center(child: Text('sheet')),
                              ),
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
              builder:
                  (context) => FButton.icon(
                    child: const Icon(FIcons.chevronRight),
                    onPress: () {
                      autoDispose(
                        showFPersistentSheet(
                          context: context,
                          side: FLayout.btt,
                          keepAliveOffstage: true,
                          builder:
                              (context, controller) => Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: context.theme.colors.background,
                                child: const Center(child: Text('sheet')),
                              ),
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
            builder:
                (context) => FButton.icon(
                  child: const Icon(FIcons.chevronRight),
                  onPress: () {
                    autoDispose(
                      showFPersistentSheet(
                        context: context,
                        side: FLayout.btt,
                        builder:
                            (context, controller) => Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: context.theme.colors.background,
                              child: const Center(child: Text('sheet')),
                            ),
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
              builder:
                  (context) => FButton.icon(
                    child: const Icon(FIcons.chevronRight),
                    onPress: () {
                      autoDispose(
                        showFPersistentSheet(
                          key: const Key('test'),
                          context: context,
                          side: FLayout.btt,
                          builder:
                              (context, controller) => Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: context.theme.colors.background,
                                child: const Center(child: Text('sheet')),
                              ),
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
      late FPersistentSheetController controller;
      const key = Key('test');

      await tester.pumpWidget(
        TestScaffold.app(
          child: FSheets(
            key: key,
            child: Builder(
              builder:
                  (context) => FButton.icon(
                    child: const Icon(FIcons.chevronRight),
                    onPress: () {
                      controller = showFPersistentSheet(
                        context: context,
                        side: FLayout.btt,
                        builder:
                            (context, controller) => Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: context.theme.colors.background,
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
      (FLayout.btt, const Offset(0, 300)),
      (FLayout.ttb, const Offset(0, -300)),
      (FLayout.ltr, const Offset(-300, 0)),
      (FLayout.rtl, const Offset(300, 0)),
    ]) {
      testWidgets('drag to dismiss - $side', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            child: FSheets(
              child: Builder(
                builder:
                    (context) => FButton.icon(
                      child: const Icon(FIcons.chevronRight),
                      onPress: () {
                        autoDispose(
                          showFPersistentSheet(
                            context: context,
                            side: side,
                            builder:
                                (context, controller) => Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: context.theme.colors.background,
                                  child: const Center(child: Text('sheet')),
                                ),
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
                builder:
                    (context) => FButton.icon(
                      child: const Icon(FIcons.chevronRight),
                      onPress: () {
                        autoDispose(
                          showFPersistentSheet(
                            context: context,
                            side: side,
                            draggable: false,
                            builder:
                                (context, controller) => Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: context.theme.colors.background,
                                  child: const Center(child: Text('sheet')),
                                ),
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
  });
}

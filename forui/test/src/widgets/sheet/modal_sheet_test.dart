import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../test_scaffold.dart';

void main() {
  group('FModalSheet', () {
    testWidgets('tap on barrier dismisses', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          child: Builder(
            builder: (context) => FButton.icon(
              child: FIcon(FAssets.icons.chevronRight),
              onPress: () => showFSheet(
                context: context,
                side: Layout.btt,
                builder: (context) => Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: context.theme.colorScheme.background,
                  child: const Center(child: Text('sheet')),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsOne);

      await tester.tapAt(const Offset(100, 100));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('sheet'), findsNothing);
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
            child: Builder(
              builder: (context) => FButton.icon(
                child: FIcon(FAssets.icons.chevronRight),
                onPress: () => showFSheet(
                  context: context,
                  side: side,
                  builder: (context) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: context.theme.colorScheme.background,
                    child: const Center(child: Text('sheet')),
                  ),
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
            child: Builder(
              builder: (context) => FButton.icon(
                child: FIcon(FAssets.icons.chevronRight),
                onPress: () => showFSheet(
                  context: context,
                  side: side,
                  draggable: false,
                  builder: (context) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: context.theme.colorScheme.background,
                    child: const Center(child: Text('sheet')),
                  ),
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

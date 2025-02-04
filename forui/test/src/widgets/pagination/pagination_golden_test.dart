@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';

import '../../test_scaffold.dart';

void main() {
  group('FPagination', () {
    testWidgets('blue screen', (tester) async {
      await tester.pumpWidget(
        TestScaffold.blue(
          child: FPagination(
            style: TestScaffold.blueScreen.paginationStyle,
            controller: FPaginationController(length: 10),
          ),
        ),
      );

      await expectBlueScreen(find.byType(TestScaffold));
    });

    for (final theme in TestScaffold.themes) {
      testWidgets('default', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(controller: FPaginationController(length: 10)),
          ),
        );

        await expectLater(find.byType(TestScaffold), matchesGoldenFile('pagination/${theme.name}/default.png'));
      });

      testWidgets('showEdges = false', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(controller: FPaginationController(length: 10, showEdges: false)),
          ),
        );

        await tester.tap(find.text('4'));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('pagination/${theme.name}/hide-edges.png'),
        );
      });

      testWidgets('siblings = 0', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(controller: FPaginationController(length: 10, siblings: 0, page: 3)),
          ),
        );
        await tester.tap(find.bySemanticsLabel('Pagination action').last);
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('pagination/${theme.name}/siblings-zero.png'),
        );
      });

      testWidgets('siblings = 2', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(controller: FPaginationController(length: 14, siblings: 2)),
          ),
        );
        await tester.tap(find.text('7'));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('pagination/${theme.name}/siblings-two.png'),
        );
      });

      testWidgets('custom icon', (tester) async {
        final style = theme.data.paginationStyle;
        final controller = FPaginationController(length: 10, page: 5);
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(
              controller: controller,
              next: Padding(
                padding: style.itemPadding,
                child: ConstrainedBox(
                  constraints: style.contentConstraints,
                  child: FButton.icon(
                    style: FButtonStyle.ghost,
                    onPress: controller.next,
                    child: FIconStyleData(
                      style: style.iconStyle,
                      child: FIcon(FAssets.icons.bird),
                    ),
                  ),
                ),
              ),
              previous: Padding(
                padding: style.itemPadding,
                child: ConstrainedBox(
                  constraints: style.contentConstraints,
                  child: FButton.icon(
                    style: FButtonStyle.ghost,
                    onPress: controller.previous,
                    child: FIconStyleData(
                      style: style.iconStyle,
                      child: FIcon(FAssets.icons.anchor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await expectLater(find.byType(TestScaffold), matchesGoldenFile('pagination/${theme.name}/custom-icon.png'));
      });
    }
  });
}

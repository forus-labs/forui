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

      testWidgets('showFirstLastPages set to false', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(controller: FPaginationController(length: 10, showFirstLastPages: false)),
          ),
        );

        await tester.tap(find.text('4'));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('pagination/${theme.name}/no-first-last-page.png'),
        );
      });

      testWidgets('sibling length 1', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(controller: FPaginationController(length: 10)),
          ),
        );
        await tester.tap(find.text('5'));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('pagination/${theme.name}/sibling-length-one.png'),
        );
      });

      testWidgets('sibling length 2', (tester) async {
        await tester.pumpWidget(
          TestScaffold(
            theme: theme.data,
            child: FPagination(controller: FPaginationController(length: 14, siblingLength: 2)),
          ),
        );
        await tester.tap(find.text('7'));
        await tester.pumpAndSettle(const Duration(milliseconds: 500));

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('pagination/${theme.name}/sibling-length-two.png'),
        );
      });

      testWidgets('custom icon', (tester) async {
        final style = theme.data.paginationStyle;
        final controller = FPaginationController(length: 10, initialPage: 5);
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

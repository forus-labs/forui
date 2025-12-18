import 'package:flutter/widgets.dart' hide Action;

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import 'package:forui/src/widgets/pagination/pagination.dart';
import '../../test_scaffold.dart';

void main() {
  late FPaginationController controller;

  setUp(() => controller = FPaginationController(pages: 10));

  tearDown(() => controller.dispose());

  testWidgets('blue screen', (tester) async {
    await tester.pumpWidget(
      TestScaffold.blue(
        child: FPagination(style: TestScaffold.blueScreen.paginationStyle, control: const .managed(pages: 10)),
      ),
    );

    await expectBlueScreen();
  });

  for (final theme in TestScaffold.themes) {
    testWidgets('default', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FPagination(control: .managed(pages: 10)),
        ),
      );

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('pagination/${theme.name}/default.png'));
    });

    testWidgets('hide edges', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FPagination(control: .managed(pages: 10, showEdges: false)),
        ),
      );

      await tester.tap(find.text('4'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('pagination/${theme.name}/hide-edges.png'));
    });

    testWidgets('no siblings', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FPagination(control: .managed(initial: 2, pages: 10, siblings: 0)),
        ),
      );
      await tester.tap(find.byType(Action).last);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('pagination/${theme.name}/siblings-zero.png'));
    });

    testWidgets('2 siblings', (tester) async {
      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: const FPagination(control: .managed(pages: 14, siblings: 2)),
        ),
      );
      await tester.tap(find.text('7'));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('pagination/${theme.name}/siblings-two.png'));
    });

    testWidgets('custom icon', (tester) async {
      final style = theme.data.paginationStyle;
      final controller = autoDispose(FPaginationController(pages: 10, page: 4));

      await tester.pumpWidget(
        TestScaffold(
          theme: theme.data,
          child: FPagination(
            control: .managed(controller: controller),
            next: Padding(
              padding: style.itemPadding,
              child: ConstrainedBox(
                constraints: style.itemConstraints,
                child: FButton.icon(
                  style: FButtonStyle.ghost(),
                  onPress: controller.next,
                  child: IconTheme(data: style.itemIconStyle.resolve({}), child: const Icon(FIcons.bird)),
                ),
              ),
            ),
            previous: Padding(
              padding: style.itemPadding,
              child: ConstrainedBox(
                constraints: style.itemConstraints,
                child: FButton.icon(
                  style: FButtonStyle.ghost(),
                  onPress: controller.previous,
                  child: IconTheme(data: style.itemIconStyle.resolve({}), child: const Icon(FIcons.anchor)),
                ),
              ),
            ),
          ),
        ),
      );
      await expectLater(find.byType(TestScaffold), matchesGoldenFile('pagination/${theme.name}/custom-icon.png'));
    });
  }
}

@Tags(['golden'])
library;

import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O'];

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  for (final theme in TestScaffold.themes) {
    group('Content', () {
      group('scroll handles', () {
        testWidgets('show both', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              alignment: Alignment.topCenter,
              child: FSelect<String>(
                key: key,
                contentScrollController: scrollController,
                contentScrollHandles: true,
                children: [
                  FSelectSection(
                    label: const Text('Lorem'),
                    children: [for (final letter in letters) FSelectItem.text(letter)],
                  ),
                ],
              ),
            ),
          );

          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          scrollController.jumpTo(scrollController.position.maxScrollExtent / 2);
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('select/${theme.name}/content/both_scroll_handles.png'),
          );
        });

        testWidgets('hide starting scroll handle', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              alignment: Alignment.topCenter,
              child: FSelect<String>(
                key: key,
                contentScrollController: scrollController,
                contentScrollHandles: true,
                children: [
                  FSelectSection(
                    label: const Text('Lorem'),
                    children: [for (final letter in letters) FSelectItem.text(letter)],
                  ),
                ],
              ),
            ),
          );

          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('select/${theme.name}/content/hide_start_scroll_handle.png'),
          );
        });

        testWidgets('hide ending scroll handle', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              alignment: Alignment.topCenter,
              child: FSelect<String>(
                key: key,
                contentScrollController: scrollController,
                contentScrollHandles: true,
                children: [
                  FSelectSection(
                    label: const Text('Lorem'),
                    children: [for (final letter in letters) FSelectItem.text(letter)],
                  ),
                ],
              ),
            ),
          );

          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          scrollController.jumpTo(scrollController.position.maxScrollExtent);
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('select/${theme.name}/content/hide_end_scroll_handle.png'),
          );
        });

        testWidgets('hide scroll handles when handles disabled', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              alignment: Alignment.topCenter,
              child: FSelect<String>(
                key: key,
                contentScrollController: scrollController,
                children: [
                  FSelectSection(
                    label: const Text('Lorem'),
                    children: [for (final letter in letters) FSelectItem.text(letter)],
                  ),
                ],
              ),
            ),
          );

          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          scrollController.jumpTo(scrollController.position.maxScrollExtent / 2);
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('select/${theme.name}/content/no_scroll_handles.png'),
          );
        });

        testWidgets('hide scroll handles when all items visible', (tester) async {
          await tester.pumpWidget(
            TestScaffold.app(
              theme: theme.data,
              alignment: Alignment.topCenter,
              child: FSelect<String>(
                key: key,
                contentScrollController: scrollController,
                contentScrollHandles: true,
                children: [
                  FSelectSection(label: const Text('Lorem'), children: [FSelectItem.text('1')]),
                ],
              ),
            ),
          );

          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          scrollController.jumpTo(scrollController.position.maxScrollExtent / 2);
          await tester.pumpAndSettle();

          await expectLater(
            find.byType(TestScaffold),
            matchesGoldenFile('select/${theme.name}/content/all_items_visible.png'),
          );
        });
      });

      testWidgets('focus on selected item', (tester) async {
        controller.value = 'O';

        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              controller: controller,
              contentScrollController: scrollController,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem.text(letter)],
                ),
              ],
            ),
          ),
        );

        await tester.tap(find.byKey(key));
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(TestScaffold),
          matchesGoldenFile('select/${theme.name}/content/focused_selected_item.png'),
        );
      });
    });
  }

  tearDown(() {
    scrollController.dispose();
    controller.dispose();
  });
}

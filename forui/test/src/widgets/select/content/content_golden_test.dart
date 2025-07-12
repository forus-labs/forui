import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:forui/forui.dart';
import '../../../test_scaffold.dart';

const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O'];

class ItemWrapper extends StatelessWidget with FItemMixin {
  const ItemWrapper({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Center(
      child: FSelect<String>(
        format: (s) => s,
        children: [
          FSelectSection(label: const Text('Section 1'), children: [FSelectItem<String>('Item 1', 'item 1')]),
          FSelectSection(label: const Text('Section 2'), children: [FSelectItem<String>('Item 2', 'item 2')]),
        ],
      ),
    ),
  );
}

void main() {
  const key = ValueKey('select');

  late FSelectController<String> controller;
  late ScrollController scrollController;

  setUp(() {
    controller = FSelectController<String>(vsync: const TestVSync());
    scrollController = ScrollController();
  });

  tearDown(() {
    scrollController.dispose();
    controller.dispose();
  });

  for (final theme in TestScaffold.themes) {
    group('scroll handles', () {
      testWidgets('show both', (tester) async {
        await tester.pumpWidget(
          TestScaffold.app(
            theme: theme.data,
            alignment: Alignment.topCenter,
            child: FSelect<String>(
              key: key,
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(letter, letter)],
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
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(letter, letter)],
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
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(letter, letter)],
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
              format: (string) => string,
              contentScrollController: scrollController,
              children: [
                FSelectSection(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(letter, letter)],
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
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: [
                FSelectSection(label: const Text('Lorem'), children: [FSelectItem('1', '1')]),
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

    testWidgets('dividers', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>(
            key: key,
            divider: FItemDivider.full,
            format: (s) => s,
            children: [
              FSelectSection.fromMap(
                label: const Text('Group 1'),
                divider: FItemDivider.indented,
                items: {
                  for (final item in ['1A', '1B']) item: item,
                },
              ),
              FSelectSection.fromMap(
                label: const Text('Group 2'),
                items: {
                  for (final item in ['2A', '2B']) item: item,
                },
              ),
              FSelectItem('Item 3', 'Item 3'),
              FSelectItem('Item 4', 'Item 4'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/content/dividers.png'));
    });

    testWidgets('hover with dividers', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>(
            key: key,
            divider: FItemDivider.full,
            format: (s) => s,
            children: [
              FSelectSection.fromMap(
                label: const Text('Group 1'),
                divider: FItemDivider.indented,
                items: {
                  for (final item in ['1A', '1B']) item: item,
                },
              ),
              FSelectSection.fromMap(
                label: const Text('Group 2'),
                items: {
                  for (final item in ['2A', '2B']) item: item,
                },
              ),
              FSelectItem('Item 3', 'Item 3'),
              FSelectItem('Item 4', 'Item 4'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      final gesture = await tester.createPointerGesture();
      await gesture.moveTo(tester.getCenter(find.text('1B')));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select/${theme.name}/content/dividers-hover.png'),
      );
    });

    testWidgets('focus on selected item', (tester) async {
      controller.value = 'O';

      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>(
            key: key,
            format: (string) => string,
            controller: controller,
            contentScrollController: scrollController,
            children: [
              FSelectSection(
                label: const Text('Lorem'),
                children: [for (final letter in letters) FSelectItem(letter, letter)],
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
  }

  testWidgets('leaky inherited FItemData does not affect FSelect', (tester) async {
    await tester.pumpWidget(
      TestScaffold.app(
        child: FItemGroup(
          divider: FItemDivider.indented,
          children: [
            FItem(title: const Text('2nd')),
            const ItemWrapper(key: key),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(find.byType(TestScaffold), matchesGoldenFile('select/content/leaky_inherited_fitemdata.png'));
  });
}

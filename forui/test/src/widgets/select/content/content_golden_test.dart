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
      child: FSelect<String>.rich(
        format: (s) => s,
        children: const [
          FSelectSection.rich(
            label: Text('Section 1'),
            children: [FSelectItem<String>(title: Text('Item 1'), value: 'item 1')],
          ),
          FSelectSection.rich(
            label: Text('Section 2'),
            children: [FSelectItem<String>(title: Text('Item 2'), value: 'item 2')],
          ),
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
    controller = FSelectController<String>();
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
            child: FSelect<String>.rich(
              key: key,
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: [
                FSelectSection.rich(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(title: Text(letter), value: letter)],
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
            child: FSelect<String>.rich(
              key: key,
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: [
                FSelectSection.rich(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(title: Text(letter), value: letter)],
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
            child: FSelect<String>.rich(
              key: key,
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: [
                FSelectSection.rich(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(title: Text(letter), value: letter)],
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
            child: FSelect<String>.rich(
              key: key,
              format: (string) => string,
              contentScrollController: scrollController,
              children: [
                FSelectSection.rich(
                  label: const Text('Lorem'),
                  children: [for (final letter in letters) FSelectItem(title: Text(letter), value: letter)],
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
            child: FSelect<String>.rich(
              key: key,
              format: (string) => string,
              contentScrollController: scrollController,
              contentScrollHandles: true,
              children: const [
                FSelectSection.rich(
                  label: Text('Lorem'),
                  children: [FSelectItem(title: Text('1'), value: '1')],
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
          matchesGoldenFile('select/${theme.name}/content/all_items_visible.png'),
        );
      });
    });

    testWidgets('dividers', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.rich(
            key: key,
            contentDivider: FItemDivider.full,
            format: (s) => s,
            children: [
              FSelectSection(
                label: const Text('Group 1'),
                divider: FItemDivider.indented,
                items: {
                  for (final item in ['1A', '1B']) item: item,
                },
              ),
              FSelectSection(
                label: const Text('Group 2'),
                items: {
                  for (final item in ['2A', '2B']) item: item,
                },
              ),
              const FSelectItem(title: Text('Item 3'), value: 'Item 3'),
              const FSelectItem(title: Text('Item 4'), value: 'Item 4'),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(find.byType(TestScaffold), matchesGoldenFile('select/${theme.name}/content/dividers.png'));
    });

    testWidgets('dividers with single item', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.rich(
            key: key,
            contentDivider: FItemDivider.full,
            format: (s) => s,
            children: const [FSelectItem(title: Text('Item 1'), value: 'Item 1')],
          ),
        ),
      );

      await tester.tap(find.byKey(key));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(TestScaffold),
        matchesGoldenFile('select/${theme.name}/content/dividers-single-item.png'),
      );
    });

    testWidgets('hover with dividers', (tester) async {
      await tester.pumpWidget(
        TestScaffold.app(
          theme: theme.data,
          alignment: Alignment.topCenter,
          child: FSelect<String>.rich(
            key: key,
            contentDivider: FItemDivider.full,
            format: (s) => s,
            children: [
              FSelectSection(
                label: const Text('Group 1'),
                divider: FItemDivider.indented,
                items: {
                  for (final item in ['1A', '1B']) item: item,
                },
              ),
              FSelectSection(
                label: const Text('Group 2'),
                items: {
                  for (final item in ['2A', '2B']) item: item,
                },
              ),
              const FSelectItem(title: Text('Item 3'), value: 'Item 3'),
              const FSelectItem(title: Text('Item 4'), value: 'Item 4'),
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
          child: FSelect<String>.rich(
            key: key,
            format: (string) => string,
            control: FSelectControl.managed(controller: controller),
            contentScrollController: scrollController,
            children: [
              FSelectSection.rich(
                label: const Text('Lorem'),
                children: [for (final letter in letters) FSelectItem(title: Text(letter), value: letter)],
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
